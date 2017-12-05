pragma License (Unrestricted);
with GNAT.Traceback;
with System;
package Ada.Exceptions.Traceback is

   subtype Code_Loc is System.Address;

   subtype Tracebacks_Array is GNAT.Traceback.Tracebacks_Array;

   function Get_PC (TB_Entry : System.Address) return Code_Loc;

end Ada.Exceptions.Traceback;
