(* Game data file for MLStone
** Carlos Santos 
** CS 210
** 03/22/2020
** Uniersity of Idaho
*)


val Health=50;
val AIHealth=50;
val Hand=[	     (1, false, "C slug", 0, 1),
	     (1, false, "int", 1, 1),
	     (1, true, "++", 0, 1),
	     (1, true, "^=", 4, 0),
	     (2, false, "for (;;)", 2, 2),
	     (3, false, "switch", 3, 3),
	     (4, false, "array a[100]", 4, 4),
	     (4, true, "Bus Error Fireball", 6, 0)
            ];

val AIHand=[     (1, true, "Atom", 0, 1),
	     (1, true, "Car", 1, 0),
	     (1, true, "Cdr", 2, 0),
	     (1, false, "Parenthesis", 1, 1),
	     (2, false, "Cons Cell", 2, 1),
	     (2, false, "defun", 3, 2),
	     (3, true, "Mapcar", 4, 0),
	     (4, false, "ML Monster", 2, 6)
            ];