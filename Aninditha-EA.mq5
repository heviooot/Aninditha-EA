//+------------------------------------------------------------------+
//|                                                 Aninditha-EA.mq5 |
//|                              Copyright 2020, Harold and Siswandy |
//+------------------------------------------------------------------+

//External Script
#include "script\Testing.mqh";
#include "script\Analyze.mqh";
#include "script\Manage.mqh";
#include "script\Execute.mqh";

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {

   Print("Hi I'm Aninditha, your friend in FX Market");

   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
   Print("Shut down");
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {

   string signal = checkEntry();
   Comment(signal);

   bool access = canEnter();

   if(access == true) {
      access = false;//reset value
      double volume = lotSizeNeeded();

      //TODO Update the comment format
      if(signal == "buy") {
         double entryPoint = calculateAskPrice();
         double stopLoss = calculateStopLoss(signal, entryPoint);
         double takeProfit = calculateTakeProfit(signal, entryPoint);
         string comment =
            "Buy. Price:" + DoubleToString(NormalizeDouble(entryPoint,4)) + " , " +
            "Volume:" + DoubleToString(volume) + " , " +
            "SL:" + DoubleToString(NormalizeDouble(stopLoss, 4)) + " , " +
            "TP:" + DoubleToString(NormalizeDouble(takeProfit,4));

         //Print(comment);
         openBuy(volume,entryPoint, stopLoss, takeProfit, comment);
      }
      if(signal == "sell") {
         double entryPoint = calculateBidPrice();
         double stopLoss = calculateStopLoss(signal, entryPoint);
         double takeProfit = calculateTakeProfit(signal, entryPoint);
         string comment =
            "Buy. Price:" + DoubleToString(NormalizeDouble(entryPoint,4)) + " , " +
            "Volume:" + DoubleToString(volume) + " , " +
            "SL:" + DoubleToString(NormalizeDouble(stopLoss, 4)) + " , " +
            "TP:" + DoubleToString(NormalizeDouble(takeProfit,4));

         //Print(comment);
         openSell(volume,entryPoint, stopLoss, takeProfit, comment);
      }
   }
}
