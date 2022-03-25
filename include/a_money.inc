/*
    ANTI_MONEY_HACK(MARLON307)_
*/
#if defined _money_included
	#endinput
#endif
#define _money_included
#pragma library money

new Money[MAX_PLAYERS];

#define GetPVarMoney(%0)             \
                                        Money[%0]
#define GivePVarMoney(%0,%1);        \
                                        GetPVarMoney(%0) += %1; GivePlayerMoney(%0, %1); ChekPVarMoney(%0);
#define ResetPVarMoney(%0);          \
                                        GetPVarMoney(%0) = 0; ResetPlayerMoney(%0);
#define ChekPVarMoney(%0);           \
                                        if(GetPVarMoney(%0) != GetPlayerMoney(%0))return Kick(%0);
