package body Interfaces.C_Streams is

   function stdin return FILEs is
   begin
      raise Program_Error; -- unimplemented
      return stdin;
   end stdin;

   function stdout return FILEs is
   begin
      raise Program_Error; -- unimplemented
      return stdout;
   end stdout;

   function stderr return FILEs is
   begin
      raise Program_Error; -- unimplemented
      return stderr;
   end stderr;

end Interfaces.C_Streams;
