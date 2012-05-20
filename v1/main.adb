

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
