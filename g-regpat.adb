package body GNAT.Regpat is

   function Compile (Expression : String; Flags : Regexp_Flags := No_Flags)
      return Pattern_Matcher is
   begin
      raise Program_Error; -- unimplemented
      return Compile (Expression, Flags);
   end Compile;

   function  Match (
      Self : Pattern_Matcher;
      Data : String;
      Data_First : Integer  := -1;
      Data_Last : Positive := Positive'Last)
      return Boolean is
   begin
      raise Program_Error; -- unimplemented
      return Match (Self, Data, Data_First, Data_Last);
   end Match;

   procedure Match (
      Self : Pattern_Matcher;
      Data : String;
      Matches : out Match_Array;
      Data_First : Integer  := -1;
      Data_Last : Positive := Positive'Last) is
   begin
      raise Program_Error; -- unimplemented
   end Match;

end GNAT.Regpat;
