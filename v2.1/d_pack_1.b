------------------------------------------------------------------------
--
--                   "DHRYSTONE" Benchmark Program
--                   -----------------------------
--                                                                            
--  Version:    Ada, Version 2.1
--		(Portable Version)
--                                                                            
--  File:       d_pack_1.b (part 4 of 6)
--
--  Date:       December 17, 1988
--
--  Author:     Reinhold P. Weicker
--
--  Comments:	This package contains, along with other procedures,
--		Proc_0 which encloses the measurement loop
--		and the statements printing the results.
--
--		For execution time measurement, a call to the procedure
--		"Clock" of package CALENDAR is used.
--		Note that Clock returns the elapsed time
--		(wall clock time). When more processes than Dhrystone
--		are running, the time values returned by the procedures
--		of CALENDAR do NOT represent the (process-specific)
--		execution time of Dhrystone.
--		
--		For more accurate time measurement, replace the calls to
--		Clock by calls to (implementation-specific)
--		procedures that return the process-specific time.
--		However, no such procedures are defined in Standard Ada.
--
--		Timing issues for Ada are discussed in "Toward Real-Time
--		Performance Benchmarks for Ada" (Russell M. Clapp et al.,
--		CACM vol. 29, no. 8, August 1986, pp. 760-778).
--
------------------------------------------------------------------------

with	Global_Def, Pack_2, TEXT_IO, CALENDAR;
pragma  ELABORATE (TEXT_IO);
use	Global_Def, TEXT_IO;

package body Pack_1 is
-------------------

  package INT_IO is new TEXT_IO.INTEGER_IO (Integer);
  package FLOAT_IO is new TEXT_IO.FLOAT_IO (Float);
  package ENUM_IO is new TEXT_IO.ENUMERATION_IO (Enumeration);
  package BOOL_IO is new TEXT_IO.ENUMERATION_IO (Boolean);
  use     INT_IO, FLOAT_IO, ENUM_IO, BOOL_IO;


  Bool_Glob:         boolean;
  Char_Glob_2:       character;
  Array_Glob_1:      Array_1_Dim_Integer;
  Array_Glob_2:      Array_2_Dim_Integer;
  Pointer_Glob,
  Pointer_Glob_Next: Record_Pointer;

  procedure Proc_4;
  procedure Proc_5;

  -- for measurement:
  Too_Small_Time:	constant := 2.0;
	-- Measurements should last at least 2 seconds
  Max_Number_Of_Runs:	constant := 1_000_000;
  subtype Run_Range is integer range 1 .. Max_Number_Of_Runs;

procedure Proc_0
is
  Int_Loc_1,
  Int_Loc_2,
  Int_Loc_3:     One_To_Fifty;
  Char_Loc:      character;
  Enum_Loc:      Enumeration;
  String_Loc_1,
  String_Loc_2:  String_30;

  -- Variables for time measurement:
  Run_Index,
  Number_Of_Runs:	Run_Range;
  Begin_Time,
  End_Time:		Calendar.Time;
  Run_Time:		Duration;
  Microseconds,
  Dhry_Per_Sec:		float;

