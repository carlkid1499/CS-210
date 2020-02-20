/*
 * These integer codes correspond to production rules in c-calctree.y
 * The numbers are almost arbitrary, except (a) we'd like to not overlap
 * with any terminal symbol codes, including ASCII codes, and (b) ideally
 * it would be trivial to tell from the code what non-terminal is involved.
 */

#define START 1000

/* object rules here */
#define OBJECT 2000
#define OBJECT_R1 2001
#define OBJECT_R2 2002
/* end of object rules here */

/* object_center rules here */
#define OBJECT_CENTER 3000
#define OBJECT_CENTER_R1 3001
#define OBJECT_CENTER_R2 3002
/* end of ebject_center rules here */

/* array rules here */
#define ARRAY 4000
#define ARRAY_R1 4001
/* end of array rules here */

/* number rules here */
#define NUMBER 5000
#define NUMBER_R1 5001
#define NUMBER_R2 5002
#define NUMBER_R3 5003
#define NUMBER_R4 5004
#define NUMBER_R5 5005
#define NUMBER_R6 5006
#define NUMBER_R7 5007
/* end of number rules here */

/* value rules here */
#define VALUE 6000
#define VALUE_R1 6001
#define VALUE_R2 6002
#define VALUE_R3 6003
#define VALUE_R4 6004
#define VALUE_R5 6005
#define VALUE_R6 6006
#define VALUE_R7 6007
/* end of value rules */

/* array_center rules here */
#define ARRAY_CENTER 7000
#define ARRAY_CENTER_R1 7001
#define ARRAY_CENTER_R2 7001