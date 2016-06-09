with Ada.Characters.Conversions;
package body GNAT.Encode_String is

   function Encode_Wide_Wide_String (S : Wide_Wide_String) return String is
   begin
      case Encoding_Method is
         when System.WCh_Con.WCEM_UTF8 =>
            return Ada.Characters.Conversions.To_String (S);
               --  String is UTF-8 in drake.
         when others =>
            raise Program_Error; -- unimplemented
      end case;
   end Encode_Wide_Wide_String;

end GNAT.Encode_String;
