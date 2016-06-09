with Ada.Unchecked_Deallocation;
package GNAT.Strings is
   pragma Preelaborate;

   type String_Access is access all String;

   procedure Free is
      new Ada.Unchecked_Deallocation (String, String_Access);

   type String_List is array (Positive range <>) of String_Access;

   type String_List_Access is access all String_List;

   procedure Free (Arg : in out String_List_Access);

end GNAT.Strings;
