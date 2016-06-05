with Ada.Command_Line;
with Ada.Processes;
with Ada.Streams.Stream_IO.Pipes;
with Ada.Strings.Unbounded_Strings;
package body GNAT.Expect is
   use type GNAT.OS_Lib.Argument_List;

   function Get_Command_Output (
      Command : String;
      Arguments : GNAT.OS_Lib.Argument_List;
      Input : String;
      Status : not null access Integer;
      Err_To_Out : Boolean := False)
      return String
   is
      Input_Reading,
      Input_Writing,
      Output_Reading,
      Output_Writing : Ada.Streams.Stream_IO.File_Type;
      Child : Ada.Processes.Process;
      Command_And_Arguments : Ada.Processes.Command_Type;
      Result : Ada.Strings.Unbounded_Strings.Unbounded_String;
   begin
      --  build command line
      Ada.Processes.Append (Command_And_Arguments, Command);
      for I in Arguments'Range loop
         Ada.Processes.Append (Command_And_Arguments, Arguments (I).all);
      end loop;
      --  open
      Ada.Streams.Stream_IO.Pipes.Create (Input_Reading, Input_Writing);
      Ada.Streams.Stream_IO.Pipes.Create (Output_Reading, Output_Writing);
      if Err_To_Out then
         Ada.Processes.Create (
            Child,
            Command_And_Arguments,
            Search_Path => True,
            Input => Input_Reading,
            Output => Output_Writing,
            Error => Output_Writing);
      else
         Ada.Processes.Create (
            Child,
            Command_And_Arguments,
            Search_Path => True,
            Input => Input_Reading,
            Output => Output_Writing);
      end if;
      --  send input
      String'Write (Ada.Streams.Stream_IO.Stream (Input_Writing), Input);
      Ada.Streams.Stream_IO.Close (Input_Writing);
      --  receive output
      begin
         loop
            declare
               Item : Character;
            begin
               Character'Read (
                  Ada.Streams.Stream_IO.Stream (Output_Reading),
                  Item);
               Ada.Strings.Unbounded_Strings.Append_Element (Result, Item);
            end;
         end loop;
      exception
         when Ada.Streams.Stream_IO.End_Error => null;
      end;
      --  wait and receive status-code
      Ada.Processes.Wait (
         Child,
         Status => Ada.Command_Line.Exit_Status (Status.all));
      return Ada.Strings.Unbounded_Strings.To_String (Result);
   end Get_Command_Output;

end GNAT.Expect;
