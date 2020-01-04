//+------------------------------------------------------------------+
//|                                         Aninditha-EA/Analyze.mqh |
//|                              Copyright 2020, Harold and Siswandy |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| This part gather all the confirmation produce by all indicators  |
//+------------------------------------------------------------------+
string checkEntry() {
   string signal = "";

   signal = iMACDConfirmation();

   return signal;

}

//+------------------------------------------------------------------+
//| MACD indicator                                                   |
//+------------------------------------------------------------------+
string iMACDConfirmation() {
   string signal = "";

   double myPriceArray[];//Array of several prices

   int MACDDefinition = iMACD(_Symbol,_Period, 12, 26, 9, PRICE_CLOSE);

   ArraySetAsSeries(myPriceArray, true);//sort price from current downwards

   CopyBuffer(MACDDefinition, 0, 0, 3, myPriceArray);

   double MACDValue = (myPriceArray[0]);

   if(MACDValue > 0) {
      signal = "buy";
   }
   if(MACDValue < 0) {
      signal = "sell";
   }
   return signal;
}

//TODO add more indicators

//+------------------------------------------------------------------+
