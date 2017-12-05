pragma License (Unrestricted);
with System.WCh_Con;
generic
   Encoding_Method : System.WCh_Con.WC_Encoding_Method;
package GNAT.Encode_String is
   pragma Pure;

   function Encode_Wide_Wide_String (S : Wide_Wide_String) return String;

end GNAT.Encode_String;
