/*  Brasil Cidade Livre Admin Functions
 *
 *  (c) Copyright 2014-2015, BCL (RPG)
 *
 */
#if defined _global_inc
	#endinput
#endif
#define _global_inc
#pragma library global

new STRX[250];

stock getIp(playerid)
{
	static Ip[20];
	GetPlayerIp(playerid, Ip, sizeof(Ip));
	return Ip;
}
stock GetName(playerid)
{
	new PlayerNameLevel[MAX_PLAYER_NAME];
	GetPlayerName(playerid, PlayerNameLevel, MAX_PLAYER_NAME);
	return PlayerNameLevel;
}
//=========================== Raio dos Portao ==================================
#if !defined IsPlayerInRangeOfPoint
stock IsPlayerInRangeOfPoint(playerid, Float:radius, Float:X, Float:Y, Float:Z)
{
	new Float:px,Float:py,Float:pz;
	GetPlayerPos(playerid,px,py,pz);
	return ( ( ((px-X)*(px-X))+((py-Y)*(py-Y))+((pz-Z)*(pz-Z)) ) >= radius*radius);
}
#endif

stock ChangeVehicleDiesel(vehicleid)
{
    switch(GetVehicleModel(vehicleid))
    {
        case 403,406,407,408,414,416,423,427,428,432,433,437,444,455,456,498,499,
        508,514,515,524,525,544,552,556,557,573,578,681,609,538,537,532,485,539,
        431,601,446,486,531:return 1;
    }
    return 0;
}

stock ChangeVehicleGnv(vehicleid)
{
    switch(GetVehicleModel(vehicleid))
    {
        case 593,592,577,563,553,548,520,519,513, 512,511,497,488,487,476,469,
        460,447,425,417:return 1;
    }
    return 0;
}
stock ChangeVehicleGasolina(vehicleid)
{
	switch(GetVehicleModel(vehicleid))
	{
		case 400,402,404,405,409,411,412,413,415,419,424,434,438,442,448,451,461,
        462,463,468,471,477,479,482,483,489,490,494,495,500,502,504,505,506,516,
        521,522,523,529,534,535,539,541,545,547,549,554,559,560,561,563,565,567,
        568,571,579,581,596,587,588,589,597,599,600,603,586:return 1;
	}
	return 0;
}
stock ChangeVehicleEtanol(vehicleid)
{
	switch(GetVehicleModel(vehicleid))
	{
		case 401,410,420,421,422,426,429,436,439,445,457,458,466,467,474,475,480,
        485,491,492,496,503,507,517,518,526,527,530,533,536,540,542,543,546,550,
        551,555,558,566,574,575,576,580,583,585,598,602,604,605,596:return 1;
	}
	return 0;
}
//-------------------------------------------------------------
stock vVeiculo(Modelo)
{
    static Valor;
    switch(Modelo)
    {
        case 522: Valor = 300000; case 581: Valor = 200000; case 461: Valor = 100000;
        case 521: Valor = 255000; case 463: Valor = 305000; case 586: Valor = 200000;
        case 468: Valor = 170500; case 471: Valor = 100000; case 480: Valor = 690000;
        case 533: Valor = 70000;  case 439: Valor = 767000; case 555: Valor = 695000;
        case 422: Valor = 300000; case 600: Valor = 599000; case 543: Valor = 200000;
        case 554: Valor = 800000; case 537: Valor = 499510; case 534: Valor = 800000;
        case 567: Valor = 505000; case 535: Valor = 900000; case 576: Valor = 100000;
        case 412: Valor = 300000; case 568: Valor = 205000; case 424: Valor = 100000;
        case 573: Valor = 900000; case 579: Valor = 305555; case 400: Valor = 200000;
        case 500: Valor = 200000; case 444: Valor = 795001; case 556: Valor = 884000;
        case 557: Valor = 683005; case 470: Valor = 600000; case 489: Valor = 500000;
        case 505: Valor = 501000; case 495: Valor = 701720; case 445: Valor = 150000;
        case 504: Valor = 200000; case 401: Valor = 200000; case 518: Valor = 350000;
        case 527: Valor = 99900;  case 542: Valor = 99999;  case 507: Valor = 200100;
        case 562: Valor = 700000; case 585: Valor = 300000; case 419: Valor = 300900;
        case 526: Valor = 100957; case 466: Valor = 190000; case 492: Valor = 210000;
        case 474: Valor = 230000; case 546: Valor = 302395; case 517: Valor = 300890;
        case 410: Valor = 200000; case 511: Valor = 250000; case 516: Valor = 320605;
        case 467: Valor = 300000; case 426: Valor = 202000; case 436: Valor = 205000;
        case 547: Valor = 200900; case 405: Valor = 201300; case 580: Valor = 300000;
        case 560: Valor = 400000; case 550: Valor = 304000; case 549: Valor = 509570;
        case 540: Valor = 300000; case 491: Valor = 310000; case 529: Valor = 307000;
        case 421: Valor = 305000; case 602: Valor = 1305000; case 496: Valor = 1305000;
        case 402: Valor = 2406000; case 541: Valor = 5305000; case 415: Valor = 1000000;
        case 589: Valor = 1005000; case 587: Valor = 1100000; case 565: Valor = 1201000;
        case 494: Valor = 3302000; case 502: Valor = 3405000; case 503: Valor = 1305000;
        case 411: Valor = 5305000; case 559: Valor = 1200000; case 603: Valor = 900000;
        case 475: Valor = 805000; case 506: Valor = 1809700; case 451: Valor = 1509300;
        case 558: Valor = 1000000; case 477: Valor = 1000000; case 404: Valor = 400000;
        case 479: Valor = 405000; case 458: Valor = 300000; case 561: Valor = 1000000;
        case 434: Valor = 6000000; case 442: Valor = 209900; case 483: Valor = 200055;
        case 539: Valor = 500000; case 545: Valor = 900000; case 571: Valor = 80000;
    }
    return Valor;
}
stock CmdErrorMessagePlayer(i)
{
    SendClientMessage(i, 0xFF0000AA,"[ERRO] Comando Inválido");
    return 1;
}
