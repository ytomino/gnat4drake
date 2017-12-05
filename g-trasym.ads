pragma License (Unrestricted);
with Ada.Exceptions;
package GNAT.Traceback.Symbolic is
   pragma Preelaborate;
   function Symbolic_Traceback (E : Ada.Exceptions.Exception_Occurrence)
      return String
      renames Ada.Exceptions.Exception_Information;
end GNAT.Traceback.Symbolic;
