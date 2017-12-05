package body System.File_IO is

   procedure Check_File_Open (File : File_Control_Block.AFCB_Ptr) is
   begin
      raise Program_Error; -- unimplemented
   end Check_File_Open;

end System.File_IO;
