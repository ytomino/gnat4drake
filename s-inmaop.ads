pragma License (Unrestricted);
package System.Interrupt_Management.Operations is

   procedure Set_Interrupt_Mask (Mask : access Interrupt_Mask);

   procedure Set_Interrupt_Mask (
      Mask  : access Interrupt_Mask;
      OMask : access Interrupt_Mask);

   procedure Get_Interrupt_Mask (Mask : access Interrupt_Mask);

   procedure Fill_Interrupt_Mask (Mask : access Interrupt_Mask);

   procedure Add_To_Interrupt_Mask (
      Mask : access Interrupt_Mask;
      Interrupt : Interrupt_ID);

   procedure Copy_Interrupt_Mask (
      X : out Interrupt_Mask;
      Y : Interrupt_Mask);

end System.Interrupt_Management.Operations;
