/* Carlos Santos
** CS 210 HW 5
** Goal: Read in 1 or more unicon (.icn) files and produce a
** .json output. 
** http://www2.cs.uidaho.edu/~jeffery/courses/210/hw5.html
**
*/

/* ----- Java Libraries that are needed ----- */
import java.io.*;
import java.util.LinkedList;
import java.util.Queue;

/* ----- Main program class ----- */
class unison {

    public static void main(String args[]) {
        int argsLength = args.length;
        if (argsLength > 0) {
            for (int argsCount = 0; argsCount <= (argsLength - 1); argsCount++) {
                System.out.println("args[" + argsCount + "] :" + args[argsCount]);
                Queue<String> q = unison.icn_parser(args[argsCount]);
                unison.json_maker(q, args[argsCount]);
            }
        } else {
            System.out.println("No arguments passed");
        }

    }

    public static Queue<String> icn_parser(String file_name) {
        /* ----- Begin: Initilize our Queue ---- */
        Queue<String> q = new LinkedList<>();
        /* ---- End: Initilize our Queue ---- */
        /* ----- Begin: File Code ----- */
        try {
            // constructor of file class having file as argument
            File file = new File(file_name);
            FileInputStream fis = new FileInputStream(file); // opens a connection to an actual file
            BufferedReader br = new BufferedReader(new InputStreamReader(fis));
            String line;
            boolean multi_para_class = false;
            boolean multi_para_method = false;
            while ((line = br.readLine()) != null) {

                // Does it start with "class"
                if (line.startsWith("class")) {
                    if (line.contains("(") && line.contains(")")) {
                        // super class case
                        if (line.contains(":")) {
                            String[] tokens = line.split(":");
                            int tokens_size = tokens.length;
                            for (int i = 0; i < tokens_size; i++) {
                                q.add(tokens[i]);
                            }
                        } else {
                            String[] tokens = line.split(" ");
                            int tokens_size = tokens.length;
                            for (int i = 0; i < tokens_size; i++) {
                                q.add(tokens[i]);
                            }
                        }
                    }
                    // This must mean we have multiple parameters on multiple lines
                    else if (line.startsWith("class") && line.contains("(") && !line.contains(")")) {
                        // super class case
                        if (line.contains(":")) {
                            String[] tokens = line.split(":");
                            int tokens_size = tokens.length;
                            for (int i = 0; i < tokens_size; i++) {
                                q.add(tokens[i]);
                            }
                        } else {
                            String[] tokens = line.split(" ");
                            int tokens_size = tokens.length;
                            for (int i = 0; i < tokens_size; i++) {
                                q.add(tokens[i]);
                            }
                        }
                        multi_para_class = true;
                    } else {
                        ;
                    }

                }
                // Does it start with a space and not have a # (for comment)
                else if (line.startsWith(" ") && !line.contains("#")) {
                    if (multi_para_class && !line.contains(")")) {
                        q.add(line);
                    } else if (multi_para_class && line.contains(")")) {
                        q.add(line);
                        multi_para_class = false;
                    } else if (line.contains("method") && line.contains("(") && line.contains(")")) {
                        String[] tokens = line.split(" ");
                        int tokens_size = tokens.length;
                        for (int i = 0; i < tokens_size; i++) {
                            q.add(tokens[i]);
                        }
                    } else if (line.contains("method") && line.contains("(") && !line.contains(")")) {
                        multi_para_method = true;
                        String[] tokens = line.split(" ");
                        int tokens_size = tokens.length;
                        for (int i = 0; i < tokens_size; i++) {
                            q.add(tokens[i]);
                        }
                    } else if (multi_para_method && !line.contains(")")) {
                        q.add(line);
                    } else if (multi_para_method && line.contains(")")) {
                        q.add(line);
                    } else {
                        ;
                    }
                } else {
                    ;
                }
            }

            br.close();
        } catch (Exception e) {
            System.out.println("Error: Invalid file name");
        }
        /* ---- End: File Code ---- */
        q.add("end");
        return q;
    }

    public static void json_maker(Queue<String> q, String name) {
        try {
            /* ----- Begin: Make the file ----- */
            File json_file = new File(name + ".json");
            if (json_file.createNewFile()) {
                System.out.println("File created: " + json_file.getName());
            } else {
                System.out.println("File already exists: " + name + ".json");
            }
            /* ----- End: Make the file ----- */
            /* ---- Begin: Write to the file ---- */
            FileWriter writer = new FileWriter(name + ".json");
            writer.write("{ ");
            /* ---- Begin: Remove our Queue ---- */

            // Top item of queue will always have the key word class + a name (super class)
            // or just word class + nothing. (regular class)
            Boolean regular_class = false;
            Boolean super_class = false;
            Boolean super_class_parameters = false;
            int q_size = q.size();
            int j = 0;
            while (j < q_size) {
                String data = q.remove();
                if (!data.isEmpty()) {
                    if (data.matches("class\\s+[aA-zZ]+\\s*")) {
                        System.out.println("we have a super class");
                        super_class = true;
                        String[] tokens = data.split(" ");
                        writer.write(" \"" + tokens[0] + "\": " + "\"" + tokens[1] + "\",\n");
                        writer.write("\"" + "super" + "\": " + "[");
                    } 
                    else if (data.matches("class\\s*")) {
                        System.out.println("we have a class");
                        regular_class = true;
                        writer.write(" \"" + data + "\": ");

                    }
                    else if(super_class && !data.contains("(") && !data.contains(")"))
                    {
                        writer.write("\"" + data + "\",");
                    }
                    else if(super_class && data.contains("(") && !data.contains(")"))
                    {   
                        data = data.replace("(","");
                        data = data.replace(" ","");
                        writer.write("\"" + data + "\"],");
                        super_class = false;
                        super_class_parameters = true;
                        writer.write("\n\"fields\": [");
                    }
                    else if(super_class_parameters && data.contains(",") && !data.contains(")"))
                    {
                        data = data.replace(" ", "");
                        data = data.replace(",", "");
                        writer.write("\"" + data + "\",");
                    }
                    else if(super_class_parameters && !data.contains(",") && !data.contains(")"))
                    {
                        data = data.replace(" ", "");
                        data = data.replace(",", "");
                        writer.write("\"" + data + "\"]");
                    }
                    else if(super_class_parameters && !data.contains(",") && data.contains(")"))
                    {
                        data = data.replace(" ", "");
                        data = data.replace(")", "");
                        writer.write("\"" + data + "\"]");
                        super_class_parameters = false;
                    }
                    System.out.println(data);
                }
                j++;
            }
            /* ---- End: Remove our Queue ---- */
            writer.write(" }");
            writer.close();
            /* ---- End: Write to file ----- */

        } catch (IOException e) {
            System.out.println("An error occurred.");
        }
    }
}