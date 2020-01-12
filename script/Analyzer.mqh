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

   bool trending = isItTrending();

   if(trending == true) {

      signal = strategy();

   }

   return signal;

}

bool Analyzer::isItTrending(void) {

   Indicators i;

   bool trending = false;

   double ADXValue = i.ADX(PERIOD_H1, 0, 0);

	bool trendADX = false;

   if(ADXValue >= 25.00) { //ADX trend boundary 25.00
      trendADX = true;
   }
   
   double ATRValue = i.ATR(PERIOD_H1, 0);
   
   bool volatilityATR = false;
   
   if(ATRValue > 0.0012){ //volatility boundary 12 pips above
   	volatilityATR = true;
   }

	if(trendADX == true && volatilityATR == true){
		trending = true;
	}

   return trending;
}

string Analyzer::strategy(void) {

   //Use MACD (crossover) and ADX (+DI and -DI position) as confirmation

   Indicators i;

   string confirmation = "";

   //MACD section

   string macdSignal = "";

   double macdRecent = i.MACD(PERIOD_H1, 0, 0);
   double macdBefore = i.MACD(PERIOD_H1, 0, 1);

   double signalRecent = i.MACD(PERIOD_H1, 1, 0);
   double signalBefore = i.MACD(PERIOD_H1, 1, 1);

   if(macdRecent > 0 && macdRecent > macdBefore) {
      if(signalBefore < 0 && signalRecent < 0) {
         macdSignal = "buy";
      }
   }
   if(macdRecent < 0 && macdRecent < macdBefore) {
      if(signalBefore > 0 && signalRecent > 0) {
         macdSignal = "sell";
      }
   }

   //ADX section

   string adxSignal = "";

   double plusDI = i.ADX(PERIOD_H1, 1, 0);
   double minusDI = i.ADX(PERIOD_H1, 2, 0);

   if(plusDI > minusDI) {
      adxSignal = "buy";
   }
   if(plusDI < minusDI) {
      adxSignal = "sell";
   }
   
   //Confirmation section
   
   if(macdSignal == "buy" && adxSignal == "buy"){
   	confirmation = "buy";
   }
   if(macdSignal == "sell" && adxSignal == "sell"){
   	confirmation = "sell";
   }
   
   return confirmation;

}


//TODO add more indicators configuration
//TODO come up with a trending strategy and ranging strategy

//+------------------------------------------------------------------+
