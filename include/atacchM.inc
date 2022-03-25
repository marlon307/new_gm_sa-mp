

enum _spw
{
	pmodel[10],
	pbone[10],
	Float:pfX[10],
	Float:pfY[10],
	Float:pfZ[10],
	Float:prX[10],
	Float:prY[10],
	Float:prZ[10],
	Float:psX[10],
	Float:psY[10],
	Float:psZ[10],
	pUsingSlot[10]
}
new AttaCheP[MAX_PLAYERS][_spw];

/*public OnFilterScriptInit()
{
    format(Query, sizeof(Query), "CREATE TABLE IF NOT EXISTS `acessorios` (`Name` varchar(24) NOT NULL, `Slot` int(11) NOT NULL, `model` int(11) NOT NULL, \
  	`bone` int(11) NOT NULL, `fX` float NOT NULL, `fY` float NOT NULL, `fZ` float NOT NULL, `rX` float NOT NULL, `rY` float NOT NULL, `rZ` float NOT NULL, \
  	`sX` float NOT NULL, `sY` float NOT NULL, `sZ` float NOT NULL, `Enabled` int(11) NOT NULL) ENGINE=MyISAM DEFAULT CHARSET=latin1");

    mysql_query(MySql, Query, false);
	return 1;
} */

stock SetPlayerAtt(playerid,index, modelid, boneid,
                                   Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ,
                                   Float:fRotX, Float:fRotY, Float:fRotZ,
                                   Float:fScaleX, Float:fScaleY, Float:fScaleZ )
{
    AttaCheP[playerid][pmodel][index] = modelid;
    AttaCheP[playerid][pbone][index] = boneid;
    AttaCheP[playerid][pfX][index] = fOffsetX;
    AttaCheP[playerid][pfY][index] = fOffsetY;
    AttaCheP[playerid][pfZ][index] = fOffsetZ;
    AttaCheP[playerid][prX][index] = fRotX;
    AttaCheP[playerid][prY][index] = fRotY;
    AttaCheP[playerid][prZ][index] = fRotZ;
    AttaCheP[playerid][psX][index] = fScaleX;
    AttaCheP[playerid][psY][index] = fScaleY;
    AttaCheP[playerid][psZ][index] = fScaleZ;
    AttaCheP[playerid][pUsingSlot][index] = 1;
    SetPlayerAttachedObject(playerid,index,modelid,boneid,fOffsetX,fOffsetY,fOffsetZ,fRotX,fRotY,fRotZ,fScaleX,fScaleY,fScaleZ);
    return 1;
}

stock OnacessoriosLoad(playerid)
{
    new pName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pName, MAX_PLAYER_NAME);

    mysql_format(SqL, Query, sizeof(Query), "SELECT * FROM `acessorios` WHERE `Name` = '%s' LIMIT 10", pName);
    mysql_query(SqL,Query,true);

    if(IsPlayerConnected(playerid))
   	{
 		if(!cache_num_rows())
		{
		    for(new i; i < MAX_PLAYER_ATTACHED_OBJECTS; ++i)
		    {
				mysql_format(SqL,Query, sizeof(Query), "INSERT INTO `acessorios` (`Name`, `Index`) VALUES ('%s', %d)", pName, i);
                mysql_query(SqL, Query, false);

                for(new o; o != _:_spw; ++o)//http://forum.sa-mp.com/showthread.php?t=587095
                AttaCheP[playerid][_spw:o] = 0;
			}
		}
   		else
   		{
            for(new x; x < MAX_PLAYER_ATTACHED_OBJECTS; ++x)
   		    {
                cache_get_value_int(x, "Enabled", AttaCheP[playerid][pUsingSlot][x]);

                if(AttaCheP[playerid][pUsingSlot][x] != 0)
                {
                    cache_get_value_int(x, "model",AttaCheP[playerid][pmodel][x]);
    	   		    cache_get_value_int(x, "bone", AttaCheP[playerid][pbone][x]);
    	   		    cache_get_value_float(x, "fX", AttaCheP[playerid][pfX][x]);
    	   		    cache_get_value_float(x, "fY", AttaCheP[playerid][pfY][x]);
    	   		    cache_get_value_float(x, "fZ", AttaCheP[playerid][pfZ][x]);
    	   		    cache_get_value_float(x, "rX", AttaCheP[playerid][prX][x]);
    	   		    cache_get_value_float(x, "rY", AttaCheP[playerid][prY][x]);
    	   		    cache_get_value_float(x, "rZ", AttaCheP[playerid][prZ][x]);
    	   		    cache_get_value_float(x, "sX", AttaCheP[playerid][psX][x]);
    	   		    cache_get_value_float(x, "sY", AttaCheP[playerid][psY][x]);
    	   		    cache_get_value_float(x, "sZ", AttaCheP[playerid][psZ][x]);
                }
            }
		}
  	}
    return 1;
}

