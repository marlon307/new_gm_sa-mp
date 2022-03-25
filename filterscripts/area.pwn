#include 	<a_samp>
#include 	<zcmd>

#define 	DIALOG_IPIA_MAKER    (204)
#define     DIALOG_IPIA_SAVE     (205)


#define ResetAll() for(new i;i < 4;i++) AreaInfo[i] = 0.0

new Float:AreaInfo[6];

CMD:area(playerid, params[])
{
	return ShowPlayerDialog(playerid, DIALOG_IPIA_MAKER, DIALOG_STYLE_LIST, "IsPlayerInArea Maker", "Save the first point\nSave the second point\n{F58282}Create IsPlayerInArea\nReset All points, and Save Again", "Select", "Cancel"), 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch (dialogid)
	{
	    case DIALOG_IPIA_MAKER:
	    {
	    	if(!response) return 0;
			switch(listitem)
			{
				case 0:
				{
				    GetPlayerPos(playerid, AreaInfo[0], AreaInfo[1], AreaInfo[2]);
				    SendClientMessage(playerid, 0xCC9900FF, "Minimum X and Y and Z created.");
				}
				case 1:
				{
				    GetPlayerPos(playerid, AreaInfo[3], AreaInfo[4], AreaInfo[5]);
				    SendClientMessage(playerid, 0xCC9900FF, "Maximum X and Y and Z created.");
				}
				case 2:	ShowPlayerDialog(playerid, DIALOG_IPIA_SAVE, DIALOG_STYLE_INPUT, " ", "{F58282}Type the file name inside the box", "Save", "Cancel");
				default:
				{
					if(!IsUseOne() && !IsUseTwo()) return SendClientMessage(playerid, 0xFF0000FF, "you cannot reset the point until you save some point!");

					ResetAll();
		    		SendClientMessage(playerid, 0xCC9900FF, "The points has reseted successfully!");
				}
			}
	    }
		case DIALOG_IPIA_SAVE:
		{
			if(!response) return ShowPlayerDialog(playerid, DIALOG_IPIA_MAKER, DIALOG_STYLE_LIST, "IsPlayerInArea Maker", "Save the first point\nSave the second point\n{F58282}Create IsPlayerInArea\nReset All points, and Save Again", "Select", "Cancel"), 1;
			if(!IsUseOne() && !IsUseTwo()) return SendClientMessage(playerid, 0xFF0000FF, "You have to save two points!");
	  	  	if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_IPIA_SAVE, DIALOG_STYLE_INPUT, " ", "{F58282}Type the file name inside the box", "Save", "Cancel");

			new string[128];
			new filename[64];
			format(filename, sizeof(filename), "IsPlayerInArea_%s.ini", inputtext);
		    format(string, sizeof(string), "IsPlayerInArea(playerid, %f, %f,%f, %f, %f,%f);\r\n",
				(AreaInfo[0] < AreaInfo[3]) ? AreaInfo[0] : AreaInfo[3],
				(AreaInfo[1] < AreaInfo[4]) ? AreaInfo[1] : AreaInfo[4],
				(AreaInfo[2] < AreaInfo[5]) ? AreaInfo[2] : AreaInfo[5],
				(AreaInfo[0] > AreaInfo[3]) ? AreaInfo[0] : AreaInfo[3],
				(AreaInfo[1] > AreaInfo[4]) ? AreaInfo[1] : AreaInfo[4],
				(AreaInfo[2] > AreaInfo[5]) ? AreaInfo[2] : AreaInfo[5]
			);

			new File:pos=fopen(filename, io_append);
		    fwrite(pos, string);
		    fclose(pos);

		    new dialogstring[128];
		    format(dialogstring, sizeof(dialogstring), "\nIsPlayerInArea saved under the name {F58282}IsPlayerInArea_%s.ini {a9c4e4}inside the scriptfiles folder!\n", inputtext);
		    ShowPlayerDialog(playerid, 206, DIALOG_STYLE_MSGBOX, " ", dialogstring, "Exit", "");
			ResetAll();
		}
	}
	return 1;
}

stock IsUseOne() return AreaInfo[0] != 0.0 ? true:false;
stock IsUseTwo() return AreaInfo[3] != 0.0 ? true:false;

stock IsPlayerInArea(playerid, Float:MinX, Float:MinY, Float:MinZ,Float:MaxX, Float:MaxY,Float:MaxZ)
{
    new Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    return (X >= MinX && X <= MaxX && Y >= MinY && Y <= MaxY  && Z >= MinZ && Z <= MaxZ) ? 1 : 0;
}
