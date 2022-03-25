/*
	PlayerArea's - By Kwarde.
	Current version: 1.0.1
    http://forum.sa-mp.com/showthread.php?t=229423
*/

#if defined _playerarea_included
	#endinput
#endif
#define _playerarea_included

//#include <a_samp>

#define MAX_AREAS       100
#define ERROR_NOAREA    11
#define ERROR_LIMIT     12

#if defined IsPlayerInArea
	#define IsPlayerInAreaEx IsPlayerInKRPAArea
#else
	#define IsPlayerInArea IsPlayerInKRPAArea
#endif

enum aInfo
{
	aID,
	Float:aPosMinX,
	Float:aPosMinY,
	Float:aPosMinZ,
	Float:aPosMaxX,
	Float:aPosMaxY,
	Float:aPosMaxZ,
	bool:aZUsed,
	bool:aCreated
};
new AreaInfo[MAX_AREAS][aInfo], AreaCount = -1;
new pIsInArea[MAX_PLAYERS], pTimer[MAX_PLAYERS];

forward OnPlayerEnterArea(playerid, areaid);
forward OnPlayerExitArea(playerid, areaid);

forward _KRPA_OnPlayerConnect(playerid);
forward _KRPA_OnPlayerDisconnect(playerid, reason);
forward CheckPlayerPos(playerid);

