

with Global_Def, Pack_2;
use Global_Def;

package body Pack_1 is
-------------------

  Bool_Glob:         boolean;
  Char_Glob_1,
  Char_Glob_2:       character;
  Array_Glob_1:      Array_1_Dim_Integer;
  Array_Glob_2:      Array_2_Dim_Integer;
  Pointer_Glob,
  Pointer_Glob_Next: Record_Pointer;

  procedure Proc_4;
  procedure Proc_5;

procedure Proc_0
is
  Int_Loc_1,
  Int_Loc_2,
  Int_Loc_3:     One_To_Fifty;
  Char_Loc:      character;
  Enum_Loc:      Enumeration;
  String_Loc_1,
  String_Loc_2:  String_30;
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

  -----------------
  -- Start timer --
  -----------------

  Proc_5;
  Proc_4;
    -- Char_Glob_1 = 'A', Char_Glob_2 = 'B', Bool_Glob = false
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
    end if;
  end loop;
    -- Enum_Loc = Ident_1
    -- Int_Loc_1 = 3, Int_Loc_2 = 3, Int_Loc_3 = 7
  Int_Loc_3 := Int_Loc_2 * Int_Loc_1;
  Int_Loc_2 := Int_Loc_3 / Int_Loc_1;
  Int_Loc_2 := 7 * (Int_Loc_3 - Int_Loc_2) - Int_Loc_1;
  Proc_2 (Int_Loc_1);

  ----------------
  -- Stop timer --
  ----------------

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
  else -- not executed
    Int_Glob := 100;
  end if;
  Pack_2.Proc_7 (10, Int_Glob, Pointer_Glob.Int_Comp);
end Proc_3;

procedure Proc_4 -- without parameters
is  -- executed once
  Bool_Loc: boolean;
begin
  Bool_Loc := Char_Glob_1 = 'A';
  Bool_Loc := Bool_Loc or Bool_Glob;
  Char_Glob_2 := 'B';
end Proc_4;

procedure Proc_5 -- without parameters
is  -- executed once
begin
  Char_Glob_1 := 'A';
  Bool_Glob := false;
end Proc_5;

end Pack_1;
