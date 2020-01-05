//+------------------------------------------------------------------+
//|                                         Aninditha-EA/Analyze.mqh |
//|                              Copyright 2020, Harold and Siswandy |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| This part gather all the confirmation produce by all indicators  |
//+------------------------------------------------------------------+
string checkEntry() {
   string signal = "";

   signal = iMACDiRSI();

   return signal;

}

string iMACDiRSI() {

   //MACD + RSI
   //It check if the the RSI is overbough/oversold
   //and then proceed to check for MACD main and signal position

   string signal = "";

   string iRSISignal = iRSIConfirmation();

   if(iRSISignal == "buy") {
      string iMACDSignal = iMACDConfirmation();
      if(iMACDSignal == "buy") {
         signal = "buy";
      }
   }
   if(iRSISignal == "sell") {
      string iMACDSignal = iMACDConfirmation();
      if(iMACDSignal == "sell") {
         signal = "sell";
      }
   }

   return signal;
}

//+------------------------------------------------------------------+
//| MACD indicator                                                   |
//+------------------------------------------------------------------+
string iMACDConfirmation() {
   string signal = "";

   //double myPriceArray[];//Array of several prices
   double macdBuffer[];
   double signalBuffer[];

   int MACDDefinition = iMACD(_Symbol,_Period, 12, 26, 9, PRICE_CLOSE);

   //ArraySetAsSeries(myPriceArray, true);//sort price from current downwards
   ArraySetAsSeries(macdBuffer, true);
   ArraySetAsSeries(signalBuffer, true);

   CopyBuffer(MACDDefinition, 0, 0, 3, macdBuffer);
   CopyBuffer(MACDDefinition, 1, 0, 3, signalBuffer);

   //Make changes
   double macdRecent = macdBuffer[0];
   double macdBefore = macdBuffer[1];

   double signalRecent = signalBuffer[0];
   double signalBefore = signalBuffer[1];

   if(macdRecent < 0) {
      if(macdBefore == macdBefore) {
         if(signalRecent < macdRecent) {
            signal = "buy";
         }
      }
   }
   if(macdRecent > 0) {
      if(macdBefore == macdBefore) {
         if(signalRecent > macdRecent) {
            signal = "sell";
         }
      }
   }

   return signal;
}

//+------------------------------------------------------------------+
//| RSI indicator                                                    |
//+------------------------------------------------------------------+
string iRSIConfirmation() {
   string signal = "";

   double myPriceArray[];

   int RSIDefinition = iRSI(_Symbol, _Period, 14, PRICE_CLOSE);

   ArraySetAsSeries(myPriceArray, true);//sort price from current downwards

   CopyBuffer(RSIDefinition, 0, 0, 3, myPriceArray);

   //Calculate the RSI value
   double RSIValue = NormalizeDouble((myPriceArray[0]),2);

   if(RSIValue < 30) {
      signal = "buy"; //oversold
   }
   if(RSIValue > 70) {
      signal = "sell"; //overbought
   }
   return signal;
}

//TODO add more indicators

//+------------------------------------------------------------------+
