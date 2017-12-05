package body System.File_Control_Block is

   function Stream (File : AFCB_Ptr) return Interfaces.C_Streams.FILEs is
   begin
      raise Program_Error; -- FILE * is not used in drake
      return Stream (File);
   end Stream;

end System.File_Control_Block;