public OnPlayerConnect(playerid)
{
	pIsInArea[playerid] = (-1);
	pTimer[playerid] = SetTimerEx("CheckPlayerPos", 500, true, "i", playerid);
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect _KRPA_OnPlayerConnect

public OnPlayerDisconnect(playerid, reason)
{
	KillTimer(pTimer[playerid]);
	pTimer[playerid] = (-1);
	pIsInArea[playerid] = (-1);
    return 1;
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect _KRPA_OnPlayerDisconnect

public CheckPlayerPos(playerid)
{
	for(new i = 0; i < MAX_AREAS; i++)
    {
	    if(!IsAreaCreated(i)) continue;
	    if(IsPlayerInArea(playerid, i) && pIsInArea[playerid] != i)
        {
     		CallLocalFunction("OnPlayerEnterArea", "dd", playerid, i);
     		pIsInArea[playerid] = i;
		}
		else if(!IsPlayerInArea(playerid, i) && pIsInArea[playerid] == i)
        {
		    CallLocalFunction("OnPlayerExitArea", "dd", playerid, i);
		    pIsInArea[playerid] = (-1);
		}
	}
	return 1;
}

stock IsPlayerInKRPAArea(playerid, areaid)
{
	if(!IsAreaCreated(areaid)) return ERROR_NOAREA;
	new
	    Float:pX,
	    Float:pY,
	    Float:pZ
	;
	GetPlayerPos(playerid, pX, pY, pZ);
	if(pX >= AreaInfo[areaid][aPosMinX] && pX <= AreaInfo[areaid][aPosMaxX] && pY >= AreaInfo[areaid][aPosMinY] && pY <= AreaInfo[areaid][aPosMaxY]){
	    if(AreaInfo[areaid][aZUsed])
        {
	        if(pZ >= AreaInfo[areaid][aPosMinZ] && pZ <= AreaInfo[areaid][aPosMaxZ])
	            return true;
		}
		else return true;
	}
	return false;
}

stock IsAreaCreated(areaid)
	return AreaInfo[areaid][aCreated];

stock GetLowestFreeAreaID()
{
	for(new i = 0; i < MAX_AREAS; i++)
	{
	    if(IsAreaCreated(i) || i == AreaCount) //I had a bug.
			continue;
		else
		    return i;
	}
	return ERROR_NOAREA;
}

stock CreateArea(Float:MinX, Float:MaxX, Float:MinY, Float:MaxY, Float:MinZ = -1.0, Float:MaxZ = -1.0)
{
	new id;
	AreaCount++;
	if(AreaCount == MAX_AREAS-1) return ERROR_LIMIT; //Script language counts from 0 untill the end - 1. (Because the '0' was there). With 'for(new i = 0; i < 5; i++)' it'll loop untill 4
	id = GetLowestFreeAreaID();
	AreaInfo[id][aPosMinX] = MinX;
	AreaInfo[id][aPosMaxX] = MaxX;
	AreaInfo[id][aPosMinY] = MinY;
	AreaInfo[id][aPosMaxY] = MaxY;
	AreaInfo[id][aPosMinZ] = MinZ;
	AreaInfo[id][aPosMaxZ] = MaxZ;
	if(AreaInfo[id][aPosMinZ] == -1.0 && AreaInfo[id][aPosMaxZ] == -1.0) AreaInfo[id][aZUsed] = false;
	AreaInfo[id][aCreated] = true;
	return id;
}

stock CreateArea2(Float:MinX, Float:MinY, Float:MaxX, Float:MaxY, Float:MinZ = -1.0, Float:MaxZ = -1.0) //Gangzones
	return CreateArea(MinX, MaxX, MinY, MaxY, MinZ, MaxZ);

stock CreateArea3(Float:MaxX, Float:MinX, Float:MaxY, Float:MinY, Float:MinZ = -1.0, Float:MaxZ = -1.0) //World Bounds
	return CreateArea(MinX, MaxX, MinY, MaxY, MinZ, MaxZ);

stock DeleteArea(areaid)
{
	if(!IsAreaCreated(areaid)) return ERROR_NOAREA;
	AreaCount--;
	AreaInfo[areaid][aPosMinX] = 0.0;
	AreaInfo[areaid][aPosMaxX] = 0.0;
	AreaInfo[areaid][aPosMinY] = 0.0;
	AreaInfo[areaid][aPosMaxY] = 0.0;
	AreaInfo[areaid][aPosMinZ] = 0.0;
	AreaInfo[areaid][aPosMaxZ] = 0.0;
	AreaInfo[areaid][aZUsed] = false;
	AreaInfo[areaid][aCreated] = false;
}

stock UpdateArea(areaid, Float:MinX, Float:MaxX, Float:MinY, Float:MaxY, Float:MinZ = -1.0, Float:MaxZ = -1.0)
{
	new id = areaid;
	if(!IsAreaCreated(id)) return ERROR_NOAREA;
	AreaInfo[id][aPosMinX] = MinX;
	AreaInfo[id][aPosMaxX] = MaxX;
	AreaInfo[id][aPosMinY] = MinY;
	AreaInfo[id][aPosMaxY] = MaxY;
	AreaInfo[id][aPosMinZ] = MinZ;
	AreaInfo[id][aPosMaxZ] = MaxZ;
	if(AreaInfo[id][aPosMinZ] == -1.0 && AreaInfo[id][aPosMaxZ] == -1.0) AreaInfo[id][aZUsed] = false;
}

stock UpdateArea2(areaid, Float:MinX, Float:MinY, Float:MaxX, Float:MaxY, Float:MinZ = -1.0, Float:MaxZ = -1.0)
	return UpdateArea(areaid, MinX, MaxX, MinY, MaxY, MinZ, MaxZ);

stock UpdateArea3(areaid, Float:MaxX, Float:MinX, Float:MaxY, Float:MinY, Float:MinZ = -1.0, Float:MaxZ = -1.0)
	return UpdateArea(areaid, MinX, MaxX, MinY, MaxY, MinZ, MaxZ);

stock GetAreaInfo(areaid, &Float:MinX, &Float:MaxX, &Float:MinY, &Float:MaxY, &Float:MinZ, &Float:MaxZ)
{
	if(!IsAreaCreated(areaid)) return ERROR_NOAREA;
	MinX = AreaInfo[areaid][aPosMinX];
	MaxX = AreaInfo[areaid][aPosMaxX];
	MinY = AreaInfo[areaid][aPosMinY];
	MaxY = AreaInfo[areaid][aPosMaxY];
	MaxZ = AreaInfo[areaid][aPosMaxZ];
	return 1;
}
