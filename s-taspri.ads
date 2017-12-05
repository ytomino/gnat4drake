pragma License (Unrestricted);
package System.Task_Primitives is
   pragma Preelaborate;

   subtype Task_Address is System.Address;

   Task_Address_Size : constant := Standard'Address_Size;

end System.Task_Primitives;
