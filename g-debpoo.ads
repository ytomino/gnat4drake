with System.Storage_Elements;
with System.Storage_Pools.Standard_Pools;
package GNAT.Debug_Pools is

   type Debug_Pool is new System.Storage_Pools.Standard_Pools.Standard_Pool
      with null record;

   subtype SSC is System.Storage_Elements.Storage_Count;

   Default_Max_Freed : constant SSC := 50_000_000;
   Default_Stack_Trace_Depth : constant Natural := 20;
   Default_Reset_Content : constant Boolean := False;
   Default_Raise_Exceptions : constant Boolean := True;
   Default_Advanced_Scanning : constant Boolean := False;
   Default_Min_Freed : constant SSC := 0;
   Default_Errors_To_Stdout : constant Boolean := True;
   Default_Low_Level_Traces : constant Boolean := False;

   procedure Configure (
      Pool : in out Debug_Pool;
      Stack_Trace_Depth : Natural := Default_Stack_Trace_Depth;
      Maximum_Logically_Freed_Memory : SSC := Default_Max_Freed;
      Minimum_To_Free : SSC := Default_Min_Freed;
      Reset_Content_On_Free : Boolean := Default_Reset_Content;
      Raise_Exceptions : Boolean := Default_Raise_Exceptions;
      Advanced_Scanning : Boolean := Default_Advanced_Scanning;
      Errors_To_Stdout : Boolean := Default_Errors_To_Stdout;
      Low_Level_Traces : Boolean := Default_Low_Level_Traces) is null;
      --  unimplemented

   type Report_Type is (All_Reports);

   generic
      with procedure Put_Line (S : String) is <>;
      with procedure Put (S : String) is <>;
   procedure Dump (
      Pool : Debug_Pool;
      Size : Positive;
      Report : Report_Type := All_Reports);

   procedure Dump_Stdout (
      Pool : Debug_Pool;
      Size : Positive;
      Report : Report_Type := All_Reports);

   procedure Reset is null; -- unimplemented

   procedure Get_Size (
      Storage_Address : System.Address;
      Size_In_Storage_Elements : out System.Storage_Elements.Storage_Count;
      Valid : out Boolean);

   type Byte_Count is mod System.Max_Binary_Modulus;

   function High_Water_Mark (Pool : Debug_Pool) return Byte_Count;

   function Current_Water_Mark (Pool : Debug_Pool) return Byte_Count;

   procedure System_Memory_Debug_Pool (
      Has_Unhandled_Memory : Boolean := True) is null; -- unimplemented

end GNAT.Debug_Pools;
