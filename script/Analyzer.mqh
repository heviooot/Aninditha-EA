//+------------------------------------------------------------------+
//|                                        Aninditha-EA/Analyzer.mqh |
//|                              Copyright 2020, Harold and Siswandy |
//+------------------------------------------------------------------+

#include "Indicators.mqh";

class Analyzer: private Indicators {
 public:
   string signal();
   void setup(ENUM_TIMEFRAMES period);
 private:
   //strategy
   string iRSIiMA();
   string iMACDiRSI();
   string iMAiMACD();
};

//+==================================================================+

//+------------------------------------------------------------------+
//| This part gather all the Signal produce by indicators            |
//+------------------------------------------------------------------+
string Analyzer::signal() {

   Indicators i;

   string signal = "";

   signal = i.MACD(PERIOD_H1);

   return signal;

}

//+------------------------------------------------------------------+
//| Signal: RSI + MA                                                 |
//+------------------------------------------------------------------+
string Analyzer::iRSIiMA(void) {

   Indicators i;

   string signal = "";

   //string iMASignal = iMASignal();
   string iMASignal = i.MA(PERIOD_H1);

   if(iMASignal == "buy") {
      string iRSISignal = i.RSI(PERIOD_H1);
      if(iRSISignal == "buy") {
         signal = "buy";
      }
   }
   if(iMASignal == "sell") {
      string iRSISignal = i.RSI(PERIOD_H1);
      if(iRSISignal == "sell") {
         signal = "sell";
      }
   }

   return signal;
}

//+------------------------------------------------------------------+
//| Signal: MA + MACD                                                |
//+------------------------------------------------------------------+
string Analyzer::iMAiMACD(void) {

   Indicators i;

   string signal = "";

   string iMASignal = i.MA(PERIOD_H1);

   if(iMASignal == "buy") {
      string iMACDSignal = i.MACD(PERIOD_H1);
      if(iMACDSignal == "buy") {
         signal = "buy";
      }
   }
   if(iMASignal == "sell") {
      string iMACDSignal = i.MACD(PERIOD_H1);
      if(iMACDSignal == "sell") {
         signal = "sell";
      }
   }

   return signal;
}

//+------------------------------------------------------------------+
//| Signal: MACD + RSI                                               |
//+------------------------------------------------------------------+
string Analyzer::iMACDiRSI(void) {

   //MACD + RSI
   //It check if the the RSI is overbough/oversold
   //and then proceed to check for MACD main and signal position

   Indicators i;

   string signal = "";

   string iRSISignal = i.RSI(PERIOD_H1);

   if(iRSISignal == "buy") {
      string iMACDSignal = i.MACD(PERIOD_H1);
      if(iMACDSignal == "buy") {
         signal = "buy";
      }
   }
   if(iRSISignal == "sell") {
      string iMACDSignal = i.MACD(PERIOD_H1);
      if(iMACDSignal == "sell") {
         signal = "sell";
      }
   }

   return signal;
}

//TODO add more indicators configuration
//TODO come up with a trending strategy and ranging strategy

//+------------------------------------------------------------------+
