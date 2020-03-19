(* MLStone Game for CS210
** Carlos Santos
** CS 210
** 03/22/2020
** Uniersity of Idaho
*)


(* The Game Intro
** The "print" funtion is similar to "printf" in C
*)



val menu = 1;
val welcome = 1;
print "Hello Player! \nWelcome to MLStone";
print "Please Enter your name: ";

(* grab user input.  Remeber it grabs \n as well
*)

val myLine = valOf(TextIO.inputLine TextIO.stdIn);
val myLineMod = String.substring(myLine, 0, size myLine - 1); (* Remove the "\n" from the input*)

print ("Welcome player: " ^ myLineMod ^ " !");

val menu_items = ("Please Select one of the options below: \n","Opton 1: Start Game! ", "Option 2: Exit Game! "); (* This is the menu item tuple  *)


print(#1 menu_items); (* prnt  out the options from the menu one at a time *)
print(#2 menu_items);
print(#3 menu_items);


fun welcomscreentest x = (* This worls! *)
        if x > 0 then ( print("Hello World");
          print("This is a test");
          print("For multi line functions");
          print("Inside SMLNJ")
        )
        else print("Error: Out of bound value.");
