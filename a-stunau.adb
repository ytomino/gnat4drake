with Ada.Strings.Unbounded_Strings;
with System.Address_To_Named_Access_Conversions;
package body Ada.Strings.Unbounded.Aux is

   package Big_String_Access_Conv is
      new System.Address_To_Named_Access_Conversions (
         Big_String,
         Big_String_Access);

   procedure Get_String (
      U : Unbounded_String;
      S : out Big_String_Access;
      L : out Natural)
   is
      Mutable_U : Unbounded_String
         renames U'Unrestricted_Access.all;
   begin
      S := Big_String_Access_Conv.To_Pointer (
         Unbounded_Strings.Reference (Mutable_U).Element.all'Address);
         --  Use Reference to get the non-shared string.
      L := Length (U);
   end Get_String;

end Ada.Strings.Unbounded.Aux;
