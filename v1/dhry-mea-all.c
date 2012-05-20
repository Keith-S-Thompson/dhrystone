/******************************************************************************/
/*                                                                            */
/*                   "DHRYSTONE" Benchmark Program                            */
/*                   -----------------------------                            */
/*                                                                            */
/*  Version:   C / 2 (Measurement Version, for Berkeley UNIX C, in one file)  */
/*                   (Version without register variables)                     */
/*                                                                            */
/*  File:      dhry-mea-all.c                                                 */
/*                                                                            */
/*  Date:      Oct. 1984                                                      */
/*                                                                            */
/*  Author:    Reinhold P. Weicker                                            */
/*                                                                            */
/******************************************************************************/
/*                                                                            */
/*  This version uses calls to the C runtime library of the Berkeley          */
/*  UNIX system (4.2 bsd) for time measurement. For measurements on other     */
/*  systems, these calls need to be modified.                                 */
/*                                                                            */
/******************************************************************************/
/*                                                                            */
/*  The following program contains statements of a high level programming     */
/*  language (here: C) in a distribution considered representative:           */
/*                                                                            */
/*    assignments                  52 (51.0 %)                                */
/*    control statements           33 (32.4 %)                                */
/*    procedure, function calls    17 (16.7 %)                                */
/*                                                                            */
/*  102 statements are dynamically executed. The program is balanced with     */
/*  respect to the three aspects:                                             */
/*                                                                            */
/*    - statement type                                                        */
/*    - operand type                                                          */
/*    - operand locality                                                      */
/*         operand global, local, parameter, or constant.                     */
/*                                                                            */
/*  The combination of these three aspects is balanced only approximately.    */
/*                                                                            */
/*  1. Statement Type:                                                        */
/*  -----------------             number                                      */
/*                                                                            */
/*     V1 = V2                     9                                          */
/*       (incl. V1 = F(..)                                                    */
/*     V = Constant               12                                          */
/*     Assignment,                 7                                          */
/*       with array element                                                   */
/*     Assignment,                 6                                          */
/*       with record component                                                */
/*                                --                                          */
/*                                34       34                                 */
/*                                                                            */
/*     X = Y +|-|"&&"|"|" Z        5                                          */
/*     X = Y +|-|"==" Constant     6                                          */
/*     X = X +|- 1                 3                                          */
/*     X = Y *|/ Z                 2                                          */
/*     X = Expression,             1                                          */
/*           two operators                                                    */
/*     X = Expression,             1                                          */
/*           three operators                                                  */
/*                                --                                          */
/*                                18       18                                 */
/*                                                                            */
/*     if ....                    14                                          */
/*       with "else"      7                                                   */
/*       without "else"   7                                                   */
/*           executed        3                                                */
/*           not executed    4                                                */
/*     for ...                     6  |  counted every time                   */
/*     while ...                   4  |  the loop condition                   */
/*     do ... while                1  |  is evaluated                         */
/*     switch ...                  1                                          */
/*     break                       1                                          */
/*     declaration with            1                                          */
/*       initialization                                                       */
/*                                --                                          */
/*                                33       33                                 */
/*                                                                            */
/*     P (...)  procedure call    11                                          */
/*       user procedure      10                                               */
/*       library procedure    1                                               */
/*     X = F (...)                                                            */
/*             function  call      6                                          */
/*       user function        5                                               */
/*       library function     1                                               */
/*                                --                                          */
/*                                17       17                                 */
/*                                        ---                                 */
/*                                        102                                 */
/*                                                                            */
/*    The average number of parameters in procedure or function calls         */
/*    is 1.82 (not counting the function values as implicit parameters).      */
/*                                                                            */
/*                                                                            */
/*  2. Operators                                                              */
/*  ------------                                                              */
/*                          number    approximate                             */
/*                                    percentage                              */
/*                                                                            */
/*    Arithmetic             31          50.8                                 */
/*                                                                            */
/*       +                     20          32.8                               */
/*       -                      7          11.5                               */
/*       *                      3           4.9                               */
/*       / (int div)            1           1.6                               */
/*                                                                            */
/*    Comparison             26           42.6                                */
/*                                                                            */
/*       ==                     9           14.8                              */
/*       /=                     4            6.6                              */
/*       >                      1            1.6                              */
/*       <                      3            4.9                              */
/*       >=                     1            1.6                              */
/*       <=                     8           13.1                              */
/*                                                                            */
/*    Logic                   4            6.6                                */
/*                                                                            */
/*       && (AND-THEN)          1            1.6                              */
/*       |  (OR)                1            1.6                              */
/*       !  (NOT)               2            3.3                              */
/*                                                                            */
/*                           --          -----                                */
/*                           61          100.0                                */
/*                                                                            */
/*                                                                            */
/*  3. Operand Type (counted once per operand reference):                     */
/*  ---------------                                                           */
/*                          number    approximate                             */
/*                                    percentage                              */
/*                                                                            */
/*     Integer               171        71.8 %                                */
/*     Character              45        18.9 %                                */
/*     Pointer                12         5.0 %                                */
/*     String30                6         2.5 %                                */
/*     Array                   2         0.8 %                                */
/*     Record                  2         0.8 %                                */
/*                           ---       -------                                */
/*                           238        99.8 %                                */
/*                                                                            */
/*  When there is an access path leading to the final operand (e.g. a record  */
/*  component), only the final data type on the access path is counted.       */
/*                                                                            */
/*                                                                            */
/*  4. Operand Locality:                                                      */
/*  -------------------                                                       */
/*                                number    approximate                       */
/*                                          percentage                        */
/*                                                                            */
/*     local variable              111        46.6 %                          */
/*     global variable              21         8.8 %                          */
/*     parameter                    45        18.9 %                          */
/*        value                        23         9.7 %                       */
/*        reference                    22         9.2 %                       */
/*     function result               6         2.5 %                          */
/*     constant                     55        23.1 %                          */
/*                                 ---       -------                          */
/*                                 238        99.9 %                          */
/*                                                                            */
/*                                                                            */
/*  It is assumed that C incorporates the feature "Structure Assignment"      */
/*  as described in "Recent Changes to C", Nov. 15, 1978, Berkeley UNIX       */
/*  (Otherwise, the structure assignments in Proc_1 have to be replaced       */
/*  by calls to a suitable subroutine).                                       */
/*  Also, the following subroutines of the Berkeley UNIX C library are used:  */
/*  strcpy (string copy), strcmp (string comparison)                          */
/*                                                                            */
/*  The program does not compute anything meaningful, but it is syntactically */
/*  and semantically correct. All variables have a value assigned to them     */
/*  before they are used as a source operand.                                 */
/*                                                                            */
/*  There may be cases where a highly optimizing compiler may recognize       */
/*  unnecessary statements and may not generate code for them.                */
/*                                                                            */
/*  There has been no explicit effort to account for the effects of a         */
/*  cache, or to balance the use of long or short displacements for code or   */
/*  data.                                                                     */
/*                                                                            */
/******************************************************************************/
/*                                                                            */
/*  The program structure of the C version is assumed to be similar to the    */
/*  Ada version: There are three modules where two modules contain the        */
/*  executable routines of the program (one of them containing the            */
/*  procedure "main" and the  global variables), and one contains global      */
/*  type definitions (the other modules use an "#include" to refer to it).    */
/*                                                                            */
/*  For many C systems there will be no difference in execution time between  */
/*  the two cases                                                             */
/*  (1) the three modules are compiled separately and linked together later,  */
/*  (2) the three modules are merged into one source file.                    */
/*  However, for some machines there may be a difference since different      */
/*  representations may be used for addresses (e.g., 16 bit or 32 bit),       */
/*  depending on the compilation model used.                                  */
/*                                                                            */
/*  If there is a difference in execution time, the times for both models     */
/*  should be measured; model (1) is the one that corresponds more to actual  */
/*  software development.                                                     */
/*                                                                            */
/*  This file contains a sample "measurement" version of Dhrystone/C,         */
/*  with statements for measurement on a VAX 11/780 running Berkeley UNIX     */
/*  (4.2 bsd), with the program in one source file.                           */
/*  For a version with the three modules in separate source files,            */
/*  see the files dhry-mea-pt1.c, ..., dhry-mea-pt3.c.                        */
/*                                                                            */
/******************************************************************************/

