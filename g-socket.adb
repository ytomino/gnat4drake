with Ada.Unchecked_Deallocation;
package body GNAT.Sockets is

   procedure Free is
      new Ada.Unchecked_Deallocation (
         Ada.Streams.Stream_IO.File_Type,
         Socket_Type);

   function Addresses (E : Host_Entry_Type; N : Positive := 1)
      return Inet_Addr_Type
   is
      pragma Unreferenced (N);
   begin
      return (
         Family => Family_Inet,
         Host_Name =>
            Ada.Strings.Unbounded_Strings.To_Unbounded_String (String (E)));
   end Addresses;

   function Get_Host_By_Name (Name : String) return Host_Entry_Type is
   begin
      return Host_Entry_Type (Name);
   end Get_Host_By_Name;

   procedure Create_Socket (
      Socket : out Socket_Type;
      Family : Family_Type := Family_Inet;
      Mode : Mode_Type := Socket_Stream)
   is
      pragma Unreferenced (Family);
      pragma Unreferenced (Mode);
   begin
      Socket := new Ada.Streams.Stream_IO.File_Type;
   end Create_Socket;

   procedure Close_Socket (Socket : in out Socket_Type) is
   begin
      Ada.Streams.Stream_IO.Close (Socket.all);
      Free (Socket);
   end Close_Socket;

   procedure Connect_Socket (
      Socket : Socket_Type;
      Server : in out Sock_Addr_Type)
   is
      End_Point : constant Ada.Streams.Stream_IO.Sockets.End_Point :=
         Ada.Streams.Stream_IO.Sockets.Resolve (
            Ada.Strings.Unbounded_Strings.Constant_Reference (
               Server.Addr.Host_Name).Element.all,
            Server.Port);
   begin
      Ada.Streams.Stream_IO.Sockets.Connect (Socket.all, End_Point);
   end Connect_Socket;

   procedure Receive_Socket (
      Socket : Socket_Type;
      Item : out Ada.Streams.Stream_Element_Array;
      Last : out Ada.Streams.Stream_Element_Offset;
      Flags : Request_Flag_Type := No_Request_Flag)
   is
      pragma Unreferenced (Flags);
   begin
      Ada.Streams.Stream_IO.Read (Socket.all, Item, Last);
   end Receive_Socket;

   function Stream (Socket : Socket_Type) return Stream_Access is
   begin
      return Ada.Streams.Stream_IO.Stream (Socket.all);
   end Stream;

end GNAT.Sockets;