begin

  -- Initializations

  Pack_1.Pointer_Glob_Next := new Record_Type;

  Pack_1.Pointer_Glob := new Record_Type
                        '(
                          Pointer_Comp   => Pack_1.Pointer_Glob_Next,
                          Discr          => Ident_1,
                          Enum_Comp      => Ident_3,
                          Int_Comp       => 40,
                          String_Comp    => "DHRYSTONE PROGRAM, SOME STRING"
                         );

  String_Loc_1 := "DHRYSTONE PROGRAM, 1'ST STRING";

  Array_Glob_2 (8,7) := 10;

  Put_Line ("Dhrystone Benchmark, Version 2.1 (Language: Ada)");
  New_Line;
  Put_Line ("Please give the number of runs through the benchmark: ");
  Put ("> ");
  Get (Number_Of_Runs);

  Put ("Execution starts, ");
  Put (Number_Of_Runs);
  Put ("  runs through Dhrystone");
  New_Line;
  
  -----------------
  -- Start timer --
  -----------------

  Begin_Time := Calendar.Clock;

  for Run_Index in 1 .. Number_Of_Runs Loop

    Proc_5;
    Proc_4;
      -- Char_Glob_ 'A', Char_Glob_2 = 'B', Bool_Glob = false
    Int_Loc_1 := 2;
    Int_Loc_2 := 3;
    String_Loc_2 := "DHRYSTONE PROGRAM, 2'ND STRING";
    Enum_Loc := Ident_2;
    Bool_Glob := not Pack_2.Func_2 (String_Loc_1, String_Loc_2);
      -- Bool_Glob = true
    while Int_Loc_1 < Int_Loc_2 loop  -- loop body executed once
      Int_Loc_3 := 5 * Int_Loc_1 - Int_Loc_2;
        -- Int_Loc_3 = 7
      Pack_2.Proc_7 (Int_Loc_1, Int_Loc_2, Int_Loc_3);
        -- Int_Loc_3 = 7
      Int_Loc_1 := Int_Loc_1 + 1;
    end loop;
        -- Int_Loc_1 = 3
    Pack_2.Proc_8 (Array_Glob_1, Array_Glob_2, Int_Loc_1, Int_Loc_3);
      -- Int_Glob = 5
    Proc_1 (Pointer_Glob);
    for Char_Index in 'A' .. Char_Glob_2 loop -- loop body executed twice
      if Enum_Loc = Pack_2.Func_1 (Char_Index, 'C')
      then -- not executed
        Pack_2.Proc_6 (Ident_1, Enum_Loc);
        String_Loc_2 := "DHRYSTONE PROGRAM, 3'RD STRING";
        Int_Loc_2 := Run_Index;
        Int_Glob := Run_Index;
      end if;
    end loop;
      -- Enum_Loc = Ident_1
      -- Int_Loc_1 = 3, Int_Loc_2 = 3, Int_Loc_3 = 7
    Int_Loc_2 := Int_Loc_2 * Int_Loc_1;
    Int_Loc_1 := Int_Loc_2 / Int_Loc_3;
    Int_Loc_2 := 7 * (Int_Loc_2 - Int_Loc_3) - Int_Loc_1;
      -- Int_Loc_1 = 1, Int_Loc_2 = 13, Int_Loc_3 = 7
    Proc_2 (Int_Loc_1);
      -- Int_Loc_1 = 5

  end loop; -- for Run_Index

  ----------------
  -- Stop timer --
  ----------------

  End_Time := Calendar.Clock;

  Put_Line ("Execution ends");
  New_Line;
  Put_Line ("Final values of the variables used in the benchmark:");
  New_Line;

  INT_IO.DEFAULT_WIDTH := 6;
  Put      ("Int_Glob:          ");
  Put (Int_Glob);
  New_Line; 
  Put_Line ("        should be:      5");
  Put      ("Bool_Glob:           ");
  Put (Bool_Glob);
  New_Line;
  Put_Line ("        should be:   TRUE");
  Put      ("Char_Glob_1:         ");
  Put (Char_Glob_1);
  New_Line;
  Put_Line ("        should be:   A");
  Put      ("Char_Glob_2:         ");
  Put (Char_Glob_2);
  New_Line;
  Put_Line ("        should be:   B");
  Put      ("Array_Glob_1 (8):  ");
  Put (Array_Glob_1 (8));
  New_Line;
  Put_Line ("        should be:      7");
  Put      ("Array_Glob_2 (8,7): ");
  Put (Array_Glob_2 (8,7));
  New_Line;
  Put_Line ("        should be:   Number_Of_Runs + 10");
  Put_Line ("Pointer_Glob.");
  Put_Line ("  Pointer_Comp:      (implementation-dependent)");
  Put      ("  Discr:             ");
  Put (Pointer_Glob.Discr);
  New_Line;
  Put_Line ("        should be:   IDENT_1");
  Put      ("  Enum_Comp:         ");
  Put (Pointer_Glob.Enum_Comp);
  New_Line;
  Put_Line ("     should be:      IDENT_3");
  Put      ("  Int_Comp:        ");
  Put (Pointer_Glob.Int_Comp);
  New_Line;
  Put_Line ("     should be:        17");
  Put      ("  String_Comp:       ");
  for I in 1 .. 30 loop
    Put (Pointer_Glob.String_Comp (I));
  end loop;
  New_Line;
  Put_Line ("     should be:      DHRYSTONE PROGRAM, SOME STRING");
  Put_Line ("Pointer_Glob_Next.");
  Put_Line ("  Pointer_Comp:      (implementation-dependent)");
  Put      ("  Discr:             ");
  Put (Pointer_Glob_Next.Discr);
  New_Line;
  Put_Line ("        should be:   IDENT_1");
  Put      ("  Enum_Comp:         ");
  Put (Pointer_Glob_Next.Enum_Comp);
  New_Line;
  Put_Line ("     should be:      IDENT_2");
  Put      ("  Int_Comp:        ");
  Put (Pointer_Glob_Next.Int_Comp);
  New_Line;
  Put_Line ("     should be:        18");
  Put      ("  String_Comp:       ");
  for I in 1 .. 30 loop
    Put (Pointer_Glob_Next.String_Comp (I));
  end loop;
  New_Line;
  Put_Line ("     should be:      DHRYSTONE PROGRAM, SOME STRING");
  Put      ("Int_Loc_1:         ");
  Put (Int_Loc_1);
  New_Line;
  Put_Line ("        should be:      5");
  Put      ("Int_Loc_2:         ");
  Put (Int_Loc_2);
  New_Line;
  Put_Line ("        should be:     13");
  Put      ("Int_Loc_3:         ");
  Put (Int_Loc_3);
  New_Line;
  Put_Line ("        should be:      7");
  Put      ("Enum_Loc:            ");
  Put (Enum_Loc);
  New_Line;
  Put_Line ("     should be:      IDENT_2");
  Put      ("String_Loc_1         ");
  for I in 1 .. 30 loop
    Put (String_Loc_1 (I));
  end loop;
  New_Line;
  Put_Line ("     should be:      DHRYSTONE PROGRAM, 1'ST STRING");
  Put      ("String_Loc_2         ");
  for I in 1 .. 30 loop
    Put (String_Loc_2 (I));
  end loop;
  New_Line;
  Put_Line ("     should be:      DHRYSTONE PROGRAM, 2'ND STRING");
  New_Line;
 
  -- Compute Execution Time

  Run_Time :=  Calendar."-" (End_Time, Begin_Time);
  if Run_Time < Too_Small_Time
  then
    Put_Line ("Measured Time too small to obtain meaningful results");
    Put_Line ("Please increase number of runs");
  else
    Microseconds := 1_000_000.0 * float (Run_Time) / float (Number_Of_Runs);
    Dhry_Per_Sec := float (Number_of_Runs) / float (Run_Time);
    Put ("Microseconds for one run through Dhrystone:  ");
    Put (Microseconds, Aft => 2, Exp => 0);
    New_Line;
    Put ("Dhrystones per second:                       ");
    Put (Dhry_Per_Sec, Aft => 2, Exp => 0);
    New_Line;
  end if;
  New_Line;

