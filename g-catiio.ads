pragma License (Unrestricted);
package GNAT.Calendar.Time_IO is

   type Picture_String is new String;

   ISO_Date : constant Picture_String := "%Y-%m-%d";

   function Image (Date : Ada.Calendar.Time; Picture : Picture_String)
      return String;

   function Value (Date : String) return Ada.Calendar.Time;

end GNAT.Calendar.Time_IO;
