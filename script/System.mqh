//+------------------------------------------------------------------+
//|                                          Aninditha-EA/System.mqh |
//|                              Copyright 2020, Harold and Siswandy |
//+------------------------------------------------------------------+

class System {
 public:
   void configH1(void);
};

//+==================================================================+

//+------------------------------------------------------------------+
//| Setup Indicators that used in H1 time frame                      |
//+------------------------------------------------------------------+
void System::configH1(void) {
   //Start all indicators needed;
   ENUM_TIMEFRAMES period = PERIOD_H1;
   int ATRDefinition = iATR(_Symbol, period, 14);
   //int MACDDefinition = iMACD(_Symbol, period, 12, 26, 9, PRICE_CLOSE);
   int STCDefinition = iStochastic(_Symbol, period, 5, 3, 3, MODE_SMA, STO_CLOSECLOSE);
   int RSIDefinition = iRSI(_Symbol, period, 14, PRICE_CLOSE);
   int CCIDefinition = iCCI(_Symbol, period, 14, PRICE_TYPICAL);
   int ADXDefinition = iADX(_Symbol, period, 14);
}

//TODO support lower time frame configuration
//+------------------------------------------------------------------+
