with GNAT.OS_Lib;
package GNAT.Expect is

   --  Spawning a process

   function Get_Command_Output (
      Command : String;
      Arguments : GNAT.OS_Lib.Argument_List;
      Input : String;
      Status : not null access Integer;
      Err_To_Out : Boolean := False)
      return String;

end GNAT.Expect;
