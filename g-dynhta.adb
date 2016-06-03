package body GNAT.Dynamic_HTables is

   package body Simple_HTable is

      function R (Position : Maps.Cursor) return Element;
      function R (Position : Maps.Cursor) return Element is
      begin
         if Maps.Has_Element (Position) then
            return Maps.Element (Position);
         else
            return No_Element;
         end if;
      end R;

      procedure Set (T : in out Instance; K : Key; E : Element) is
      begin
         Maps.Include (T.Map, K, E);
      end Set;

      procedure Reset (T : in out Instance) is
      begin
         Maps.Clear (T.Map);
      end Reset;

      function Get (T : Instance; K : Key) return Element is
      begin
         return R (Maps.Find (T.Map, K));
      end Get;

      function Get_First (T : in out Instance) return Element is
      begin
         T.Position := Maps.First (T.Map);
         return R (T.Position);
      end Get_First;

      function Get_Next (T : in out Instance) return Element is
      begin
         if Maps.Has_Element (T.Position) then
            T.Position := Maps.Next (T.Position);
         end if;
         return R (T.Position);
      end Get_Next;

      function Hash (Item : Key) return Ada.Containers.Hash_Type is
      begin
         return Ada.Containers.Hash_Type'Mod (Header_Num'(Hash (Item)));
      end Hash;

   end Simple_HTable;

end GNAT.Dynamic_HTables;
