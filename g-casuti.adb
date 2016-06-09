package body GNAT.Case_Util is

   procedure To_Lower (A : in out String) is
   begin
      for I in A'Range loop
         A (I) := To_Lower (A (I));
      end loop;
      --  Constraint_Error will be propagated if "A" has any multi-byte
      --    character.
   end To_Lower;

end GNAT.Case_Util;
