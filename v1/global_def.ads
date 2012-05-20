--------------------------------------------------------------------------------
--                                                                            --
--                   "DHRYSTONE" Benchmark Program                            --
--                   -----------------------------                            --
--                                                                            --
--  Version:   ADA / 1 (Reference version, all parts in one file)             --
--                                                                            --
--  File:      dhry-ref-all.a                                                 --
--                                                                            --
--  Date:      Oct. 1984                                                      --
--                                                                            --
--  Author:    Reinhold P. Weicker                                            --
--                                                                            --
--------------------------------------------------------------------------------
--                                                                            --
--  The following program contains statements of a high level programming     --
--  language (here: Ada) in a distribution considered representative:         --
--                                                                            --
--    assignments                  53 %                                       --
--    control statements           32 %                                       --
--    procedure, function calls    15 %                                       --
--                                                                            --
--  100 statements are dynamically executed. The program is balanced with     --
--  respect to the three aspects:                                             --
--                                                                            --
--    - statement type                                                        --
--    - operand type (for simple data types)                                  --
--    - operand access                                                        --
--         operand global, local, parameter, or constant.                     --
--                                                                            --
--  The combination of these three aspects is balanced only approximately.    --
--                                                                            --
--  1. Statement Type:                                                        --
--  -----------------             number (= percentage)                       --
--                                                                            --
--     V1 := V2                   10                                          --
--     V := Constant              12                                          --
--       (incl. V1 := F(..)                                                   --
--     Assignment,                 7                                          --
--       with array element                                                   --
--     Assignment,                 6                                          --
--       with record component                                                --
--                                --                                          --
--                                35       35                                 --
--                                                                            --
--     X := Y +|-|and|or Z         5                                          --
--     X := Y +|-|"=" Constant     6                                          --
--     X := X +|- 1                3                                          --
--     X := Y *|/ Z                2                                          --
--     X := Expression,            1                                          --
--          two operators                                                     --
--     X := Expression,            1                                          --
--          three operators                                                   --
--                                --                                          --
--                                18       18                                 --
--                                                                            --
--     if .... then ....          14                                          --
--       with "else"      7                                                   --
--       without "else"   7                                                   --
--           executed        3                                                --
--           not executed    4                                                --
--     for  ...  loop              6  |  counted every time                   --
--     while ... loop              4  |  the loop condition                   --
--     loop .... exit              1  |  is evaluated                         --
--     case ... end case           1                                          --
--     return                      5                                          --
--     rename                      1                                          --
--                                --                                          --
--                                32       32                                 --
--                                                                            --
--     P (...)  proced. call      10                                          --
--       same package        5                                                --
--       other package       5                                                --
--                                                                            --
--     X := F (...)                                                           --
--          function  call         5                                          --
--       same package        2                                                --
--       other package       3                                                --
--                                --                                          --
--                                15       15                                 --
--                                        ---                                 --
--                                        100                                 --
--                                                                            --
--    22 of the 58 assignments have a variable of a constrained               --
--    (sub-)type as their destination. In general, discriminant checks        --
--    will be necessary in these cases; however, the compiler may             --
--    optimize out some of these checks.                                      --
--                                                                            --
--    The average number of parameters in procedure or function calls         --
--    is 1.80 (not counting the function values as implicit parameters).      --
--                                                                            --
--                                                                            --
--  2. Operators                                                              --
--  ------------                                                              --
--                          number    approximate                             --
--                                    percentage                              --
--                                                                            --
--    Arithmetic             27          52.9                                 --
--                                                                            --
--       +                     16          31.4                               --
--       -                      7          13.7                               --
--       *                      3           5.9                               --
--       /                      1           2.0                               --
--                                                                            --
--    Comparison             20           39.2                                --
--                                                                            --
--       =                      9           17.6                              --
--       /=                     4            7.8                              --
--       >                      1            2.0                              --
--       <                      3            5.9                              --
--       >=                     1            2.0                              --
--       <=                     2            3.9                              --
--                                                                            --
--    Logic                   4            7.8                                --
--                                                                            --
--       AND                    1            2.0                              --
--       OR                     1            2.0                              --
--       NOT                    2            3.9                              --
--                                                                            --
--                           --          -----                                --
--                           51           99.9                                --
--                                                                            --
--                                                                            --
--  3. Operand Type (counted once per operand reference):                     --
--  ---------------                                                           --
--                          number    approximate                             --
--                                    percentage                              --
--                                                                            --
--     Integer               131        54.4 %                                --
--     Character              47        19.5 %                                --
--     Enumeration            31        12.4 %                                --
--     Boolean                11         5.0 %                                --
--     Pointer                12         4.6 %                                --
--     String30                6         2.5 %                                --
--     Array                   2         0.8 %                                --
--     Record                  2         0.8 %                                --
--                           ---       -------                                --
--                           241       100.0 %                                --
--                                                                            --
--  When there is an access path leading to the final operand (e.g. a record  --
--  component), only the final data type on the access path is counted.       --
--                                                                            --
--  There are 16 accesses to components of a record, 9 of them go to          --
--  a component in a variant part. For some of these accesses, the            --
--  compiler may suppress generation of code checking the tag field           --
--  during optimization.                                                      --
--                                                                            --
--                                                                            --
--  3. Operand Locality:                                                      --
--  -------------------                                                       --
--                                                                            --
--     local variable              117        48.5 %                          --
--     global variable              19         7.9 %                          --
--        same package                 18         11.2 %                      --
--        other package                 1          0.4 %                      --
--     parameter                    45        18.7 %                          --
--        in                           27         11.2 %                      --
--        inout                        12          5.0 %                      --
--        out                           6          2.5 %                      --
--     function result               5         2.1 %                          --
--     constant                     55        22.8 %                          --
--                                 ---       -------                          --
--                                 243       100.0 %                          --
--                                                                            --
--                                                                            --
--  There may be cases where a highly optimizing compiler may recognize       --
--  unnecessary statements and may not generate code for them.                --
--                                                                            --
--  There has been no explicit effort to account for the effects of a         --
--  cache, or to balance the use of long or short displacements for code or   --
--  data.                                                                     --
--                                                                            --
--  The program does not compute anything meaningful, but it is syntactically --
--  and semantically correct. All variables have a value assigned to them     --
--  before they are used as a source operand.                                 --
--                                                                            --
--------------------------------------------------------------------------------
--                                                                            --
--  The "Dhrystone" program consists of six library units in the sense of     --
--  Ada: Two packages (Pack_1 and Pack_2) consisting of both specification    --
--  and body, one package (Global_Def) with specification only, and one       --
--  procedure (Main). The package structure is intended since this is the     --
--  natural ways for programming in Ada, and there can be systems where       --
--  calls and data accesses across package boundaries have execution          --
--  times different from those within a package.                              --
--  In addition, the execution time may depend upon the way the program       --
--  is compiled and executed; there are two possible ways:                    --
--  (1) the six units are compiled separately and linked together later,      --
--  (2) the six units are submitted to the compiler in one source file.       --
--                                                                            --
--  For many Ada systems there will be no difference in execution time,       --
--  as far as the two compilation models are concerned.                       --
--  However, for some machines there may be a difference since different      --
--  representations may be used for addresses (16 bit or 32 bit), depending   --
--  on the compilation model used.                                            --
--                                                                            --
--  If there is a difference in execution time, the times for both models     --
--  should be measured; model (1) is the one that corresponds more to actual  --
--  software development. Ada was explicitly designed for large software      --
--  projects that use separate compilation.                                   --
--                                                                            --
--  This file contains the "reference" version of Dhrystone/Ada (i.e. no      --
--  statement for measurement are included), with the whole program in        --
--  one file. For a version with separate source files for all library        --
--  units, see the files dhry-ref-pt1.ada, ..., dhry-ref-pt6.ada.             --
--                                                                            --
--------------------------------------------------------------------------------

package Global_Def is
------------------

  -- Global type definitions

  type Enumeration is (Ident_1, Ident_2, Ident_3, Ident_4, Ident_5);

  subtype One_To_Thirty is integer range 1..30;
  subtype One_To_Fifty is integer range 1..50;
  subtype Capital_Letter is character range 'A'..'Z';

  type String_30 is array (One_To_Thirty) of character;
    pragma Pack (String_30);

  type Array_1_Dim_Integer is array (One_To_Fifty) of integer;
  type Array_2_Dim_Integer is array (One_To_Fifty,
                                     One_To_Fifty) of integer;

  type Record_Type (Discr: Enumeration := Ident_1);

  type Record_Pointer is access Record_Type;

  type Record_Type (Discr: Enumeration := Ident_1) is
               record
                Pointer_Comp:   Record_Pointer;
                case Discr is
                  when Ident_1 =>     -- only this variant is used,
                                      -- but in some cases discriminant
                                      -- checks are necessary
                    Enum_Comp:      Enumeration;
                    Int_Comp:       One_To_Fifty;
                    String_Comp:    String_30;
                  when Ident_2 =>
                    Enum_Comp_2:    Enumeration;
                    String_Comp_2:  String_30;
                  when others =>
                    Char_Comp_1,
                    Char_Comp_2:    character;
                end case;
              end record;

end Global_Def;
