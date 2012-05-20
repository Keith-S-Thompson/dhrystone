------------------------------------------------------------------------
--
--                   "DHRYSTONE" Benchmark Program
--                   -----------------------------
--                                                                            
--  Version:    Ada, Version 2.1
--                                                                            
--  File:       d_pack_2.s (part 3 of 6)
--
--  Date:       August 17, 1988
--
--  Author:     Reinhold P. Weicker
--
------------------------------------------------------------------------

  with Global_Def;
  use Global_Def;

package Pack_2 is
--------------

  procedure Proc_6 (Enum_Par_In:        in     Enumeration;
                    Enum_Par_Out:       out    Enumeration);
  procedure Proc_7 (Int_Par_In_1,
                    Int_Par_In_2:       in     One_To_Fifty;
                    Int_Par_Out:        out    One_To_Fifty);
  procedure Proc_8 (Array_Par_In_Out_1: in out Array_1_Dim_Integer;
                    Array_Par_In_Out_2: in out Array_2_Dim_Integer;
                    Int_Par_In_1,
                    Int_Par_In_2:       in     integer);
  function Func_1 (Char_Par_In_1,
                   Char_Par_In_2:       in     Capital_Letter)
                                                    return Enumeration;
  function Func_2 (String_Par_In_1,
                   String_Par_In_2:     in     String_30)
                                                    return boolean;

end Pack_2;


