private with Ada.Containers.Hashed_Maps;
package GNAT.Dynamic_HTables is

   --  Simple_HTable

   generic
      type Header_Num is range <>;
      type Element is private;
      No_Element : Element;
      type Key is private;
      with function Hash  (F : Key) return Header_Num;
      with function Equal (F1, F2 : Key) return Boolean;
   package Simple_HTable is

      type Instance is private;

      procedure Set (T : in out Instance; K : Key; E : Element);

      procedure Reset (T : in out Instance);

      function Get (T : Instance; K : Key) return Element;

      function Get_First (T : in out Instance) return Element;

      function Get_Next (T : in out Instance) return Element;

   private

      function Hash (Item : Key) return Ada.Containers.Hash_Type;

      package Maps is
         new Ada.Containers.Hashed_Maps (
            Key_Type => Key,
            Element_Type => Element,
            Hash => Hash,
            Equivalent_Keys => Equal);

      type Instance is record
         Map : Maps.Map;
         Position : Maps.Cursor;
      end record;

   end Simple_HTable;

end GNAT.Dynamic_HTables;
