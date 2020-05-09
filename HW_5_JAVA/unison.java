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

                // Do we have a comment? If so ignrore it.
                if(line.matches("^\\s*#.*"))
                {
                    ;
                }
                // Does it start with "class"
                else if (line.startsWith("class")) {
                    if (line.contains("(") && line.contains(")") && !line.contains("\"")) {
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
                    else if (line.startsWith("class") && line.contains("(") && !line.contains(")") && !line.contains("\"")) {
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
                    } else if (line.contains("method") && line.contains("(") && line.contains(")") && !line.contains("\"")) {
                        String[] tokens = line.split(" ");
                        int tokens_size = tokens.length;
                        for (int i = 0; i < tokens_size; i++) {
                            q.add(tokens[i]);
                        }
                    } else if (line.contains("method") && line.contains("(") && !line.contains(")") && !line.contains("\"")) {
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
                        multi_para_method = false;
                    } else {
                        ;
                    }
                }
                
                // Does it start with a space and have a comment in it
                else if(line.startsWith("   ") && line.contains("#") && !line.contains(":=") && !line.contains("="))
                {
                    if(line.matches("\\s+method.*"))
                    {
                        String [] tokens = line.split("#");
                        q.add(tokens[0]);
                    }
                    else if(line.contains(",") && line.startsWith("   "))
                    {
                        String [] tokens = line.split("#");
                        q.add(tokens[0]);
                    }
                    else if(!line.contains(",") && line.startsWith("   "))
                    {
                        String [] tokens = line.split("#");
                        q.add(tokens[0]);
                    }
                }
                else
                {
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
            Boolean method = false;
            Boolean method_parameters = false;
            int classes_seen = 0;
            int q_size = q.size();
            int j = 0;
            while (j < q_size) {
                String data = q.remove();
                if (!data.isEmpty()) {
                    System.out.println(data);
                    if (data.matches("class\\s+[aA0-zZ9]+\\s*")) {
                        super_class = true;
                        classes_seen = classes_seen + 1;
                        String[] tokens = data.split(" ");
                        writer.write(" \"" + tokens[0] + "\": " + "\"" + tokens[1] + "\",\n");
                        writer.write("\"" + "super" + "\": " + "[");
                    } 
                    else if (data.matches("class\\s*")) {
                        regular_class = true;
                        classes_seen = classes_seen + 1;
                        writer.write(" \"" + data + "\": ");
                    }
                    else if(super_class && data.matches("\\s*[aA0-zZ9]+\\s*\\(\\s*\\)"))
                    {
                        data = data.replace("(","");
                        data = data.replace(")","");
                        data = data.replace(" ","");
                        writer.write("\"" + data + "\"" + "]\n,");
                        writer.write("\"" + "methods" + "\": {");
                        super_class = false;
                    }
                    else if(super_class && data.contains("(") && data.contains(",") && data.contains(")"))
                    {
                        String[] tokens = data.split("\\(");
                        String str1 = tokens[0];
                        String str2 = tokens[1];
                        str1 = str1.replace(" ","");
                        writer.write("\"" + str1 + "\"],\n" + "\"" + "fields" + "\": [");
                        str2 = str2.replace(")","");
                        String[] tokens2 = str2.split(",");
                        int tokens2_size = tokens2.length;
                        for(int i =0;i<(tokens2_size-1);i++)
                        {
                            writer.write("\"" + tokens2[i] + "\",");
                        }
                        String str3 = tokens2[tokens2_size-1];
                        str3 = str3.replace(")","");
                        writer.write("\"" + str3 + "\"],\n");
                        writer.write("\"" + "methods" + "\": {");
                        super_class = false;
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
                    else if(super_class && data.contains("(") && data.contains(")") && !data.contains(","))
                    {
                        String [] tokens = data.split("\\(");
                        String str1 = tokens[0];
                        String str2 = tokens[1];
                        str1 = str1.replace("(","");
                        str1 = str1.replace(")","");
                        str1 = str1.replace(" ","");
                        str2 = str2.replace("(","");
                        str2 = str2.replace(")","");
                        str2 = str2.replace(" ","");
                        writer.write("\"" + str1 + "\"],");
                        super_class = false;
                        writer.write("\n\"fields\": [" + "\"" + str2 + "\"],\n" + "\"methods\": { ");
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
                        writer.write("\"" + data + "\"],\n");
                    }
                    else if(super_class_parameters && !data.contains(",") && data.contains(")"))
                    {
                        super_class_parameters = false;
                        writer.write("\"" + "methods" + "\": {");
                    }
                    else if(regular_class && data.matches("\\s*[aA0-zZ9]+\\s*\\(\\s*\\)\\s*"))
                    {
                        data = data.replace("(","");
                        data = data.replace(")","");
                        data = data.replace(" ","");
                        writer.write("\"" + data + "\",\n");
                        writer.write("\"" + "methods" + "\": {");
                        regular_class = false;
                    }
                    else if(regular_class && data.contains("(") && !data.contains(")"))
                    {
                        data = data.replace("(","");
                        writer.write("\"" + data + "\",\n" + "\"" + "fields" + "\": [");
                    }
                    else if(regular_class && data.contains(","))
                    {
                        data = data.replace(",","");
                        data = data.replace(" ","");
                        writer.write("\"" + data + "\",");
                    }
                    else if(regular_class && !data.contains(",") && !data.contains(")"))
                    {
                        data = data.replace(" ","");
                        writer.write("\"" + data + "\"],\n");
                    }
                    else if(regular_class && !data.contains(",") && data.contains(")"))
                    {
                        regular_class = false;
                        writer.write("\"" + "methods" + "\": {");
                    }
                    else if(data.matches("\\s*method\\s*"))
                    {
                        method = true;
                    }
                    else if(method && data.matches("\\s*[aA0-zZ9]+\\s*\\(\\s*\\)"))
                    {
                        data = data.replace("(","");
                        data = data.replace(")","");
                        data = data.replace(" ","");
    
                        if(q.peek() == "end")
                        {
                            writer.write(" \"" + data + "\":" + " [] }");
                        }
                        else
                        {
                            writer.write(" \"" + data + "\":" + " [],");
                        }
                        method = false;
                    }
                    else if(method && data.contains("(") && !data.contains(",") && data.contains(")"))
                    {
                        String [] tokens = data.split("\\(");
                        String str1 = tokens[0];
                        String str2 = tokens[1];
                        str1 = str1.replace(" ","");
                        str2 = str2.replace(" ","");
                        str2 = str2.replace(")","");

                        if(q.peek() == "end")
                        {
                            writer.write(" \"" + str1 + "\":" + " [" + "\"" + str2 + "\"" + "] }");
                        }
                        else
                        {
                            writer.write(" \"" + str1 + "\":" + " [" + "\"" + str2 + "\"" + "],");
                        }
                        method = false;
                    }
                    else if(method && data.contains("(") && data.contains(",") && data.contains(")"))
                    {
                        String [] tokens = data.split("\\(");
                        String str1 = tokens[0];
                        String str2 = tokens[1];
                        str1 = str1.replace(" ","");
                        str1 = str1.replace(")","");
                        String [] tokens2 = str2.split(",");
                        int tokens2_size = tokens2.length;

                        writer.write(" \"" + str1 + "\":" + " [");
                        for(int i=0;i<(tokens2_size-1);i++)
                        {
                            String str3 = tokens2[i];
                            str3 = str3.replace(" ","");
                            str3 = str3.replace(")","");
                            writer.write(" \"" + str3 + " \",");
                        }
                        String str4 = tokens2[tokens2_size-1];
                        str4 = str4.replace(" ","");
                        str4 = str4.replace(")","");
                        writer.write(" \"" + str4 + "\"],\n");

                        if(q.peek() == "end")
                        {
                            writer.write("}");
                        }
                        method = false;
                    }
                    else if(method && data.contains("(") && data.contains(",") && !data.contains(")"))
                    {
                        String [] tokens = data.split("\\(");
                        String str1 = tokens[0];
                        String str2 = tokens[1];

                        str1 = str1.replace(" ","");
                        str2 = str2.replace(",","");
                        str2 = str2.replace(" ","");

                        method_parameters = true;
                        writer.write("\"" + str1 + "\":" + "[" + "\"" + str2 + "\",");
                    }
                    else if(method_parameters && data.contains(",") && !data.contains(")"))
                    {
                        data = data.replace(",","");
                        data = data.replace(" ","");
                        if(q.peek() == "end" || q.peek() == "method")
                        {
                            writer.write("\"" + data + "\"]");
                        }
                        else
                        {
                            writer.write("\"" + data + "\",");
                        }
                    }
                    else if(method_parameters && !data.contains(",") && data.contains(")"))
                    {
                        method_parameters = false;
                        data = data.replace(" ","");
                        data = data.replace(")","");
                        if(q.peek() == "end")
                        {
                            writer.write("\"" + data + "\"] }");
                        }
                        else
                        {
                            writer.write("\"" + data + "\"],");
                        }
                    }
                    else if(method_parameters && data.contains(",") && data.contains(")"))
                    {
                        method_parameters = false;
                        String [] tokens = data.split(",");
                        int tokens_size = tokens.length;

                        for(int i=0;i<(tokens_size-1);i++)
                        {
                            String str1 = tokens[i];
                            str1 = str1.replace(",","");
                            str1 = str1.replace(" ","");
                            writer.write("\"" + str1 + "\"," );
                        }
                        String str2 = tokens[tokens_size-1];
                        str2 = str2.replace(" ","");
                        str2 = str2.replace(")","");
                        if(q.peek() == "end")
                        {
                            writer.write("\"" + str2 + "\"] }");
                        }
                        else
                        {
                            writer.write("\"" + str2 + "\"],");
                        }
                    }
                    else
                    {
                        ;
                    }
                }
                j++;
            }
            /* ---- End: Remove our Queue ---- */
            for(int i = 0;i<classes_seen;i++)
            {
                writer.write(" }");
            }
            writer.close();
            /* ---- End: Write to file ----- */

        } catch (IOException e) {
            System.out.println("An error occurred.");
        }
    }
}