package body Ada.Exceptions.Traceback is

   function Get_PC (TB_Entry : System.Address) return Code_Loc is
   begin
      return TB_Entry;
   end Get_PC;

end Ada.Exceptions.Traceback;
