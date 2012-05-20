------------------------------------------------------------------------
--
--                   "DHRYSTONE" Benchmark Program
--                   -----------------------------
--                                                                            
--  Version:    Ada, Version 2.1
--                                                                            
--  File:       d_main.b (part 6 of 6)
--
--  Date:       August 17, 1988
--
--  Author:     Reinhold P. Weicker
--
------------------------------------------------------------------------

  with Global_Def, Pack_1;
  use Global_Def;

procedure Main is
--------------

begin

  Pack_1.Proc_0;   -- Proc_0 is actually the main program, but it is part
                   -- of a package, and a program within a package can
                   -- not be designated as the main program for execution.
                   -- Therefore Proc_0 is activated by a call from "Main".

end Main;

