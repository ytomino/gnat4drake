pragma License (Unrestricted);
with System.WCh_Con;
with GNAT.Encode_String;
package GNAT.Encode_UTF8_String is
   new GNAT.Encode_String (System.WCh_Con.WCEM_UTF8);
pragma Pure (GNAT.Encode_UTF8_String);