/***************************************************/
/*  Begin of the first module (global definitions) */
/***************************************************/

#include <stdio.h>
                /* for strcpy, strcmp */
#include <sys/types.h>
#include <sys/times.h>
                /* for time measurement */

#define Null 0 
                /* Value of a Null pointer */

#define true  1
#define false 0

#define Ident_1 0
#define Ident_2 1
#define Ident_3 2
#define Ident_4 3
#define Ident_5 4
                /* for boolean and enumeration types in Ada, Pascal */

                /* definitions for execution time measurement */

#define Large_Time              1000000.0
#define Number_Of_Executions    10000
#define Number_Of_Runs          10
#define Microseconds_Per_Clock  1000000.0
                /* UNIX C returns process times in seconds/Frequency */
#define Frequency               60
                /* power supply with frequency 60 Hz */

                /* end of definitions for execution time measurement */

/* Global type definitions */

typedef int  Enumeration;

typedef int  One_To_Thirty;
typedef int  One_To_Fifty;
typedef char Capital_Letter;
typedef int  Boolean;


typedef struct record 
    {
    struct record *Pointer_Comp;
    Enumeration    Discr;
    union {
          struct {
                  Enumeration Enum_Comp;
                  int         Int_Comp;
                  char        String_Comp [31];
                  } variant_1;
          struct {
                  Enumeration Enum_Comp_2;
                  char        String_Comp_2 [31];
                  } variant_2;
          struct {
                  char        Char_Comp_1;
                  char        Char_Comp_2;
                  } variant_3;
          } variant;
      } Record_Type, *Record_Pointer;

