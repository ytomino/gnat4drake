with Ada.Wide_Characters.Handling;
package Ada.Wide_Characters.Unicode is
   pragma Preelaborate; -- Ada.Wide_Characters.Handling is not Pure.

   function To_Lower_Case (U : Wide_Character) return Wide_Character
      renames Handling.To_Lower;

end Ada.Wide_Characters.Unicode;
