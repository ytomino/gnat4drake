with System.WCh_Con;
with GNAT.Decode_String;
package GNAT.Decode_UTF8_String is
   new GNAT.Decode_String (System.WCh_Con.WCEM_UTF8);
pragma Pure (GNAT.Decode_UTF8_String);
