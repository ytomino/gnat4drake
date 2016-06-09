with Ada;
package GNAT.Source_Info is
   pragma Pure;

   function File return String
      renames Ada.Debug.File;
   function Line return Integer
      renames Ada.Debug.Line;
   function Source_Location return String
      renames Ada.Debug.Source_Location;
   function Enclosing_Entity return String
      renames Ada.Debug.Enclosing_Entity;

end GNAT.Source_Info;
