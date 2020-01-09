//+------------------------------------------------------------------+
//|                                          Aninditha-EA/Manage.mqh |
//|                              Copyright 2020, Harold and Siswandy |
//+------------------------------------------------------------------+

class Manager {
 public:
   bool access();
};
//+------------------------------------------------------------------+
//| Prevent multiple order open and small volume trade               |
//+------------------------------------------------------------------+
bool Manager::access(void) {
   bool haveAccess = false;
   double balance = AccountInfoDouble(ACCOUNT_BALANCE);
   if(PositionsTotal() < 1 && balance > 50) {
      haveAccess = true;
   } else {
      haveAccess = false;
   }
   return haveAccess;
}

//+------------------------------------------------------------------+
