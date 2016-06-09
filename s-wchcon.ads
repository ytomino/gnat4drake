package System.WCh_Con is
   pragma Pure;

   type WC_Encoding_Method is (
      WCEM_Hex,
      WCEM_Upper,
      WCEM_Shift_JIS,
      WCEM_EUC,
      WCEM_UTF8,
      WCEM_Brackets);

end System.WCh_Con;
