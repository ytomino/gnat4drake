pragma License (Unrestricted);
with System.File_Control_Block;
package System.File_IO is
   pragma Preelaborate;

   procedure Check_File_Open (File : File_Control_Block.AFCB_Ptr);

end System.File_IO;
