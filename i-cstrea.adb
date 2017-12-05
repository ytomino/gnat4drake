package body Interfaces.C_Streams is

   function stdin return FILEs is
   begin
      return C.stdio.stdin;
   end stdin;

   function stdout return FILEs is
   begin
      return C.stdio.stdout;
   end stdout;

   function stderr return FILEs is
   begin
      return C.stdio.stderr;
   end stderr;

end Interfaces.C_Streams;
