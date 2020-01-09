class Indicators{
	protected:
		string iMACDConfirmation();
		string iMAConfirmation();
		string iRSIConfirmation();
};

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Indicators::iMAConfirmation(void){
   string signal = "";

   double SMA10Array[], SMA50Array[], SMA100Array[];

   int SMA10Definition = iMA(_Symbol, _Period, 10, 0, MODE_SMA, PRICE_CLOSE);
   int SMA50Definition = iMA(_Symbol, _Period, 50, 0, MODE_SMA, PRICE_CLOSE);
   //int SMA100Definition = iMA(_Symbol, _Period, 100, 0, MODE_SMA, PRICE_CLOSE);

   ArraySetAsSeries(SMA10Array, true);
   ArraySetAsSeries(SMA50Array, true);
   //ArraySetAsSeries(SMA100Array, true);

   CopyBuffer(SMA10Definition, 0, 0, 10, SMA10Array);
   CopyBuffer(SMA50Definition, 0, 0, 50, SMA50Array);
   //CopyBuffer(SMA100Definition, 0, 0, 100, SMA100Array);

   double range = MathAbs(SMA10Array[0] - SMA50Array[0]);
   //range = range;
   if(range >= 0.0025) {
      if(SMA10Array[0] > SMA50Array[0]) {
         signal = "buy";
      }
      if(SMA10Array[0] < SMA50Array[0]) {
         signal = "sell";
      }
   }
   /*
      if(SMA10Array[0] > SMA50Array[0]) {
         if(SMA50Array[0] > SMA100Array[0]) {
            signal = "buy";
         }
      }
      if(SMA10Array[0] < SMA50Array[0]) {
         if(SMA50Array[0] < SMA100Array[0]) {
            signal = "sell";
         }
      }
   */

   return signal;
}

//+------------------------------------------------------------------+
//| MACD indicator                                                   |
//+------------------------------------------------------------------+
string Indicators::iMACDConfirmation(void) {
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

   if(macdRecent > 0 && macdRecent > macdBefore) {
      if(signalBefore < 0 && signalRecent < 0) {
         signal = "buy";
      }
   }
   if(macdRecent < 0 && macdRecent < macdBefore) {
      if(signalBefore > 0 && signalRecent > 0) {
         signal = "sell";
      }
   }
   /*
      if(macdRecent < 0) {
         if(signalBefore > macdBefore) {
            if(signalRecent < macdRecent) {
               signal = "buy";
            }
         }
      }
      if(macdRecent > 0) {
         if(signalBefore < macdBefore) {
            if(signalRecent > macdRecent) {
               signal = "sell";
            }
         }
      }
   */
   return signal;
}

//+------------------------------------------------------------------+
//| RSI indicator                                                    |
//+------------------------------------------------------------------+
string Indicators::iRSIConfirmation(void) {
   string signal = "";

   double myPriceArray[];

   int RSIDefinition = iRSI(_Symbol, _Period, 14, PRICE_CLOSE);

   ArraySetAsSeries(myPriceArray, true);//sort price from current downwards

   CopyBuffer(RSIDefinition, 0, 0, 3, myPriceArray);

   //Calculate the RSI value
   double recentRSIValue = NormalizeDouble((myPriceArray[1]),2);
   double beforeRSIValue = NormalizeDouble((myPriceArray[2]),2);

   /*
      if(RSIValue < 30) {
         signal = "buy"; //oversold
      }
      if(RSIValue > 70) {
         signal = "sell"; //overbought
      }
   */
   if(recentRSIValue > 50 && beforeRSIValue < 50 && recentRSIValue > beforeRSIValue) {
      signal = "buy";
   }
   if(recentRSIValue < 50 && beforeRSIValue > 50 && recentRSIValue < beforeRSIValue) {
      signal = "sell";
   }
   return signal;
}

//TODO add more indicators

//+------------------------------------------------------------------+
