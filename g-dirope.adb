package body GNAT.Directory_Operations is

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

end GNAT.Directory_Operations;
