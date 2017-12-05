with System.Address_To_Named_Access_Conversions;
with System.Tasks;
package body System.Task_Primitives.Operations is

   package Task_Id_Conv is
      new Address_To_Named_Access_Conversions (
         Tasks.Task_Record,
         Tasks.Task_Id);

   procedure Abort_Task (T : System.Tasking.Task_Id) is
   begin
      System.Tasks.Send_Abort (Task_Id_Conv.To_Pointer (T));
   end Abort_Task;

end System.Task_Primitives.Operations;
