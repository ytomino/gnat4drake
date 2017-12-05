pragma License (Unrestricted);
with C.stdio;
package Interfaces.C_Streams is
   pragma Preelaborate;

   subtype int is C.signed_int;

   subtype FILEs is C.stdio.FILE_ptr;

   function stdin return FILEs;
   function stdout return FILEs;
   function stderr return FILEs;

   --  Note: FILE * is not used in drake.

   function fflush (stream : access C.stdio.FILE) return int
      renames C.stdio.fflush;

end Interfaces.C_Streams;
