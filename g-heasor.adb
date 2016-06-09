with Ada.Containers.Generic_Sort;
package body GNAT.Heap_Sort is

   procedure Sort (N : Natural; Xchg : Xchg_Procedure; Lt : Lt_Function) is
      procedure Do_Sort is
         new Ada.Containers.Generic_Sort (Natural, Lt.all, Xchg.all);
   begin
      Do_Sort (1, N);
   end Sort;

end GNAT.Heap_Sort;
