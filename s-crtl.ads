pragma License (Unrestricted);
with C.stdlib;
package System.CRTL is
   pragma Preelaborate;

   subtype size_t is C.size_t;

   --  Other C runtime functions

   procedure free (Ptr : System.Address)
      renames C.stdlib.free;

   function malloc (Size : size_t) return System.Address
      renames C.stdlib.malloc;

   function realloc (Ptr : System.Address; Size : size_t) return System.Address
      renames C.stdlib.realloc;

end System.CRTL;
