with System;
package GNAT.Traceback is
   pragma Preelaborate;

   type Tracebacks_Array is array (Positive range <>) of System.Address;

   procedure Call_Chain (
      Traceback : out Tracebacks_Array;
      Len : out Natural);

end GNAT.Traceback;
