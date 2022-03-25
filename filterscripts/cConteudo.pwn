#include <a_samp>
#include <zcmd>

#define MAX_PLAYER_C(%0)         if(%0 > 25)return SendClientMessage(playerid,-1,"Erro");
#define MIN_PLAYER_C(%0)         if(%0 < 5)return SendClientMessage(playerid,-1,"Erro");
#define MAX_PLAYER_M(%0)         if(%0 > 30)return SendClientMessage(playerid,-1,"Erro");
#define MIN_PLAYER_M (%0)        if(%0 < 8)return SendClientMessage(playerid,-1,"Erro");

#define PASTA_EVENTOS           Eventos/%s.ini


#define PRESSED(%0)        \
	                          (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0)       \
	                          (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

new eventName[120];

public OnFilterScriptInit(){
    return 1;
}


public OnFilterScriptExit()
{
	return 1;
}

CMD:cc(playerid,params[])
{
    ShowPlayerDialog(playerid,5464, DIALOG_STYLE_INPUT, "CC", "De o nome Deste Evento", "Login", "Cancel");
   // creatEdit = 1;
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

public OnPlayerDeath(playerid, killerid, reason)
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

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}



public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(PRESSED(KEY_CROUCH))
    {

    }
    return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case 5464:
        {
              new str[50],string[100],pName[MAX_PLAYER_NAME];
              GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
              format(str, sizeof(str),"Eventos/%s.ini",inputtext);
              new File:filename=fopen(str,io_readwrite);
              format(string, sizeof(string),"%s\n\r%s",pName,inputtext);
              fwrite(filename, string);
              fwrite(filename, str);
              fclose(filename);
              eventName = inputtext;
        }
    }
    return 1;
}
public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}
