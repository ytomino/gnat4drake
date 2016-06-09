package body GNAT.Strings is

   procedure Raw_Free is
      new Ada.Unchecked_Deallocation (String_List, String_List_Access);

   procedure Free (Arg : in out String_List_Access) is
   begin
      if Arg /= null then
         for I in Arg'Range loop
            Free (Arg (I));
         end loop;
         Raw_Free (Arg);
      end if;
   end Free;

end GNAT.Strings;
