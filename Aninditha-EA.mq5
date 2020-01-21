//+------------------------------------------------------------------+
//|                                                 Aninditha-EA.mq5 |
//|                              Copyright 2020, Harold and Siswandy |
//+------------------------------------------------------------------+

//External Script
#include "script\Analyzer.mqh";
#include "script\Manage.mqh";
#include "script\Calculate.mqh";
#include "script\Execute.mqh";
#include "script\System.mqh";

//Class Object
Analyzer AninAnalyze;
Manage AninManage;
Calculate AninCalculate;
Execute AninExecute;
System Settings;

//Global Variable
double previousBalance;
double currentBalance;
string tempSignal = "";

//+==================================================================+

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {

   Print("Hi I'm Aninditha, your friend in FX Market");

   bool haveOpenOrder = AninManage.anyOpenedOrder();
   if(haveOpenOrder == false) {
      previousBalance = AccountInfoDouble(ACCOUNT_BALANCE);
      currentBalance = AccountInfoDouble(ACCOUNT_BALANCE);
   }

   Settings.configH1();

   return(INIT_SUCCEEDED);

}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
   Print("Shut down");

   //TODO close all order features
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {

   bool access = AninManage.access();

   //previousBalance = previousBalance;
   currentBalance = AccountInfoDouble(ACCOUNT_BALANCE);

   if(access == true) {

      access = false;//reset value

      string signal = "";

      bool goingStrong = AninAnalyze.isItTrending();

      if(goingStrong == true) {
         //Print("STONK");
         if(currentBalance > previousBalance) {
            //TODO check trend first feature
            signal = tempSignal;
         } else {
            signal = AninAnalyze.signal();
         }
         if(signal == "buy") {
            previousBalance = currentBalance;
            double volume = AninCalculate.lotSize();
            double entryPoint = AninCalculate.askPrice();
            double stopLoss = AninCalculate.stopLoss(signal, entryPoint);
            double takeProfit = AninCalculate.takeProfit(signal, entryPoint);
            string comment = "Balance: " + DoubleToString(previousBalance, 2);
            //Print(comment);
            AninExecute.instantBuy(volume,entryPoint, stopLoss, takeProfit, comment);
         }
         if(signal == "sell") {
            previousBalance = currentBalance;
            double volume = AninCalculate.lotSize();
            double entryPoint = AninCalculate.bidPrice();
            double stopLoss = AninCalculate.stopLoss(signal, entryPoint);
            double takeProfit = AninCalculate.takeProfit(signal, entryPoint);
            string comment = "Balance: " + DoubleToString(previousBalance, 2);
            //Print(comment);
            AninExecute.instantSell(volume,entryPoint, stopLoss, takeProfit, comment);
         }
         tempSignal = signal;
      } else {
         //Print("smol pp");
      }
   }
}
//+------------------------------------------------------------------+
