/*==============================================================================
 				SetPlayerAttachedObject script by Richie©
 		  		 Based on the Attachments script by h02
==============================================================================*/
#include <a_samp>
#include <zcmd>
#include <a_mysql>

enum _spw
{
	pUserName[24],
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
new MySql;

public OnFilterScriptInit()
{
	new Query[450];

    format(Query, sizeof(Query), "CREATE TABLE IF NOT EXISTS `acessorios` (`Name` varchar(24) NOT NULL, `Slot` int(11) NOT NULL, `model` int(11) NOT NULL, \
  	`bone` int(11) NOT NULL, `fX` float NOT NULL, `fY` float NOT NULL, `fZ` float NOT NULL, `rX` float NOT NULL, `rY` float NOT NULL, `rZ` float NOT NULL, \
  	`sX` float NOT NULL, `sY` float NOT NULL, `sZ` float NOT NULL, `Enabled` int(11) NOT NULL) ENGINE=MyISAM DEFAULT CHARSET=latin1");
    mysql_query(MySql,Query,false);
	return 1;
}

public OnPlayerEditAttachedObject( playerid, response, index, modelid, boneid,
                                   Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ,
                                   Float:fRotX, Float:fRotY, Float:fRotZ,
                                   Float:fScaleX, Float:fScaleY, Float:fScaleZ )
{
    SendClientMessage(playerid, -1, "{0BDDC4}[Hold Objects]{FFFFFF} Editing of object done.");
    SetPlayerAttachedObject(playerid,index,modelid,boneid,fOffsetX,fOffsetY,fOffsetZ,fRotX,fRotY,fRotZ,fScaleX,fScaleY,fScaleZ);

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

    SavePObjects(playerid, index);
    return 1;
}

forward Initializeacessorios(playerid);
public Initializeacessorios(playerid)
{
    new Query[160];
    new pName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
   // mysql_format(MySql, Query, sizeof(Query), "SELECT * FROM `contas` WHERE `usuario` = '%s'",pName);
    mysql_format(MySql, Query, sizeof(Query), "SELECT * FROM `acessorios` WHERE `Name` = '%s' LIMIT 10", pName);
	mysql_function_query(MySql, Query, true, "OnacessoriosLoad", "d", playerid);
}

forward OnacessoriosLoad(playerid);
public OnacessoriosLoad(playerid)
{
    new pName[MAX_PLAYER_NAME],Query[160];
    GetPlayerName(playerid, pName, MAX_PLAYER_NAME);

    mysql_format(MySql, Query, sizeof(Query), "SELECT * FROM `acessorios` WHERE `Name` = '%s' LIMIT 10", pName);
    mysql_query(MySql,Query,true);

    if(IsPlayerConnected(playerid))
   	{
	    new rows, fields;
 		cache_get_data(rows, fields);
 		if(!rows)
		{
            new EscName[MAX_PLAYER_NAME];
	    	mysql_real_escape_string(pName, EscName);
		    for(new i = 0; i < 10; i++)
		    {
				format(Query, sizeof(Query), "INSERT INTO `acessorios` (`Name`, `Slot`) VALUES ('%s', %d)", EscName, i);
				mysql_function_query(MySql, Query, false, "NoReturnThread", "d", playerid);

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
			    AttaCheP[playerid][pUsingSlot][i] = 0;
			}
		}
   		else
   		{
   		    new Data[50];
   		    for(new x=0; x<rows; x++)
   		    {
	   		    cache_get_field_content(x, "model", Data), 						AttaCheP[playerid][pmodel][x]  = strval(Data);
	   		    cache_get_field_content(x, "bone", Data), 						AttaCheP[playerid][pbone][x] = strval(Data);
	   		    cache_get_field_content(x, "fX", Data),							AttaCheP[playerid][pfX][x] = floatstr(Data);
	   		    cache_get_field_content(x, "fY", Data),							AttaCheP[playerid][pfY][x] = floatstr(Data);
	   		    cache_get_field_content(x, "fZ", Data),							AttaCheP[playerid][pfZ][x] = floatstr(Data);
	   		    cache_get_field_content(x, "rX", Data),							AttaCheP[playerid][prX][x] = floatstr(Data);
	   		    cache_get_field_content(x, "rY", Data),							AttaCheP[playerid][prY][x] = floatstr(Data);
	   		    cache_get_field_content(x, "rZ", Data), 						AttaCheP[playerid][prZ][x] = floatstr(Data);
	   		    cache_get_field_content(x, "sX", Data),							AttaCheP[playerid][psX][x] = floatstr(Data);
	   		    cache_get_field_content(x, "sY", Data),							AttaCheP[playerid][psY][x] = floatstr(Data);
	   		    cache_get_field_content(x, "sZ", Data),							AttaCheP[playerid][psZ][x] = floatstr(Data);
	   		    cache_get_field_content(x, "Enabled", Data),					AttaCheP[playerid][pUsingSlot][x] = strval(Data);
			}
		}
  	}
    return 1;
}

stock Setacessorios(playerid)
{
    for(new i=0; i<10; i++)
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
}

stock SavePObjects(playerid, slotid)
{
    new
		Query[1024], EscName[MAX_PLAYER_NAME];

	new index = slotid;

	if(index < 10)
	{
        new pName[MAX_PLAYER_NAME];
        GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
        mysql_real_escape_string(pName, EscName);

	    format(Query, sizeof(Query), "UPDATE `acessorios` SET `model` = %d, `bone` = %d, `fX` = %f, `fY` = %f, `fZ` = %f, `rX` = %f, `rY` = %f, `rZ` = %f, `sX` = %f, `sY` = %f, `sZ` = %f, `Enabled` = %d WHERE `Name` = '%s' AND `Slot` = %d",
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
	    AttaCheP[playerid][pUsingSlot][index],
		EscName,
	 	index);

        mysql_query(MySql,Query,false);
	}
}

stock ResetHoldObjects(playerid)
{
	for(new i = 0; i < 10; i++)
	{
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
	    AttaCheP[playerid][pUsingSlot][i] = 0;
	}
}
