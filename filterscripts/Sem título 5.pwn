





forward GangZoneCreateEx(Float:pX,Float:pY,Float:Size,gangzone);
public GangZoneCreateEx(Float:pX,Float:pY,Float:Size,gangzone)
{
    gangzone = GangZoneCreate(pX-Size,pY-Size,pX+Size,pY+Size);
    return 1;
}


stock GetPlayerGangZone(playerid,gangzone)
{
    new Float:X,Float:Y,Float:Z;
    GetPlayerPos(playerid,X,Y,Z);
    if((X < GANG_X_MAX) && (X > GAME_X_MIN) && (Y < GANG_Y_MAX) && (Y > GANG_Y_MIN))
    {
        return 1;
    }
    return 0;
}




new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
if((X < GANG_X_MAX) && (X > GAME_X_MIN) && (Y < GANG_Y_MAX) && (Y > GANG_Y_MIN))
{
  //He's in the gang zone
}
