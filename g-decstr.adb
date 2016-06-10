with Ada.Characters.Conversions;
package body GNAT.Decode_String is

   procedure Decode_Wide_Character (
      Input : String;
      Ptr : in out Natural;
      Result : out Wide_Character)
   is
      Item : Wide_Wide_Character;
   begin
      Decode_Wide_Wide_Character (Input, Ptr, Item);
      Result := Ada.Characters.Conversions.To_Wide_Character (Item);
   end Decode_Wide_Character;

   procedure Decode_Wide_Wide_Character (
      Input : String;
      Ptr : in out Natural;
      Result : out Wide_Wide_Character) is
   begin
      case Encoding_Method is
         when System.WCh_Con.WCEM_UTF8 =>
            Ada.Characters.Conversions.Get (
               Input (Ptr .. Input'Last),
               Ptr,
               Result);
               --  String is UTF-8 in drake.
         when others =>
            raise Program_Error; -- unimplemented
      end case;
   end Decode_Wide_Wide_Character;

   procedure Next_Wide_Character (Input : String; Ptr : in out Natural) is
      Unused : Wide_Character;
   begin
      Decode_Wide_Character (Input, Ptr, Unused);
   end Next_Wide_Character;

end GNAT.Decode_String;
