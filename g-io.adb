with Ada.Integer_Text_IO;
package body GNAT.IO is
   procedure Put (Item : Integer) is
   begin
      Ada.Integer_Text_IO.Put (Item);
   end Put;
end GNAT.IO;
