//+------------------------------------------------------------------+
//|                                       Aninditha-EA/Calculate.mqh |
//|                              Copyright 2020, Harold and Siswandy |
//+------------------------------------------------------------------+

#include "Indicators.mqh";

class Calculate: private Indicators {
 public:
   double lotSize();
   double stopLoss(string signal, double entry);
   double takeProfit(string signal, double entry);
   double askPrice();
   double bidPrice();
   //double entry();
 private:
   double dynamicLot(double lotSize);
   double usdBase(string pair, double lotSize);
   double usdCounter(string pair, double lotSize);
   double usdJpy(double lotSize);
   double otherCurr(string pair); //TODO: implement in the future
   double maxRiskInDollar(double balance, double percent);
};

//+==================================================================+

//+------------------------------------------------------------------+
//| Calculate lot size dynamicaly                                    |
//+------------------------------------------------------------------+
double Calculate::lotSize(void) {

   double lotSize = 0.00;

   lotSize = dynamicLot(lotSize);

   return lotSize;
}

double Calculate::dynamicLot(double lotSize) {

   Indicators i;

   string symbol = _Symbol;

   if(symbol == "EURUSD" || symbol == "GBPUSD" || symbol == "AUDUSD" || symbol == "NZDUSD") {
      lotSize = usdCounter(symbol, lotSize);
   }
   if(symbol == "USDCHF" || symbol == "USDCAD" || symbol == "USDJPY") {
      if(symbol == "USDJPY") {
         lotSize = usdJpy(lotSize);
      } else {
         lotSize = usdBase(symbol, lotSize);
      }
   }

   return lotSize;

}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Calculate::usdBase(string pair, double lotSize) {

   Indicators i;

   ENUM_TIMEFRAMES period = PERIOD_H1;
   double maxPipsRisked = NormalizeDouble((i.ATR(period, 0)*10000),0); //convert the ATR value into numbers of pips
   //Print("Pips: " + maxPipsRisked);
   double maxDlrsRisked = maxRiskInDollar(AccountInfoDouble(ACCOUNT_BALANCE),2); //risk only 2% of the current balance

   //EUR-USD - Standart
   double pricePerPip = (SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE)*maxDlrsRisked) / maxPipsRisked; //convert it from symbol to USD
   lotSize = pricePerPip * (10000/1);
   lotSize /= 100000;

   //Shift the decimal to 10^-2
   lotSize = NormalizeDouble(lotSize, 5);
   lotSize = NormalizeDouble(lotSize, 4);
   lotSize = NormalizeDouble(lotSize, 3);
   lotSize = NormalizeDouble(lotSize, 2);
   //Print("Lot Size Normal = " + lotSize);

   return lotSize;

}

double Calculate::usdCounter(string pair, double lotSize) {

   Indicators i;

   ENUM_TIMEFRAMES period = PERIOD_H1;
   double maxPipsRisked = NormalizeDouble((i.ATR(period, 0)*10000),0); //convert the ATR value into numbers of pips
   //Print("Pips: " + maxPipsRisked);
   double maxDlrsRisked = maxRiskInDollar(AccountInfoDouble(ACCOUNT_BALANCE),2); //risk only 2% of the current balance

   //EUR-USD - Standart
   double pricePerPip = maxDlrsRisked / maxPipsRisked;
   lotSize = pricePerPip * (10000/1);
   lotSize /= 100000;

   //Shift the decimal to 10^-2
   lotSize = NormalizeDouble(lotSize, 5);
   lotSize = NormalizeDouble(lotSize, 4);
   lotSize = NormalizeDouble(lotSize, 3);
   lotSize = NormalizeDouble(lotSize, 2);
   //Print("Lot Size Normal = " + lotSize);

   return lotSize;
}

//TODO: Do USDJPY
double Calculate::usdJpy(double lotSize){

   Indicators i;

   ENUM_TIMEFRAMES period = PERIOD_H1;
   double maxPipsRisked = NormalizeDouble((i.ATR(period, 0)*10),0); //convert the ATR value into numbers of pips
   //Print("Pips: " + maxPipsRisked);
   double maxDlrsRisked = maxRiskInDollar(AccountInfoDouble(ACCOUNT_BALANCE),2); //risk only 2% of the current balance

   //EUR-USD - Standart
   double pricePerPip = maxDlrsRisked / maxPipsRisked;
   lotSize = pricePerPip * (10000/1);
   lotSize /= 100000;

   //Shift the decimal to 10^-2
   lotSize = NormalizeDouble(lotSize, 3);
   lotSize = NormalizeDouble(lotSize, 2);
   //Print("Lot Size Normal = " + lotSize);

   return lotSize;
   
}



//+------------------------------------------------------------------+
//| Calculate the maximum risk in dollar                             |
//+------------------------------------------------------------------+
double Calculate::maxRiskInDollar(double balance,double percent) {
   return (balance * (percent/100));
}

//+------------------------------------------------------------------+
//| Calculate Stop Loss                                              |
//+------------------------------------------------------------------+
double Calculate::stopLoss(string signal,double entry) {
   //TODO support pending order calculation
   //TODO support trailing order calculation

   Indicators i;
   ENUM_TIMEFRAMES period = PERIOD_H1;

   double sl = 0;
   double slATR = i.ATR(period, 0);
   if(signal == "buy") {
      sl = (entry - slATR); //stop loss using ATR
      //sl = (entry-(50*_Point)); //stop loss 5 pips
   }
   if(signal == "sell") {
      sl = (entry + slATR); //stop loss using ATR
      //sl = (entry+(50*_Point)); //stop loss 5 pips
   }
   return sl;
}

//+------------------------------------------------------------------+
//| Calculate Take Profit                                            |
//+------------------------------------------------------------------+
double Calculate::takeProfit(string signal,double entry) {
   //TODO support pending order calculation
   //TODO support trailing order calculation

   Indicators i;
   ENUM_TIMEFRAMES period = PERIOD_H1;

   double tp = 0;
   double tpATR = i.ATR(period, 0);
   if(signal == "buy") {
      tp = (entry + (3 * tpATR)); //take profit 3x ATR
      //tp = (entry + (150*_Point)); //take profit 15 pips
   }
   if(signal == "sell") {
      tp = (entry - (3 * tpATR)); //take profit 3x ATR
      //tp = (entry - (150*_Point)); //take profit 15 pips
   }
   return tp;
}

//+------------------------------------------------------------------+
//| Check the recent Ask Price                                       |
//+------------------------------------------------------------------+
double Calculate::askPrice(void) {
   return NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK), _Digits);
}

//+------------------------------------------------------------------+
//| Check the recent Bid Price                                       |
//+------------------------------------------------------------------+
double Calculate::bidPrice(void) {
   return NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID), _Digits);
}

//+------------------------------------------------------------------+