/********************************/
/*  Begin of the second module  */
/********************************/

/* Global Variables */

Record_Pointer  Pointer_Glob,
                Next_Pointer_Glob;
int             Int_Glob;
Boolean         Bool_Glob;
char            Char_Glob_1,
                Char_Glob_2;
int             Array_Glob_1 [30];
int             Array_Glob_2 [30] [30];

Record_Type     First_Record,
                Second_Record;
                /* correspond to dynamically allocated variables       */
                /* in the Ada and Pascal versions                      */


main ()
/*****/
{

  int           Int_Loc_1,
                Int_Loc_2,
                Int_Loc_3;
  char          Char_Index;
  Enumeration   Enum_Loc;
  char          String_Loc_1 [31],
                String_Loc_2 [31];

  /* Variables for time measurement */

  struct tms    begin_time, 
                end_time;
                /* see system call "times" (UNIX bsd, 7th edition */
  int           Meas_Index,
                Run_Index; 
  float         User_Time,
                System_Time,
		Empty_Loop_User_Time,
		Empty_Loop_System_Time,
                Total_Time,
                Sum_User_Time,
                Sum_System_Time,
                Sum_Total_Time,
                Min_User_Time,
                Min_System_Time,
                Min_Total_Time,
                Aver_User_Time,
                Aver_System_Time,
                Aver_Total_Time;

  /* end of variables for time measurement */

  /* main program, corresponds to procedures        */
  /* Main and Proc_0 in the Ada version             */

  /* Initializations */

  Next_Pointer_Glob = &Second_Record;
  Pointer_Glob = &First_Record;
        /* Static allocation instead of dynamic allocation in Ada, Pascal     */
        /* Attempts to use "malloc" resulted in compiler warnings             */

  Pointer_Glob->Pointer_Comp                  = Next_Pointer_Glob;
  Pointer_Glob->Discr                         = Ident_1;
  Pointer_Glob->variant.variant_1.Enum_Comp    = Ident_3;
  Pointer_Glob->variant.variant_1.Int_Comp     = 40;
  strcpy (Pointer_Glob->variant.variant_1.String_Comp, 
          "DHRYSTONE PROGRAM, SOME STRING");
 
  strcpy (String_Loc_1, "DHRYSTONE PROGRAM, 1'ST STRING");

  printf ("\n");
  printf ("Dhrystone Benchmark (March 84), Version C / 2\n");
  printf ("(without register variables)\n");
  printf ("\n");
  printf ("All times are CPU times, in microseconds\n");
  printf ("\n");

  Sum_User_Time = 0.0;
  Sum_System_Time = 0.0;
  Sum_Total_Time = 0.0;
  Min_User_Time = Large_Time;
  Min_System_Time = Large_Time;
  Min_Total_Time = Large_Time;

  for (Run_Index = 1; Run_Index <= Number_Of_Runs; ++Run_Index)
  {

  /***************/
  /* Start timer */
  /***************/

  times (&begin_time);
 
  for (Meas_Index = 1; Meas_Index <= Number_Of_Executions; ++Meas_Index)
  {

    Proc_5();
    Proc_4();
      /* Char_Glob_1 == 'A', Char_Glob_2 == 'B', Bool_Glob == false */
    Int_Loc_1 = 2;
    Int_Loc_2 = 3;
    strcpy (String_Loc_2, "DHRYSTONE PROGRAM, 2'ND STRING");
    Enum_Loc = Ident_2;
    Bool_Glob = ! Func_2 (String_Loc_1, String_Loc_2);
      /* Bool_Glob == 1 */
    while (Int_Loc_1 < Int_Loc_2)  /* loop body executed once */
    {
      Int_Loc_3 = 5 * Int_Loc_1 - Int_Loc_2;
        /* Int_Loc_3 == 7 */
      Proc_7 (Int_Loc_1, Int_Loc_2, &Int_Loc_3);
        /* Int_Loc_3 == 7 */
      Int_Loc_1 += 1;
    } /* while */
      /* Int_Loc_1 == 3 */
    Proc_8 (Array_Glob_1, Array_Glob_2, Int_Loc_1, Int_Loc_3);
      /* Int_Glob == 5 */
    Proc_1 (Pointer_Glob);
    for (Char_Index = 'A'; Char_Index <= Char_Glob_2; ++Char_Index)
                             /* loop body executed twice */
    {
      if (Enum_Loc == Func_1 (Char_Index, 'C'))
          /* then, not executed */
        Proc_6 (Ident_1, &Enum_Loc);
    }
      /* Int_Loc_1 == 3, Int_Loc_2 == 3, Int_Loc_3 == 7 */
    Int_Loc_3 = Int_Loc_2 * Int_Loc_1;
    Int_Loc_2 = Int_Loc_3 / Int_Loc_1;
    Int_Loc_2 = 7 * (Int_Loc_3 - Int_Loc_2) - Int_Loc_1;
    Proc_2 (&Int_Loc_1);
   
  } /* loop "for Number_Of_Executions" */

  /**************/
  /* Stop timer */
  /**************/

  times (&end_time);

  User_Time = (end_time.tms_utime - begin_time.tms_utime) 
                * Microseconds_Per_Clock / (Frequency * Number_Of_Executions);
  System_Time = (end_time.tms_stime - begin_time.tms_stime) 
                * Microseconds_Per_Clock / (Frequency * Number_Of_Executions);

  /* Measure and subtract time for Number_Of_Executions empty loops */

  times (&begin_time);
  for (Meas_Index = 1; Meas_Index <= Number_Of_Executions; ++Meas_Index)
  {
    /* empty */
  }
  times (&end_time);
  Empty_Loop_User_Time = (end_time.tms_utime - begin_time.tms_utime) 
                * Microseconds_Per_Clock / (Frequency * Number_Of_Executions);
  Empty_Loop_System_Time = (end_time.tms_stime - begin_time.tms_stime) 
                * Microseconds_Per_Clock / (Frequency * Number_Of_Executions);

  User_Time = User_Time - Empty_Loop_User_Time;
  System_Time = System_Time - Empty_Loop_System_Time;

  Total_Time = User_Time + System_Time;

  printf ("User Time for run %2d", Run_Index);
  printf (": %4.4f \n", User_Time);
  printf ("System Time for run %2d", Run_Index);
  printf (": %4.4f \n", System_Time);

  Sum_User_Time += User_Time;
  Sum_System_Time += System_Time;
  Sum_Total_Time += Total_Time;
  if (User_Time < Min_User_Time)
    Min_User_Time = User_Time;
  if (System_Time < Min_System_Time)
    Min_System_Time = System_Time;
  if (Total_Time < Min_Total_Time)
    Min_Total_Time = Total_Time;

  } /* loop "for Run_Index" */

  Aver_User_Time = Sum_User_Time / Number_Of_Runs;
  Aver_System_Time = Sum_System_Time / Number_Of_Runs;
  Aver_Total_Time = Sum_Total_Time / Number_Of_Runs;
  
  printf ("\n");
  printf ("Average User Time: %4.4f \n", Aver_User_Time);
  printf ("Average System Time: %4.4f \n", Aver_System_Time);
  printf ("\n");
  printf ("Average Total Time: %4.4f \n", Aver_Total_Time);
  printf ("\n");
  printf ("Minimum User Time: %4.4f \n", Min_User_Time);
  printf ("Minimum System Time: %4.4f \n", Min_System_Time);
  printf ("\n");
  printf ("Minimum Total Time: %4.4f \n", Min_Total_Time);
  printf ("\n");

}


