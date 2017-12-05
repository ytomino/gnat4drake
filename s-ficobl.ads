pragma License (Unrestricted);
with Ada.Streams.Naked_Stream_IO;
with Interfaces.C_Streams;
package System.File_Control_Block is
   pragma Preelaborate;

   type AFCB_Ptr is tagged private; -- Ada.Streams.Stream_IO.File_Type

   function Stream (File : AFCB_Ptr) return Interfaces.C_Streams.FILEs;

private

   type AFCB_Ptr is tagged record
      Stream : aliased Ada.Streams.Naked_Stream_IO.Non_Controlled_File_Type;
   end record;

end System.File_Control_Block;
