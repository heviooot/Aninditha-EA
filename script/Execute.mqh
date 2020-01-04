//+------------------------------------------------------------------+
//|                                         Aninditha-EA/Execute.mqh |
//|                              Copyright 2020, Harold and Siswandy |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Open Instant Buy Contract                                        |
//+------------------------------------------------------------------+
void openBuy(double vol, double prce, double sl, double tp, string comment) {
   //Declare and initialize the trade request and result of trade request
   MqlTradeRequest request = {0};
   MqlTradeResult result = {0};

   //Parameter of request
   request.action = TRADE_ACTION_DEAL;
   request.symbol = Symbol();
   request.volume = vol;
   request.price = prce;
   request.sl = sl;
   request.tp = tp;
   request.deviation = 5;
   request.type = ORDER_TYPE_BUY;
   request.type_filling = ORDER_FILLING_FOK;

   if(!OrderSend(request, result)) {
      PrintFormat("OrderSend error %d",GetLastError());// if unable to send the request, output
   }
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);

   //Print(comment);
}

//+------------------------------------------------------------------+
//| Open Instant SellContract                                        |
//+------------------------------------------------------------------+
void openSell(double vol, double prce, double sl, double tp, string comment) {
//Declare and initialize the trade request and result of trade request
   MqlTradeRequest request = {0};
   MqlTradeResult result = {0};

   //Parameter of request
   request.action = TRADE_ACTION_DEAL;
   request.symbol = Symbol();
   request.volume = vol;
   request.price = prce;
   request.sl = sl;
   request.tp = tp;
   request.deviation = 5;
   request.type = ORDER_TYPE_SELL;
   request.type_filling = ORDER_FILLING_FOK;

   if(!OrderSend(request, result)) {
      PrintFormat("OrderSend error %d",GetLastError());// if unable to send the request, output
   }
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);

   //Print(comment);
}

//TODO Make pending order

//+------------------------------------------------------------------+
