package body GNAT.Calendar.Time_IO is

   function Image (Date : Ada.Calendar.Time; Picture : Picture_String)
      return String is
   begin
      raise Program_Error; -- unimplemented
      return Image (Date, Picture);
   end Image;

   function Value (Date : String) return Ada.Calendar.Time is
   begin
      raise Program_Error; -- unimplemented
      return Value (Date);
   end Value;

end GNAT.Calendar.Time_IO;
