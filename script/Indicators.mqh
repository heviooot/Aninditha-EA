//+------------------------------------------------------------------+
//|                                      Aninditha-EA/Indicators.mqh |
//|                              Copyright 2020, Harold and Siswandy |
//+------------------------------------------------------------------+

class Indicators {
 public:
   double MACD(ENUM_TIMEFRAMES period, int buffer, int index);
   double ADX(ENUM_TIMEFRAMES period, int buffer, int index);
   double ATR(ENUM_TIMEFRAMES period, int index);
};

//+==================================================================+

//+------------------------------------------------------------------+
//| Get MACD Value                                                   |
//+------------------------------------------------------------------+
double Indicators::MACD(ENUM_TIMEFRAMES period, int buffer, int index) {
	
	//TODO turn it more modular, and output the MACD value only
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
//| Get ATR value                                                    |
//+------------------------------------------------------------------+
double Indicators::ATR(ENUM_TIMEFRAMES period, int index) {

   double myPriceArray[];

   int ATRDefinition = iATR(_Symbol, period, 14);

   ArraySetAsSeries(myPriceArray, true);

   CopyBuffer(ATRDefinition, 0, 0, 3, myPriceArray);

   double ATRValue = NormalizeDouble(myPriceArray[0], 4);

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

//TODO add more indicators

//+------------------------------------------------------------------+
