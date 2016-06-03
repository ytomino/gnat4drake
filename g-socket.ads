with Ada.Streams.Stream_IO.Sockets;
private with Ada.Strings.Unbounded_Strings;
package GNAT.Sockets is

   procedure Initialize is null;

   type Socket_Type is access Ada.Streams.Stream_IO.File_Type; -- non-limited

   type Family_Type is (Family_Inet);

   type Mode_Type is (Socket_Stream);

   subtype Port_Type is Ada.Streams.Stream_IO.Sockets.Port_Number;

   type Inet_Addr_Type (Family : Family_Type := Family_Inet) is private;

   type Sock_Addr_Type (Family : Family_Type := Family_Inet) is record
      Addr : Inet_Addr_Type (Family);
      Port : Port_Type;
   end record;

   type Host_Entry_Type (<>) is private;

   function Addresses (E : Host_Entry_Type; N : Positive := 1)
      return Inet_Addr_Type;

   function Get_Host_By_Name (Name : String) return Host_Entry_Type;

   type Level_Type is (Socket_Level);

   type Option_Name is (Keep_Alive, Reuse_Address, Receive_Buffer);

   type Option_Type (Name : Option_Name := Keep_Alive) is record
      case Name is
         when Keep_Alive | Reuse_Address =>
            Enabled : Boolean;
         when Receive_Buffer =>
            Size : Natural;
      end case;
   end record;

   type Request_Name is (Non_Blocking_IO, N_Bytes_To_Read);

   type Request_Type (Name : Request_Name := Non_Blocking_IO) is record
      case Name is
         when Non_Blocking_IO =>
            Enabled : Boolean;
         when N_Bytes_To_Read =>
            Size : Natural;
      end case;
   end record;

   type Request_Flag_Type is (No_Request_Flag);

   procedure Create_Socket (
      Socket : out Socket_Type;
      Family : Family_Type := Family_Inet;
      Mode : Mode_Type := Socket_Stream);

   procedure Close_Socket (Socket : in out Socket_Type);

   procedure Connect_Socket (
      Socket : Socket_Type;
      Server : in out Sock_Addr_Type);

   procedure Control_Socket (
      Socket : Socket_Type;
      Request : in out Request_Type) is null;
      --  Non-blocking mode is not implemented in drake.

   procedure Receive_Socket (
      Socket : Socket_Type;
      Item : out Ada.Streams.Stream_Element_Array;
      Last : out Ada.Streams.Stream_Element_Offset;
      Flags : Request_Flag_Type := No_Request_Flag);

   procedure Set_Socket_Option (
      Socket : Socket_Type;
      Level : Level_Type := Socket_Level;
      Option : Option_Type) is null;
      --  The detailed options are not implemented in drake.

   subtype Stream_Access is Ada.Streams.Stream_IO.Stream_Access;

   function Stream (Socket : Socket_Type) return Stream_Access;

private

   type Inet_Addr_Type (Family : Family_Type := Family_Inet) is record
      Host_Name : Ada.Strings.Unbounded_Strings.Unbounded_String;
   end record;

   type Host_Entry_Type is new String;

end GNAT.Sockets;
