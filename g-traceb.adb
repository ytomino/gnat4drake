with System.Unwind.Backtrace; -- implementation unit
package body GNAT.Traceback is

   procedure Call_Chain (
      Traceback : out Tracebacks_Array;
      Len : out Natural)
   is
      X : System.Unwind.Exception_Occurrence;
      T_Index : Integer;
   begin
      System.Unwind.Backtrace.Call_Chain (X);
      Len := Integer'Min (X.Num_Tracebacks, Traceback'Length);
      T_Index := Traceback'First;
      for I in 1 .. Len loop
         Traceback (T_Index) := X.Tracebacks (I);
         T_Index := T_Index + 1;
      end loop;
   end Call_Chain;

end GNAT.Traceback;
