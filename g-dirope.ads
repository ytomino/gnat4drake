with Ada.Directories;
with Ada.Hierarchical_File_Names;
package GNAT.Directory_Operations is

   subtype Dir_Name_Str is String;

   subtype Dir_Type is Ada.Directories.Search_Type;

   Directory_Error : exception;

   --  Basic Directory operations

   procedure Change_Dir (Dir_Name : Dir_Name_Str)
      renames Ada.Directories.Set_Directory;

   procedure Make_Dir (Dir_Name : Dir_Name_Str);

   procedure Remove_Dir (
      Dir_Name : Dir_Name_Str;
      Recursive : Boolean := False);

   function Get_Current_Dir return Dir_Name_Str
      renames Ada.Directories.Current_Directory;

   --  Pathname Operations

   subtype Path_Name is String;

   function Dir_Name (Path : Path_Name) return Dir_Name_Str
      renames Ada.Hierarchical_File_Names.Containing_Directory;

   function Base_Name (Path : Path_Name; Suffix : String := "")
      return String;

   function File_Extension (Path : Path_Name) return String
      renames Ada.Hierarchical_File_Names.Extension;

   type Path_Style is (System_Default);

   function Format_Pathname (
      Path : Path_Name;
      Style : Path_Style := System_Default)
      return Path_Name;

   --  Iterators

   procedure Open (Dir : in out Dir_Type; Dir_Name : Dir_Name_Str);

   procedure Close (Dir : in out Dir_Type)
      renames Ada.Directories.End_Search;

   procedure Read (
      Dir : in out Dir_Type;
      Str : out String;
      Last : out Natural);

end GNAT.Directory_Operations;