Proc_1 (Pointer_Par_Val)
/**********************/

Record_Pointer Pointer_Par_Val;
    /* executed once */
{
  Record_Pointer Next_Record = Pointer_Par_Val->Pointer_Comp;  
                                        /* == Pointer_Glob_Next */
  /* corresponds to "rename" in Ada, "with" in Pascasl  */
  
  *Pointer_Par_Val->Pointer_Comp = *Pointer_Glob; 
    /* This results in a structure assignment (C extension) */
  Pointer_Par_Val->variant.variant_1.Int_Comp = 5;
  Next_Record->variant.variant_1.Int_Comp 
        = Pointer_Par_Val->variant.variant_1.Int_Comp;
  Next_Record->Pointer_Comp = Pointer_Par_Val->Pointer_Comp;
  Proc_3 (&Next_Record->Pointer_Comp);
    /* Pointer_Par_Val->Pointer_Comp->Pointer_Comp 
                        == Pointer_Glob->Pointer_Comp */
  if (Next_Record->Discr == Ident_1)
    /* then, executed */
  {
    Next_Record->variant.variant_1.Int_Comp = 6;
    Proc_6 (Pointer_Par_Val->variant.variant_1.Enum_Comp, 
           &Next_Record->variant.variant_1.Enum_Comp);
    Next_Record->Pointer_Comp = Pointer_Glob->Pointer_Comp;
    Proc_7 (Next_Record->variant.variant_1.Int_Comp, 10, 
           &Next_Record->variant.variant_1.Int_Comp);
  }
  else /* not executed */
    *Pointer_Par_Val = *Pointer_Par_Val->Pointer_Comp; 
       /* This would result in a structure assignment (C extension) */
} /* Proc_1 */


