with System.WCh_Con;
generic
   Encoding_Method : System.WCh_Con.WC_Encoding_Method;
package GNAT.Decode_String is
   pragma Pure;

   procedure Decode_Wide_Character (
      Input : String;
      Ptr : in out Natural;
      Result : out Wide_Character);

   procedure Decode_Wide_Wide_Character (
      Input : String;
      Ptr : in out Natural;
      Result : out Wide_Wide_Character);

   procedure Next_Wide_Character (Input : String; Ptr : in out Natural);

end GNAT.Decode_String;
