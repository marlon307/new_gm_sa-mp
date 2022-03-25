/*     SA-MP [SaveAt.inc]
 *     pawn(Marlon307)
 *     Aproveite a include.
 *     Duvidas opiniões palpites criticas para melhorar a include e só posta no forum
 *     LINK:   forum.sa-mp.com/showthread.php?p=3163589#post3163589
 */

#define PASTA_ACESSORIOS                          "/Acessorios/Acessorio_%s.ini"
#define MAX_ATTCHP                                                             4

#if defined _SaveAt_included
	#endinput
#endif
#define _SaveAt_included
#pragma library SaveAt

/*native SaveAttacheplayer(playerid, varAdmin = 1, varVip = 1, index,modelid, boneid,Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ,Float:fRotX, Float:fRotY, Float:fRotZ,Float:fScaleX, Float:fScaleY, Float:fScaleZ);
native LoadAttacheplayer(playerid, varAdmin = 1, varVip = 1);
native RemoveSlotAttached(playerid,index);*/

enum AtachhP
{
    bool:Used,
    ModeloID,
    BoneID,
    Float:ApX,
    Float:ApY,
    Float:ApZ,
    Float:ArX,
    Float:ArY,
    Float:ArZ,
    Float:AeX,
    Float:AeY,
    Float:AeZ
};
new AttaCheP[MAX_PLAYERS][MAX_PLAYER_ATTACHED_OBJECTS][AtachhP];

stock SaveAttacheplayer(playerid,index,modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ,Float:fRotX, Float:fRotY, Float:fRotZ,Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
    new pName[MAX_PLAYER_NAME] /*,slots*/;
	GetPlayerName(playerid, pName, MAX_PLAYER_NAME);

	AttaCheP[playerid][index][Used] = true;
	AttaCheP[playerid][index][ModeloID] = modelid;
	AttaCheP[playerid][index][BoneID] = boneid;
	AttaCheP[playerid][index][ApX] = fOffsetX;
	AttaCheP[playerid][index][ApY] = fOffsetY;
	AttaCheP[playerid][index][ApZ] = fOffsetZ;
	AttaCheP[playerid][index][ArX] = fRotX;
	AttaCheP[playerid][index][ArY] = fRotY;
	AttaCheP[playerid][index][ArZ] = fRotZ;
	AttaCheP[playerid][index][AeX] = fScaleX;
	AttaCheP[playerid][index][AeY] = fScaleY;
	AttaCheP[playerid][index][AeZ] = fScaleZ;

	SetPlayerAttachedObject(playerid,index,AttaCheP[playerid][index][ModeloID],
	AttaCheP[playerid][index][BoneID], AttaCheP[playerid][index][ApX],
	AttaCheP[playerid][index][ApY], AttaCheP[playerid][index][ApZ],
	AttaCheP[playerid][index][ArX], AttaCheP[playerid][index][ArY],
	AttaCheP[playerid][index][ArZ], AttaCheP[playerid][index][AeX],
	AttaCheP[playerid][index][AeY], AttaCheP[playerid][index][AeZ]);

/*	if(varAdmin > 0 || varVip > 0)
	slots = MAX_PLAYER_ATTACHED_OBJECTS;
	else slots = MAX_ATTCHP; */

    for(new i; i < MAX_PLAYER_ATTACHED_OBJECTS; ++i)
	{
        mysql_format(MySql, Query, sizeof(Query), "UPDATE `acessorios` SET `%d_ApZ` = '%f' WHERE `usuario` = '%s'", AttaCheP[playerid][i][ApZ],pName);
		mysql_query(MySql, Query, true);
	}
    return 1;
}

