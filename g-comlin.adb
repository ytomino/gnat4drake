with Ada.Characters.Latin_1;
with Ada.Command_Line;
package body GNAT.Command_Line is

   function Getopt (
      Switches : String;
      Concatenate : Boolean := True;
      Parser : Opt_Parser := Command_Line_Parser)
      return Character
   is
      pragma Unreferenced (Switches);
      pragma Unreferenced (Concatenate);
      pragma Unreferenced (Parser);
   begin
      if Ada.Command_Line.Argument_Count > 0 then
         raise Program_Error; -- unimplemented
      end if;
      return Ada.Characters.Latin_1.NUL;
   end Getopt;

   function Full_Switch (Parser : Opt_Parser := Command_Line_Parser)
      return String is
   begin
      raise Program_Error; -- unimplemented
      return Full_Switch (Parser);
   end Full_Switch;

   function Get_Argument (
      Do_Expansion : Boolean := False;
      Parser : Opt_Parser := Command_Line_Parser)
      return String is
   begin
      raise Program_Error; -- unimplemented
      return Get_Argument (Do_Expansion, Parser);
   end Get_Argument;

   function Parameter (Parser : Opt_Parser := Command_Line_Parser)
      return String is
   begin
      raise Program_Error; -- unimplemented
      return Parameter (Parser);
   end Parameter;

end GNAT.Command_Line;
