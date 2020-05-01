/* Carlos Santos
** CS 210 HW 5
** Goal: Read in 1 or more unicon (.icn) files and produce a
** .json output. 
** http://www2.cs.uidaho.edu/~jeffery/courses/210/hw5.html
**
*/

/* ----- Java Libraries that are needed ----- */
import java.io.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.LinkedList;
import java.util.Queue;

/* ----- Main program class ----- */
class unison {

    public static void main(String args[]) {
        int argsLength = args.length;
        if (argsLength > 0) {
            for (int argsCount = 0; argsCount <= (argsLength - 1); argsCount++) {
                System.out.println("args[" + argsCount + "] :" + args[argsCount]);
                unison.icn_parser(args[argsCount]);
            }
        } else {
            System.out.println("No arguments passed");
        }

    }

    public static void icn_parser(String name) {
        /* ----- Begin: Reg Expression ----- */
        String class_type = "class(\\s+[aA-zZ]+\\(.*\\))";
        String method_type = "method(\\s+[aA-zZ]+\\(.*\\))";
        /* ----- Begin: Initilize o)ur Queue ---- */
        Queue<String> q = new LinkedList<>();
        /* ---- End: Initilize our Queue ---- */
        // Create a Pattern object
        Pattern class_type_p = Pattern.compile(class_type);
        Pattern method_type_p = Pattern.compile(method_type);
        /* ----- Begin: File Code ----- */
        try {
            // constructor of file class having file as argument
            File file = new File(name);
            FileInputStream fis = new FileInputStream(file); // opens a connection to an actual file
            BufferedReader br = new BufferedReader(new InputStreamReader(fis));
            System.out.println("file content: "); // Prints one line at a time
            String line;
            while ((line = br.readLine()) != null) {
                //System.out.println(line); // prints the content of the file
                // Create matcher object
                Matcher class_type_m = class_type_p.matcher(line);
                Matcher method_type_m = method_type_p.matcher(line);

                while (class_type_m.find()) {
                    q.add(class_type_m.group());
                    System.out.println("start(): " + class_type_m.start());
                    System.out.println("end(): " + class_type_m.end());
                }

                while (method_type_m.find()) {
                    q.add(method_type_m.group());
                    System.out.println("start(): " + method_type_m.start());
                    System.out.println("end(): " + method_type_m.end());
                }
            }
            br.close();
        } catch (Exception e) {
            System.out.println("Error: Invalid file name");
        }
        /* ---- End: File Code ---- */

        int q_size = q.size();
        int j = 0;
        while (j < q_size) {
            String data = q.remove();
            System.out.println("Queue Remove: " + data);
            j++;
        }
        /* ----- End: Reg Expressions ----- */

    }

}