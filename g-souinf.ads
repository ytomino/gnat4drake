with Ada;
package GNAT.Source_Info is
   pragma Pure;
   function File return String
      renames Ada.Debug.File;
   function Line return Integer
      renames Ada.Debug.Line;
end GNAT.Source_Info;
