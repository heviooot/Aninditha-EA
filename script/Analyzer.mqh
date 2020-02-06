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
   string stochastic(ENUM_TIMEFRAMES period);
   string eMovingAvg(ENUM_TIMEFRAMES period);

   string bearBullPower(ENUM_TIMEFRAMES period);
   string bearsPower(ENUM_TIMEFRAMES period);
   string bullsPower(ENUM_TIMEFRAMES period);
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

   bool rangeATR = false;

   if(ATRValue <= 0.0010) {
      rangeATR = true;
   }

   if(rangeATR) { //delete ADX
      trending = true;
   }

   return trending;
}

string Analyzer::strategy(void) {

   //Use MACD (crossover) and ADX (+DI and -DI position) as confirmation

   Indicators i;
   ENUM_TIMEFRAMES confPer = PERIOD_M15; //confirmation period
   ENUM_TIMEFRAMES trendPer = PERIOD_H1;

   string confirmation = "";

   // STC section
   string stcSignal = "";
   stcSignal = stochastic(trendPer);

   // MA section
   string maSignal = "";
   maSignal = eMovingAvg(trendPer);

   // Bear Bull section
   string bbSignal = "";
   bbSignal = bearBullPower(trendPer);


   //Confirmation section

   if(bbSignal == "buy" && maSignal == "buy") {
      confirmation = "buy";
   }
   if(bbSignal == "sell" && maSignal == "sell") {
      confirmation = "sell";
   }

   return confirmation;

}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Analyzer::bearBullPower(ENUM_TIMEFRAMES period) {
   
   string signal = "";
   
   // Bulls Power section
   string bulSignal = "";
   bulSignal = bullsPower(period);

   // Bears Power section
   string brpSignal = "";
   brpSignal = bearsPower(period);

   if(brpSignal == bulSignal) {
      signal = brpSignal;
   }
   
   return signal;
}

string Analyzer::bearsPower(ENUM_TIMEFRAMES period) {

   Indicators i;

   string signal = "";

   double bearNumber = i.BRP(period, 0);

   if(bearNumber > 0.0) { //TODO: 5 pips
      signal = "buy";
   }
   if(bearNumber < -0.00020) { //TODO: 5 pips
      signal = "sell";
   }


   return signal;
}

string Analyzer::bullsPower(ENUM_TIMEFRAMES period) {

   Indicators i;

   string signal = "";

   double bullNumber = i.BLP(period, 0);

   if(bullNumber > 0.00020) { //TODO: 5 pips
      signal = "buy";
   }
   if(bullNumber < -0.0) { //TODO: 5 pips
      signal = "sell";
   }

   return signal;

}

string Analyzer::stochastic(ENUM_TIMEFRAMES period) {

   //Stochastic (STC)

   Indicators i;

   string signal = "";

   double stcRecent = i.STC(period, 0, 0);
   double stcBefore = i.STC(period, 0, 1);

   double signalRecent = i.STC(period, 1, 0);
   double signalBefore = i.STC(period, 1, 1);

   if(stcBefore <= 20.00) {
      if(stcRecent < signalRecent) {
         signal = "buy";
      }
   }
   if(stcBefore >= 80.00) {
      if(stcRecent > signalRecent) {
         signal = "sell";
      }
   }

   return signal;
}

string Analyzer::eMovingAvg(ENUM_TIMEFRAMES period) {

   //Exponensial Moving Average (EMA)
   Indicators i;

   string signal = "";

   double maPrc = i.MA(period, 0, 3);
   double ma07 = i.MA(period, 0, 7);
   double ma20 = i.MA(period, 0, 20);
   double ma25 = i.MA(period, 0, 25);
   double ma30 = i.MA(period, 0, 30);
   double ma35 = i.MA(period, 0, 35);
   double ma40 = i.MA(period, 0, 40);
   double ma45 = i.MA(period, 0, 45);
   double ma50 = i.MA(period, 0, 50);
   double ma55 = i.MA(period, 0, 55);

   //TODO: check MA spread
   
   if((maPrc < ma07) && (ma07 < ma20) && (ma20 < ma25) && (ma25 < ma30) && (ma30 < ma35) && (ma35 < ma40) && (ma40 < ma45) && (ma45 < ma50) && (ma50 < ma55)) {
      signal = "sell";
   }
   if((maPrc < ma07) && (ma07 < ma20) && (ma20 > ma25) && (ma25 > ma30) && (ma30 > ma35) && (ma35 > ma40) && (ma40 > ma45) && (ma45 > ma50) && (ma50 > ma55)) {
      signal = "buy";
   }

   return signal;
}

//TODO add more indicators configuration
//TODO come up with a trending strategy and ranging strategy

//+------------------------------------------------------------------+
