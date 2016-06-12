with Ada.Calendar;
with Ada.Directories.Information;
with Ada.Hierarchical_File_Names;
with System;
with GNAT.Calendar;
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

   subtype String_List_Access is Strings.String_List_Access;

   procedure Free (Arg : in out String_List_Access)
      renames Strings.Free;

   function "=" (Left, Right : String_List_Access) return Boolean
      renames Strings."=";

   --  Time/Date Stuff

   subtype OS_Time is Ada.Calendar.Time;

   Invalid_Time : constant OS_Time := GNAT.Calendar.No_Time;

   subtype Year_Type is Integer range 1900 .. 2099;
   subtype Month_Type is Integer range 1 .. 12;
   subtype Day_Type is Integer range 1 .. 31;
   subtype Hour_Type is Integer range 0 .. 23;
   subtype Minute_Type is Integer range 0 .. 59;
   subtype Second_Type is Integer range 0 .. 59;

   procedure GM_Split (
      Date : OS_Time;
      Year : out Year_Type;
      Month : out Month_Type;
      Day : out Day_Type;
      Hour : out Hour_Type;
      Minute : out Minute_Type;
      Second : out Second_Type);

   --  File Stuff

   type File_Descriptor is private;
   function "=" (Left, Right : File_Descriptor) return Boolean
      with Import, Convention => Intrinsic;

   Standin  : constant File_Descriptor;
   Standout : constant File_Descriptor;
   Standerr : constant File_Descriptor;

   Invalid_FD : constant File_Descriptor;

   procedure Close (FD : File_Descriptor);

   type Copy_Mode is (Copy, Overwrite);

   type Attribute is (Time_Stamps, Full);

   procedure Copy_File (
      Name : String;
      Pathname : String;
      Success : out Boolean;
      Mode : Copy_Mode := Copy;
      Preserve : Attribute := Time_Stamps);

   procedure Copy_File_Attributes (
      From : String;
      To : String;
      Success : out Boolean;
      Copy_Timestamp : Boolean := True;
      Copy_Permissions : Boolean := True);

   type Mode is (Binary);

   function Create_File (Name : String; Fmode : Mode) return File_Descriptor;

   Temp_File_Len : constant Integer := 10;
      --  The length of a temporary name is 10 ("ADAXXXXXX" & NUL) in drake,
      --    against 12 ("GNAT-XXXXXX" & NUL) in GNAT runtime.

   subtype Temp_File_Name is String (1 .. Temp_File_Len);

   procedure Create_Temp_File (
      FD : out File_Descriptor;
      Name : out Temp_File_Name);

   procedure Create_Temp_File (
      FD : out File_Descriptor;
      Name : out String_Access);

   procedure Delete_File (Name : String; Success : out Boolean);

   function File_Length (FD : File_Descriptor) return Long_Integer;

   function File_Time_Stamp (Name : String) return OS_Time;

   function Is_Absolute_Path (Name : String) return Boolean
      renames Ada.Hierarchical_File_Names.Is_Full_Name;

   function Is_Directory (Name : String) return Boolean;

   function Is_Regular_File (Name : String) return Boolean;

   function Is_Symbolic_Link (Name : String) return Boolean
      renames Ada.Directories.Information.Is_Symbolic_Link;

   function Is_Writable_File (Name : String) return Boolean;

   function Locate_Exec_On_Path (Exec_Name : String) return String_Access;

   function Locate_Regular_File (File_Name : String; Path : String)
      return String_Access;

   Seek_Set : constant := 0;
   Seek_Cur : constant := 1;
   Seek_End : constant := 2;

   procedure Lseek (
      FD : File_Descriptor;
      offset : Long_Integer;
      origin : Integer);

   function Normalize_Pathname (
      Name : String;
      Directory : String  := "";
      Resolve_Links : Boolean := True;
      Case_Sensitive : Boolean := True)
      return String;

   function Open_Read (Name  : String; Fmode : Mode) return File_Descriptor;

   function Open_Read_Write (Name : String; Fmode : Mode)
      return File_Descriptor;

   function Read (FD : File_Descriptor; A : System.Address; N : Integer)
      return Integer;

   procedure Rename_File (
      Old_Name : String;
      New_Name : String;
      Success : out Boolean);

   procedure Set_Non_Readable (Name : String);

   procedure Set_Non_Writable (Name : String);

   procedure Set_Readable (Name : String);

   procedure Set_Writable (Name : String);

   function Write (FD : File_Descriptor; A : System.Address; N : Integer)
      return Integer;

   --  Subprocesses

   subtype Argument_List is String_List;

   subtype Argument_List_Access is String_List_Access;

   --  Miscellaneous

   function Errno return Integer;

   function Getenv (Name : String) return String_Access;

   procedure OS_Exit (Status : Integer);

   Directory_Separator : constant Character :=
      Ada.Hierarchical_File_Names.Default_Path_Delimiter;
   pragma Warnings (Off, Directory_Separator); -- condition is always False

   Path_Separator : constant Character := ':'; -- ???

private

   type File_Descriptor is new System.Native_IO.Handle_Type; -- int or HANDLE

   Standin  : constant File_Descriptor :=
      File_Descriptor (System.Native_IO.Standard_Input);
   Standout : constant File_Descriptor :=
      File_Descriptor (System.Native_IO.Standard_Output);
   Standerr : constant File_Descriptor :=
      File_Descriptor (System.Native_IO.Standard_Error);

   Invalid_FD : constant File_Descriptor :=
      File_Descriptor (System.Native_IO.Invalid_Handle);

end GNAT.OS_Lib;
