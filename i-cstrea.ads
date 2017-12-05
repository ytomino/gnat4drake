pragma License (Unrestricted);
with C;
package Interfaces.C_Streams is
   pragma Preelaborate;

   subtype FILEs is C.void_ptr; -- C.stdio.FILE_ptr;

   function stdin return FILEs;
   function stdout return FILEs;
   function stderr return FILEs;

   --  Note: FILE * is not used in drake.

end Interfaces.C_Streams;