stock SetPlayerObjects(playerid)
{
    for(new i; i < MAX_PLAYER_ATTACHED_OBJECTS; ++i)
    {
        if(AttaCheP[playerid][pmodel][i] > 18000)
        {
            if(AttaCheP[playerid][pUsingSlot][i] == 1)
            {
        		SetPlayerAttachedObject(playerid, i, AttaCheP[playerid][pmodel][i], AttaCheP[playerid][pbone][i], AttaCheP[playerid][pfX][i], AttaCheP[playerid][pfY][i], AttaCheP[playerid][pfZ][i],
        		AttaCheP[playerid][prX][i], AttaCheP[playerid][prY][i], AttaCheP[playerid][prZ][i], AttaCheP[playerid][psX][i], AttaCheP[playerid][psY][i], AttaCheP[playerid][psZ][i]);
			}
        }
    }
    return 1;
}

stock SavePObjects(playerid, index)
{
    new pName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pName, MAX_PLAYER_NAME);

	if(index < MAX_PLAYER_ATTACHED_OBJECTS)
	{
	    mysql_format(SqL,Query, sizeof(Query), "UPDATE `acessorios` SET `model` = %d, `bone` = %d, `fX` = %f, `fY` = %f, `fZ` = %f, `rX` = %f, `rY` = %f, `rZ` = %f, `sX` = %f, `sY` = %f, `sZ` = %f, `Enabled` = %d WHERE `Name` = '%s' AND `Index` = %d",
        AttaCheP[playerid][pmodel][index],
	    AttaCheP[playerid][pbone][index],
	    AttaCheP[playerid][pfX][index],
	    AttaCheP[playerid][pfY][index],
	    AttaCheP[playerid][pfZ][index],
	    AttaCheP[playerid][prX][index],
	    AttaCheP[playerid][prY][index],
	    AttaCheP[playerid][prZ][index],
	    AttaCheP[playerid][psX][index],
	    AttaCheP[playerid][psY][index],
	    AttaCheP[playerid][psZ][index],
	    AttaCheP[playerid][pUsingSlot][index],pName,index);
        mysql_query(SqL,Query,true);
	}
    return 1;
}

stock RemovePlayerObj(playerid,index)
{
     AttaCheP[playerid][pUsingSlot][index] = 0;
     SavePObjects(playerid, index);
     return 1;
}

stock ResetHoldObjects(playerid)
{
    for(new i; i < MAX_PLAYER_ATTACHED_OBJECTS; ++i)
	{
        AttaCheP[playerid][pUsingSlot][i] = 0;
        AttaCheP[playerid][pmodel][i] = 0;
	    AttaCheP[playerid][pbone][i] = 0;
	    AttaCheP[playerid][pfX][i] = 0;
	    AttaCheP[playerid][pfY][i] = 0;
	    AttaCheP[playerid][pfZ][i] = 0;
	    AttaCheP[playerid][prX][i] = 0;
	    AttaCheP[playerid][prY][i] = 0;
	    AttaCheP[playerid][prZ][i] = 0;
	    AttaCheP[playerid][psX][i] = 0;
	    AttaCheP[playerid][psY][i] = 0;
	    AttaCheP[playerid][psZ][i] = 0;
	}
    return 1;
}
