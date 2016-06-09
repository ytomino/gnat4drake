with Ada;
with System.System_Allocators.Allocated_Size; -- implementation unit
package body GNAT.Debug_Pools is

   procedure Dump (
      Pool : Debug_Pool;
      Size : Positive;
      Report : Report_Type := All_Reports)
   is
      pragma Unreferenced (Put_Line);
      pragma Unreferenced (Put);
      pragma Unreferenced (Pool);
      pragma Unreferenced (Size);
      pragma Unreferenced (Report);
   begin
      Ada.Debug.Put ("unimplemented"); -- unimplemented
   end Dump;

   procedure Dump_Stdout (
      Pool : Debug_Pool;
      Size : Positive;
      Report : Report_Type := All_Reports)
   is
      pragma Unreferenced (Pool);
      pragma Unreferenced (Size);
      pragma Unreferenced (Report);
   begin
      Ada.Debug.Put ("unimplemented"); -- unimplemented
   end Dump_Stdout;

   procedure Get_Size (
      Storage_Address : System.Address;
      Size_In_Storage_Elements : out System.Storage_Elements.Storage_Count;
      Valid : out Boolean) is
   begin
      Size_In_Storage_Elements :=
         System.System_Allocators.Allocated_Size (Storage_Address);
      Valid := True;
   end Get_Size;

   function High_Water_Mark (Pool : Debug_Pool) return Byte_Count is
      pragma Unreferenced (Pool);
   begin
      return 1; -- unimplemented
   end High_Water_Mark;

   function Current_Water_Mark (Pool : Debug_Pool) return Byte_Count is
      pragma Unreferenced (Pool);
   begin
      return 1; -- unimplemented
   end Current_Water_Mark;

end GNAT.Debug_Pools;
