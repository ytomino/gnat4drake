with Ada.Calendar.Formatting;
with Ada.Characters.Latin_1;
with Ada.Environment_Variables;
with Ada.Exceptions.Finally;
with Ada.Directories.Temporary;
with Ada.Directories.Volumes;
with Ada.IO_Modes;
with Ada.Streams;
with System.Native_IO.Names; -- implementation unit
with C.errno;
with C.stdlib;
with C.string;
package body GNAT.OS_Lib is
   use type Ada.Directories.File_Kind;

   --  (adaint.c)

   function gnat_is_directory (Name : not null C.char_const_ptr)
      return C.signed_int
      with Export, Convention => C, External_Name => "__gnat_is_directory";

   function gnat_is_directory (Name : not null C.char_const_ptr)
      return C.signed_int
   is
      Length : constant Natural := Natural (C.string.strlen (Name));
      Name_As_Ada : String (1 .. Length);
      for Name_As_Ada'Address use Name.all'Address;
   begin
      return Boolean'Pos (Is_Directory (Name_As_Ada));
   end gnat_is_directory;

   function Get_File_Names_Case_Sensitive return C.signed_int
      with Export,
         Convention => C,
         External_Name => "__gnat_get_file_names_case_sensitive";

   function Get_File_Names_Case_Sensitive return C.signed_int is
      FS : constant Ada.Directories.Volumes.File_System :=
         Ada.Directories.Volumes.Where (Ada.Directories.Current_Directory);
   begin
      return Boolean'Pos (Ada.Directories.Volumes.Case_Sensitive (FS));
   end Get_File_Names_Case_Sensitive;

   --  Time/Date Stuff

   procedure GM_Split (
      Date : OS_Time;
      Year : out Year_Type;
      Month : out Month_Type;
      Day : out Day_Type;
      Hour : out Hour_Type;
      Minute : out Minute_Type;
      Second : out Second_Type)
   is
      Sub_Second : Ada.Calendar.Formatting.Second_Duration;
   begin
      Ada.Calendar.Formatting.Split (
         Date,
         Year => Year,
         Month => Month,
         Day => Day,
         Hour => Hour,
         Minute => Minute,
         Second => Second,
         Sub_Second => Sub_Second,
         Time_Zone => 0); -- GMT
   end GM_Split;

   --  File Stuff

   procedure Do_Open (
      Method : System.Native_IO.Open_Method;
      FD : out File_Descriptor;
      Mode : Ada.IO_Modes.File_Mode;
      Name : String);
   procedure Do_Open (
      Method : System.Native_IO.Open_Method;
      FD : out File_Descriptor;
      Mode : Ada.IO_Modes.File_Mode;
      Name : String)
   is
      package Holder is
         new Ada.Exceptions.Finally.Scoped_Holder (
            System.Native_IO.Name_Pointer,
            System.Native_IO.Free);
      X_Name : aliased System.Native_IO.Name_Pointer;
      Handle : aliased System.Native_IO.Handle_Type;
   begin
      Holder.Assign (X_Name);
      System.Native_IO.Names.Open_Ordinary (
         Method => Method,
         Handle => Handle,
         Mode => Mode,
         Name => Name,
         Out_Name => X_Name,
         Form => (
            Shared => Ada.IO_Modes.Allow, -- ???
            Wait => False,
            Overwrite => True));
      FD := File_Descriptor (Handle);
   end Do_Open;

   procedure Close (FD : File_Descriptor) is
   begin
      System.Native_IO.Close_Ordinary (
         System.Native_IO.Handle_Type (FD),
         null,
         Raise_On_Error => True);
   end Close;

   procedure Copy_File (
      Name : String;
      Pathname : String;
      Success : out Boolean;
      Mode : Copy_Mode := Copy;
      Preserve : Attribute := Time_Stamps)
   is
      pragma Unreferenced (Preserve);
   begin
      Ada.Directories.Copy_File (
         Name,
         Pathname,
         Overwrite => Mode = Overwrite);
      Success := True;
   exception
      when Ada.Directories.Name_Error | Ada.Directories.Use_Error =>
         Success := False;
   end Copy_File;

   procedure Copy_File_Attributes (
      From : String;
      To : String;
      Success : out Boolean;
      Copy_Timestamp : Boolean := True;
      Copy_Permissions : Boolean := True) is
   begin
      raise Program_Error; -- unimplemented
   end Copy_File_Attributes;

   function Create_File (Name : String; Fmode : Mode) return File_Descriptor is
      pragma Unreferenced (Fmode);
      Result : File_Descriptor;
   begin
      Do_Open (System.Native_IO.Create, Result, Ada.IO_Modes.Out_File, Name);
      return Result;
   end Create_File;

   procedure Create_Temp_File (
      FD : out File_Descriptor;
      Name : out Temp_File_Name)
   is
      Full_Name : constant String :=
         Ada.Directories.Temporary.Create_Temporary_File (
            Ada.Directories.Current_Directory);
      S_First : Positive;
      S_Last : Natural;
   begin
      Ada.Hierarchical_File_Names.Simple_Name (Full_Name,
         First => S_First, Last => S_Last);
      Name (1 .. S_Last - S_First + 1) := Full_Name (S_First .. S_Last);
      for I in S_Last - S_First + 2 .. Name'Last loop
         Name (I) := Ada.Characters.Latin_1.NUL;
      end loop;
      Do_Open (System.Native_IO.Create, FD, Ada.IO_Modes.Out_File, Name);
   end Create_Temp_File;

   procedure Create_Temp_File (
      FD : out File_Descriptor;
      Name : out String_Access)
   is
      package Holder is
         new Ada.Exceptions.Finally.Scoped_Holder (
            System.Native_IO.Name_Pointer,
            System.Native_IO.Free);
      X_Name : aliased System.Native_IO.Name_Pointer;
      Handle : aliased System.Native_IO.Handle_Type;
   begin
      Holder.Assign (X_Name);
      System.Native_IO.Open_Temporary (Handle, X_Name);
      FD := File_Descriptor (Handle);
      Name := new String'(System.Native_IO.Value (X_Name));
   end Create_Temp_File;

   procedure Delete_File (Name : String; Success : out Boolean) is
   begin
      Ada.Directories.Delete_File (Name);
   exception
      when Ada.Directories.Name_Error | Ada.Directories.Use_Error =>
         Success := False;
   end Delete_File;

   function File_Length (FD : File_Descriptor) return Long_Integer is
   begin
      return Long_Integer (
         System.Native_IO.Size (System.Native_IO.Handle_Type (FD)));
   end File_Length;

   function File_Time_Stamp (Name : String) return OS_Time is
   begin
      return Ada.Directories.Modification_Time (Name);
   end File_Time_Stamp;

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

   function Is_Writable_File (Name : String) return Boolean is
   begin
      return Ada.Directories.Information.User_Permission_Set (Name)
         (Ada.Directories.Information.User_Write);
   end Is_Writable_File;

   function Locate_Exec_On_Path (Exec_Name : String) return String_Access is
   begin
      raise Program_Error; -- unimplemented
      return Locate_Exec_On_Path (Exec_Name);
   end Locate_Exec_On_Path;

   function Locate_Regular_File (File_Name : String; Path : String)
      return String_Access is
   begin
      raise Program_Error; -- unimplemented
      return Locate_Regular_File (File_Name, Path);
   end Locate_Regular_File;

   procedure Lseek (
      FD : File_Descriptor;
      offset : Long_Integer;
      origin : Integer)
   is
      Whence : System.Native_IO.Whence_Type;
      Dummy : Ada.Streams.Stream_Element_Offset;
   begin
      case origin is
         when Seek_Set =>
            Whence := System.Native_IO.From_Begin;
         when Seek_Cur =>
            Whence := System.Native_IO.From_Current;
         when Seek_End =>
            Whence := System.Native_IO.From_End;
         when others =>
            raise Constraint_Error;
      end case;
      System.Native_IO.Set_Relative_Index (
         System.Native_IO.Handle_Type (FD),
         Ada.Streams.Stream_Element_Offset (offset),
         Whence,
         Dummy);
   end Lseek;

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
      Result : File_Descriptor;
   begin
      Do_Open (System.Native_IO.Open, Result, Ada.IO_Modes.In_File, Name);
      return Result;
   end Open_Read;

   function Open_Read_Write (Name : String; Fmode : Mode)
      return File_Descriptor
   is
      pragma Unreferenced (Fmode);
      Result : File_Descriptor;
   begin
      Do_Open (
         System.Native_IO.Open,
         Result,
         Ada.IO_Modes.Append_File, -- Inout_File
         Name);
      return Result;
   end Open_Read_Write;

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

   procedure Rename_File (
      Old_Name : String;
      New_Name : String;
      Success : out Boolean) is
   begin
      Ada.Directories.Rename (Old_Name => Old_Name, New_Name => New_Name);
      Success := True;
   exception
      when Ada.Directories.Name_Error | Ada.Directories.Use_Error =>
         Success := False;
   end Rename_File;

   procedure Set_Non_Readable (Name : String) is
   begin
      raise Program_Error; -- unimplemented
   end Set_Non_Readable;

   procedure Set_Non_Writable (Name : String) is
   begin
      raise Program_Error; -- unimplemented
   end Set_Non_Writable;

   procedure Set_Readable (Name : String) is
   begin
      raise Program_Error; -- unimplemented
   end Set_Readable;

   procedure Set_Writable (Name : String) is
   begin
      raise Program_Error; -- unimplemented
   end Set_Writable;

   function Write (FD : File_Descriptor; A : System.Address; N : Integer)
      return Integer
   is
      Result : Ada.Streams.Stream_Element_Offset;
   begin
      System.Native_IO.Write (
         System.Native_IO.Handle_Type (FD),
         A,
         Ada.Streams.Stream_Element_Offset (N),
         Out_Length => Result);
      return Integer (Result);
   end Write;

   --  Miscellaneous

   function Errno return Integer is
   begin
      return Integer (C.errno.errno);
   end Errno;

   function Getenv (Name : String) return String_Access is
   begin
      return new String'(Ada.Environment_Variables.Value (Name, ""));
   end Getenv;

   procedure OS_Exit (Status : Integer) is
   begin
      C.stdlib.C_exit (C.signed_int (Status));
   end OS_Exit;

end GNAT.OS_Lib;
