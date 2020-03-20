(* MLStone Game for CS210
** Carlos Santos
** CS 210
** 03/22/2020
** Uniersity of Idaho
*)

val menu_items = ("Please Select one of the options below:\n","Option 1: Start Game!\n", "Option 2: Exit Game!\n"); (* This is the menu item tuple  *)

(* ----- func defs: Begin ----- *)
fun welcome_screen () =
  (
    print("Hello welcome to MLStone!\n");
    print("A knock off knock off of HeartStone LOL!\n");
    print("You will be asked for your name shortly. You'll be playing against a CPU\n\n")
  );

fun print_menu_items () =
  ( print(#1 menu_items); (* prnt  out the options from the menu one at a time *)
    print(#2 menu_items);
    print(#3 menu_items)
  );

fun get_input () =
  case TextIO.inputLine TextIO.stdIn of
    NONE => ""
    | SOME v => v;

fun game_loop x =
  if x = "1" then print("Game is starting!......")
  else if x = "2" then print("game is exiting")
  else (print("Not valid option. Try again\n\n");
        print_menu_items();
        (* How to use let in end
          reference: https://www.cs.cornell.edu/courses/cs312/2004fa/lectures/rec21.html 
        *)
        let
          val menu_option = get_input()
          val menu_option = String.substring(menu_option, 0, size menu_option - 1)
        in
          (* To run functions inside let use a set of ( ) around the function
            If you are going to use more than one seperate then by ,
            reference: https://stackoverflow.com/questions/43081978/how-to-call-two-functions-in-a-let-in-in-sml-nj
          *)
          (game_loop(menu_option))
        end
  );


(* ----- func defs: End ----- *)

welcome_screen();
val myLine = get_input();
val myLineMod = String.substring(myLine, 0, size myLine - 1); (* Remove the "\n" from the input*)
print ("Welcome player: " ^ myLineMod ^ " !");
print_menu_items();

val menu_option = get_input();
val menu_option = String.substring(menu_option, 0, size menu_option - 1);
game_loop(menu_option);


