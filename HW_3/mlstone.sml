(* MLStone Game for CS210
** Carlos Santos
** CS 210
** 03/22/2020
** Uniersity of Idaho
*)
;#set CM.Control.verbose false;

val menu_items = ("Please Select one of the options below:\n","Option 1: Start\n", "Option 2: Quit\n"); (* This is the menu item tuple  *)
(* Load in another .sml file into the main sml file
  Reference: https://www.classes.cs.uchicago.edu/archive/2006/fall/15300-1/handouts/sml-load.pdf
*)
use "game.sml"; 

val game_loop_items = ("Start","Quit: Quits game.\n","End: Ends Turn\n","Play: Play a spell on monstor or AI\n","Attack: Attack a monstor, or AI\n");


(* ----- func defs: Begin ----- *)
fun welcome_screen () =
  (
    print("\n\nHello welcome to MLStone!\n");
    print("A knock off knock off of HeartStone LOL!\n");
    print("You will be asked for your name shortly. You'll be playing against a CPU\n\n")
  );

fun print_menu_items () =
  ( print(#1 menu_items); (* print  out the options from the menu one at a time *)
    print(#2 menu_items);
    print(#3 menu_items)
  );

fun print_game_loop_items () =
  (
    print("Please Select an option to continue:\n");
    print(#2 game_loop_items);
    print(#3 game_loop_items);
    print(#4 game_loop_items);
    print(#5 game_loop_items)
  );

fun get_input () =
  case TextIO.inputLine TextIO.stdIn of
    NONE => ""
    | SOME v => v;

fun length(L) =
  (* Grab the length of a list: https://stackoverflow.com/questions/37575769/computes-the-length-of-list-which-contains-list-sml#37601413 *)
  if (L=nil) then 0
  else 1+length(tl(L));

(* Function to print eeach card 
  We know each card has 5 elements to it: 
  energy cost, spell power, name, attack, health*)

fun print_all_hand (L:(int*bool*string*int*int) list,i) = (* Note: When stuff is vague it's better to specify stuff *)
  if L=nil then print("Empty hand!")
  else if i < 0 then print("\n\n\n")
  else (
      let
        val tuple = List.nth(L,i)
        val spot1 = #1 tuple;
        val spot2 = #2 tuple;
        val spot3 = #3 tuple;
        val spot4 = #4 tuple;
        val spot5 = #5 tuple;

      in  
        print("Card " ^ Int.toString(i) ^ ": ");
        print("\t Energy Cost: " ^ Int.toString(spot1));
        print("\t Spell Power: " ^ Bool.toString(spot2));
        print("\t Name: " ^ spot3);
        print("\t Attack: " ^ Int.toString(spot4));
        print("\t Health: " ^ Int.toString(spot5));
        print("\n\n");
        print_all_hand(L,i-1)
      end
    );

fun user_attack (L1:(int*bool*string*int*int) list,L2:(int*bool*string*int*int) list,x:int,y:int) =
  (
    if x >= 0  then (
      if x <= (length(L1) - 1) then (
        let
          val cardx = List.nth(L1,x)
          val cardy = List.nth(L2,y)
          val cardx_cost = #1 cardx;
          val cardx_spell =  #2 cardx;
          val cardx_attack = #4 cardx;
          val cardx_health = #5 cardx;
          val cardy_cost = #1 cardy;
          val cardy_spell =  #2 cardy;
          val cardy_attack = #4 cardy;
          val cardy_health = #5 cardy;
          val newcardy_health = cardy_health - cardx_attack;
        in
          (if cardx_spell = false then (
            if cardy_spell = false then (
              print("\n\nAttack is valid. Starting attack.\n\n")
              
            )
            else print("\n\nCan't attack a spell card!\n\n")
            )
            else print("\n\nCan't attack a spell card!\n\n"))
        end
      )
      else print("\n\nNot a valid card!\n\n")
    )
    else print("\n\nNot a valid card!\n\n")
  );  

fun user_play (L1:(int*bool*string*int*int) list,L2:(int*bool*string*int*int) list,x:int,y:int) =
  (
    if x >= 0  then (
      if x <= (length(L1) - 1) then (
        let
          val cardx = List.nth(L1,x)
          val cardy = List.nth(L2,y)
          val cardx_cost = #1 cardx;
          val cardx_spell =  #2 cardx;
          val cardx_attack = #4 cardx;
          val cardx_health = #5 cardx;
          val cardy_cost = #1 cardy;
          val cardy_spell =  #2 cardy;
          val cardy_attack = #4 cardy;
          val cardy_health = #5 cardy;
          val newcardy_health = cardy_health - cardx_attack;
        in
          (if cardx_spell = true then (
            if cardy_spell = false then (
              print("\n\nSpell Attack is valid. Starting attack.\n\n")
              
            )
            else print("\n\nNot a Spell card!\n\n")
            )
            else print("\n\nNot a Spell card!\n\n"))
        end
      )
      else print("\n\nNot a valid card!\n\n")
    )
    else print("\n\nNot a valid card!\n\n")
  );  

fun game_loop x =
  if x = "Start" then (
    print_game_loop_items();
    let
      val menu_option = get_input()
      val menu_option = String.substring(menu_option, 0, size menu_option - 1)
    in
      (game_loop(menu_option))
    end
  )

  else if x = "Quit" then ( print("Game is exiting.....");
    OS.Process.exit(OS.Process.success))
  
  else if x = "End" then print("End")

  else if x = "Play" then (
    print("Enter only the card number!\n");
    print("Play which spell card #?:\n");

    let
      val strinput1 = get_input()   
      val strinput1 = String.substring(strinput1, 0, size strinput1 - 1)
    in
      print("Selecting card: " ^ strinput1 ^ ".......\n");
      print("Play spell on card#?:\n");
      let
        val strinput2 = get_input()   
        val strinput2 = String.substring(strinput2, 0, size strinput2 - 1)
      in
        print("\nCasting spell card: " ^ strinput2 ^ ".......\n");
        (* The line below means: pass in a List, int, int. We have to convert and grab the int option value*)
        user_play(Hand,AIHand,valOf(Int.fromString(strinput1)),valOf(Int.fromString(strinput2))); 
        game_loop("Start")
      end
    end
  )  

  else if x = "Attack" then (
    print("Enter only the card number!\n");
    print("Attack with which card #?:\n");

    let
      val strinput1 = get_input()   
      val strinput1 = String.substring(strinput1, 0, size strinput1 - 1)
    in
      print("Selecting card: " ^ strinput1 ^ ".......\n");
      print("Attack card#?:\n");
      let
        val strinput2 = get_input()   
        val strinput2 = String.substring(strinput2, 0, size strinput2 - 1)
      in
        print("\nAttacking card: " ^ strinput2 ^ ".......\n");
        (* The line below means: pass in a List, int, int. We have to convert and grab the int option value*)
        user_attack(Hand,AIHand,valOf(Int.fromString(strinput1)),valOf(Int.fromString(strinput2))); 
        game_loop("Start")
      end
    end
  )

  else (print("Not valid option. Try again\n\n");
        print_game_loop_items();
        let
          val menu_option = get_input()
          val menu_option = String.substring(menu_option, 0, size menu_option - 1)
        in
          (game_loop(menu_option))
        end
  );

fun Intro_loop x =
  if x = "Start" then (
    print("Game is starting!...... \n\n\n");
    print("Your current hand is.......: \n");
    print_all_hand(Hand,(length(Hand) - 1));
    print("AIHand current hand is.......: \n");
    print_all_hand(AIHand,(length(Hand) - 1));
    game_loop("Start")
  )
  else if x = "Quit" then ( print("Game is exiting.....");
                        (* How to terminate current sml program
                          Reference: https://smlnj.org/doc/FAQ/usage.html
                        *)
                        OS.Process.exit(OS.Process.success)  
                        )
  else (print("Not valid option. Try again\n\n");
        print_menu_items();
        (* How to use let in end
          Reference: https://www.cs.cornell.edu/courses/cs312/2004fa/lectures/rec21.html 
        *)
        let
          val menu_option = get_input()
          (* Remove \n f rom the string:  String.substring(str,start,end) *)
          val menu_option = String.substring(menu_option, 0, size menu_option - 1)
        in
          (* To run functions inside let use a set of ( ) around the function
            If you are going to use more than one seperate then by ,
            Reference: https://stackoverflow.com/questions/43081978/how-to-call-two-functions-in-a-let-in-in-sml-nj
          *)
          (Intro_loop(menu_option))
        end
  ); 
(* ----- func defs: End ----- *)

welcome_screen();
print("What is your name:\n");
val myLine = get_input();
val myLineMod = String.substring(myLine, 0, size myLine - 1); (* Remove the "\n" from the input*)
print ("\n\nWelcome player: " ^ myLineMod ^ " !\n\n");
print_menu_items();

val menu_option = get_input();
val menu_option = String.substring(menu_option, 0, size menu_option - 1);
Intro_loop(menu_option);


