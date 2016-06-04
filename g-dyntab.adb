with Ada.Containers.Generic_Array_Access_Types;
with Ada.Unchecked_Deallocation;
package body GNAT.Dynamic_Tables is

   procedure Free is new Ada.Unchecked_Deallocation (Table_Type, Table_Ptr);

   package Arrays is
      new Ada.Containers.Generic_Array_Access_Types (
         Implementation.Index_Type,
         Table_Component_Type,
         Table_Type,
         Table_Ptr,
         Free => Free);

   procedure Init (T : in out Instance) is
   begin
      Arrays.Set_Length (T.Table, Table_Initial);
   end Init;

   function Last (T : Instance) return Table_Index_Type is
   begin
      return T.Last_Index;
   end Last;

   procedure Free (T : in out Instance) is
   begin
      Free (T.Table);
   end Free;

   procedure Set_Last (T : in out Instance; New_Val : Table_Index_Type) is
   begin
      if New_Val > T.Table'Last then
         Arrays.Set_Length (
            T.Table,
            Ada.Containers.Count_Type (New_Val - Table_Low_Bound + 1));
      end if;
      T.Last_Index := New_Val;
   end Set_Last;

   procedure Append (T : in out Instance; New_Val : Table_Component_Type) is
   begin
      Set_Last (T, T.Last_Index + 1);
      T.Table (T.Last_Index) := New_Val;
   end Append;

end GNAT.Dynamic_Tables;
