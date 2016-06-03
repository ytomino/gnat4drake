with Ada.Hierarchical_File_Names;
package GNAT.Directory_Operations is

   subtype Dir_Name_Str is String;

   --  Pathname Operations

   subtype Path_Name is String;

   function Dir_Name (Path : Path_Name) return Dir_Name_Str
      renames Ada.Hierarchical_File_Names.Containing_Directory;

   function Base_Name (Path : Path_Name; Suffix : String := "")
      return String;

end GNAT.Directory_Operations;
