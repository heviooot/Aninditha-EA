//+------------------------------------------------------------------+
//|                                      Aninditha-EA/Indicators.mqh |
//|                              Copyright 2020, Harold and Siswandy |
//+------------------------------------------------------------------+

class Indicators {
 public:
   double MACD(ENUM_TIMEFRAMES period, int buffer, int index);
   double ADX(ENUM_TIMEFRAMES period, int buffer, int index);
   double ATR(ENUM_TIMEFRAMES period, int index);

   double STC(ENUM_TIMEFRAMES period, int buffer, int index);
   double RSI(ENUM_TIMEFRAMES period, int index);
   double CCI(ENUM_TIMEFRAMES period, int index);
   double BRP(ENUM_TIMEFRAMES period, int index);
   double BLP(ENUM_TIMEFRAMES period, int index);

   double MA(ENUM_TIMEFRAMES period, int index, int ma_period);
};

//+==================================================================+

//+------------------------------------------------------------------+
//| Get MACD Value                                                   |
//+------------------------------------------------------------------+
double Indicators::MACD(ENUM_TIMEFRAMES period, int buffer, int index) {

   //the parameters inputed: period, buffer, index (recent = 0 < late)
   double MACDValue;

   //double myPriceArray[];//Array of several prices
   double macdBuffer[];

   //int MACDDefinition = iMACD()
   int MACDDefinition = iMACD(_Symbol, period, 12, 26, 9, PRICE_CLOSE);

   //ArraySetAsSeries(myPriceArray, true);//sort price from current downwards
   ArraySetAsSeries(macdBuffer, true);

   CopyBuffer(MACDDefinition, buffer, 0, 3, macdBuffer);
   //CopyBuffer(MACDDefinition, 1, 0, 3, signalBuffer);

   //Make changes
   MACDValue = macdBuffer[index];

   return MACDValue;
}

//+------------------------------------------------------------------+
//| Get STC value                                                    |
//+------------------------------------------------------------------+
double Indicators::STC(ENUM_TIMEFRAMES period,int buffer,int index) {

   //Stochastic Indicator
   double STCValue;

   double stcBuffer[];

   int STCDefinition = iStochastic(_Symbol, period, 5, 3, 3, MODE_SMA, STO_CLOSECLOSE);

   ArraySetAsSeries(stcBuffer, true);

   CopyBuffer(STCDefinition, buffer, 0, 3, stcBuffer);

   STCValue = NormalizeDouble(stcBuffer[index], 2);

   return STCValue;

}

//+------------------------------------------------------------------+
//| Get RSI value                                                    |
//+------------------------------------------------------------------+
double Indicators::RSI(ENUM_TIMEFRAMES period,int index) {

   double myPriceArray[];

   int RSIDefinition = iRSI(_Symbol, period, 14, PRICE_CLOSE);

   ArraySetAsSeries(myPriceArray, true);

   CopyBuffer(RSIDefinition, 0, 0, 3, myPriceArray);

   double RSIValue = NormalizeDouble(myPriceArray[index], 2);

   return RSIValue;
}

//+------------------------------------------------------------------+
//| Get CCI value                                                    |
//+------------------------------------------------------------------+
double Indicators::CCI(ENUM_TIMEFRAMES period,int index) {

   double myPriceArray[];

   int CCIDefinition = iCCI(_Symbol, period, 14, PRICE_TYPICAL);

   ArraySetAsSeries(myPriceArray, true);

   CopyBuffer(CCIDefinition, 0, 0, 3, myPriceArray);

   double CCIValue = NormalizeDouble(myPriceArray[index], 2);

   return CCIValue;
}

//+------------------------------------------------------------------+
//| Get ATR value                                                    |
//+------------------------------------------------------------------+
double Indicators::ATR(ENUM_TIMEFRAMES period, int index) {

   double myPriceArray[];

   int ATRDefinition = iATR(_Symbol, period, 14);

   ArraySetAsSeries(myPriceArray, true);

   CopyBuffer(ATRDefinition, 0, 0, 3, myPriceArray);

   double ATRValue = NormalizeDouble(myPriceArray[index], 4);

   return ATRValue;
}

//+------------------------------------------------------------------+
//| Get ADX value                                                    |
//+------------------------------------------------------------------+
double Indicators::ADX(ENUM_TIMEFRAMES period,int buffer,int index) {

   double ADXValue;

   double myPriceArray[];

   int ADXDefinition = iADX(_Symbol, period, 14);

   ArraySetAsSeries(myPriceArray, true);

   CopyBuffer(ADXDefinition, buffer, 0, 3, myPriceArray);

   ADXValue = NormalizeDouble(myPriceArray[0], 2);

   return ADXValue;
}

//+------------------------------------------------------------------+
//| Get MA value                                                     |
//+------------------------------------------------------------------+
double Indicators::MA(ENUM_TIMEFRAMES period,int index, int ma_period) {
	double myPriceArray[];

   int MADefinition = iMA(_Symbol, period, ma_period, 0, MODE_EMA, PRICE_CLOSE);

   ArraySetAsSeries(myPriceArray, true);

   CopyBuffer(MADefinition, 0, 0, 3, myPriceArray);

   double MAValue = myPriceArray[index];

   return MAValue;
}


double Indicators::BLP(ENUM_TIMEFRAMES period,int index){
   //Bull power
   double myPriceArray[];
   
   int blpDefinition = iBullsPower(_Symbol, period, 13);
   
   ArraySetAsSeries(myPriceArray, true);
   
   CopyBuffer(blpDefinition, 0, 0, 3, myPriceArray);
   
   double blpValue = myPriceArray[index];
   
   return blpValue;
}

double Indicators::BRP(ENUM_TIMEFRAMES period,int index){
   //Bear power
   double myPriceArray[];
   
   int brpDefinition = iBearsPower(_Symbol, period, 13);
   
   ArraySetAsSeries(myPriceArray, true);
   
   CopyBuffer(brpDefinition, 0, 0, 3, myPriceArray);
   
   double brpValue = myPriceArray[index];
   
   return brpValue;
}



//TODO add more indicators

//+------------------------------------------------------------------+
