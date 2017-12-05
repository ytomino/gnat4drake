pragma License (Unrestricted);
with Ada.Interrupts;
with C.signal;
package System.Interrupt_Management is
   pragma Elaborate_Body;

   subtype Interrupt_Mask is C.signal.sigset_t;

   subtype Interrupt_ID is
      C.signed_int range 0 .. C.signed_int (Ada.Interrupts.Interrupt_Id'Last);

   type Interrupt_Set is array (Interrupt_ID) of Boolean;

--  Reserve : Interrupt_Set := (others => False);
   function Reserve (Interrupt : Interrupt_ID) return Boolean;

end System.Interrupt_Management;
