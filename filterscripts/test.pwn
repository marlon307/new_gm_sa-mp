#include <a_samp>
#include <a_http>

#define HostURL "yu-ki-ko.com/fsns/Host.php?IP=" // Leave it like this if you ain't hosting the php file

public OnFilterScriptInit()
{
	print("GetPlayerHost by [L3th4l] loaded.");
	return 1;
}

public OnFilterScriptExit()
{
	print("GetPlayerHost by [L3th4l] unloaded.");
	return 1;
}

public OnPlayerConnect(playerid)
{
	new
	    pIP[16];

	GetPlayerIp(playerid, pIP, sizeof(pIP));

	new
	    iStr[150];

	format(iStr, sizeof(iStr), ""HostURL"%s", pIP);

	HTTP(playerid, HTTP_GET, iStr, "", "OnHostResponse");
	return 1;
}

forward OnHostResponse(iIndex, response_code, const Data[]);
public OnHostResponse(iIndex, response_code, const Data[])
{
	new
		szBuffer[128];

	if(response_code == 200)
	{
	    format(szBuffer, sizeof(szBuffer), "Your host is {7EB339}%s", Data);
	    SendClientMessage(iIndex, -1, szBuffer);
	}
	else
	{
	    format(szBuffer, sizeof(szBuffer), "Can't send your request. {C21F1F}Response_Code: %i", response_code);
	    SendClientMessage(iIndex, -1, szBuffer);
	}
}
