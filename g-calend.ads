pragma License (Unrestricted);
with Ada.Calendar;
package GNAT.Calendar is

   No_Time : constant Ada.Calendar.Time :=
      Ada.Calendar.Time_Of (
         Year => Ada.Calendar.Year_Number'First,
         Month => Ada.Calendar.Month_Number'First,
         Day => Ada.Calendar.Day_Number'First);

end GNAT.Calendar;
