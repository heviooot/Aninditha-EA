//+------------------------------------------------------------------+
//|                                          Aninditha-EA/Manage.mqh |
//|                              Copyright 2020, Harold and Siswandy |
//+------------------------------------------------------------------+

class Manage {
 public:
   bool access();
   bool anyOpenedOrder();
};

//+==================================================================+

//+------------------------------------------------------------------+
//| Prevent multiple order open and small volume trade               |
//+------------------------------------------------------------------+
bool Manage::access(void) {
   bool haveAccess = false;
   double balance = AccountInfoDouble(ACCOUNT_BALANCE);
   if(PositionsTotal() < 1 && balance > 50) {
      haveAccess = true;
   } else {
      haveAccess = false;
   }
   return haveAccess;
}

bool Manage::anyOpenedOrder(void){
	bool openedOrder;
	int total = PositionsTotal();
	if(total == 0){
		openedOrder = false;
	}
	else{
		openedOrder = true;
	}
	return openedOrder;
}



//+------------------------------------------------------------------+
