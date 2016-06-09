with Ada.Characters.Handling;
package GNAT.Case_Util is
   pragma Preelaborate; -- Ada.Characters.Handling is not pure.

   function To_Lower (A : Character) return Character
      renames Ada.Characters.Handling.To_Lower;

   procedure To_Lower (A : in out String);

end GNAT.Case_Util;
