/*
================================
|		Xenon Library          |
================================
*  Versão: 1.0
*  Creditos:
*  Baseado no "Xenon Extremo" de romerorodriges
*  Editado por King_Vegeta

* Natives:
native AttachXenonToVehicle(vehicleid, XenonColor);
native DestroyXenon(vehicleid);
native DestroyAllXenon();
*/
#include <a_samp>
#if defined _xLibrary_included
#endinput
#endif
#define _xLibrary_included
#pragma library xLibrary

#define 		Azul                    1
#define 		Verde              		2
#define 		Vermelho           		3
#define 		Branco             		4
#define 		Violeta         	    5
#define		    VerdeLimao  	        6
#define 		Rosa                    7
#define 		Purpura            		8
#define 		Amarelo            		9
#define 		Aqua               		10

new
xenonazul[8][MAX_VEHICLES],
xenonverde[8][MAX_VEHICLES],
xenonbranco[8][MAX_VEHICLES],
xenonvermelho[8][MAX_VEHICLES]
;

stock AttachXenonToVehicle( vehicleid, XenonColor )
{
	if(BadVehicleXenon(vehicleid))
	{
		print("ERROR: Veiculo nao suporta Xenon.");
		return 1;
	}
	DestroyXenon(vehicleid);

	switch(XenonColor)
	{
		case Azul:
		{
			AzulOne(vehicleid);
			AzulTwo(vehicleid);
		}
		case Verde:
		{
			VerdeOne(vehicleid);
			VerdeTwo(vehicleid);
		}
		case Vermelho:
		{
			VermelhoOne(vehicleid);
			VermelhoTwo(vehicleid);
		}
		case Branco:
		{
			BrancoOne(vehicleid);
			BrancoTwo(vehicleid);
		}
		case Violeta:
		{
			BrancoOne(vehicleid);
			BrancoTwo(vehicleid);
			AzulOne(vehicleid);
			AzulTwo(vehicleid);
		}
		case VerdeLimao:
		{
			BrancoOne(vehicleid);
			BrancoTwo(vehicleid);
			VerdeOne(vehicleid);
			VerdeTwo(vehicleid);
		}
		case Rosa:
		{
			BrancoOne(vehicleid);
			BrancoTwo(vehicleid);
			VermelhoOne(vehicleid);
			VermelhoTwo(vehicleid);
		}
		case Purpura:
		{
			VermelhoOne(vehicleid);
			VermelhoTwo(vehicleid);
			AzulOne(vehicleid);
			AzulTwo(vehicleid);
		}
		case Amarelo:
		{
			VermelhoOne(vehicleid);
			VermelhoTwo(vehicleid);
			VerdeOne(vehicleid);
			VerdeTwo(vehicleid);
		}
		case Aqua:
		{
			VerdeOne(vehicleid);
			VerdeTwo(vehicleid);
			AzulOne(vehicleid);
			AzulTwo(vehicleid);
		}
		default:
		{
			print("ERROR: Xenon Invalido.");
		}
	}
	return 1;
}

stock BrancoOne(vehicleid)
{
	xenonbranco[0][vehicleid] = CreateObject(19295,0,0,0,0,0,0);
	xenonbranco[1][vehicleid] = CreateObject(19295,0,0,0,0,0,0);
	xenonbranco[2][vehicleid] = CreateObject(19295,0,0,0,0,0,0);
	xenonbranco[3][vehicleid] = CreateObject(19295,0,0,0,0,0,0);
	AttachObjectToVehicle(xenonbranco[0][vehicleid], vehicleid, -1.0, 3.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonbranco[1][vehicleid], vehicleid, -1.0, 5.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonbranco[2][vehicleid], vehicleid, -1.0, 6.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonbranco[3][vehicleid], vehicleid, -1.0, 7.0, -0.8, 0.0, 0.0, 0.0);
	return 1;
}

stock BrancoTwo(vehicleid)
{
	xenonbranco[4][vehicleid] = CreateObject(19295,0,0,0,0,0,0);
	xenonbranco[5][vehicleid] = CreateObject(19295,0,0,0,0,0,0);
	xenonbranco[6][vehicleid] = CreateObject(19295,0,0,0,0,0,0);
	xenonbranco[7][vehicleid] = CreateObject(19295,0,0,0,0,0,0);
	AttachObjectToVehicle(xenonbranco[4][vehicleid], vehicleid, 1.0, 3.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonbranco[5][vehicleid], vehicleid, 1.0, 5.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonbranco[6][vehicleid], vehicleid, 1.0, 6.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonbranco[7][vehicleid], vehicleid, 1.0, 7.0, -0.8, 0.0, 0.0, 0.0);
	return 1;
}

stock VermelhoOne(vehicleid)
{
	xenonvermelho[0][vehicleid] = CreateObject(19296,0,0,0,0,0,0);
	xenonvermelho[1][vehicleid] = CreateObject(19296,0,0,0,0,0,0);
	xenonvermelho[2][vehicleid] = CreateObject(19296,0,0,0,0,0,0);
	xenonvermelho[3][vehicleid] = CreateObject(19296,0,0,0,0,0,0);
	AttachObjectToVehicle(xenonvermelho[0][vehicleid], vehicleid, -1.0, 3.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonvermelho[1][vehicleid], vehicleid, -1.0, 5.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonvermelho[2][vehicleid], vehicleid, -1.0, 6.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonvermelho[3][vehicleid], vehicleid, -1.0, 7.0, -0.8, 0.0, 0.0, 0.0);
	return 1;
}

