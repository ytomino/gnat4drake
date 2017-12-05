with C.signal;
package body System.Interrupt_Management.Operations is
   use type C.signed_int;

   procedure Set_Interrupt_Mask (Mask : access Interrupt_Mask) is
   begin
      Set_Interrupt_Mask (Mask => Mask, OMask => null);
   end Set_Interrupt_Mask;

   procedure Set_Interrupt_Mask (
      Mask  : access Interrupt_Mask;
      OMask : access Interrupt_Mask)
   is
      errno : C.signed_int;
   begin
      errno := C.signal.sigprocmask (C.signal.SIG_SETMASK, Mask, OMask);
      if errno /= 0 then
         raise Program_Error;
      end if;
   end Set_Interrupt_Mask;

   procedure Get_Interrupt_Mask (Mask : access Interrupt_Mask) is
   begin
      Set_Interrupt_Mask (Mask => null, OMask => Mask);
   end Get_Interrupt_Mask;

   procedure Fill_Interrupt_Mask (Mask : access Interrupt_Mask) is
      Dummy : C.signed_int;
   begin
      Dummy := C.signal.sigfillset (Mask);
   end Fill_Interrupt_Mask;

   procedure Add_To_Interrupt_Mask (
      Mask : access Interrupt_Mask;
      Interrupt : Interrupt_ID)
   is
      Dummy : C.signed_int;
   begin
      Dummy := C.signal.sigaddset (Mask, Interrupt);
   end Add_To_Interrupt_Mask;

   procedure Copy_Interrupt_Mask (
      X : out Interrupt_Mask;
      Y : Interrupt_Mask) is
   begin
      X := Y;
   end Copy_Interrupt_Mask;

end System.Interrupt_Management.Operations;
