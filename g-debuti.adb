with System.Storage_Elements;
package body GNAT.Debug_Utilities is

   function Value (S : String) return System.Address is
   begin
      return System.Storage_Elements.To_Address (
         System.Storage_Elements.Integer_Address'Value (S));
   end Value;

end GNAT.Debug_Utilities;
