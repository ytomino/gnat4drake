with Ada.Exceptions.Finally;
with Ada.Directories;
with Ada.IO_Modes;
with Ada.Streams;
with System.Native_IO.Names; -- implementation unit
package body GNAT.OS_Lib is
   use type Ada.Directories.File_Kind;

   --  File Stuff

   procedure Close (FD : File_Descriptor) is
   begin
      System.Native_IO.Close_Ordinary (
         System.Native_IO.Handle_Type (FD),
         null,
         Raise_On_Error => True);
   end Close;

   function File_Length (FD : File_Descriptor) return Long_Integer is
   begin
      return Long_Integer (
         System.Native_IO.Size (System.Native_IO.Handle_Type (FD)));
   end File_Length;

   function Is_Directory (Name : String) return Boolean is
   begin
      return Ada.Directories.Exists (Name)
         and then Ada.Directories.Kind (Name) = Ada.Directories.Directory;
   end Is_Directory;

   function Is_Regular_File (Name : String) return Boolean is
   begin
      return Ada.Directories.Exists (Name)
         and then Ada.Directories.Kind (Name) = Ada.Directories.Ordinary_File;
   end Is_Regular_File;

   function Normalize_Pathname (
      Name : String;
      Directory : String  := "";
      Resolve_Links : Boolean := True;
      Case_Sensitive : Boolean := True)
      return String
   is
      pragma Unreferenced (Case_Sensitive);
      pragma Unreferenced (Resolve_Links);
   begin
      if Ada.Hierarchical_File_Names.Is_Full_Name (Name) then
         return Name;
      elsif Directory'Length = 0 then
         return Ada.Hierarchical_File_Names.Normalized_Compose (
            Ada.Directories.Current_Directory,
            Name);
      else
         return Ada.Hierarchical_File_Names.Normalized_Compose (
            Directory,
            Name);
      end if;
   end Normalize_Pathname;

   function Open_Read (Name  : String; Fmode : Mode) return File_Descriptor is
      pragma Unreferenced (Fmode);
      package Holder is
         new Ada.Exceptions.Finally.Scoped_Holder (
            System.Native_IO.Name_Pointer,
            System.Native_IO.Free);
      X_Name : aliased System.Native_IO.Name_Pointer;
      Result : aliased System.Native_IO.Handle_Type;
   begin
      Holder.Assign (X_Name);
      System.Native_IO.Names.Open_Ordinary (
         Method => System.Native_IO.Open,
         Handle => Result,
         Mode => Ada.IO_Modes.In_File,
         Name => Name,
         Out_Name => X_Name,
         Form => (
            Shared => Ada.IO_Modes.Read_Only,
            Wait => False,
            Overwrite => True));
      return File_Descriptor (Result);
   end Open_Read;

   function Read (FD : File_Descriptor; A : System.Address; N : Integer)
      return Integer
   is
      Result : Ada.Streams.Stream_Element_Offset;
   begin
      System.Native_IO.Read (
         System.Native_IO.Handle_Type (FD),
         A,
         Ada.Streams.Stream_Element_Offset (N),
         Out_Length => Result);
      return Integer (Result);
   end Read;

end GNAT.OS_Lib;
