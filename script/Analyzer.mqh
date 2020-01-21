//+------------------------------------------------------------------+
//|                                        Aninditha-EA/Analyzer.mqh |
//|                              Copyright 2020, Harold and Siswandy |
//+------------------------------------------------------------------+

#include "Indicators.mqh";

class Analyzer: private Indicators {
 public:
   string signal();
   bool isItTrending();
 private:
   string strategy();
};

//+==================================================================+

//+------------------------------------------------------------------+
//| This part gather all the Signal produce by indicators            |
//+------------------------------------------------------------------+
string Analyzer::signal() {

   Indicators i;

   string signal = "";

   signal = strategy();

   return signal;

}

bool Analyzer::isItTrending(void) {

   Indicators i;

   bool trending = false;
// Hide temporary
   double ADXValue = i.ADX(PERIOD_H1, 0, 0);

   bool trendADX = false;

   if(ADXValue >= 25.00) { //ADX trend boundary 25.00
      trendADX = true;
   }

   if(trendADX == true) {
      trending = true;
   }
   return trending;
}

string Analyzer::strategy(void) {

   //Use MACD (crossover) and ADX (+DI and -DI position) as confirmation

   Indicators i;
   ENUM_TIMEFRAMES confPer = PERIOD_M15; //confirmation period
   ENUM_TIMEFRAMES trenPer = PERIOD_H1;

   string confirmation = "";

   //Stochastic (STC)
   string stcSignal = "";

   double stcRecent = i.STC(confPer, 0, 0);
   double stcBefore = i.STC(confPer, 0, 1);

   double signalRecent = i.STC(confPer, 1, 0);
   double signalBefore = i.STC(confPer, 1, 1);

   if(stcBefore <= 20.00) {
      if(stcBefore < stcRecent) {
         stcSignal = "buy";
      }
   }
   if(stcBefore >= 80.00) {
      if(stcBefore > stcRecent) {
         stcSignal = "sell";
      }
   }
/*
   //RSI
   string rsiSignal = "";

   double rsiValue = i.RSI(confPer, 0);

   if(rsiValue < 30.00) {
      rsiSignal = "buy";
   }
   if(rsiValue > 70.00) {
      rsiSignal = "sell";
   }

   //CCI
   string cciSignal = "";

   double cciValue = i.CCI(confPer, 0);

   if(cciValue < -100.00) {
		cciSignal = "buy";
   }
   if(cciValue > 100.00) {
		cciSignal = "sell";
   }
*/   
   //ADX section
   //TODO add trend power decreade signal
	string adxSignal = "";

   double plusDI = i.ADX(trenPer, 1, 0);
   double minusDI = i.ADX(trenPer, 2, 0);

   if(plusDI > minusDI) {
      adxSignal = "buy";
   }
   if(plusDI < minusDI) {
      adxSignal = "sell";
   }
	

   //Confirmation section

   if(stcSignal == "buy" && adxSignal == "buy") {
      confirmation = "buy";
   }
   if(stcSignal == "sell" && adxSignal == "buy") {
      confirmation = "sell";
   }

   return confirmation;

}


//TODO add more indicators configuration
//TODO come up with a trending strategy and ranging strategy

//+------------------------------------------------------------------+
