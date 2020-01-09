class Calculate{
	public:
		double lotSize();
		double stopLoss(string signal, double entry);
		double takeProfit(string signal, double entry);
		double askPrice();
		double bidPrice();
	private:
		double dynamicLot(double lotSize);
		double maxRiskInDollar(double balance, double percent);
		
};

//+------------------------------------------------------------------+
//| Calculate lot size dynamicaly                                    |
//+------------------------------------------------------------------+
double Calculate::lotSize(void) {

   double lotSize = 0.00;

   lotSize = dynamicLot(lotSize);

   return lotSize;
}

double Calculate::dynamicLot(double lotSize) {

   double maxPipsRisked = 5;
   double maxDlrsRisked = maxRiskInDollar(AccountInfoDouble(ACCOUNT_BALANCE),2);

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

   //TODO support other currency pair

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
   //TODO make a dynamic pips range
   double sl = 0;
   if(signal == "buy") {
      sl = (entry-(50*_Point)); //stop loss 5 pips
   }
   if(signal == "sell") {
      sl = (entry+(50*_Point)); //stop loss 5 pips
   }
   return sl;
}

//+------------------------------------------------------------------+
//| Calculate Take Profit                                            |
//+------------------------------------------------------------------+
double Calculate::takeProfit(string signal,double entry) {
   //TODO support pending order calculation
   //TODO make a dynamic pips range
   double tp = 0;
   if(signal == "buy") {
      tp = (entry+(150*_Point)); //stop loss 15 pips
   }
   if(signal == "sell") {
      tp = (entry-(150*_Point)); //stop loss 15 pips
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
