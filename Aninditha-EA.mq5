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
int OnInit(){
	
	
	int i = 0;
	while(i < 5){
		printAnalyze();   	
		printManage();
		printExecute();
		printTesting();
		Print(i);
		i++;
	}
	
	return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason){
	
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(){
	
}

//+------------------------------------------------------------------+
