#include <a_samp>
#include <zcmd>
#include <sscanf2>
#include <streamer>

#define Loop(%0,%1)        \
                              for(new %0; %0 != %1; ++%0)
//#include "../include/a_money.inc"

#define Vermelho                                                                0xFF0000AA
#define PROF_PIZZABOYLS                                                         3


enum pInfo {
    Profissao
};
new PlayerInfo[MAX_PLAYERS][pInfo];

new bool:DestinoCarg[MAX_PLAYERS];

//variaveis carro de profissoes
new vPizzaBoy[12];

//Profissão pizza boy LS
new Float:PizzaBoyLs[][3] =
{
    {2002.8317,-1131.2650,24.8158},
    {1257.8948,-1074.5381,27.5068},
    {265.0087,-1234.2450,73.2099},
    {657.0215,-1073.9583,47.8731},
    {2402.1563,-1728.0730,12.9457},
    {2837.3989,-1184.2491,24.1005},
    {2638.6177,-1069.0092,69.0160},
    {2765.4275,-1978.7095,12.9356},
    {2674.6794,-2008.0238,12.9446},
    {2220.0576,-1786.2136,12.7801},
    {2077.1919,-1717.4512,12.9620},
    {1800.7949,-2108.2310,12.9469},
    {483.2446,-1534.8568,18.9431},
    {1993.7633,-1336.4866,23.3908},
    {2141.0723,-1305.5994,23.4043}
};

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");

    LoadVehicleFromFile("vPizzaBoyLs.txt",vPizzaBoy);
    return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

CMD:pegarpizza(playerid, params[])
{
   // if(!PlayerToPoint(8.0, playerid, 2096.3174,-1806.4795,13.1165))return CmdErrorMessage(playerid);
    {
        if(DestinoCarg[playerid] == true)return SendClientMessage(playerid,Vermelho,"Você já pegou uma pizza para entregar.  ( ; ");
        {
            if(!IsPlayerInVehicle(playerid, 448))return SendClientMessage(playerid,Vermelho,"Você já pegou uma pizza para entregar.  ( ; ");
            {
                switch(PlayerInfo[playerid][Profissao])
                {
                    case PROF_PIZZABOYLS:
                    {
                        new rand = random(sizeof(PizzaBoyLs));
                        SetPlayerCheckpoint(playerid,PizzaBoyLs[rand][0],PizzaBoyLs[rand][1],PizzaBoyLs[rand][2],4.5);
                        DestinoCarg[playerid] = true;
                    }
                }
             }
        }
    }
    return 1;
}


public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
    return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{

    switch(newstate)
    {
        case 0:return 0;
    }
    switch(newstate)
    {
        case PLAYER_STATE_DRIVER:
        {
            Loop(i,12)
            {
                if(IsPlayerInVehicle(playerid, vPizzaBoy[i]) && PlayerInfo[playerid][Profissao] != PROF_PIZZABOYLS)
                {
                    SendClientMessage(playerid, Vermelho, "Você não é um pizzaboy  ; )");
                    RemovePlayerFromVehicle(playerid);
                }
            }
            return 1;
        }
    }
    return 0;
}

public OnPlayerEnterCheckpoint(playerid)
{
    new str[150], ValorCaga[MAX_PLAYERS];

    if(DestinoCarg[playerid] == true)
    {
        if(!IsPlayerInAnyVehicle(playerid))return DisablePlayerCheckpoint(playerid);
        {
            switch(PlayerInfo[playerid][Profissao])
            {
                case PROF_PIZZABOYLS:
                {
                    if(!(GetPlayerVehicleID(playerid) != 448))return SendClientMessage(playerid,Vermelho,"Você esta sem a carga.");
                    {
                        switch(random(5))
                        {
                            case 1: ValorCaga[playerid] = 600;
                            case 2: ValorCaga[playerid] = 500;
                            case 3: ValorCaga[playerid] = 350;
                            case 4: ValorCaga[playerid] = 250;
                            case 5: ValorCaga[playerid] = 200;
                        }
                  //      format(str,sizeof(str),"Você recebeu {C0C0C0}$%d,00{FF8000} por fazer uma emtrega em {C0C0C0}%s{FF8000}.",ValorCaga[playerid],GetPlayerArea(playerid));
                    }
                }
            }
            SendClientMessage(playerid,0xFF8000AA,str);
            DisablePlayerCheckpoint(playerid);
            TogglePlayerControllable(playerid, false);
            GivePlayerMoney(playerid,ValorCaga[playerid]);
            DeletePVar(playerid,"CargItem");
            DestinoCarg[playerid] = false;
            SetTimerEx("Deascongelar", 8000, false, "i",playerid);
        }
    }
    return 1;
}

stock LoadVehicleFromFile(filename[], varName[])
{
    new File:file_ptr, line[200], num, modelid, Float:px, Float:py, Float:pz, Float:r, c1, c2,str[20];

    format(str, 20,"Veiculos/%s",filename);

    file_ptr = fopen(str, io_read);

    if(!file_ptr)
        return printf("ERROR! File %s Doesn't Exist", str);

    while(fread(file_ptr, line) > 0)
    {
        if(!sscanf(line, "p<,>ddffffdd", num, modelid, px, py, pz, r, c1, c2))
        {
            varName[num] = CreateVehicle(modelid, px, py, pz, r, c1, c2, (8 * 60));
        }
    }
    return 1;
}
