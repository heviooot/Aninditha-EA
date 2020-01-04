//+------------------------------------------------------------------+
//|                                          Aninditha-EA/Manage.mqh |
//|                              Copyright 2020, Harold and Siswandy |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Calculate lot size dynamicaly                                    |
//+------------------------------------------------------------------+
double lotSizeNeeded() {
   //TODO make dynamic lot sizing
   double lotSize = 0.40;

   return lotSize;
}

//+------------------------------------------------------------------+
//| Prevent multiple order open simultaneously                       |
//+------------------------------------------------------------------+
bool canEnter() {
   bool haveAccess = false;
   if(PositionsTotal() < 1) {
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
