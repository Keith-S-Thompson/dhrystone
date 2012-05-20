------------------------------------------------------------------------
--
--                   "DHRYSTONE" Benchmark Program
--                   -----------------------------
--                                                                            
--  Version:    Ada, Version 2.1
--                                                                            
--  File:       d_pack_1.s (part 2 of 6)
--
--  Date:       August 17, 1988
--
--  Author:     Reinhold P. Weicker
--
------------------------------------------------------------------------

  with Global_Def;
  use Global_Def;

package Pack_1 is
--------------

  procedure Proc_0;
  procedure Proc_1 (Pointer_Par_In:     in     Record_Pointer);
  procedure Proc_2 (Int_Par_In_Out:     in out One_To_Fifty);
  procedure Proc_3 (Pointer_Par_Out:    out    Record_Pointer);

  Int_Glob:          integer;
  Char_Glob_1:       character;

end Pack_1;


