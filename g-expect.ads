with GNAT.OS_Lib;
with GNAT.Regpat;
private with Ada.Processes;
private with Ada.Streams.Stream_IO;
package GNAT.Expect is

   type Process_Descriptor is tagged limited private;

   type Process_Descriptor_Access is access Process_Descriptor'Class;

   --  Spawning a process

   procedure Close (Descriptor : in out Process_Descriptor);

   procedure Close (
      Descriptor : in out Process_Descriptor;
      Status : out Integer);

   function Get_Command_Output (
      Command : String;
      Arguments : GNAT.OS_Lib.Argument_List;
      Input : String;
      Status : not null access Integer;
      Err_To_Out : Boolean := False)
      return String;

   --  Sending data

   procedure Send (
      Descriptor : in out Process_Descriptor;
      Str : String;
      Add_LF : Boolean := True;
      Empty_Buffer : Boolean := False);

   --  Working on the output (single process, simple regexp)

   type Expect_Match is new Integer;

   Expect_Timeout : constant Expect_Match := -2;

   procedure Expect (
      Descriptor : in out Process_Descriptor;
      Result : out Expect_Match;
      Regexp : String;
      Timeout : Integer := 10_000;
      Full_Buffer : Boolean := False);

   procedure Expect (
      Descriptor : in out Process_Descriptor;
      Result : out Expect_Match;
      Regexp : GNAT.Regpat.Pattern_Matcher;
      Timeout : Integer := 10_000;
      Full_Buffer : Boolean := False);

   --  Getting the output

   procedure Flush (
      Descriptor : in out Process_Descriptor;
      Timeout : Integer := 0);

   function Expect_Out (Descriptor : Process_Descriptor) return String;

   --  Exceptions

   Invalid_Process : exception;

   Process_Died : exception;

private

   type Process_Descriptor is tagged limited record
      Item : Ada.Processes.Process;
      Input_Writing : access Ada.Streams.Stream_IO.File_Type;
   end record;

end GNAT.Expect;
