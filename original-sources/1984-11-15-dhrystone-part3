                                                                                                                                                                                                                                                                
Relay-Version: version B 2.10 5/3/83; site utzoo.UUCP
Posting-Version: Notesfiles $Revision: 1.6.2.14 $; site siemens.UUCP
Path: utzoo!watmath!clyde!burl!ulysses!allegra!princeton!eosp1!siemens!bea
From: b...@siemens.UUCP
Newsgroups: net.sources
Subject: Dhrystone benchmark, part 3 of 4
Message-ID: <28600006@siemens.UUCP>
Date: Thu, 15-Nov-84 10:09:00 EST
Article-I.D.: siemens.28600006
Posted: Thu Nov 15 10:09:00 1984
Date-Received: Fri, 16-Nov-84 05:33:53 EST
Lines: 622
Nf-ID: #N:siemens:28600006:000:26791
Nf-From: siemens!bea    Nov 15 10:09:00 1984




(******************************************************************************)
(*                                                                            *)
(*                   "DHRYSTONE" Benchmark Program                            *)
(*                   -----------------------------                            *)
(*                                                                            *)
(*  Version:   Pascal / 2 (Measurement Version, for Berkeley UNIX Pascal)     *)
(*                                                                            *)
(*  File:      dhry-mea.p                                                     *)
(*                                                                            *)
(*  Date:      Oct. 1984                                                      *)
(*                                                                            *)
(*  Author:    Reinhold P. Weicker                                            *)
(*                                                                            *)
(******************************************************************************)
(*                                                                            *)
(*  This version uses calls to the Pascal runtime library of the Berkeley     *)
(*  UNIX system (4.2 bsd) for time measurement. For measurements on other     *)
(*  systems, these calls need to be modified.                                 *)
(*                                                                            *)
(******************************************************************************)
(*                                                                            *)
(*  The following program contains statements of a high level programming     *)
(*  language (here: Pascal) in a distribution considered representative:      *)
(*                                                                            *)
(*    assignments                  58 %                                       *)
(*    control statements           27 %                                       *)
(*    procedure, function calls    15 %                                       *)
(*                                                                            *)
(*  100 statements are dynamically executed. The program is balanced with     *)
(*  respect to the three aspects:                                             *)
(*                                                                            *)
(*    - statement type                                                        *)
(*    - operand type (for simple data types)                                  *)
(*    - operand access                                                        *)
(*         operand global, local, parameter, or constant.                     *)
(*           There is no static nesting of blocks or procedures,              *)
(*           therefore all variables are either global or local.              *)
(*                                                                            *)
(*  The combination of these three aspects is balanced only approximately.    *)
(*                                                                            *)
(*  1. Statement Type:                                                        *)
(*  -----------------             number (= percentage)                       *)
(*                                                                            *)
(*     V1 := V2                   15                                          *)
(*     V := Constant              12                                          *)
(*       (incl. V1 := F(..)                                                   *)
(*     Assignment,                 7                                          *)
(*       with array element                                                   *)
(*     Assignment,                 6                                          *)
(*       with record component                                                *)
(*                                --                                          *)
(*                                40       40                                 *)
(*                                                                            *)
(*     X := Y +|-|and|or Z         5                                          *)
(*     X := Y +|-|"=" Constant     6                                          *)
(*     X := X +|- 1                3                                          *)
(*     X := Y *|/ Z                2                                          *)
(*     X := Expression,            1                                          *)
(*          two operators                                                     *)
(*     X := Expression,            1                                          *)
(*          three operators                                                   *)
(*                                --                                          *)
(*                                18       18                                 *)
(*                                                                            *)
(*     if .... then ....          14                                          *)
(*       with "else"      7                                                   *)
(*       without "else"   7                                                   *)
(*           executed        3                                                *)
(*           not executed    4                                                *)
(*     for I in 1..N do ...        6  |  counted every time                   *)
(*     while ... do ...            4  |  the loop condition                   *)
(*     repeat ... until            1  |  is evaluated                         *)
(*     case ... end                1                                          *)
(*     with                        1                                          *)
(*                                --                                          *)
(*                                27       27                                 *)
(*                                                                            *)
(*     P (...)  procedure call    10                                          *)
(*     X := F (...)                                                           *)
(*             function  call      5                                          *)
(*                                --                                          *)
(*                                15       15                                 *)
(*                                        ---                                 *)
(*                                        100                                 *)
(*                                                                            *)
(*    22 of the 58 assignments have a variable of a constrained               *)
(*    (sub-)type as their destination. In general, discriminant checks        *)
(*    will be necessary in these cases; however, the compiler may             *)
(*    optimize out some of these checks.                                      *)
(*                                                                            *)
(*    The average number of parameters in procedure or function calls         *)
(*    is 1.80 (not counting the function values as implicit parameters).      *)
(*                                                                            *)
(*                                                                            *)
(*  2. Operators                                                              *)
(*  ------------                                                              *)
(*                          number    approximate                             *)
(*                                    percentage                              *)
(*                                                                            *)
(*    Arithmetic             27          52.9                                 *)
(*                                                                            *)
(*       +                     16          31.4                               *)
(*       -                      7          13.7                               *)
(*       *                      3           5.9                               *)
(*       div                    1           2.0                               *)
(*                                                                            *)
(*    Comparison             20           39.2                                *)
(*                                                                            *)
(*       =                      9           17.6                              *)
(*       <>                     4            7.8                              *)
(*       >                      1            2.0                              *)
(*       <                      3            5.9                              *)
(*       >=                     1            2.0                              *)
(*       <=                     2            3.9                              *)
(*                                                                            *)
(*    Logic                   4            7.8                                *)
(*                                                                            *)
(*       AND                    1            2.0                              *)
(*       OR                     1            2.0                              *)
(*       NOT                    2            3.9                              *)
(*                                                                            *)
(*                           --          -----                                *)
(*                           51           99.9                                *)
(*                                                                            *)
(*                                                                            *)
(*  3. Operand Type (counted once per operand reference):                     *)
(*  ---------------                                                           *)
(*                          number    approximate                             *)
(*                                    percentage                              *)
(*                                                                            *)
(*     Integer               131        53.9 %                                *)
(*     Character              47        19.3 %                                *)
(*     Enumeration            31        12.8 %                                *)
(*     Boolean                13         5.3 %                                *)
(*     Pointer                11         4.5 %                                *)
(*     String30                6         2.5 %                                *)
(*     Array                   2         0.8 %                                *)
(*     Record                  2         0.8 %                                *)
(*                           ---       -------                                *)
(*                           243        99.9 %                                *)
(*                                                                            *)
(*  When there is an access path leading to the final operand (e.g. a record  *)
(*  component), only the final data type on the access path is counted.       *)
(*                                                                            *)
(*  There are 16 accesses to components of a record, 9 of them go to          *)
(*  a component in a variant part. For some of these accesses, the            *)
(*  compiler may suppress generation of code checking the tag field           *)
(*  during optimization.                                                      *)
(*                                                                            *)
(*                                                                            *)
(*  3. Operand Locality:                                                      *)
(*  -------------------                                                       *)
(*                                                                            *)
(*     local variable               81        33.3 %                          *)
(*     global variable              57        23.5 %                          *)
(*     parameter                    45        18.5 %                          *)
(*        value                        23         9.5 %                       *)
(*        reference                    22         9.1 %                       *)
(*     function result               5         2.1 %                          *)
(*     constant                     55        22.6 %                          *)
(*                                 ---       -------                          *)
(*                                 243       100.0 %                          *)
(*                                                                            *)
(*                                                                            *)
(*  The program does not compute anything meaningful, but it is syntactically *)
(*  and semantically correct. All variables have a value assigned to them     *)
(*  before they are used as a source operand.                                 *)
(*                                                                            *)
(*  There may be cases where a highly optimizing compiler may recognize       *)
(*  unnecessary statements and may not generate code for them.                *)
(*                                                                            *)
(*  There has been no explicit effort to account for the effects of a         *)
(*  cache, or to balance the use of long or short displacements for code or   *)
(*  data.                                                                     *)
(*                                                                            *)
(*  As far as the program structure is concerned, no attempt has been made    *)
(*  to construct a Pascal version with several modules (similar to the Ada    *)
(*  and C versions) since Standard Pascal does not have a separate            *)
(*  compilation model.                                                        *)
(*                                                                            *)
(******************************************************************************)

program Dhrystone;
(****************)

const (* for measurement *)

  NumberOfExecutions	= 10000;
  NumberOfMeasurements	= 10;
  LargeRealNumber	= 1000000.0;

  MicrosecondsPerClock	= 1000;
        (* In Berkeley UNIX Pascal, the function "clock"        *)
        (* returns milliseconds                                 *)

type

  (* Global type definitions *)

  Enumeration = (Ident1, Ident2, Ident3, Ident4, Ident5);

  OneToThirty = 1..30;
  OneToFifty = 1..50;
  CapitalLetter = 'A'..'Z';

  String30 = packed array [1..30] of char;

  Array1DimInteger = array [OneToFifty] of integer;
  Array2DimInteger = array [OneToFifty, OneToFifty] of integer;

  RecordPointer = ^RecordType;

  RecordType =
      record
        PointerComp:   RecordPointer;
        case Discr:    Enumeration of
          Ident1:         (* only this variant is used,           *)
                          (* but in some cases discriminant       *)
                          (* checks are necessary                 *)
            (EnumComp:      Enumeration;
             IntComp:       OneToFifty;
             StringComp:    String30);
          Ident2:
            (EnumComp2:    Enumeration;
             StringComp2:  String30);
          Ident3, Ident4, Ident5:
            (CharComp1,
             CharComp2:    char);
      end; (* record *)

var

  (* for measurement only *)

  ExecutionIndex:    1..NumberOfExecutions;
  MeasurementIndex:  1..NumberOfMeasurements;
  BeginClock,
  EndClock:          integer;
  SumClocks,
  EmptyLoopClocks,
  TimePerExecution,  
  SumTime,
  MinTime:           real;

  (* end of variables for measurement *)

  PointerGlob,
  NextPointerGlob: RecordPointer;
  IntGlob:         integer;

  BoolGlob:        boolean;
  CharGlob1,
  CharGlob2:       char;
  ArrayGlob1:      Array1DimInteger;
  ArrayGlob2:      Array2DimInteger;

  IntGlob1,
  IntGlob2,
  IntGlob3:       OneToFifty;
  CharIndex:      char;
  EnumGlob:       Enumeration;
  StringGlob1,
  StringGlob2:    String30;


procedure Proc1 (    PointerParVal: RecordPointer);     forward;

procedure Proc2 (var IntParRef:     OneToFifty);        forward;

procedure Proc3 (var PointerParRef: RecordPointer);     forward;

procedure Proc4;                                        forward;
  (* without parameters *)

procedure Proc5;                                        forward;
  (* without parameters *)

procedure Proc6 (    EnumParVal:    Enumeration;
                 var EnumParRef:    Enumeration);       forward;

procedure Proc7 (    IntPar1Val,
                     IntPar2Val:    OneToFifty;
                 var IntParRef:     OneToFifty);        forward;

procedure Proc8 (var ArrayPar1Ref:  Array1DimInteger;
                 var ArrayPar2Ref:  Array2DimInteger;
                     IntPar1Val,
                     IntPar2Val:    integer);            forward;

function Func1  (    CharPar1Val,
                     CharPar2Val:   CapitalLetter): 
                                            Enumeration; forward;

function Func2  (var StringPar1Ref,
                     StringPar2Ref: String30): 
                                            boolean;      forward;

function Func3  (    EnumParVal:    Enumeration): 
                                            boolean;      forward;


procedure Proc1; (* (PointerParVal: RecordPointer) *)
    (* executed once *)
begin
  with PointerParVal^.PointerComp^ (* = PointerGlobNext *) do
  begin
    PointerParVal^.PointerComp^ := PointerGlob^;
    PointerParVal^.IntComp := 5;
    IntComp := PointerParVal^.IntComp;
    PointerComp := PointerParVal^.PointerComp;
    Proc3 (PointerComp);
      (* PointerParVal^.PointerComp^.PointerComp = PointerGlob^.PointerComp *)
    if Discr = Ident1
    then (* executed *)
    begin
      IntComp := 6;
      Proc6 (PointerParVal^.EnumComp, EnumComp);
      PointerComp := PointerGlob^.PointerComp;
      Proc7 (IntComp, 10, IntComp);
    end (* then *)
    else (* not executed *)
      PointerParVal^ := PointerParVal^.PointerComp^;
  end; (* with *)
end; (* Proc1 *)


procedure Proc2; (* (var IntParRef: OneToFifty) *)
    (* executed once *)
    (* InParRef = 3, becomes 7 *)
var
  IntLoc:  OneToFifty;
  EnumLoc: Enumeration;
begin
  IntLoc := IntParRef + 10;
  repeat (* executed once *)
    if CharGlob1 = 'A'
    then (* executed *)
    begin
      IntLoc := IntLoc - 1;
      IntParRef := IntLoc - IntGlob;
      EnumLoc := Ident1;
    end (* if *)
  until EnumLoc = Ident1; (* true *)
end; (* Proc2 *)


procedure Proc3; (* (var PointerParRef: RecordPointer) *)
    (* executed once *)
    (* PointerParRef becomes PointerGlob *)
begin
  if PointerGlob <> nil
  then (* executed *)
    PointerParRef := PointerGlob^.PointerComp
  else (* not executed *)
    IntGlob := 100;
  Proc7 (10, IntGlob, PointerGlob^.IntComp);
end; (* Proc3 *)


procedure Proc4; (* without parameters *)
    (* executed once *)
var
  BoolLoc: boolean;
begin
  BoolLoc := CharGlob1 = 'A';
  BoolLoc := BoolLoc or BoolGlob;
  CharGlob2 := 'B';
end; (* Proc4 *)


procedure Proc5; (* without parameters *)
    (* executed once *)
begin
  CharGlob1 := 'A';
  BoolGlob := false;
end; (* Proc5 *)


procedure Proc6; (* (    EnumParVal:     Enumeration;
                     var EnumParRef:     Enumeration) *)
    (* executed once *)
    (* EnumParVal = Ident3, EnumParRef becomes Ident2 *)
begin
  EnumParRef := EnumParVal;
  if not Func3 (EnumParVal)
  then (* not executed *)
    EnumParRef := Ident4;
  case EnumParVal of
    Ident1: EnumParRef := Ident1;
    Ident2: if IntGlob > 100
              then EnumParRef := Ident1
              else EnumParRef := Ident4;
    Ident3: EnumParRef := Ident2;    (* executed *)
    Ident4: ;
    Ident5: EnumParRef := Ident3;
  end; (* case *)
end; (* Proc6 *)


procedure Proc7; (* (    IntPar1Val,
                         IntPar2Val:    OneToFifty;
                     var IntParRef:     OneToFifty) *)
    (* executed three times                               *)
    (* first call:      IntPar1Val = 2, IntPar2Val = 3,   *)
    (*                  IntParRef becomes 7              *)
    (* second call:     IntPar1Val = 6, IntPar2Val = 10,  *)
    (*                  IntParRef becomes 18              *)
    (* third call:      IntPar1Val = 10, IntPar2Val = 5,  *)
    (*                  IntParRef becomes 17              *)
var
  IntLoc: OneToFifty;
begin
  IntLoc := IntPar1Val + 2;
  IntParRef := IntPar2Val + IntLoc;
end; (* Proc7 *)


procedure Proc8; (* (var ArrayPar1Ref: Array1DimInteger;
                     var ArrayPar2Ref: Array2DimInteger;
                         IntPar1Val,
                         IntPar2Val:    integer)          *)
    (* executed once *)
    (* IntPar1Val = 3 *)
    (* IntPar2Val = 7 *)
var
  IntIndex,
  IntLoc:   OneToFifty;
begin
  IntLoc := IntPar1Val + 5;
  ArrayPar1Ref [IntLoc] := IntPar2Val;
  ArrayPar1Ref [IntLoc+1] := ArrayPar1Ref [IntLoc];
  ArrayPar1Ref [IntLoc+30] := IntLoc;
  for IntIndex := IntLoc to IntLoc+1 do
    ArrayPar2Ref [IntLoc, IntIndex] := IntLoc;
  ArrayPar2Ref [IntLoc, IntLoc-1] := ArrayPar2Ref [IntLoc, IntLoc-1] + 1;
  ArrayPar2Ref [IntLoc+20, IntLoc] := ArrayPar1Ref [IntLoc];
  IntGlob := 5;
end; (* Proc8 *)


function Func1; (* (CharPar1Val,
                    CharPar2Val: CapitalLetter): Enumeration *)
    (* executed three times, returns always Ident1              *)
    (* first call:      CharPar1Val = 'H', CharPar2Val = 'R'    *)
    (* second call:     CharPar1Val = 'A', CharPar2Val = 'C'    *)
    (* third call:      CharPar1Val = 'B', CharPar2Val = 'C'    *)
var
  CharLoc1, CharLoc2: CapitalLetter;
begin
  CharLoc1 := CharPar1Val;
  CharLoc2 := CharLoc1;
  if CharLoc2 <> CharPar2Val
  then  (* executed *)
    Func1 := Ident1
  else  (* not executed *)
    Func1 := Ident2;
end; (* Func1 *)


function Func2; (* (var StringPar1Ref,
                        StringPar2Ref: String30): boolean *)
    (* executed once, returns false              *)
    (* StringPar1Ref = 'DHRYSTONE PROGRAM, 1''ST STRING' *)
    (* StringPar2Ref = 'DHRYSTONE PROGRAM, 2''ND STRING' *)
var
  IntLoc:  OneToThirty;
  CharLoc: CapitalLetter;
begin
  IntLoc := 2;
  while IntLoc <= 2 do (* loop body executed once *)
    if Func1 (StringPar1Ref[IntLoc],
              StringPar2Ref[IntLoc+1]) = Ident1
    then (* executed *)
    begin
      CharLoc := 'A';
      IntLoc := IntLoc + 1;
    end; (* if, while *)
  if (CharLoc >= 'W') and (CharLoc < 'Z')
  then (* not executed *)
    IntLoc := 7;
  if CharLoc = 'X'
  then (* not executed *)
    Func2 := true
  else (* executed *)
  begin
    if StringPar1Ref > StringPar2Ref
    then (* not executed *)
    begin
      IntLoc := IntLoc + 7;
      Func2 := true
    end
    else (* executed *)
      Func2 := false;
  end; (* if CharLoc *)
end; (* Func2 *)


function Func3; (* (EnumParVal: Enumeration): boolean *)
    (* executed once, returns true      *)
    (* EnumParVal = Ident3              *)
var
  EnumLoc:  Enumeration;
begin
  EnumLoc := EnumParVal;
  if EnumLoc = Ident3
  then (* executed *)
    Func3 := true;
end; (* Func3 *)


begin (* main program, corresponds to procedures        *)
      (* Main and Proc_0 in the Ada version             *)

  (* Initializations *)

  new (NextPointerGlob);

  new (PointerGlob);

  PointerGlob^.PointerComp := NextPointerGlob;
  PointerGlob^.Discr       := Ident1;
  PointerGlob^.EnumComp    := Ident3;
  PointerGlob^.IntComp     := 40;
  PointerGlob^.StringComp  := 'DHRYSTONE PROGRAM, SOME STRING';

  StringGlob1 := 'DHRYSTONE PROGRAM, 1''ST STRING';

  writeln;
  writeln ('Dhrystone Benchmark (March 84), Version Pascal / 2');
  writeln ('Times are CPU user time per execution, in microseconds');
  writeln;

  SumTime := 0.0;
  MinTime := LargeRealNumber;

  for MeasurementIndex :=  1 to NumberOfMeasurements do
  begin

    BeginClock := clock;

    (***************)
    (* Start timer *)
    (***************)
  
    for ExecutionIndex := 1 to NumberOfExecutions do
    begin

      Proc5;
      Proc4;
        (* CharGlob1 = 'A', CharGlob2 = 'B', BoolGlob = false *)
      IntGlob1 := 2;
      IntGlob2 := 3;
      StringGlob2 := 'DHRYSTONE PROGRAM, 2''ND STRING';
      EnumGlob := Ident2;
      BoolGlob := Func2 (StringGlob1, StringGlob2);
        (* BoolGlob = false *)
      while IntGlob1 < IntGlob2 do  (* loop body executed once *)
      begin
        IntGlob3 := 5 * IntGlob1 - IntGlob2;
          (* IntGlob3 = 7 *)
        Proc7 (IntGlob1, IntGlob2, IntGlob3);
          (* IntGlob3 = 7 *)
        IntGlob1 := IntGlob1 + 1;
      end; (* while *)
        (* IntGlob1 = 3 *)
      Proc8 (ArrayGlob1, ArrayGlob2, IntGlob1, IntGlob3);
        (* IntGlob = 5 *)
      Proc1 (PointerGlob);
      for CharIndex := 'A' to CharGlob2 do   (* loop body executed twice *)
        if EnumGlob = Func1 (CharIndex, 'C')
        then (* not executed *)
          Proc6 (Ident1, EnumGlob);
      (* IntGlob1 = 3, IntGlob2 = 3, IntGlob3 = 7 *)
      IntGlob3 := IntGlob2 * IntGlob1;
      IntGlob2 := IntGlob3 div IntGlob1;
      IntGlob2 := 7 * (IntGlob3 - IntGlob2) - IntGlob1;
      Proc2 (IntGlob1);
 
    end; (* for ExecutionIndex *)

    EndClock := clock;

    (**************)
    (* Stop timer *)
    (**************)

    SumClocks := (EndClock - BeginClock) * MicrosecondsPerClock;

    (* Measure and subtract time for NumberOfExecutions empty loops *)

    BeginClock := clock;
    for ExecutionIndex := 1 to NumberOfExecutions do
    begin
      (* empty *)
    end;
    EndClock := clock;
    EmptyLoopClocks := (EndClock - BeginClock) * MicrosecondsPerClock;

    SumClocks := SumClocks - EmptyLoopClocks;

    TimePerExecution := SumClocks / NumberOfExecutions;

    write ('Time for run ', MeasurementIndex : 2, ':');
    writeln (TimePerExecution : 8 : 1);

    SumTime := SumTime + TimePerExecution;
    if TimePerExecution < MinTime
    then MinTime := TimePerExecution;

  end; (* for MeasurementIndex *)

  writeln;
  write ('Average execution time: ');
  writeln (SumTime/NumberOfMeasurements : 8 : 1);
  writeln;
  write ('Minimum execution time: ');
  writeln (MinTime : 8 : 1);
  writeln;
end.