stock VermelhoTwo(vehicleid)
{
	xenonvermelho[4][vehicleid] = CreateObject(19296,0,0,0,0,0,0);
	xenonvermelho[5][vehicleid] = CreateObject(19296,0,0,0,0,0,0);
	xenonvermelho[6][vehicleid] = CreateObject(19296,0,0,0,0,0,0);
	xenonvermelho[7][vehicleid] = CreateObject(19296,0,0,0,0,0,0);
	AttachObjectToVehicle(xenonvermelho[4][vehicleid], vehicleid, 1.0, 3.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonvermelho[5][vehicleid], vehicleid, 1.0, 5.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonvermelho[6][vehicleid], vehicleid, 1.0, 6.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonvermelho[7][vehicleid], vehicleid, 1.0, 7.0, -0.8, 0.0, 0.0, 0.0);
	return 1;
}

stock VerdeOne(vehicleid)
{
	xenonverde[0][vehicleid] = CreateObject(19297,0,0,0,0,0,0);
	xenonverde[1][vehicleid] = CreateObject(19297,0,0,0,0,0,0);
	xenonverde[2][vehicleid] = CreateObject(19297,0,0,0,0,0,0);
	xenonverde[3][vehicleid] = CreateObject(19297,0,0,0,0,0,0);
	AttachObjectToVehicle(xenonverde[0][vehicleid], vehicleid, -1.0, 3.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonverde[1][vehicleid], vehicleid, -1.0, 5.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonverde[2][vehicleid], vehicleid, -1.0, 6.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonverde[3][vehicleid], vehicleid, -1.0, 7.0, -0.8, 0.0, 0.0, 0.0);
	return 1;
}

stock VerdeTwo(vehicleid)
{
	xenonverde[4][vehicleid] = CreateObject(19297,0,0,0,0,0,0);
	xenonverde[5][vehicleid] = CreateObject(19297,0,0,0,0,0,0);
	xenonverde[6][vehicleid] = CreateObject(19297,0,0,0,0,0,0);
	xenonverde[7][vehicleid] = CreateObject(19297,0,0,0,0,0,0);
	AttachObjectToVehicle(xenonverde[4][vehicleid], vehicleid, 1.0, 3.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonverde[5][vehicleid], vehicleid, 1.0, 5.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonverde[6][vehicleid], vehicleid, 1.0, 6.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonverde[7][vehicleid], vehicleid, 1.0, 7.0, -0.8, 0.0, 0.0, 0.0);
	return 1;
}

stock AzulOne(vehicleid)
{
	xenonazul[0][vehicleid] = CreateObject(19298,0,0,0,0,0,0);
	xenonazul[1][vehicleid] = CreateObject(19298,0,0,0,0,0,0);
	xenonazul[2][vehicleid] = CreateObject(19298,0,0,0,0,0,0);
	xenonazul[3][vehicleid] = CreateObject(19295,0,0,0,0,0,0);
	AttachObjectToVehicle(xenonazul[0][vehicleid], vehicleid, -1.0, 3.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonazul[1][vehicleid], vehicleid, -1.0, 5.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonazul[2][vehicleid], vehicleid, -1.0, 6.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonazul[3][vehicleid], vehicleid, -1.0, 7.0, -0.8, 0.0, 0.0, 0.0);
	return 1;
}

stock AzulTwo(vehicleid)
{
	xenonazul[4][vehicleid] = CreateObject(19295,0,0,0,0,0,0);
	xenonazul[5][vehicleid] = CreateObject(19298,0,0,0,0,0,0);
	xenonazul[6][vehicleid] = CreateObject(19298,0,0,0,0,0,0);
	xenonazul[7][vehicleid] = CreateObject(19295,0,0,0,0,0,0);
	AttachObjectToVehicle(xenonazul[4][vehicleid], vehicleid, 1.0, 3.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonazul[5][vehicleid], vehicleid, 1.0, 5.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonazul[6][vehicleid], vehicleid, 1.0, 6.0, -0.8, 0.0, 0.0, 0.0);
	AttachObjectToVehicle(xenonazul[7][vehicleid], vehicleid, 1.0, 7.0, -0.8, 0.0, 0.0, 0.0);
	return 1;
}

stock DestroyXenon(vehicleid)
{
	for(new x; x < sizeof(xenonazul); x++)
	{
		DestroyObject(xenonazul[x][vehicleid]);
	}
	for(new x; x < sizeof(xenonverde); x++)
	{
		DestroyObject(xenonverde[x][vehicleid]);
	}
	for(new x; x < sizeof(xenonvermelho); x++)
	{
		DestroyObject(xenonvermelho[x][vehicleid]);
	}
	for(new x; x < sizeof(xenonbranco); x++)
	{
		DestroyObject(xenonbranco[x][vehicleid]);
	}
	return 1;
}

stock BadVehicleXenon( vehicleid )
{
	new result;
	new model = GetVehicleModel( vehicleid );
	switch( model )
	{
		case 522,462,521,461,463,581,448,586,
		523,468,471,509,481,510,539,472,473,
		493,595,484,430,453,452,446,454,548,
		425,417,487,497,563,501,465,447,469,
		488,520,476,593,553,513,512,577,592,
		511,464,519,460: result = model;
		default: result = 0;
	}
	return result;
}

stock DestroyAllXenon()
{
	for(new i = 0; i < MAX_VEHICLES; i++)
	{
		for(new x; x < sizeof(xenonazul); x++)
		{
			DestroyObject(xenonazul[x][i]);
		}
		for(new x; x < sizeof(xenonverde); x++)
		{
			DestroyObject(xenonverde[x][i]);
		}
		for(new x; x < sizeof(xenonvermelho); x++)
		{
			DestroyObject(xenonvermelho[x][i]);
		}
		for(new x; x < sizeof(xenonbranco); x++)
		{
			DestroyObject(xenonbranco[x][i]);
		}
	}
}
