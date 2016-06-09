package GNAT.Regpat is
   pragma Preelaborate;

   --  Constants

   Expression_Error : exception;

   type Regexp_Bit is (
      Case_Insensitive_Bit,
      Single_Line_Bit,
      Multiple_Lines_Bit);
      --  representation

   type Regexp_Flags is array (Regexp_Bit) of Boolean;
   pragma Pack (Regexp_Flags);

   No_Flags : constant Regexp_Flags := (others => False);
   Case_Insensitive : constant Regexp_Flags :=
      (Case_Insensitive_Bit => True, others => False);
   Single_Line : constant Regexp_Flags :=
      (Single_Line_Bit => True, others => False);
   Multiple_Lines : constant Regexp_Flags :=
      (Multiple_Lines_Bit => True, others => False);

   --  Match_Array

   subtype Match_Count is Natural;

   type Match_Location is record
      First : Natural := 0;
      Last : Natural := 0;
   end record;

   type Match_Array is array (Match_Count range <>) of Match_Location;

   No_Match : constant Match_Location := (First => 0, Last => 0);

   --  Pattern_Matcher Compilation

   type Pattern_Matcher is null record;

   function Compile (Expression : String; Flags : Regexp_Flags := No_Flags)
      return Pattern_Matcher;

   --  Matching a Pre-Compiled Regular Expression

   function  Match (
      Self : Pattern_Matcher;
      Data : String;
      Data_First : Integer  := -1;
      Data_Last : Positive := Positive'Last)
      return Boolean;

   procedure Match (
      Self : Pattern_Matcher;
      Data : String;
      Matches : out Match_Array;
      Data_First : Integer  := -1;
      Data_Last : Positive := Positive'Last);

end GNAT.Regpat;
