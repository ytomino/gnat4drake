private with System.Shared_Locking; -- implementation unit
package GNAT.Task_Lock is
   pragma Preelaborate;

   procedure Lock;
   procedure Unlock;

   pragma Inline (Lock); -- renamed
   pragma Inline (Unlock); -- renamed

private

   procedure Lock
      renames System.Shared_Locking.Enter;
   procedure Unlock
      renames System.Shared_Locking.Leave;

end GNAT.Task_Lock;
