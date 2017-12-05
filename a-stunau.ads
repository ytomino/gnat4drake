pragma License (Unrestricted);
package Ada.Strings.Unbounded.Aux is
   pragma Preelaborate;

   subtype Big_String is String (1 .. Positive'Last);

   type Big_String_Access is access all Big_String;
   for Big_String_Access'Storage_Size use 0;

   procedure Get_String (
      U : Unbounded_String;
      S : out Big_String_Access;
      L : out Natural);

end Ada.Strings.Unbounded.Aux;