end Proc_0;

procedure Proc_1 (Pointer_Par_In: in Record_Pointer)
is  -- executed once
  Next_Record: Record_Type
    renames Pointer_Par_In.Pointer_Comp.all; -- = Pointer_Glob_Next.all
begin
  Next_Record := Pointer_Glob.all;
  Pointer_Par_In.Int_Comp := 5;
  Next_Record.Int_Comp := Pointer_Par_In.Int_Comp;
  Next_Record.Pointer_Comp := Pointer_Par_In.Pointer_Comp;
  Proc_3 (Next_Record.Pointer_Comp);
    -- Next_Record.Pointer_Comp = Pointer_Glob.Pointer_Comp = Pointer_Glob_Next
  if Next_Record.Discr = Ident_1
  then -- executed
    Next_Record.Int_Comp := 6;
    Pack_2.Proc_6 (Pointer_Par_In.Enum_Comp, Next_Record.Enum_Comp);
    Next_Record.Pointer_Comp := Pointer_Glob.Pointer_Comp;
    Pack_2.Proc_7 (Next_Record.Int_Comp, 10, Next_Record.Int_Comp);
  else -- not executed
    Pointer_Par_In.all := Next_Record;
  end if;
end Proc_1;

procedure Proc_2 (Int_Par_In_Out: in out One_To_Fifty)
is  -- executed once
    -- In_Par_In_Out = 3, becomes 7
  Int_Loc:  One_To_Fifty;
  Enum_Loc: Enumeration;
begin
  Int_Loc := Int_Par_In_Out + 10;
  loop -- executed once
    if Char_Glob_1 = 'A'
    then -- executed
      Int_Loc := Int_Loc - 1;
      Int_Par_In_Out := Int_Loc - Int_Glob;
      Enum_Loc := Ident_1;
    end if;
  exit when Enum_Loc = Ident_1; -- true
  end loop;
end Proc_2;

procedure Proc_3 (Pointer_Par_Out: out Record_Pointer)
is  -- executed once
    -- Pointer_Par_Out becomes Pointer_Glob
begin
  if Pointer_Glob /= null
  then -- executed
    Pointer_Par_Out := Pointer_Glob.Pointer_Comp;
  end if;
  Pack_2.Proc_7 (10, Int_Glob, Pointer_Glob.Int_Comp);
end Proc_3;

procedure Proc_4 -- without parameters
is  -- executed once
  Bool_Loc: boolean;
begin
  Bool_Loc := Char_Glob_1 = 'A';
  Bool_Glob := Bool_Loc or Bool_Glob;
  Char_Glob_2 := 'B';
end Proc_4;

procedure Proc_5 -- without parameters
is  -- executed once
begin
  Char_Glob_1 := 'A';
  Bool_Glob := false;
end Proc_5;

end Pack_1;


