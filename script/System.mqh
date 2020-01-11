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
   int MACDDefinition = iMACD(_Symbol, period, 12, 26, 9, PRICE_CLOSE);
}

//TODO support lower time frame configuration
//+------------------------------------------------------------------+