stock LoadAttacheplayer(playerid, varAdmin = 1, varVip = 1)
{
    new pName[MAX_PLAYER_NAME], file[100], strText[15], slots;
	GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
	format(file, sizeof(file), PASTA_ACESSORIOS, pName);
	if(DOF2::FileExists(file))
	{
		if(varAdmin > 0 || varVip > 0)
		slots = MAX_PLAYER_ATTACHED_OBJECTS;
		else slots = MAX_ATTCHP;
		for(new i; i < slots; i++)
		{
			format(strText, 15, "%d_Used", i);
			AttaCheP[playerid][i][Used] = bool:DOF2::GetInt(file,strText);

            if(AttaCheP[playerid][i][Used] == true)
			{
				format(strText, 15, "%d_Modelo", i);
				AttaCheP[playerid][i][ModeloID] = DOF2::GetInt(file,strText);
				format(strText, 15, "%d_Bone", i);
				AttaCheP[playerid][i][BoneID] = DOF2::GetInt(file,strText);
				format(strText, 15, "%d_ApX", i);
				AttaCheP[playerid][i][ApX] = DOF2::GetFloat(file,strText);
				format(strText, 15, "%d_ApY", i);
				AttaCheP[playerid][i][ApY] = DOF2::GetFloat(file,strText);
				format(strText, 15, "%d_ApZ", i);
				AttaCheP[playerid][i][ApZ] = DOF2::GetFloat(file,strText);
				format(strText, 15, "%d_ArX", i);
				AttaCheP[playerid][i][ArX] = DOF2::GetFloat(file,strText);
				format(strText, 15, "%d_ArY", i);
				AttaCheP[playerid][i][ArY] = DOF2::GetFloat(file,strText);
				format(strText, 15, "%d_ArZ", i);
				AttaCheP[playerid][i][ArZ] = DOF2::GetFloat(file,strText);
				format(strText, 15, "%d_AeX", i);
				AttaCheP[playerid][i][AeX] = DOF2::GetFloat(file,strText);
				format(strText, 15, "%d_AeY", i);
				AttaCheP[playerid][i][AeY] = DOF2::GetFloat(file,strText);
				format(strText, 15, "%d_AeZ", i);
				AttaCheP[playerid][i][AeZ] = DOF2::GetFloat(file,strText);

                SetPlayerAttachedObject(playerid,i,AttaCheP[playerid][i][ModeloID],
				AttaCheP[playerid][i][BoneID], AttaCheP[playerid][i][ApX],
				AttaCheP[playerid][i][ApY], AttaCheP[playerid][i][ApZ],
				AttaCheP[playerid][i][ArX], AttaCheP[playerid][i][ArY],
				AttaCheP[playerid][i][ArZ], AttaCheP[playerid][i][AeX],
				AttaCheP[playerid][i][AeY], AttaCheP[playerid][i][AeZ]);
			}
		}
	}else{
        for(new i; i < MAX_PLAYER_ATTACHED_OBJECTS; i++)
        {
            AttaCheP[playerid][i][Used] = false;
            AttaCheP[playerid][i][ModeloID] = 0;
            AttaCheP[playerid][i][BoneID] = 0;
            AttaCheP[playerid][i][ApX] = 0;
            AttaCheP[playerid][i][ApY] = 0;
            AttaCheP[playerid][i][ApZ] = 0;
            AttaCheP[playerid][i][ArX] = 0;
            AttaCheP[playerid][i][ArY] = 0;
            AttaCheP[playerid][i][ArZ] = 0;
            AttaCheP[playerid][i][AeX] = 0;
            AttaCheP[playerid][i][AeY] = 0;
            AttaCheP[playerid][i][AeZ] = 0;
        }
    }
    return 1;
}

stock RemoveSlotAttached(playerid, index)
{
	new pName[MAX_PLAYER_NAME],file[40],strText[15];
	GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
	format(file, sizeof(file), PASTA_ACESSORIOS, pName);
	if(DOF2::FileExists(file))
    {
        format(strText, 15, "%d_Used", index);
		DOF2::SetInt(file, strText, false);
        RemovePlayerAttachedObject(playerid, index);
        DOF2::SaveFile();
    }
    return 1;
}
