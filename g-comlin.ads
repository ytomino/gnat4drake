pragma License (Unrestricted);
package GNAT.Command_Line is

   --  Parsing

   type Opt_Parser is null record;

   Command_Line_Parser : constant Opt_Parser := (null record);

   procedure Initialize_Option_Scan (
      Switch_Char : Character := '-';
      Stop_At_First_Non_Switch : Boolean := False;
      Section_Delimiters : String := "") is null;

   function Full_Switch (Parser : Opt_Parser := Command_Line_Parser)
      return String;

   function Getopt (
      Switches : String;
      Concatenate : Boolean := True;
      Parser : Opt_Parser := Command_Line_Parser)
      return Character;

   function Get_Argument (
      Do_Expansion : Boolean := False;
      Parser : Opt_Parser := Command_Line_Parser)
      return String;

   function Parameter (Parser : Opt_Parser := Command_Line_Parser)
      return String;

   Invalid_Switch : exception;

   Invalid_Parameter : exception;

end GNAT.Command_Line;
