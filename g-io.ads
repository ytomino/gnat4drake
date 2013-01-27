with Ada.Text_IO;
package GNAT.IO is
   procedure Put (Item : String)
      renames Ada.Text_IO.Put;
   procedure Put (Item : Integer);
   procedure Put_Line (Item : String)
      renames Ada.Text_IO.Put_Line;
   procedure New_Line (Spacing : Ada.Text_IO.Positive_Count := 1)
      renames Ada.Text_IO.New_Line;
end GNAT.IO;
