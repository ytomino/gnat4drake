pragma License (Unrestricted);
package GNAT.Heap_Sort is
   pragma Pure;

   type Xchg_Procedure is access procedure (Op1, Op2 : Natural);

   type Lt_Function is access function (Op1, Op2 : Natural) return Boolean;

   procedure Sort (N : Natural; Xchg : Xchg_Procedure; Lt : Lt_Function);

end GNAT.Heap_Sort;