Proc_2 (Int_Par_Ref)
/******************/
    /* executed once */
    /* *In_Par_Ref == 3, becomes 7 */

One_To_Fifty   *Int_Par_Ref;
{
  One_To_Fifty  Int_Loc;  
  Enumeration   Enum_Loc;

  Int_Loc = *Int_Par_Ref + 10;
  do /* executed once */
    if (Char_Glob_1 == 'A')
      /* then, executed */
    {
      Int_Loc -= 1;
      *Int_Par_Ref = Int_Loc - Int_Glob;
      Enum_Loc = Ident_1;
    } /* if */
  while (Enum_Loc != Ident_1); /* true */
} /* Proc_2 */


Proc_3 (Pointer_Par_Ref)
/**********************/
    /* executed once */
    /* Pointer_Par_Ref becomes Pointer_Glob */

Record_Pointer *Pointer_Par_Ref;

{
  if (Pointer_Glob != Null)
    /* then, executed */
    *Pointer_Par_Ref = Pointer_Glob->Pointer_Comp;
  else /* not executed */
    Int_Glob = 100;
  Proc_7 (10, Int_Glob, &Pointer_Glob->variant.variant_1.Int_Comp);
} /* Proc_3 */



Proc_4 () /* without parameters */
/*******/
    /* executed once */
{
  Boolean Bool_Loc;

  Bool_Loc = Char_Glob_1 == 'A';
  Bool_Loc = Bool_Loc | Bool_Glob;
  Char_Glob_2 = 'B';
} /* Proc_4 */


Proc_5 () /* without parameters */
/*******/
    /* executed once */
{
  Char_Glob_1 = 'A';
  Bool_Glob = false;
} /* Proc_5 */


/*******************************/
/*  Begin of the third module  */
/*******************************/

Proc_6 (Enum_Par_Val, Enum_Par_Ref)
/*********************************/
    /* executed once */
    /* Enum_Par_Val == Ident_3, Enum_Par_Ref becomes Ident_2 */

Enumeration  Enum_Par_Val,
            *Enum_Par_Ref;
{
*Enum_Par_Ref = Enum_Par_Val;
  if (! Func_3 (Enum_Par_Val))
    /* then, not executed */
    *Enum_Par_Ref = Ident_4;
  switch (Enum_Par_Val)
  {
    case Ident_1: 
      *Enum_Par_Ref = Ident_1;
      break;
    case Ident_2: 
      if (Int_Glob > 100)
        /* then */
      *Enum_Par_Ref = Ident_1;
      else *Enum_Par_Ref = Ident_4;
      break;
    case Ident_3: /* executed */
      *Enum_Par_Ref = Ident_2;
      break;
    case Ident_4: break;
    case Ident_5: 
      *Enum_Par_Ref = Ident_3;
      break;
  } /* switch */
} /* Proc_6 */


Proc_7 (Int_Par_Val1, Int_Par_Val2, Int_Par_Ref)
/**********************************************/
    /* executed three times                                    */
    /* first call:      Int_Par_Val1 == 2, Int_Par_Val2 == 3,  */
    /*                  Int_Par_Ref becomes 7                  */
    /* second call:     Int_Par_Val1 == 6, Int_Par_Val2 == 10, */
    /*                  Int_Par_Ref becomes 18                 */
    /* third call:      Int_Par_Val1 == 10, Int_Par_Val2 == 5, */
    /*                  Int_Par_Ref becomes 17                 */
