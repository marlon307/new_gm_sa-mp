/*  BCL vip's Functions
 *
 *  (c) Copyright 2012-2012, BCL Team
 *
 */

#if defined _vips_included
	#endinput
#endif
#define _vips_included
#pragma library vips

/*
native SetPlayerVIP(playerid, days);
native UnsetPlayerVIP(playerid);
native RenameFileVIP(oldfile[], newfile[]);
native CheckPlayerVIP(playerid);
native GetVIPDays(playerid);
native IsPlayerVIP(playerid);
*/

new vip[MAX_PLAYERS];
//new filev[128];
//new filev2[128];

stock SetPlayerVIP(playerid, days)
{
	if(IsPlayerConnected(playerid))
	{
		new VIPS[128], ACCS[128], STRV[128];

		new year, month, day;
		getdate(year, month, day);

		format(VIPS, sizeof(VIPS), PASTA_VIPS, GetName(playerid));
		if(!DOF2::FileExists(VIPS))
		{
			DOF2::CreateFile(VIPS);
		}
		DOF2::SetInt(VIPS, "Dias", DOF2::GetInt(VIPS, "Dias")+days);
		format(STRV, sizeof(STRV), "%d/%d/%d", day, month, year);
		DOF2::SetString(VIPS, "DataSet", STRV);

		format(ACCS, sizeof(ACCS), PASTA_CONTAS, GetName(playerid));
		DOF2::SetInt(ACCS, "UsouConce", 0);
		DOF2::SetInt(ACCS, "VIP", 1);
		vip[playerid] = 1;
        DOF2::SaveFile();
	}
	return 1;
}

stock RenameFileVIP(oldfile[], newfile[])
{
	new mndias;
	new mndataset[100];
	new mnusouconce;
	new mnvip;

	mndias = DOF2::GetInt(oldfile, "Dias");
	mndataset = DOF2::GetString(oldfile, "DataSet");
	mnusouconce = DOF2::GetInt(oldfile, "UsouConce");
	mnvip = DOF2::GetInt(oldfile, "VIP");
	DOF2::RemoveFile(oldfile);

	DOF2::CreateFile(newfile);
	DOF2::SetInt(newfile, "Dias", mndias);
	DOF2::SetString(newfile, "DataSet", mndataset);
	DOF2::SetInt(newfile, "UsouConce", mnusouconce);
	DOF2::SetInt(newfile, "VIP", mnvip);
    DOF2::SaveFile();
	return 1;
}

stock UnsetPlayerVIP(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new VIPS[128], ACCS[128];

		format(VIPS, sizeof(VIPS), PASTA_VIPS, GetName(playerid));
		if(DOF2::FileExists(VIPS))
		{
			DOF2::RemoveFile(VIPS);
		}
        format(ACCS, sizeof(ACCS), PASTA_CONTAS, GetName(playerid));
        vip[playerid] = 0;
        DOF2::SetInt(ACCS, "VIP", 0);
    }
	return 1;
}

stock CheckPlayerVIP(playerid)
{
	new VIPS[128], ACCS[128], STRV[128];

	new year, month, day;
	getdate(year, month, day);

	format(ACCS, sizeof(ACCS), PASTA_CONTAS, GetName(playerid));
	if(DOF2::FileExists(ACCS))
	{
		format(VIPS, sizeof(VIPS), PASTA_VIPS, GetName(playerid));
		if(DOF2::FileExists(VIPS))
		{
			format(STRV, sizeof(STRV), "%d/%d/%d", day, month, year);
			if(strcmp(DOF2::GetString(VIPS, "DataSet"), STRV, true) != 0)
			{
				DOF2::SetString(VIPS, "DataSet", STRV);
				DOF2::SetInt(VIPS, "Dias", DOF2::GetInt(VIPS, "Dias")-1);
                DOF2::SaveFile();
			}
			if(DOF2::GetInt(VIPS, "Dias") > 0)
			{
				#if defined AntiCheatUser
				CheckSet(0, playerid, false);
				SetWeaponAllowed(playerid, 38, true);
				SetWeaponAllowed(playerid, 35, true);
				SetWeaponAllowed(playerid, 36, true);
				SetWeaponAllowed(playerid, 37, true);
				SetWeaponAllowed(playerid, 39, true);
				SetWeaponAllowed(playerid, 40, true);
				#endif

                vip[playerid] = 1;
				DOF2::SetInt(ACCS, "VIP", 1);
			}
			else
			{
                UnsetPlayerVIP(playerid);
                vip[playerid] = 0;
				SendClientMessage(playerid, -1, "Seus dias de VIP acabaram!");
				SendClientMessage(playerid, -1, "Compre mais e divirta-se.");

                #if defined AntiCheatUser
				CheckSet(0, playerid, true);
				SetWeaponAllowed(playerid, 38, false);
				SetWeaponAllowed(playerid, 35, false);
				SetWeaponAllowed(playerid, 36, false);
				SetWeaponAllowed(playerid, 37, false);
				SetWeaponAllowed(playerid, 39, false);
				SetWeaponAllowed(playerid, 40, false);
				#endif
			}
		}
		else
		{
            vip[playerid] = 0;
			DOF2::SetInt(ACCS, "VIP", 0);
            vip[playerid] = 0;

            #if defined AntiCheatUser
			CheckSet(0, playerid, true);
			SetWeaponAllowed(playerid, 38, false);
			SetWeaponAllowed(playerid, 35, false);
			SetWeaponAllowed(playerid, 36, false);
			SetWeaponAllowed(playerid, 37, false);
			SetWeaponAllowed(playerid, 39, false);
			SetWeaponAllowed(playerid, 40, false);
			#endif
		}
	}
    else vip[playerid] = 0;
	return 1;
}

stock GetVIPDays(playerid)
{
	new VIPS[128];

	format(VIPS, sizeof(VIPS), PASTA_VIPS, GetName(playerid));
	if(DOF2::FileExists(VIPS))
	{
		return DOF2::GetInt(VIPS, "Dias");
	}
	else return 0;
}

stock IsPlayerVIP(playerid)
{
    return vip[playerid];
}
