

with Global_Def, Pack_1;
use Global_Def;

package body Pack_2 is
-------------------

function Func_3 (Enum_Par_In: in Enumeration) return boolean;
         -- forward declaration

procedure Proc_6 (Enum_Par_In:  in  Enumeration;
                  Enum_Par_Out: out Enumeration)
is  -- executed once
    -- Enum_Par_In = Ident_3, Enum_Par_Out becomes Ident_2
begin
  Enum_Par_Out := Enum_Par_In;
  if not Func_3 (Enum_Par_In)
  then -- not executed
    Enum_Par_Out := Ident_4;
  end if;
  case Enum_Par_In is
    when Ident_1 => Enum_Par_Out := Ident_1;
    when Ident_2 => if Pack_1.Int_Glob > 100
                      then Enum_Par_Out := Ident_1;
                      else Enum_Par_Out := Ident_4;
                    end if;
    when Ident_3 => Enum_Par_Out := Ident_2;    -- executed
    when Ident_4 => null;
    when Ident_5 => Enum_Par_Out := Ident_3;
  end case;
end Proc_6;

procedure Proc_7 (Int_Par_In_1,
                  Int_Par_In_2:   in  One_To_Fifty;
                  Int_Par_Out:    out One_To_Fifty)
is  -- executed three times
    -- first call:      Int_Par_In_1 = 2, Int_Par_In_2 = 3,
    --                  Int_Par_Out becomes 7
    -- second call:     Int_Par_In_1 = 6, Int_Par_In_2 = 10,
    --                  Int_Par_Out becomes 18
    -- third call:      Int_Par_In_1 = 10, Int_Par_In_2 = 5,
    --                  Int_Par_Out becomes 17
  Int_Loc: One_To_Fifty;
begin
  Int_Loc := Int_Par_In_1 + 2;
  Int_Par_Out := Int_Par_In_2 + Int_Loc;
end Proc_7;

procedure Proc_8 (Array_Par_In_Out_1: in out Array_1_Dim_Integer;
                  Array_Par_In_Out_2: in out Array_2_Dim_Integer;
                  Int_Par_In_1,
                  Int_Par_In_2:       in     integer)
is  -- executed once
    -- Int_Par_In_1 = 3
    -- Int_Par_In_2 = 7
  Int_Loc: One_To_Fifty;
begin
  Int_Loc := Int_Par_In_1 + 5;
  Array_Par_In_Out_1 (Int_Loc) := Int_Par_In_2;
  Array_Par_In_Out_1 (Int_Loc+1) :=
                          Array_Par_In_Out_1 (Int_Loc);
  Array_Par_In_Out_1 (Int_Loc+30) := Int_Loc;
  for Int_Index in Int_Loc .. Int_Loc+1 loop -- loop body executed twice
    Array_Par_In_Out_2 (Int_Loc, Int_Index) := Int_Loc;
  end loop;
  Array_Par_In_Out_2 (Int_Loc, Int_Loc-1) :=
                          Array_Par_In_Out_2 (Int_Loc, Int_Loc-1) + 1;
  Array_Par_In_Out_2 (Int_Loc+20, Int_Loc) :=
                          Array_Par_In_Out_1 (Int_Loc);
  Pack_1.Int_Glob := 5;
end Proc_8;

function Func_1 (Char_Par_In_1,
                 Char_Par_In_2: in Capital_Letter)
                                                return Enumeration
is  -- executed three times, returns Ident_1 each time
    -- first call:      Char_Par_In_1 = 'H', Char_Par_In_2 = 'R'
    -- second call:     Char_Par_In_1 = 'A', Char_Par_In_2 = 'C'
    -- third call:      Char_Par_In_1 = 'B', Char_Par_In_2 = 'C'
  Char_Loc_1, Char_Loc_2: Capital_Letter;
begin
  Char_Loc_1 := Char_Par_In_1;
  Char_Loc_2 := Char_Loc_1;
  if Char_Loc_2 /= Char_Par_In_2
  then  -- executed
    return Ident_1;
  else  -- not executed
    return Ident_2;
  end if;
  end Func_1;

function Func_2 (String_Par_In_1,
                 String_Par_In_2: in String_30) return boolean
is  -- executed once, returns false
    -- String_Par_In_1 = "DHRYSTONE PROGRAM, 1'ST STRING"
    -- String_Par_In_2 = "DHRYSTONE PROGRAM, 2'ND STRING"
  Int_Loc:  One_To_Thirty;
  Char_Loc: Capital_Letter;
begin
  Int_Loc := 2;
  while Int_Loc <= 2 loop -- loop body executed once
    if Func_1 (String_Par_In_1(Int_Loc),
               String_Par_In_2(Int_Loc+1)) = Ident_1
    then -- executed
      Char_Loc := 'A';
      Int_Loc := Int_Loc + 1;
    end if;
  end loop;
  if Char_Loc >= 'W' and Char_Loc < 'Z'
  then -- not executed
    Int_Loc := 7;
  end if;
  if Char_Loc = 'X'
  then -- not executed
    return true;
  else -- executed
    if String_Par_In_1 > String_Par_In_2
    then -- not executed
      Int_Loc := Int_Loc + 7;
      return true;
    else -- executed
      return false;
    end if;
  end if;
end Func_2;

function Func_3 (Enum_Par_In: in Enumeration) return boolean
is  -- executed once, returns true
    -- Enum_Par_In = Ident_3
  Enum_Loc:  Enumeration;
begin
  Enum_Loc := Enum_Par_In;
  if Enum_Loc = Ident_3
  then -- executed
    return true;
  end if;
end Func_3;

end Pack_2;
