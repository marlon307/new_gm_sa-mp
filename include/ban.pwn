#define MOTIVE_RCON                                                            1
#define MOTIVE_INSULTO                                                         2
#define MOTIVE_HACK                                                            3
stock _Ban(playerid, motivo)
{
    new str[128],IP[16],pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
    GetPlayerIp(playerid,IP,sizeof(IP));
    switch(motivo)
    {
        case MOTIVE_RCON: format(str, sizeof(str), "{00FFFF}ID: %d \n{FF8040}IP: %d \n{3C3CFF}Nick: %s \n{FFFFFF}Você foi banido \npor tentar logar na RCON",playerid,IP,pName);
        case MOTIVE_INSULTO: format(str, sizeof(str), "{00FFFF}ID: %d \n{FF8040}IP: %d \n{3C3CFF}Nick: %s \n{FFFFFF}Você foi banido por\ninsultar o server",playerid,IP,pName);
        case MOTIVE_HACK: format(str, sizeof(str), "{00FFFF}ID: %d \n{FF8040}IP: %d \n{3C3CFF}Nick: %s \n{FFFFFF}Você foi banido por\nusar {FF0000}HACK",playerid,IP,pName);
    }
    ShowPlayerDialog(playerid, DIALOG_BANS, DIALOG_STYLE_MSGBOX, "{FF0000}Notificação", str, "Close", "");
    return Ban(playerid);
}
