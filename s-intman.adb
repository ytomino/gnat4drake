package body System.Interrupt_Management is

   function Reserve (Interrupt : Interrupt_ID) return Boolean is
   begin
      return Ada.Interrupts.Is_Reserved (
         Ada.Interrupts.Interrupt_Id (Interrupt));
   end Reserve;

end System.Interrupt_Management;