One_To_Fifty   Int_Par_Val1,
               Int_Par_Val2,
              *Int_Par_Ref;
{
  One_To_Fifty Int_Loc;

  Int_Loc = Int_Par_Val1 + 2;
  *Int_Par_Ref = Int_Par_Val2 + Int_Loc;
} /* Proc_7 */


Proc_8 (Array_Par_1_Ref, Array_Par_2_Ref, Int_Par_Val_1, Int_Par_Val_2)
/*********************************************************************/
    /* executed once */
    /* Int_Par_Val_1 == 3 */
    /* Int_Par_Val_2 == 7 */
int            Int_Par_Val_1,
               Int_Par_Val_2;
int            Array_Par_1_Ref [30];
int            Array_Par_2_Ref [30] [30];
{
  One_To_Fifty Int_Index,
               Int_Loc;

  Int_Loc = Int_Par_Val_1 + 5;
  Array_Par_1_Ref [Int_Loc] = Int_Par_Val_2;
  Array_Par_1_Ref [Int_Loc+1] = Array_Par_1_Ref [Int_Loc];
  Array_Par_1_Ref [Int_Loc+30] = Int_Loc;
  for (Int_Index = Int_Loc; Int_Index <= Int_Loc+1; ++Int_Index)
    Array_Par_2_Ref [Int_Loc] [Int_Index] = Int_Loc;
  Array_Par_2_Ref [Int_Loc] [Int_Loc-1] += 1;
  Array_Par_2_Ref [Int_Loc+20] [Int_Loc] = Array_Par_1_Ref [Int_Loc];
  Int_Glob = 5;
} /* Proc_8 */


Enumeration Func_1 (Char_Par_1_Val, Char_Par_2_Val)
/*************************************************/
    /* executed three times                                             */
    /* first call:      Char_Par_1_Val == 'H', Char_Par_2_Val == 'R'    */
    /* second call:     Char_Par_1_Val == 'A', Char_Par_2_Val == 'C'    */
    /* third call:      Char_Par_1_Val == 'B', Char_Par_2_Val == 'C'    */

Capital_Letter   Char_Par_1_Val,
                 Char_Par_2_Val;
{
  Capital_Letter Char_Loc_1, 
                 Char_Loc_2;

  Char_Loc_1 = Char_Par_1_Val;
  Char_Loc_2 = Char_Loc_1;
  if (Char_Loc_2 != Char_Par_2_Val)
    /* then, executed */
    return (Ident_1);
  else  /* not executed */
    return (Ident_2);
} /* Func_1 */


int Func_2 (String_Par_1_Ref, String_Par_2_Ref)
/*********************************************/
    /* executed once */
    /* String_Par_1_Ref == "DHRYSTONE PROGRAM, 1'ST STRING" */
    /* String_Par_2_Ref == "DHRYSTONE PROGRAM, 2'ND STRING" */

char             String_Par_1_Ref [31],
                 String_Par_2_Ref [31];
{
  One_To_Thirty  Int_Loc;
  Capital_Letter Char_Loc;

  Int_Loc = 2;
  while (Int_Loc <= 2) /* loop body executed once */
    if (Func_1 (String_Par_1_Ref[Int_Loc],
               String_Par_2_Ref[Int_Loc+1]) == Ident_1)
      /* then, executed */
    {
      Char_Loc = 'A';
      Int_Loc += 1;
    } /* if, while */
  if (Char_Loc >= 'W' && Char_Loc < 'Z')
    /* then, not executed */
    Int_Loc = 7;
  if (Char_Loc == 'X')
    /* then, not executed */
    return (true);
  else /* executed */
  {
    if (strcmp (String_Par_1_Ref, String_Par_2_Ref) > 0)
      /* then, not executed */
    {
      Int_Loc += 7;
      return (true);
    }
    else /* executed */
      return (false);
  } /* if Char_Loc */
} /* Func_2 */


Boolean Func_3 (Enum_Par_Val)
/***************************/
    /* executed once        */
    /* Enum_Par_Val == Ident_3 */
Enumeration Enum_Par_Val;
{
  Enumeration Enum_Loc;

  Enum_Loc = Enum_Par_Val;
  if (Enum_Loc == Ident_3)
    /* then, executed */
    return (true);
} /* Func_3 */
