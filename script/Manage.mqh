//+------------------------------------------------------------------+
//|                                          Aninditha-EA/Manage.mqh |
//|                              Copyright 2020, Harold and Siswandy |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Calculate lot size dynamicaly                                    |
//+------------------------------------------------------------------+
double lotSizeNeeded() {

   double lotSize = 0.00;

   lotSize = dynamicLot(lotSize);

   return lotSize;
}

double dynamicLot(double lotSize) {

   double maxPipsRisked = 5;
   double maxDlrsRisked = maxRiskInDollar(AccountInfoDouble(ACCOUNT_BALANCE),2);

   //EUR-USD - Standart
   double pricePerPip = maxDlrsRisked / maxPipsRisked;
   lotSize = pricePerPip * (10000/1);
   lotSize /= 100000;

   lotSize = NormalizeDouble(lotSize, 2);

   //TODO support other currency pair

   return lotSize;
}

//+------------------------------------------------------------------+
//| Calculate the maximum risk in dollar                             |
//+------------------------------------------------------------------+
double maxRiskInDollar(double balance, double percent) {
   return (balance * (percent/100));
}


//+------------------------------------------------------------------+
//| Prevent multiple order open and small volume trade               |
//+------------------------------------------------------------------+
bool canEnter() {
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
//| Calculate Stop Loss                                              |
//+------------------------------------------------------------------+
double calculateStopLoss(string signal, double entry) {
   //TODO support pending order calculation
   double sl = 0;
   if(signal == "buy") {
      sl = (entry-(50*_Point)); //stop loss 5 pips
   }
   if(signal == "sell") {
      sl = (entry+(50*_Point)); //stop loss 5 pips
   }
   return sl;
}

//+------------------------------------------------------------------+
//| Calculate Take Profit                                            |
//+------------------------------------------------------------------+
double calculateTakeProfit(string signal, double entry) {
   //TODO support pending order calculation
   double tp = 0;
   if(signal == "buy") {
      tp = (entry+(150*_Point)); //stop loss 15 pips
   }
   if(signal == "sell") {
      tp = (entry-(150*_Point)); //stop loss 15 pips
   }
   return tp;
}

//+------------------------------------------------------------------+
//| Check the recent Ask Price                                       |
//+------------------------------------------------------------------+
double calculateAskPrice() {
   return NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK), _Digits);
}

//+------------------------------------------------------------------+
//| Check the recent Bid Price                                       |
//+------------------------------------------------------------------+
double calculateBidPrice() {
   return NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID), _Digits);
}

//+------------------------------------------------------------------+
