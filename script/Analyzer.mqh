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

   // ADX section
   double ADXValue = i.ADX(PERIOD_H1, 0, 0);

   bool trendADX = false;

   if(ADXValue >= 25.00) { //ADX trend boundary 25.00
      trendADX = true;
   }
   
   // ATR section
   double ATRValue = i.ATR(PERIOD_H1, 0);
   
   bool trendATR = false;
   
   if(ATRValue <= 0.0015){
   	trendATR = true;
   }

   if(trendADX == true && trendATR == true) {
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

   double stcRecent = i.STC(trenPer, 0, 0);
   double stcBefore = i.STC(trenPer, 0, 1);

   double signalRecent = i.STC(trenPer, 1, 0);
   double signalBefore = i.STC(trenPer, 1, 1);

   if(stcBefore <= 20.00) {
      if(stcRecent < signalRecent) {
         stcSignal = "buy";
      }
   }
   if(stcBefore >= 80.00) {
      if(stcRecent > signalRecent) {
         stcSignal = "sell";
      }
   }

   // MA section
   string maSignal = "";

	double maPrc = i.MA(trenPer, 0, 7);
   double ma20 = i.MA(trenPer, 0, 20);
   double ma25 = i.MA(trenPer, 0, 25);
   double ma30 = i.MA(trenPer, 0, 30);
   double ma35 = i.MA(trenPer, 0, 35);
   double ma40 = i.MA(trenPer, 0, 40);
   double ma45 = i.MA(trenPer, 0, 45);
   double ma50 = i.MA(trenPer, 0, 50);
   double ma55 = i.MA(trenPer, 0, 55);

   if((maPrc < ma20) && (ma20 < ma25) && (ma25 < ma30) && (ma30 < ma35) && (ma35 < ma40) && (ma40 < ma45) && (ma45 < ma50) && (ma50 < ma55)) {
      maSignal = "sell";
   }
   if((maPrc < ma20) && (ma20 > ma25) && (ma25 > ma30) && (ma30 > ma35) && (ma35 > ma40) && (ma40 > ma45) && (ma45 > ma50) && (ma50 > ma55)) {
      maSignal = "buy";
   }


   //Confirmation section

   if(stcSignal == "buy" && maSignal == "buy") {
      confirmation = "buy";
   }
   if(stcSignal == "sell" && maSignal == "sell") {
      confirmation = "sell";
   }

   return confirmation;

}


//TODO add more indicators configuration
//TODO come up with a trending strategy and ranging strategy

//+------------------------------------------------------------------+
