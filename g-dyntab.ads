pragma License (Unrestricted);
generic
   type Table_Component_Type is private;
   type Table_Index_Type is range <>;
   Table_Low_Bound : Table_Index_Type;
   Table_Initial : Positive;
   Table_Increment : Natural;
   pragma Unreferenced (Table_Increment);
package GNAT.Dynamic_Tables is

   package Implementation is

      subtype Index_Type is
         Table_Index_Type range Table_Low_Bound .. Table_Index_Type'Last;

   end Implementation;

   type Table_Type is
      array (Implementation.Index_Type range <>) of Table_Component_Type;

   type Table_Ptr is access Table_Type;

   type Instance is record
      Table : aliased Table_Ptr := null;
      Last_Index : Implementation.Index_Type'Base := Table_Low_Bound - 1;
   end record;

   procedure Init (T : in out Instance);

   function Last (T : Instance) return Table_Index_Type;

   procedure Free (T : in out Instance);

   First : constant Table_Index_Type := Table_Low_Bound;

   procedure Set_Last (T : in out Instance; New_Val : Table_Index_Type);

   procedure Append (T : in out Instance; New_Val : Table_Component_Type);

end GNAT.Dynamic_Tables;
