/* SA-MP Include Some-Functions
 *
 * (c) by Kaliber, 2015
 *
 */
#if !defined _samp_included
    #include <a_samp>
#endif
#if defined _samp_func
    #endinput
#endif
#define _samp_func
#if !defined URL_SIZE
	#define URL_SIZE 64
#endif
#define A:: P_Q_AS_D_
#define P_Q_AS_D_Z(%0,%1) %0[0]='\0',strpack(%0,%1,URL_SIZE)
/*
	native PlayAudioStreamForVehicle(vehicleid, const url[]);
	native StopAudioStreamForVehicle(vehicleid);
*/
forward A::OnPlayerStateChange(playerid, newstate, oldstate);
enum A::E {
	bool:A::b, A::u[URL_SIZE char]
};
static A::S[MAX_VEHICLES][A::E];

stock PlayAudioStreamForVehicle(vehicleid, const url[]) {
	if(vehicleid <= 0 || vehicleid >= MAX_VEHICLES) return print(!"AudioStream: Invalid vehicleid!"),0;
	if(!url[0]) return print(!"AudioStream: Invalid URL!"),0;
	return A::S[vehicleid][A::b] = true,A::Z(A::S[vehicleid][A::u],url),1;
}
stock StopAudioStreamForVehicle(vehicleid) {
    if(vehicleid <= 0 || vehicleid >= MAX_VEHICLES) return print(!"StopAudioStream: Invalid vehicleid!"),0;
    for(new i; i<MAX_PLAYERS; ++i) if(IsPlayerInVehicle(i,vehicleid)) StopAudioStreamForPlayer(i);
    return A::S[vehicleid][A::b]=false,1;
}

public OnPlayerStateChange(playerid, newstate, oldstate) {
	switch(newstate) {
	    case PLAYER_STATE_DRIVER,PLAYER_STATE_PASSENGER: {
	        new v = GetPlayerVehicleID(playerid);
	        if(!A::S[v][A::b]) return CallLocalFunction("P_Q_AS_D_OnPlayerStateChange","ddd",playerid,newstate,oldstate);
	       	PlayAudioStreamForPlayer(playerid,A::un(A::S[v][A::u]),0.0,0.0,0.0,20.0);
	    }
	    case PLAYER_STATE_ONFOOT: StopAudioStreamForPlayer(playerid);
	}
	return CallLocalFunction("P_Q_AS_D_OnPlayerStateChange","ddd",playerid,newstate,oldstate);
}
#if defined _ALS_OnPlayerStateChange
	#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange P_Q_AS_D_OnPlayerStateChange
stock A::un(const string[]) {
	new tmp[URL_SIZE];
	return strunpack(tmp,string,URL_SIZE),tmp;
}
#if defined Remove_Button_Spawn
	forward A::OnPlayerRequestClass(playerid,classid);
	public OnPlayerRequestClass(playerid,classid)
		return SetSpawnInfo(playerid,0,299,0,0,3,0,0,0,0,0,0,0),SpawnPlayer(playerid);
	#if defined _ALS_OnPlayerRequestClass
		#undef OnPlayerRequestClass
	#else
		#define _ALS_OnPlayerRequestClass
	#endif
	#define OnPlayerRequestClass P_Q_AS_D_OnPlayerRequestClass
#endif
