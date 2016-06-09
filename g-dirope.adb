package body GNAT.Directory_Operations is

   procedure Make_Dir (Dir_Name : Dir_Name_Str) is
   begin
      Ada.Directories.Create_Directory (Dir_Name);
   end Make_Dir;

   procedure Remove_Dir (
      Dir_Name : Dir_Name_Str;
      Recursive : Boolean := False) is
   begin
      if Recursive then
         Ada.Directories.Delete_Tree (Dir_Name);
      else
         Ada.Directories.Delete_Directory (Dir_Name);
      end if;
   end Remove_Dir;

   function Base_Name (Path : Path_Name; Suffix : String := "")
      return String
   is
      E_First : Positive;
      E_Last : Natural;
      Last : Natural;
   begin
      Ada.Hierarchical_File_Names.Extension (Path,
         First => E_First, Last => E_Last);
      if E_First <= E_Last and then Path (E_First .. E_Last) = Suffix then
         Last := E_First - 1;
      else
         Last := Path'Last;
      end if;
      return Ada.Hierarchical_File_Names.Simple_Name (
         Path (Path'First .. Last));
   end Base_Name;

   function Format_Pathname (
      Path : Path_Name;
      Style : Path_Style := System_Default)
      return Path_Name
   is
      pragma Unreferenced (Style);
   begin
      return Path;
   end Format_Pathname;

   procedure Open (Dir : in out Dir_Type; Dir_Name : Dir_Name_Str) is
   begin
      Ada.Directories.Start_Search (Dir, Dir_Name);
   end Open;

   procedure Read (
      Dir : in out Dir_Type;
      Str : out String;
      Last : out Natural) is
   begin
      if Ada.Directories.More_Entries (Dir) then
         declare
            Directory_Entry : Ada.Directories.Directory_Entry_Type;
         begin
            Ada.Directories.Get_Next_Entry (Dir, Directory_Entry);
            declare
               Simple_Name : constant String :=
                  Ada.Directories.Simple_Name (Directory_Entry);
            begin
               Last := Str'First + (Simple_Name'Length - 1);
               Str (Str'First .. Last) := Simple_Name;
            end;
         end;
      else
         Last := 0; -- end of directory
      end if;
   end Read;

end GNAT.Directory_Operations;
