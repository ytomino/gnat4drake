with Ada.Hierarchical_File_Names;
with System;
with GNAT.Strings;
private with System.Native_IO; -- implementation unit
package GNAT.OS_Lib is
   --  Note: Ada.Directories is not preelaborate.

   --  String Operations

   subtype String_Access is Strings.String_Access;

   function "=" (Left, Right : String_Access) return Boolean
      renames Strings."=";

   procedure Free (X : in out String_Access)
      renames Strings.Free;

   subtype String_List is Strings.String_List;

   --  File Stuff

   type File_Descriptor is private;
   function "=" (Left, Right : File_Descriptor) return Boolean
      with Import, Convention => Intrinsic;

   Invalid_FD : constant File_Descriptor;

   procedure Close (FD : File_Descriptor);

   type Mode is (Binary);

   function File_Length (FD : File_Descriptor) return Long_Integer;

   function Is_Absolute_Path (Name : String) return Boolean
      renames Ada.Hierarchical_File_Names.Is_Full_Name;

   function Is_Directory (Name : String) return Boolean;

   function Is_Regular_File (Name : String) return Boolean;

   function Normalize_Pathname (
      Name : String;
      Directory : String  := "";
      Resolve_Links : Boolean := True;
      Case_Sensitive : Boolean := True)
      return String;

   function Open_Read (Name  : String; Fmode : Mode) return File_Descriptor;

   function Read (FD : File_Descriptor; A : System.Address; N : Integer)
      return Integer;

   --  Subprocesses

   subtype Argument_List is String_List;

   --  Miscellaneous

   Directory_Separator : constant Character :=
      Ada.Hierarchical_File_Names.Default_Path_Delimiter;
   pragma Warnings (Off, Directory_Separator); -- condition is always False

private

   type File_Descriptor is new System.Native_IO.Handle_Type; -- int or HANDLE

   Invalid_FD : constant File_Descriptor :=
      File_Descriptor (System.Native_IO.Invalid_Handle);

end GNAT.OS_Lib;
