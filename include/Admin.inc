/*  Brasil Cidade Livre Admin Functions
 *
 *  (c) Copyright 2014-2014, BCL (RPG)
 *
 */

#if defined _admin_included
	#endinput
#endif
#define _admin_included
#pragma library admin

#define tcadm 0x33AAFFFF

new admin[MAX_PLAYERS];
new pAdmin[MAX_PLAYERS];

stock PlayerSetPlayerAdmin(playerid, plid, lvl)
{
    new string[150];
    mysql_format(SqL,Query, sizeof(Query), "UPDATE `contas` SET `aAdmin` = '%d', `Admin` = '%d' WHERE `usuario` = '%s'", 1, lvl, GetName(plid));
    mysql_query(SqL, Query, true);

    if(playerid != -1)
    {
        if(lvl >= 1)
        {
            admin[plid] = 1;
            pAdmin[plid] = lvl;
            format(string, sizeof(string), "%s (%d) (») Promoveu: %s (%d) para ADM (») Level: %d", GetName(playerid), playerid, GetName(plid), plid, lvl);
        }
        if(lvl == 0)
        {
            admin[plid] = 0;
            pAdmin[plid] = 0;
            format(string, sizeof(string), "%s (%d) (») Retirou ADM do(a): %s (%d)", GetName(playerid), playerid, GetName(plid), plid);
        }
    }
    else
    {
        if(lvl >= 1)
        {
            admin[plid] = 1;
            pAdmin[plid] = lvl;
            format(string, sizeof(string), "Swit_Cj. (») Promoveu: %s (%d) para ADM (») Level: %d", GetName(plid), plid, lvl);
        }
        if(lvl == 0)
        {
            admin[plid] = 0;
            pAdmin[plid] = 0;
            format(string, sizeof(string), "Swit_CJ. (») Retirou ADM do(a): %s (%d)", GetName(plid), plid);
        }
    }
    SendClientMessageToAll(tcadm, string);
    return 1;
}
