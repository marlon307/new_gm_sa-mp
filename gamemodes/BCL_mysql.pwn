//_______________________Infos MySql____________________________________________
#define SQL_HOST "sql10.freemysqlhosting.net"   //db4free.net
#define SQL_USER "sql10251988"        //sambcl
#define SQL_PASS "AJMWbPsRJf"      // 27121996
#define SQL_DB "sql10251988"          //bclbcl
/*Sistemas
http://pastebin.com/u/GustavoAraujo*/
//______________________________________________________________________________
#define HostNameUser

#define _CallBack:%0(%1)   \
                              forward%0(%1); public%0(%1)
#define Loop(%0,%1)        \
                              for(new %0; %0 != %1; ++%0)
#define PRESSED(%0)        \
	                          (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0)       \
	                          (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#define GM_VERSAO v0.4.4

#if defined HostNameUser
	#define SERVER_NOME      "hostname BCL - Brasil Cidade Livre"

	#define GAMEMOD_NOME     "Brasil - BCL RPG  "#GM_VERSAO""

    #define MAPA_NOME        "mapname BCL - BR"

    #define LANGUAGE_SERVER  "language  Português - Brasil"
#endif

#define TEXTO_LOGIN          "{FFFFFF}Versão do Servidor: {22D0D0}"#GM_VERSAO"\n{FFFFFF}Usuário: {7777FF}%s\n{FFFFFF}Conta: {00FF00}Registrada\n\n{00FF80}Informe sua senha."
#define TEXTO_LOGINERRO      "{FFFFFF}Versão do Servidor: {22D0D0}"#GM_VERSAO"\n{FFFFFF}Usuário: {7777FF}%s\n{FFFFFF}Conta: {00D900}Registrada\n\n{FF0000}Senha Incorreta."
#define TEXTO_REGISTRO       "{FFFFFF}Versão do Servidor: {22D0D0}"#GM_VERSAO"\n{FFFFFF}Nick: {7777FF}%s\n{FFFFFF}Conta: {D5D500}Pedente a Registrar. \n\n{00FF80}Registre_se Aki."

#define CITY_LOS_SANTOS 	                                                   0
#define CITY_SAN_FIERRO 	                                                   1
#define CITY_LAS_VENTURAS 	                                                   2

//______________________________Preços e valores________________________________
#define MAX_DIESEL_COMB                                                      250
#define MAX_GNV_COMB                                                         300
#define MAX_GASOLINA_COMB                                                     60
#define MAX_ETANOL_COMB                                                       60
#define VALOR_GASOLINA_COMB                                                    2
#define VALOR_ETANOL_COMB                                                      2
#define VALOR_DIESEL_COMB                                                      3
#define VALOR_GNV_COMB                                                         4
#define MAX_EVENTOS                                                            5
//___________________________________Includes___________________________________
#include <a_samp>
#undef MAX_PLAYERS
#define MAX_PLAYERS                                                           30
#include <streamer>
#include <crashdetect>
#include <foreach>
#include <a_mysql>
#include <sscanf2>
#include <zcmd>

new Query[500];
new MySQL:SqL;
//#include "../include/iee.inc" //forum.sa-mp.com/showthread.php?t=289660
#include "../include/Admin.inc"
#include "../include/gl_messages.inc"
#include "../include/bcl_global.inc"
#include "../include/vehicleutil.inc"
#include "../include/a_money.inc"
#include "../include/Neon.inc"
#include "../include/mSelection.inc"
#include "../include/atacchM.inc"
//______________________________________________________________________________
new countVehicle = 0;
#define MAX_VEHICLES_SPAWN                                                   500
new countObject = 0;
//______________________________________________________________________________
#define PROF_DESENPREGADOS                                                     0
#define PROF_CAMINHOEIRPLS                                                     1
#define PROF_AERONAVPILOTO                                                     2
#define PROF_PIZZABOYLS                                                        3
#define PROF_PETROLEIRO                                                        4
#define PROF_CORREIOS                                                          5
//_____________________________________Cor da profissão_________________________
//http://www.webcalc.com.br/utilitarios/rgb_hex.html
#define COR_CAMINHOEIRPLS                                             0x804000AA//Marron
#define COR_AERONAVPILOTO                                             0x00C6C6AA//Azul Claro
#define COR_PIZZABOYLS                                                0xFF962DAA//Laranja
#define COR_PETROLEIRO                                                0x008080AA//Teal
#define COR_CORREIOS                                                  0xD5D500AA//Amarelo
//_____________________________________Cores____________________________________
#define Vermelho                                                      0xFF0000AA
#define Roxo                                                          0xB900B9AA
#define Verde                                                         0x00D500AA
#define Amarelo                                                       0xFFFF00AA
#define Azul                                                          0x0000FFAA
#define Laranjado                                                     0xFF8040AA
//____________________________________DIALOGS___________________________________
#define DIALOG_REGISTRO                                                        0
#define DIALOG_LOGIN                                                           1
#define DIALOG_PGASOLINA                                                       2
#define DIALOG_PETANOL                                                         3
#define DIALOG_PDIESEL                                                         4
#define DIALOG_PGNV                                                            5
#define DIALOG_COMBUSTIVEIS                                                    6
#define DIALOG_ADMINON                                                         7
#define DIALOG_NOTIFICACAO                                                     8
#define _DIALOG_NOTIFICACAO                                                    9
#define DIALOG_NEONS                                                          10
#define DIALOG_ACESSORIOS                                                     11
#define DIALOG_ACESSORIOS_EDIT                                                12
#define DIALOG_ACESSORIOS_BONE                                                13
#define DIALOG_PLAYER                                                         14
#define DIALOG_STATUS                                                         15
#define DIALOG_SELECT                                                         16
#define DIALOG_AJUDA                                                          17
#define DIALOG_CARGAS                                                         18
//_________________________________Variaveis Globais____________________________
new bool:AreaPosto[MAX_PLAYERS];
new AimbotWarnings[MAX_PLAYERS];
new TimersT[10];
new ContFlood[MAX_PLAYERS][2];
new Notifc[MAX_PLAYERS][128];
new NotficL[MAX_PLAYERS];
new Duvid[MAX_PLAYERS][128];
new DuvidResp;
new _DuvidResp[MAX_PLAYERS][128];
new Dresp[MAX_PLAYERS];
new InfoPlayerResp[MAX_PLAYERS][128];
new DuvidpLer[MAX_PLAYERS];
new gPlayerCitySelection[MAX_PLAYERS];
//_________________________________Txts Draws___________________________________
new PlayerText:pCidadeSelect[MAX_PLAYERS][5];
new CitySelect[MAX_PLAYERS] = 0;
new Text:txtTimeDisp,horas,minutos,timestr[32];
new PlayerText:Notificacoes[MAX_PLAYERS];
new CarsAdmin = mS_INVALID_LISTID;
new SkinAdmin = mS_INVALID_LISTID;
new Acessorios = mS_INVALID_LISTID;
new PlayerText:Velocimetro[MAX_PLAYERS][5];
new stryngv[80];
new spe;
new Float:Posicao[4];
new PlayerText:HQobserv[MAX_PLAYERS];
static ranmessage[][] =
{
    "[!] {FF9224}Pa mais ajuda comunique ao admin ou use o comando /C",
    "[!] {5959FF}Pa mais ajuda comunique ao admin ou use o comando /C"
};
//__________________________VARIAVEIS PARA PROFISSOES___________________________
new bool:DestinoCarg[MAX_PLAYERS];
//profissão caminhoneiro
new vCaminhao[21];
new gzCaminhoneiro;
static Float:Carg[][3] =
{
   {-576.7003,-548.7578,26.5405},//DESCARGA LS 1
   {-216.9391,-196.8365,2.4383},  //DESCARGA LS 2
   {1053.2322,2194.7788,11.8292}, //DESCARGA  LV
   {2368.6582,2806.2258,11.8394}, //DESCARGA LV 1
   {-2131.8960,-131.2176,36.3527}//DESCAR SF
};
//Profissão petroleiro
new vPetroleiro[20];
static Float:pCarg[][3] =
{
    {644.3897,1676.5643,7.5634},// bone county 200
    {41.3012,1224.0857,19.6902},// fort carson 230
    {-1311.5328,2705.7498,50.6322},// tierra robada 300
    {-1491.9934,1876.4279,33.1973},// tierra robada 1 340
    {-2442.0330,953.4233,45.8668},// juniper hill 400
    {-1715.7760,394.5754,7.7662},// easter basin 450
    {-2236.8269,-2572.1394,32.5120},// angel pine 450
    {-1628.6808,-2695.7988,49.1243},// whetstone 450
    {-67.8326,-1162.7721,2.3795},// flint count 580
    {1361.5836,481.7296,20.7457},// montgomery 550
    {664.7007,-580.8862,16.9210},// dillimor 550
    {1032.6582,-925.8719,42.8676},// mulholland 750
    {1918.5427,-1790.2557,13.9708},// idlewood 800
    {2130.0813,891.8405,11.4013},// Las venturas 600
    {2649.9517,1087.1691,11.4091},// come-a-lot 1 620
    {1608.0945,2235.7041,11.4004}// redsands west 570
};
//profissão Piloto de avião de cargas
new AeroC;
new vAeroCarg[5];
static Float:AeroCarg[][3] =
{
   {1508.3267,1826.1827,12.0144}, //Las Venturas
   {-1282.7534,-14.6233,15.3426}  //San Fierro
};
//Profissão pizza boy LS
new gzPizzaboyLs;
new vPizzaBoy[12];
static Float:PizzaBoyLs[][3] =
{
    {2002.8317,-1131.2650,24.8158},
    {1257.8948,-1074.5381,27.5068},
    {265.0087,-1234.2450,73.2099},
    {657.0215,-1073.9583,47.8731},
    {2402.1563,-1728.0730,12.9457},
    {2837.3989,-1184.2491,24.1005},
    {2638.6177,-1069.0092,69.0160},
    {2765.4275,-1978.7095,12.9356},
    {2674.6794,-2008.0238,12.9446},
    {2220.0576,-1786.2136,12.7801},
    {2077.1919,-1717.4512,12.9620},
    {1800.7949,-2108.2310,12.9469},
    {483.2446,-1534.8568,18.9431},
    {1993.7633,-1336.4866,23.3908},
    {2141.0723,-1305.5994,23.4043}
};
//Profissão Correios
new vCorreios[12];
//_____________________________Camera ao conectar_______________________________
//Cameras na hora de logar
static Float:RquestCam[][] =
{
   {1812.0879,-1285.5819,120.2656,181.4083},//Los Santos
   {-2612.1511,1441.2721,7.6663,181.4083},  //San Fierro
   {2000.4006,1579.4746,16.7761,181.4083}   //Las Venturas
};
//_______________________________Enumeradores___________________________________
enum pInfo
{
    bool:Logged,
    Skin,
    Float:Casa[3],
    Comb[4],
    Profissao,
    cBanc,
    sBancario
};
static PlayerInfo[MAX_PLAYERS][pInfo];

enum iI
{
    IncomingIP[16],
    IncomingVezes,
    IncomingTempo
}
static IncomingConnection[iI];

static AttachmentBones[][] = {
    {"Coluna"},
    {"Cabeça"},
    {"Braço esquerdo"},
    {"Braço direito"},
    {"Mão esquerda"},
    {"Mão direita"},
    {"Coxa esquerda"},
    {"Coxa direita"},
    {"Pé esquerdo"},
    {"Pé direito"},
    {"Panturrilha direita"},
    {"Panturrilha esquerda"},
    {"Antebraço esquerdo"},
    {"Antebraçp direito"},
    {"Clavícula esquerda"},
    {"Clavícula direita"},
    {"Pescoço"},
    {"Mandíbula"}
};

static VeiculosNome[][] =
{
    "Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Firetruck","Trashmaster",
    "Limosine","Manana","Infernus","Voodoo","Pony","Mule","Cheetah","Ambulancia","Leviathan","Moonbeam","Esperanto",
    "Taxi","Washington","Bobcat","Mr Whoopee","BF Injection","Hunter","Premier","Enforcer","Securicar","Banshee",
    "Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie","Stallion","Rumpo",
    "RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer",
    "Turismo","Speeder","Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer",
    "PCJ-600","Faggio","Freeway","RC Baron","RC Raider","Glendale","Oceanic","Sanchez","Sparrow","Patriot",
    "Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR-350","Walton","Regina","Comet","BMX",
    "Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo",
    "Greenwood","Jetmax","Hotring","Sandking","Blista Compact","Maverick Policial","Boxville","Benson","Mesa",
    "RC Goblin","Hotring Racer A","Hotring Racer B","Bloodring Banger","Rancher","Super GT","Elegant",
    "Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain","Nebula","Majestic",
    "Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona",
    "FBI Truck","Willard","Forklift","Trator","Combine","Feltzer","Remington","Slamvan","Blade","Freight",
    "Streak","Vortex","Vincent","Bullet","Clover","Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob",
    "Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A","Monster B","Uranus",
    "Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight",
    "Trailer","Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford",
    "BF-400","Newsvan","Tug","Trailer A","Emperor","Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C",
    "Andromada","Dodo","RC Cam","Launch","Viatura(LSPD)","Viatura(SFPD)","Viatura(LVPD)","Police Ranger",
    "Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A","Luggage Trailer B",
    "Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};
// GPS
enum GPSInfo
{
	zone_name[30],
	Float:zone_minx,
	Float:zone_miny,
	Float:zone_minz,
	Float:zone_maxx,
	Float:zone_maxy,
	Float:zone_maxz
};
//RoamPT
static Float:Zones[][GPSInfo] = {
	{ "The Big Ear",                -410.00,  1403.30,    -3.00,  -137.90,  1681.20,   200.00},
	{ "Aldea Malvada",               -1372.10,  2498.50,     0.00, -1277.50,  2615.30,   200.00},
	{ "Angel Pine",                  -2324.90, -2584.20,    -6.10, -1964.20, -2212.10,   200.00},
	{ "Arco del Oeste",               -901.10,  2221.80,     0.00,  -592.00,  2571.90,   200.00},
	{ "Avispa Country Club",         -2646.40,  -355.40,     0.00, -2270.00,  -222.50,   200.00},
	{ "Avispa Country Club",         -2831.80,  -430.20,    -6.10, -2646.40,  -222.50,   200.00},
	{ "Avispa Country Club",         -2361.50,  -417.10,     0.00, -2270.00,  -355.40,   200.00},
	{ "Avispa Country Club",         -2667.80,  -302.10,   -28.80, -2646.40,  -262.30,    71.10},
	{ "Avispa Country Club",         -2470.00,  -355.40,     0.00, -2270.00,  -318.40,    46.10},
	{ "Avispa Country Club",         -2550.00,  -355.40,     0.00, -2470.00,  -318.40,    39.70},
	{ "Back o Beyond",               -1166.90, -2641.10,     0.00,  -321.70, -1856.00,   200.00},
	{ "Battery Point",               -2741.00,  1268.40,    -4.50, -2533.00,  1490.40,   200.00},
	{ "Bayside",                     -2741.00,  2175.10,     0.00, -2353.10,  2722.70,   200.00},
	{ "Bayside Marina",              -2353.10,  2275.70,     0.00, -2153.10,  2475.70,   200.00},
	{ "Beacon Hill",                  -399.60, -1075.50,    -1.40,  -319.00,  -977.50,   198.50},
	{ "Blackfield",                    964.30,  1203.20,   -89.00,  1197.30,  1403.20,   110.90},
	{ "Blackfield",                    964.30,  1403.20,   -89.00,  1197.30,  1726.20,   110.90},
	{ "Blackfield Chapel",            1375.60,   596.30,   -89.00,  1558.00,   823.20,   110.90},
	{ "Blackfield Chapel",            1325.60,   596.30,   -89.00,  1375.60,   795.00,   110.90},
	{ "Blackfield Intersection",      1197.30,  1044.60,   -89.00,  1277.00,  1163.30,   110.90},
	{ "Blackfield Intersection",      1166.50,   795.00,   -89.00,  1375.60,  1044.60,   110.90},
	{ "Blackfield Intersection",      1277.00,  1044.60,   -89.00,  1315.30,  1087.60,   110.90},
	{ "Blackfield Intersection",      1375.60,   823.20,   -89.00,  1457.30,   919.40,   110.90},
	{ "Blueberry",                     104.50,  -220.10,     2.30,   349.60,   152.20,   200.00},
	{ "Blueberry",                      19.60,  -404.10,     3.80,   349.60,  -220.10,   200.00},
	{ "Blueberry Acres",              -319.60,  -220.10,     0.00,   104.50,   293.30,   200.00},
	{ "Caligula's Palace",            2087.30,  1543.20,   -89.00,  2437.30,  1703.20,   110.90},
	{ "Caligula's Palace",            2137.40,  1703.20,   -89.00,  2437.30,  1783.20,   110.90},
	{ "Calton Heights",              -2274.10,   744.10,    -6.10, -1982.30,  1358.90,   200.00},
	{ "Chinatown",                   -2274.10,   578.30,    -7.60, -2078.60,   744.10,   200.00},
	{ "City Hall",                   -2867.80,   277.40,    -9.10, -2593.40,   458.40,   200.00},
	{ "Come-A-Lot",                   2087.30,   943.20,   -89.00,  2623.10,  1203.20,   110.90},
	{ "Commerce",                     1323.90, -1842.20,   -89.00,  1701.90, -1722.20,   110.90},
	{ "Commerce",                     1323.90, -1722.20,   -89.00,  1440.90, -1577.50,   110.90},
	{ "Commerce",                     1370.80, -1577.50,   -89.00,  1463.90, -1384.90,   110.90},
	{ "Commerce",                     1463.90, -1577.50,   -89.00,  1667.90, -1430.80,   110.90},
	{ "Commerce",                     1583.50, -1722.20,   -89.00,  1758.90, -1577.50,   110.90},
	{ "Commerce",                     1667.90, -1577.50,   -89.00,  1812.60, -1430.80,   110.90},
	{ "Conference Center",            1046.10, -1804.20,   -89.00,  1323.90, -1722.20,   110.90},
	{ "Conference Center",            1073.20, -1842.20,   -89.00,  1323.90, -1804.20,   110.90},
	{ "Cranberry Station",           -2007.80,    56.30,     0.00, -1922.00,   224.70,   100.00},
	{ "Creek",                        2749.90,  1937.20,   -89.00,  2921.60,  2669.70,   110.90},
	{ "Dillimore",                     580.70,  -674.80,    -9.50,   861.00,  -404.70,   200.00},
	{ "Doherty",                     -2270.00,  -324.10,    -0.00, -1794.90,  -222.50,   200.00},
	{ "Doherty",                     -2173.00,  -222.50,    -0.00, -1794.90,   265.20,   200.00},
	{ "Downtown",                    -1982.30,   744.10,    -6.10, -1871.70,  1274.20,   200.00},
	{ "Downtown",                    -1871.70,  1176.40,    -4.50, -1620.30,  1274.20,   200.00},
	{ "Downtown",                    -1700.00,   744.20,    -6.10, -1580.00,  1176.50,   200.00},
	{ "Downtown",                    -1580.00,   744.20,    -6.10, -1499.80,  1025.90,   200.00},
	{ "Downtown",                    -2078.60,   578.30,    -7.60, -1499.80,   744.20,   200.00},
	{ "Downtown",                    -1993.20,   265.20,    -9.10, -1794.90,   578.30,   200.00},
	{ "Downtown Los Santos",          1463.90, -1430.80,   -89.00,  1724.70, -1290.80,   110.90},
	{ "Downtown Los Santos",          1724.70, -1430.80,   -89.00,  1812.60, -1250.90,   110.90},
	{ "Downtown Los Santos",          1463.90, -1290.80,   -89.00,  1724.70, -1150.80,   110.90},
	{ "Downtown Los Santos",          1370.80, -1384.90,   -89.00,  1463.90, -1170.80,   110.90},
	{ "Downtown Los Santos",          1724.70, -1250.90,   -89.00,  1812.60, -1150.80,   110.90},
	{ "Downtown Los Santos",          1370.80, -1170.80,   -89.00,  1463.90, -1130.80,   110.90},
	{ "Downtown Los Santos",          1378.30, -1130.80,   -89.00,  1463.90, -1026.30,   110.90},
	{ "Downtown Los Santos",          1391.00, -1026.30,   -89.00,  1463.90,  -926.90,   110.90},
	{ "Downtown Los Santos",          1507.50, -1385.20,   110.90,  1582.50, -1325.30,   335.90},
	{ "East Beach",                   2632.80, -1852.80,   -89.00,  2959.30, -1668.10,   110.90},
	{ "East Beach",                   2632.80, -1668.10,   -89.00,  2747.70, -1393.40,   110.90},
	{ "East Beach",                   2747.70, -1668.10,   -89.00,  2959.30, -1498.60,   110.90},
	{ "East Beach",                   2747.70, -1498.60,   -89.00,  2959.30, -1120.00,   110.90},
	{ "East Los Santos",              2421.00, -1628.50,   -89.00,  2632.80, -1454.30,   110.90},
	{ "East Los Santos",              2222.50, -1628.50,   -89.00,  2421.00, -1494.00,   110.90},
	{ "East Los Santos",              2266.20, -1494.00,   -89.00,  2381.60, -1372.00,   110.90},
	{ "East Los Santos",              2381.60, -1494.00,   -89.00,  2421.00, -1454.30,   110.90},
	{ "East Los Santos",              2281.40, -1372.00,   -89.00,  2381.60, -1135.00,   110.90},
	{ "East Los Santos",              2381.60, -1454.30,   -89.00,  2462.10, -1135.00,   110.90},
	{ "East Los Santos",              2462.10, -1454.30,   -89.00,  2581.70, -1135.00,   110.90},
	{ "Easter Basin",                -1794.90,   249.90,    -9.10, -1242.90,   578.30,   200.00},
	{ "Easter Basin",                -1794.90,   -50.00,    -0.00, -1499.80,   249.90,   200.00},
	{ "Aeroporto de Easter Bay",     -1499.80,   -50.00,    -0.00, -1242.90,   249.90,   200.00},
	{ "Aeroporto de Easter Bay",     -1794.90,  -730.10,    -3.00, -1213.90,   -50.00,   200.00},
	{ "Aeroporto de Easter Bay",     -1213.90,  -730.10,     0.00, -1132.80,   -50.00,   200.00},
	{ "Aeroporto de Easter Bay",     -1242.90,   -50.00,     0.00, -1213.90,   578.30,   200.00},
	{ "Aeroporto de Easter Bay",     -1213.90,   -50.00,    -4.50,  -947.90,   578.30,   200.00},
	{ "Aeroporto de Easter Bay",     -1315.40,  -405.30,    15.40, -1264.40,  -209.50,    25.40},
	{ "Aeroporto de Easter Bay",     -1354.30,  -287.30,    15.40, -1315.40,  -209.50,    25.40},
	{ "Aeroporto de Easter Bay",     -1490.30,  -209.50,    15.40, -1264.40,  -148.30,    25.40},
	{ "Easter Bay Chemicals",        -1132.80,  -768.00,     0.00,  -956.40,  -578.10,   200.00},
	{ "Easter Bay Chemicals",        -1132.80,  -787.30,     0.00,  -956.40,  -768.00,   200.00},
	{ "El Castillo del Diablo",       -464.50,  2217.60,     0.00,  -208.50,  2580.30,   200.00},
	{ "El Castillo del Diablo",       -208.50,  2123.00,    -7.60,   114.00,  2337.10,   200.00},
	{ "El Castillo del Diablo",       -208.50,  2337.10,     0.00,     8.40,  2487.10,   200.00},
	{ "El Corona",                    1812.60, -2179.20,   -89.00,  1970.60, -1852.80,   110.90},
	{ "El Corona",                    1692.60, -2179.20,   -89.00,  1812.60, -1842.20,   110.90},
	{ "El Quebrados",                -1645.20,  2498.50,     0.00, -1372.10,  2777.80,   200.00},
	{ "Esplanade East",              -1620.30,  1176.50,    -4.50, -1580.00,  1274.20,   200.00},
	{ "Esplanade East",              -1580.00,  1025.90,    -6.10, -1499.80,  1274.20,   200.00},
	{ "Esplanade East",              -1499.80,   578.30,   -79.60, -1339.80,  1274.20,    20.30},
	{ "Esplanade North",             -2533.00,  1358.90,    -4.50, -1996.60,  1501.20,   200.00},
	{ "Esplanade North",             -1996.60,  1358.90,    -4.50, -1524.20,  1592.50,   200.00},
	{ "Esplanade North",             -1982.30,  1274.20,    -4.50, -1524.20,  1358.90,   200.00},
	{ "Fallen Tree",                  -792.20,  -698.50,    -5.30,  -452.40,  -380.00,   200.00},
	{ "Fallow Bridge",                 434.30,   366.50,     0.00,   603.00,   555.60,   200.00},
	{ "Fern Ridge",                    508.10,  -139.20,     0.00,  1306.60,   119.50,   200.00},
	{ "Financial",                   -1871.70,   744.10,    -6.10, -1701.30,  1176.40,   300.00},
	{ "Fisher's Lagoon",              1916.90,  -233.30,  -100.00,  2131.70,    13.80,   200.00},
	{ "Flint Intersection",           -187.70, -1596.70,   -89.00,    17.00, -1276.60,   110.90},
	{ "Flint Range",                  -594.10, -1648.50,     0.00,  -187.70, -1276.60,   200.00},
	{ "Fort Carson",                  -376.20,   826.30,    -3.00,   123.70,  1220.40,   200.00},
	{ "Foster Valley",               -2270.00,  -430.20,    -0.00, -2178.60,  -324.10,   200.00},
	{ "Foster Valley",               -2178.60,  -599.80,    -0.00, -1794.90,  -324.10,   200.00},
	{ "Foster Valley",               -2178.60, -1115.50,     0.00, -1794.90,  -599.80,   200.00},
	{ "Foster Valley",               -2178.60, -1250.90,     0.00, -1794.90, -1115.50,   200.00},
	{ "Frederick Bridge",             2759.20,   296.50,     0.00,  2774.20,   594.70,   200.00},
	{ "Gant Bridge",                 -2741.40,  1659.60,    -6.10, -2616.40,  2175.10,   200.00},
	{ "Gant Bridge",                 -2741.00,  1490.40,    -6.10, -2616.40,  1659.60,   200.00},
	{ "~g~Ganton",                    2222.50, -1852.80,   -89.00,  2632.80, -1722.30,   110.90},
	{ "~g~Ganton",                    2222.50, -1722.30,   -89.00,  2632.80, -1628.50,   110.90},
	{ "Garcia",                      -2411.20,  -222.50,    -0.00, -2173.00,   265.20,   200.00},
	{ "Garcia",                      -2395.10,  -222.50,    -5.30, -2354.00,  -204.70,   200.00},
	{ "Garver Bridge",               -1339.80,   828.10,   -89.00, -1213.90,  1057.00,   110.90},
	{ "Garver Bridge",               -1213.90,   950.00,   -89.00, -1087.90,  1178.90,   110.90},
	{ "Garver Bridge",               -1499.80,   696.40,  -179.60, -1339.80,   925.30,    20.30},
	{ "Parque Glen",                  1812.60, -1449.60,   -89.00,  1996.90, -1350.70,   110.90},
	{ "Parque Glen",                  1812.60, -1100.80,   -89.00,  1994.30,  -973.30,   110.90},
	{ "Parque Glen",                  1812.60, -1350.70,   -89.00,  2056.80, -1100.80,   110.90},
	{ "Green Palms",                   176.50,  1305.40,    -3.00,   338.60,  1520.70,   200.00},
	{ "Greenglass College",            964.30,  1044.60,   -89.00,  1197.30,  1203.20,   110.90},
	{ "Greenglass College",            964.30,   930.80,   -89.00,  1166.50,  1044.60,   110.90},
	{ "Hampton Barns",                 603.00,   264.30,     0.00,   761.90,   366.50,   200.00},
	{ "Hankypanky Point",             2576.90,    62.10,     0.00,  2759.20,   385.50,   200.00},
	{ "Harry Gold Parkway",           1777.30,   863.20,   -89.00,  1817.30,  2342.80,   110.90},
	{ "Hashbury",                    -2593.40,  -222.50,    -0.00, -2411.20,    54.70,   200.00},
	{ "Hilltop Farm",                  967.30,  -450.30,    -3.00,  1176.70,  -217.90,   200.00},
	{ "Hunter Quarry",                 337.20,   710.80,  -115.20,   860.50,  1031.70,   203.70},
	{ "Idlewood",                     1812.60, -1852.80,   -89.00,  1971.60, -1742.30,   110.90},
	{ "Idlewood",                     1812.60, -1742.30,   -89.00,  1951.60, -1602.30,   110.90},
	{ "Idlewood",                     1951.60, -1742.30,   -89.00,  2124.60, -1602.30,   110.90},
	{ "Idlewood",                     1812.60, -1602.30,   -89.00,  2124.60, -1449.60,   110.90},
	{ "Idlewood",                     2124.60, -1742.30,   -89.00,  2222.50, -1494.00,   110.90},
	{ "Idlewood",                     1971.60, -1852.80,   -89.00,  2222.50, -1742.30,   110.90},
	{ "Jefferson",                    1996.90, -1449.60,   -89.00,  2056.80, -1350.70,   110.90},
	{ "Jefferson",                    2124.60, -1494.00,   -89.00,  2266.20, -1449.60,   110.90},
	{ "Jefferson",                    2056.80, -1372.00,   -89.00,  2281.40, -1210.70,   110.90},
	{ "Jefferson",                    2056.80, -1210.70,   -89.00,  2185.30, -1126.30,   110.90},
	{ "Jefferson",                    2185.30, -1210.70,   -89.00,  2281.40, -1154.50,   110.90},
	{ "Jefferson",                    2056.80, -1449.60,   -89.00,  2266.20, -1372.00,   110.90},
	{ "Julius Thruway East",          2623.10,   943.20,   -89.00,  2749.90,  1055.90,   110.90},
	{ "Julius Thruway East",          2685.10,  1055.90,   -89.00,  2749.90,  2626.50,   110.90},
	{ "Julius Thruway East",          2536.40,  2442.50,   -89.00,  2685.10,  2542.50,   110.90},
	{ "Julius Thruway East",          2625.10,  2202.70,   -89.00,  2685.10,  2442.50,   110.90},
	{ "Julius Thruway North",         2498.20,  2542.50,   -89.00,  2685.10,  2626.50,   110.90},
	{ "Julius Thruway North",         2237.40,  2542.50,   -89.00,  2498.20,  2663.10,   110.90},
	{ "Julius Thruway North",         2121.40,  2508.20,   -89.00,  2237.40,  2663.10,   110.90},
	{ "Julius Thruway North",         1938.80,  2508.20,   -89.00,  2121.40,  2624.20,   110.90},
	{ "Julius Thruway North",         1534.50,  2433.20,   -89.00,  1848.40,  2583.20,   110.90},
	{ "Julius Thruway North",         1848.40,  2478.40,   -89.00,  1938.80,  2553.40,   110.90},
	{ "Julius Thruway North",         1704.50,  2342.80,   -89.00,  1848.40,  2433.20,   110.90},
	{ "Julius Thruway North",         1377.30,  2433.20,   -89.00,  1534.50,  2507.20,   110.90},
	{ "Julius Thruway South",         1457.30,   823.20,   -89.00,  2377.30,   863.20,   110.90},
	{ "Julius Thruway South",         2377.30,   788.80,   -89.00,  2537.30,   897.90,   110.90},
	{ "Julius Thruway West",          1197.30,  1163.30,   -89.00,  1236.60,  2243.20,   110.90},
	{ "Julius Thruway West",          1236.60,  2142.80,   -89.00,  1297.40,  2243.20,   110.90},
	{ "Juniper Hill",                -2533.00,   578.30,    -7.60, -2274.10,   968.30,   200.00},
	{ "Juniper Hollow",              -2533.00,   968.30,    -6.10, -2274.10,  1358.90,   200.00},
	{ "K.A.C.C. Military Fuels",      2498.20,  2626.50,   -89.00,  2749.90,  2861.50,   110.90},
	{ "Kincaid Bridge",              -1339.80,   599.20,   -89.00, -1213.90,   828.10,   110.90},
	{ "Kincaid Bridge",              -1213.90,   721.10,   -89.00, -1087.90,   950.00,   110.90},
	{ "Kincaid Bridge",              -1087.90,   855.30,   -89.00,  -961.90,   986.20,   110.90},
	{ "King's",                      -2329.30,   458.40,    -7.60, -1993.20,   578.30,   200.00},
	{ "King's",                      -2411.20,   265.20,    -9.10, -1993.20,   373.50,   200.00},
	{ "King's",                      -2253.50,   373.50,    -9.10, -1993.20,   458.40,   200.00},
	{ "LVA Freight Depot",            1457.30,   863.20,   -89.00,  1777.40,  1143.20,   110.90},
	{ "LVA Freight Depot",            1375.60,   919.40,   -89.00,  1457.30,  1203.20,   110.90},
	{ "LVA Freight Depot",            1277.00,  1087.60,   -89.00,  1375.60,  1203.20,   110.90},
	{ "LVA Freight Depot",            1315.30,  1044.60,   -89.00,  1375.60,  1087.60,   110.90},
	{ "LVA Freight Depot",            1236.60,  1163.40,   -89.00,  1277.00,  1203.20,   110.90},
	{ "Las Barrancas",                -926.10,  1398.70,    -3.00,  -719.20,  1634.60,   200.00},
	{ "Las Brujas",                   -365.10,  2123.00,    -3.00,  -208.50,  2217.60,   200.00},
	{ "Las Colinas",                  1994.30, -1100.80,   -89.00,  2056.80,  -920.80,   110.90},
	{ "Las Colinas",                  2056.80, -1126.30,   -89.00,  2126.80,  -920.80,   110.90},
	{ "Las Colinas",                  2185.30, -1154.50,   -89.00,  2281.40,  -934.40,   110.90},
	{ "Las Colinas",                  2126.80, -1126.30,   -89.00,  2185.30,  -934.40,   110.90},
	{ "Las Colinas",                  2747.70, -1120.00,   -89.00,  2959.30,  -945.00,   110.90},
	{ "Las Colinas",                  2632.70, -1135.00,   -89.00,  2747.70,  -945.00,   110.90},
	{ "Las Colinas",                  2281.40, -1135.00,   -89.00,  2632.70,  -945.00,   110.90},
	{ "Las Payasadas",                -354.30,  2580.30,     2.00,  -133.60,  2816.80,   200.00},
	{ "Aeroporto de Las Venturas",    1236.60,  1203.20,   -89.00,  1457.30,  1883.10,   110.90},
	{ "Aeroporto de Las Venturas",    1457.30,  1203.20,   -89.00,  1777.30,  1883.10,   110.90},
	{ "Aeroporto de Las Venturas",    1457.30,  1143.20,   -89.00,  1777.40,  1203.20,   110.90},
	{ "Aeroporto de Las Venturas",    1515.80,  1586.40,   -12.50,  1729.90,  1714.50,    87.50},
	{ "Last Dime Motel",              1823.00,   596.30,   -89.00,  1997.20,   823.20,   110.90},
	{ "Leafy Hollow",                -1166.90, -1856.00,     0.00,  -815.60, -1602.00,   200.00},
	{ "Lil' Probe Inn",                -90.20,  1286.80,    -3.00,   153.80,  1554.10,   200.00},
	{ "Linden Side",                  2749.90,   943.20,   -89.00,  2923.30,  1198.90,   110.90},
	{ "Linden Station",               2749.90,  1198.90,   -89.00,  2923.30,  1548.90,   110.90},
	{ "Linden Station",               2811.20,  1229.50,   -39.50,  2861.20,  1407.50,    60.40},
	{ "Little Mexico",                1701.90, -1842.20,   -89.00,  1812.60, -1722.20,   110.90},
	{ "Little Mexico",                1758.90, -1722.20,   -89.00,  1812.60, -1577.50,   110.90},
	{ "Los Flores",                   2581.70, -1454.30,   -89.00,  2632.80, -1393.40,   110.90},
	{ "Los Flores",                   2581.70, -1393.40,   -89.00,  2747.70, -1135.00,   110.90},
	{ "Aeroporto de Los Santos",      1249.60, -2394.30,   -89.00,  1852.00, -2179.20,   110.90},
	{ "Aeroporto de Los Santos",      1852.00, -2394.30,   -89.00,  2089.00, -2179.20,   110.90},
	{ "Aeroporto de Los Santos",      1382.70, -2730.80,   -89.00,  2201.80, -2394.30,   110.90},
	{ "Aeroporto de Los Santos",      1974.60, -2394.30,   -39.00,  2089.00, -2256.50,    60.90},
	{ "Aeroporto de Los Santos",      1400.90, -2669.20,   -39.00,  2189.80, -2597.20,    60.90},
	{ "Aeroporto de Los Santos",      2051.60, -2597.20,   -39.00,  2152.40, -2394.30,    60.90},
	{ "Marina",                        647.70, -1804.20,   -89.00,   851.40, -1577.50,   110.90},
	{ "Marina",                        647.70, -1577.50,   -89.00,   807.90, -1416.20,   110.90},
	{ "Marina",                        807.90, -1577.50,   -89.00,   926.90, -1416.20,   110.90},
	{ "Market",                        787.40, -1416.20,   -89.00,  1072.60, -1310.20,   110.90},
	{ "Market",                        952.60, -1310.20,   -89.00,  1072.60, -1130.80,   110.90},
	{ "Market",                       1072.60, -1416.20,   -89.00,  1370.80, -1130.80,   110.90},
	{ "Market",                        926.90, -1577.50,   -89.00,  1370.80, -1416.20,   110.90},
    { "Market Station",                787.40, -1410.90,   -34.10,   866.00, -1310.20,    65.80},
	{ "Martin Bridge",                -222.10,   293.30,     0.00,  -122.10,   476.40,   200.00},
	{ "Missionary Hill",             -2994.40,  -811.20,     0.00, -2178.60,  -430.20,   200.00},
	{ "Montgomery",                   1119.50,   119.50,    -3.00,  1451.40,   493.30,   200.00},
	{ "Montgomery",                   1451.40,   347.40,    -6.10,  1582.40,   420.80,   200.00},
	{ "Montgomery Intersection",      1546.60,   208.10,     0.00,  1745.80,   347.40,   200.00},
	{ "Montgomery Intersection",      1582.40,   347.40,     0.00,  1664.60,   401.70,   200.00},
	{ "Mulholland",                   1414.00,  -768.00,   -89.00,  1667.60,  -452.40,   110.90},
	{ "Mulholland",                   1281.10,  -452.40,   -89.00,  1641.10,  -290.90,   110.90},
	{ "Mulholland",                   1269.10,  -768.00,   -89.00,  1414.00,  -452.40,   110.90},
	{ "Mulholland",                   1357.00,  -926.90,   -89.00,  1463.90,  -768.00,   110.90},
	{ "Mulholland",                   1318.10,  -910.10,   -89.00,  1357.00,  -768.00,   110.90},
	{ "Mulholland",                   1169.10,  -910.10,   -89.00,  1318.10,  -768.00,   110.90},
	{ "Mulholland",                    768.60,  -954.60,   -89.00,   952.60,  -860.60,   110.90},
	{ "Mulholland",                    687.80,  -860.60,   -89.00,   911.80,  -768.00,   110.90},
	{ "Mulholland",                    737.50,  -768.00,   -89.00,  1142.20,  -674.80,   110.90},
	{ "Mulholland",                   1096.40,  -910.10,   -89.00,  1169.10,  -768.00,   110.90},
	{ "Mulholland",                    952.60,  -937.10,   -89.00,  1096.40,  -860.60,   110.90},
	{ "Mulholland",                    911.80,  -860.60,   -89.00,  1096.40,  -768.00,   110.90},
	{ "Mulholland",                    861.00,  -674.80,   -89.00,  1156.50,  -600.80,   110.90},
	{ "Mulholland Intersection",      1463.90, -1150.80,   -89.00,  1812.60,  -768.00,   110.90},
	{ "North Rock",                   2285.30,  -768.00,     0.00,  2770.50,  -269.70,   200.00},
	{ "Ocean Docks",                  2373.70, -2697.00,   -89.00,  2809.20, -2330.40,   110.90},
	{ "Ocean Docks",                  2201.80, -2418.30,   -89.00,  2324.00, -2095.00,   110.90},
	{ "Ocean Docks",                  2324.00, -2302.30,   -89.00,  2703.50, -2145.10,   110.90},
	{ "Ocean Docks",                  2089.00, -2394.30,   -89.00,  2201.80, -2235.80,   110.90},
	{ "Ocean Docks",                  2201.80, -2730.80,   -89.00,  2324.00, -2418.30,   110.90},
	{ "Ocean Docks",                  2703.50, -2302.30,   -89.00,  2959.30, -2126.90,   110.90},
	{ "Ocean Docks",                  2324.00, -2145.10,   -89.00,  2703.50, -2059.20,   110.90},
	{ "Ocean Flats",                 -2994.40,   277.40,    -9.10, -2867.80,   458.40,   200.00},
	{ "Ocean Flats",                 -2994.40,  -222.50,    -0.00, -2593.40,   277.40,   200.00},
	{ "Ocean Flats",                 -2994.40,  -430.20,    -0.00, -2831.80,  -222.50,   200.00},
	{ "Octane Springs",                338.60,  1228.50,     0.00,   664.30,  1655.00,   200.00},
	{ "Old Venturas Strip",           2162.30,  2012.10,   -89.00,  2685.10,  2202.70,   110.90},
	{ "Palisades",                   -2994.40,   458.40,    -6.10, -2741.00,  1339.60,   200.00},
	{ "Palomino Creek",               2160.20,  -149.00,     0.00,  2576.90,   228.30,   200.00},
	{ "Paradiso",                    -2741.00,   793.40,    -6.10, -2533.00,  1268.40,   200.00},
	{ "Pershing Square",              1440.90, -1722.20,   -89.00,  1583.50, -1577.50,   110.90},
	{ "Pilgrim",                      2437.30,  1383.20,   -89.00,  2624.40,  1783.20,   110.90},
	{ "Pilgrim",                      2624.40,  1383.20,   -89.00,  2685.10,  1783.20,   110.90},
	{ "Pilson Intersection",          1098.30,  2243.20,   -89.00,  1377.30,  2507.20,   110.90},
	{ "Pirates in Men's Pants",       1817.30,  1469.20,   -89.00,  2027.40,  1703.20,   110.90},
	{ "Playa del Seville",            2703.50, -2126.90,   -89.00,  2959.30, -1852.80,   110.90},
	{ "Prickle Pine",                 1534.50,  2583.20,   -89.00,  1848.40,  2863.20,   110.90},
	{ "Prickle Pine",                 1117.40,  2507.20,   -89.00,  1534.50,  2723.20,   110.90},
	{ "Prickle Pine",                 1848.40,  2553.40,   -89.00,  1938.80,  2863.20,   110.90},
	{ "Prickle Pine",                 1938.80,  2624.20,   -89.00,  2121.40,  2861.50,   110.90},
	{ "Queens",                      -2533.00,   458.40,     0.00, -2329.30,   578.30,   200.00},
	{ "Queens",                      -2593.40,    54.70,     0.00, -2411.20,   458.40,   200.00},
	{ "Queens",                      -2411.20,   373.50,     0.00, -2253.50,   458.40,   200.00},
	{ "Randolph Industrial Estate",   1558.00,   596.30,   -89.00,  1823.00,   823.20,   110.90},
	{ "Redsands East",                1817.30,  2011.80,   -89.00,  2106.70,  2202.70,   110.90},
	{ "Redsands East",                1817.30,  2202.70,   -89.00,  2011.90,  2342.80,   110.90},
	{ "Redsands East",                1848.40,  2342.80,   -89.00,  2011.90,  2478.40,   110.90},
	{ "Redsands West",                1236.60,  1883.10,   -89.00,  1777.30,  2142.80,   110.90},
	{ "Redsands West",                1297.40,  2142.80,   -89.00,  1777.30,  2243.20,   110.90},
	{ "Redsands West",                1377.30,  2243.20,   -89.00,  1704.50,  2433.20,   110.90},
	{ "Redsands West",                1704.50,  2243.20,   -89.00,  1777.30,  2342.80,   110.90},
	{ "Regular Tom",                  -405.70,  1712.80,    -3.00,  -276.70,  1892.70,   200.00},
	{ "Richman",                       647.50, -1118.20,   -89.00,   787.40,  -954.60,   110.90},
	{ "Richman",                       647.50,  -954.60,   -89.00,   768.60,  -860.60,   110.90},
	{ "Richman",                       225.10, -1369.60,   -89.00,   334.50, -1292.00,   110.90},
	{ "Richman",                       225.10, -1292.00,   -89.00,   466.20, -1235.00,   110.90},
	{ "Richman",                        72.60, -1404.90,   -89.00,   225.10, -1235.00,   110.90},
	{ "Richman",                        72.60, -1235.00,   -89.00,   321.30, -1008.10,   110.90},
	{ "Richman",                       321.30, -1235.00,   -89.00,   647.50, -1044.00,   110.90},
	{ "Richman",                       321.30, -1044.00,   -89.00,   647.50,  -860.60,   110.90},
	{ "Richman",                       321.30,  -860.60,   -89.00,   687.80,  -768.00,   110.90},
	{ "Richman",                       321.30,  -768.00,   -89.00,   700.70,  -674.80,   110.90},
	{ "Robada Intersection",         -1119.00,  1178.90,   -89.00,  -862.00,  1351.40,   110.90},
	{ "Roca Escalante",               2237.40,  2202.70,   -89.00,  2536.40,  2542.50,   110.90},
	{ "Roca Escalante",               2536.40,  2202.70,   -89.00,  2625.10,  2442.50,   110.90},
	{ "Rockshore East",               2537.30,   676.50,   -89.00,  2902.30,   943.20,   110.90},
	{ "Rockshore West",               1997.20,   596.30,   -89.00,  2377.30,   823.20,   110.90},
	{ "Rockshore West",               2377.30,   596.30,   -89.00,  2537.30,   788.80,   110.90},
	{ "Rodeo",                          72.60, -1684.60,   -89.00,   225.10, -1544.10,   110.90},
	{ "Rodeo",                          72.60, -1544.10,   -89.00,   225.10, -1404.90,   110.90},
	{ "Rodeo",                         225.10, -1684.60,   -89.00,   312.80, -1501.90,   110.90},
	{ "Rodeo",                         225.10, -1501.90,   -89.00,   334.50, -1369.60,   110.90},
	{ "Rodeo",                         334.50, -1501.90,   -89.00,   422.60, -1406.00,   110.90},
	{ "Rodeo",                         312.80, -1684.60,   -89.00,   422.60, -1501.90,   110.90},
	{ "Rodeo",                         422.60, -1684.60,   -89.00,   558.00, -1570.20,   110.90},
	{ "Rodeo",                         558.00, -1684.60,   -89.00,   647.50, -1384.90,   110.90},
	{ "Rodeo",                         466.20, -1570.20,   -89.00,   558.00, -1385.00,   110.90},
	{ "Rodeo",                         422.60, -1570.20,   -89.00,   466.20, -1406.00,   110.90},
	{ "Rodeo",                         466.20, -1385.00,   -89.00,   647.50, -1235.00,   110.90},
	{ "Rodeo",                         334.50, -1406.00,   -89.00,   466.20, -1292.00,   110.90},
	{ "Royal Cassino",                2087.30,  1383.20,   -89.00,  2437.30,  1543.20,   110.90},
	{ "San Andreas Sound",            2450.30,   385.50,  -100.00,  2759.20,   562.30,   200.00},
	{ "Santa Flora",                 -2741.00,   458.40,    -7.60, -2533.00,   793.40,   200.00},
	{ "Praia de Santa Maria",          342.60, -2173.20,   -89.00,   647.70, -1684.60,   110.90},
	{ "Praia de Santa Maria",           72.60, -2173.20,   -89.00,   342.60, -1684.60,   110.90},
	{ "Shady Cabin",                 -1632.80, -2263.40,    -3.00, -1601.30, -2231.70,   200.00},
	{ "Shady Creeks",                -1820.60, -2643.60,    -8.00, -1226.70, -1771.60,   200.00},
	{ "Shady Creeks",                -2030.10, -2174.80,    -6.10, -1820.60, -1771.60,   200.00},
	{ "Sobell Rail Yards",            2749.90,  1548.90,   -89.00,  2923.30,  1937.20,   110.90},
	{ "Spinybed",                     2121.40,  2663.10,   -89.00,  2498.20,  2861.50,   110.90},
	{ "Starfish Cassino",             2437.30,  1783.20,   -89.00,  2685.10,  2012.10,   110.90},
	{ "Starfish Cassino",             2437.30,  1858.10,   -39.00,  2495.00,  1970.80,    60.90},
	{ "Starfish Cassino",             2162.30,  1883.20,   -89.00,  2437.30,  2012.10,   110.90},
	{ "Temple",                       1252.30, -1130.80,   -89.00,  1378.30, -1026.30,   110.90},
	{ "Temple",                       1252.30, -1026.30,   -89.00,  1391.00,  -926.90,   110.90},
	{ "Temple",                       1252.30,  -926.90,   -89.00,  1357.00,  -910.10,   110.90},
	{ "Temple",                        952.60, -1130.80,   -89.00,  1096.40,  -937.10,   110.90},
	{ "Temple",                       1096.40, -1130.80,   -89.00,  1252.30, -1026.30,   110.90},
	{ "Temple",                       1096.40, -1026.30,   -89.00,  1252.30,  -910.10,   110.90},
	{ "The Camel's Toe",              2087.30,  1203.20,   -89.00,  2640.40,  1383.20,   110.90},
	{ "The Clown's Pocket",           2162.30,  1783.20,   -89.00,  2437.30,  1883.20,   110.90},
	{ "The Emerald Isle",             2011.90,  2202.70,   -89.00,  2237.40,  2508.20,   110.90},
	{ "Fazenda Sky",                 -1209.60, -1317.10,   114.90,  -908.10,  -787.30,   251.90},
	{ "The Four Dragons Casino",      1817.30,   863.20,   -89.00,  2027.30,  1083.20,   110.90},
	{ "The High Roller",              1817.30,  1283.20,   -89.00,  2027.30,  1469.20,   110.90},
	{ "The Mako Span",                1664.60,   401.70,     0.00,  1785.10,   567.20,   200.00},
	{ "The Panopticon",               -947.90,  -304.30,    -1.10,  -319.60,   327.00,   200.00},
	{ "The Pink Swan",                1817.30,  1083.20,   -89.00,  2027.30,  1283.20,   110.90},
	{ "The Sherman Dam",              -968.70,  1929.40,    -3.00,  -481.10,  2155.20,   200.00},
	{ "The Strip",                    2027.40,   863.20,   -89.00,  2087.30,  1703.20,   110.90},
	{ "The Strip",                    2106.70,  1863.20,   -89.00,  2162.30,  2202.70,   110.90},
	{ "The Strip",                    2027.40,  1783.20,   -89.00,  2162.30,  1863.20,   110.90},
	{ "The Strip",                    2027.40,  1703.20,   -89.00,  2137.40,  1783.20,   110.90},
	{ "The Visage",                   1817.30,  1863.20,   -89.00,  2106.70,  2011.80,   110.90},
	{ "The Visage",                   1817.30,  1703.20,   -89.00,  2027.40,  1863.20,   110.90},
	{ "Unity Station",                1692.60, -1971.80,   -20.40,  1812.60, -1932.80,    79.50},
	{ "Valle Ocultado",               -936.60,  2611.40,     2.00,  -715.90,  2847.90,   200.00},
	{ "Verdant Bluffs",                930.20, -2488.40,   -89.00,  1249.60, -2006.70,   110.90},
	{ "Verdant Bluffs",               1073.20, -2006.70,   -89.00,  1249.60, -1842.20,   110.90},
	{ "Verdant Bluffs",               1249.60, -2179.20,   -89.00,  1692.60, -1842.20,   110.90},
	{ "Verdant Meadows",                37.00,  2337.10,    -3.00,   435.90,  2677.90,   200.00},
	{ "Praia de Verona",               647.70, -2173.20,   -89.00,   930.20, -1804.20,   110.90},
	{ "Praia de Verona",               930.20, -2006.70,   -89.00,  1073.20, -1804.20,   110.90},
	{ "Praia de Verona",               851.40, -1804.20,   -89.00,  1046.10, -1577.50,   110.90},
	{ "Praia de Verona",              1161.50, -1722.20,   -89.00,  1323.90, -1577.50,   110.90},
	{ "Praia de Verona",              1046.10, -1722.20,   -89.00,  1161.50, -1577.50,   110.90},
	{ "Vinewood",                      787.40, -1310.20,   -89.00,   952.60, -1130.80,   110.90},
	{ "Vinewood",                      787.40, -1130.80,   -89.00,   952.60,  -954.60,   110.90},
	{ "Vinewood",                      647.50, -1227.20,   -89.00,   787.40, -1118.20,   110.90},
	{ "Vinewood",                      647.70, -1416.20,   -89.00,   787.40, -1227.20,   110.90},
	{ "Whitewood Estates",             883.30,  1726.20,   -89.00,  1098.30,  2507.20,   110.90},
	{ "Whitewood Estates",            1098.30,  1726.20,   -89.00,  1197.30,  2243.20,   110.90},
	{ "Willowfield",                  1970.60, -2179.20,   -89.00,  2089.00, -1852.80,   110.90},
	{ "Willowfield",                  2089.00, -2235.80,   -89.00,  2201.80, -1989.90,   110.90},
	{ "Willowfield",                  2089.00, -1989.90,   -89.00,  2324.00, -1852.80,   110.90},
	{ "Willowfield",                  2201.80, -2095.00,   -89.00,  2324.00, -1989.90,   110.90},
	{ "Willowfield",                  2541.70, -1941.40,   -89.00,  2703.50, -1852.80,   110.90},
	{ "Willowfield",                  2324.00, -2059.20,   -89.00,  2541.70, -1852.80,   110.90},
	{ "Willowfield",                  2541.70, -2059.20,   -89.00,  2703.50, -1941.40,   110.90},
	{ "Yellow Bell Station",          1377.40,  2600.40,   -21.90,  1492.40,  2687.30,    78.00},
	{ "~g~Los Santos",                  44.60, -2892.90,  -242.90,  2997.00,  -768.00,   900.00},
	{ "~y~Las Venturas",               869.40,   596.30,  -242.90,  2997.00,  2993.80,   900.00},
	{ "Bone County",                  -480.50,   596.30,  -242.90,   869.40,  2993.80,   900.00},
	{ "Tierra Robada",               -2997.40,  1659.60,  -242.90,  -480.50,  2993.80,   900.00},
	{ "Tierra Robada",               -1213.90,   596.30,  -242.90,  -480.50,  1659.60,   900.00},
	{ "~r~San Fierro",               -2997.40, -1115.50,  -242.90, -1213.90,  1659.60,   900.00},
	{ "Red County",                  -1213.90,  -768.00,  -242.90,  2997.00,   596.30,   900.00},
	{ "Flint County",                -1213.90, -2892.90,  -242.90,    44.60,  -768.00,   900.00},
    { "Whetstone",                   -2997.40, -2892.90,  -242.90, -1213.90, -1115.50,   900.00}
};
//______________________________________________________________________________

main()
{
	print("\n----------------------------------------------");
	print("_:::..|-BRASIL CIDADE LIVRE®-|..:::_   |-BCL-|");
	print("----------------------------------------------\n");
    printf("Numero de objetos carregados: %d",Streamer_CountItems(STREAMER_OBJECT_TYPE_GLOBAL,1));
    printf("Numero de veículos carregados: %d",countVehicle);
}

public OnGameModeInit()
{
    CarsAdmin = LoadModelSelectionMenu("CarsAdmin.txt");
    SkinAdmin = LoadModelSelectionMenu("skins.txt");
    Acessorios = LoadModelSelectionMenu("Acessorios.txt");

    //Carregar Veiculos
    LoadVehicleFromFile("vPizzaBoyLs.txt",vPizzaBoy);
    LoadVehicleFromFile("vCaminhoeiroLs.txt",vCaminhao);
    LoadVehicleFromFile("vAeroLs.txt",vAeroCarg);
    LoadVehicleFromFile("vPetroleiro.txt",vPetroleiro);
    LoadVehicleFromFile("vCorreios.txt",vCorreios);
    //Carregar Objetos
    LoadObjectFromFile("pPetroleiro.txt");

    AeroC = GangZoneCreate(1921.057739, -2651.680908, 2094.536132, -2611.698974);
    GangZoneCreateEx(2099.1538,-1806.8820,30.0, gzPizzaboyLs);
    GangZoneCreateEx(2761.0984,-2457.5835,30.0, gzCaminhoneiro);
    //__________________________________________________________________________
    LoadTextDrawsGlobal();
    #if defined HostNameUser
    SetGameModeText(GAMEMOD_NOME);
    SendRconCommand(MAPA_NOME);
    SendRconCommand(SERVER_NOME);
    SendRconCommand(LANGUAGE_SERVER);
	#endif

    EnableStuntBonusForAll(false);
    SetNameTagDrawDistance(80.0);
    UsePlayerPedAnims();

    TimersT[0] = SetTimer("Speedo",100, true);
    TimersT[1] = SetTimer("Combustivel", (2 * 60 * 1000), true); //20800 2 * 4 * 2600
    TimersT[2] = SetTimer("Cronometro", (1 * 60 * 1000), true);  // 1 minuto
    TimersT[3] = SetTimer("Locais", 3000, true);
    TimersT[4] = SetTimer("RandMesagens",(10 * 60 * 1000), true); //10 minutos


    SqL = mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DB);
    mysql_log(WARNING | ERROR);

    if(!mysql_errno(SqL))print("->> Conectado com sucesso ao |BANCO de DADOS|.");
    else print("<<- Erro ao conectar ao x|BANCO de DADOS|x.");
    return 1;
}

public OnGameModeExit()
{
    Loop(t,10)
    {
       KillTimer(TimersT[t]);
    }
    mysql_close(SqL);
    return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    if(!PlayerInfo[playerid][Logged])
    {
        new pName[MAX_PLAYER_NAME];
        GetPlayerName(playerid, pName, MAX_PLAYER_NAME);

        SetPlayerSkin(playerid,PlayerInfo[playerid][Skin]);

        new rand = random(sizeof(RquestCam));
        SetPlayerPos(playerid, RquestCam[rand][0], RquestCam[rand][1],RquestCam[rand][2]);
        SetPlayerFacingAngle(playerid, RquestCam[rand][3]);
        SetPlayerCameraPos(playerid, RquestCam[rand][0],RquestCam[rand][1]-4.3,RquestCam[rand][2]+0.5);
        SetPlayerCameraLookAt(playerid, RquestCam[rand][0]-1.7, RquestCam[rand][1], RquestCam[rand][2],CAMERA_CUT);

        CleanChatBox(playerid,30);

        SendClientMessage(playerid,Vermelho,"~~~~~~~~~~~~~~~~~~~~~~~~~~~:)(:~~~~~~~~~~~~~~~~~~~~~");
        SendClientMessage(playerid,-1,"Bem vindo(a) ao {00BB00}Brasil Cidade Livre {A5F8F5}[BCL]. {FFFFFF}Para mais ajuda /C");
        SendClientMessage(playerid,Vermelho,"~~~~~~~~~~~~~~~~~~~~~~~~~~~:)(:~~~~~~~~~~~~~~~~~~~~~");

        mysql_format(SqL, Query, sizeof(Query), "SELECT * FROM `contas` WHERE `Usuario` = '%s'",pName);
        mysql_query(SqL,Query,true);

        if(cache_num_rows() > 0)
        {//Se o Usuario existe
            format(STRX, sizeof(STRX), TEXTO_LOGIN, pName);
            ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{F5F5F5}Login", STRX, "Logar", "Sair");
        }
        else
        {//Ususario não existe
            format(STRX, sizeof(STRX), TEXTO_REGISTRO, pName);
            ShowPlayerDialog(playerid, DIALOG_REGISTRO, DIALOG_STYLE_PASSWORD, "{F5F5F5}Registro", STRX, "Registrar", "Sair");
        }
    }
    return 1;
}
public OnPlayerRequestSpawn(playerid)return 0;

public OnIncomingConnection(playerid, ip_address[], port)
{
    if(!strcmp(IncomingConnection[IncomingIP], ip_address, true) && IncomingConnection[IncomingTempo] > gettime())
    {
        if(IncomingConnection[IncomingVezes] > 3) return BlockIpAddress(ip_address, 0), printf("ip_%d:%d Bloqueado!", ip_address, port);
        ++IncomingConnection[IncomingVezes];
        return Kick(playerid);
    }
    format(IncomingConnection[IncomingIP], 16, ip_address);
    IncomingConnection[IncomingVezes] = 0;
    IncomingConnection[IncomingTempo] = gettime()+2;
    return 1;
}

public OnPlayerConnect(playerid)
{

    CleanChatBox(playerid,35);

    LoadPlayerTextsDraws(playerid);
    AimbotWarnings[playerid] = 0;

    SendClientMessage(playerid,0x00F0F0AA,"Carregando Dados.");

    CheckForPlayerBd(playerid);
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    new pName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pName, MAX_PLAYER_NAME);

    if(PlayerInfo[playerid][Logged] == true)
    {
        GetPlayerPos(playerid,PlayerInfo[playerid][Casa][0],PlayerInfo[playerid][Casa][1],PlayerInfo[playerid][Casa][2]);

        mysql_format(SqL, Query, sizeof(Query), "UPDATE `contas` SET `skin` = '%d',`aAdmin` = '%d',\
       `Gasolina` = '%d',`Etanol` = '%d',`Diesel` = '%d',`GNV` = '%d', `CasaX` = '%f', `CasaY` = '%f', `CasaZ` = '%f',\
       `Dinheiro` = '%d', `cBancario` = '%d', `sBancario` = '%d', `Profissao` = '%d' WHERE `Usuario` = '%s'",
        PlayerInfo[playerid][Skin],
        pAdmin[playerid],
        PlayerInfo[playerid][Comb][0],
        PlayerInfo[playerid][Comb][1],
        PlayerInfo[playerid][Comb][2],
        PlayerInfo[playerid][Comb][3],
        PlayerInfo[playerid][Casa][0],
        PlayerInfo[playerid][Casa][1],
        PlayerInfo[playerid][Casa][2],
        GetPVarMoney(playerid),
        PlayerInfo[playerid][cBanc],
        PlayerInfo[playerid][sBancario],
        PlayerInfo[playerid][Profissao], pName);
        mysql_query(SqL, Query, true);

        for(new i; i != _:pInfo; ++i)//http://forum.sa-mp.com/showthread.php?t=587095
        PlayerInfo[playerid][pInfo:i] = 0;

        ResetPVarMoney(playerid);
        pAdmin[playerid] = 0;
        admin[playerid] = 0;
        Duvid[playerid] = "";
        Notifc[playerid] = "";
        DestinoCarg[playerid] = false;
        ResetHoldObjects(playerid);
        DeleteTextDraws(playerid);
    }
    return 1;
}

public OnPlayerSpawn(playerid)
{
    SetPlayerSkin(playerid, PlayerInfo[playerid][Skin]);
    SetPlayerObjects(playerid);
    TextDrawShowForPlayer(playerid,txtTimeDisp);
    ResetPlayerWeapons(playerid);

   // GivePVarMoney(playerid,100000);
    return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    GivePlayerMoney(playerid, 100);

    GameTextForPlayer(playerid,"Detonado",1000,2);

    SendDeathMessage(killerid, playerid, reason);

    if(DestinoCarg[playerid]==true)
    {
        DestinoCarg[playerid]=false;
        DisablePlayerCheckpoint(playerid);
        DeletePVar(playerid,"CargItem");
    }
    return 1;
}

public OnVehicleSpawn(vehicleid)
{
    if(vehicleid != INVALID_VEHICLE_ID)
    {
        SetVehicleParamsEx(vehicleid,VEHICLE_PARAMS_OFF,lights,alarm,doors,bonnet,boot,objective);
    }
    return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
    SetVheicleNeon(vehicleid, 6);
    return 1;
}

public OnPlayerText(playerid, text[])
{
    new strText[80];  //75

    if(!PlayerInfo[playerid][Logged])
       return SendClientMessage(playerid, Vermelho, "Você não esta logado."),0;
    if(ContFlood[playerid][1] > GetTickCount())
       return SendClientMessage(playerid, Amarelo, "|ANTI_CHAT_FLOOD|"),0;
    ContFlood[playerid][1] = GetTickCount() + 2000;

    format(strText,sizeof(strText),"[ID: %d] %s",playerid,text);
    SendPlayerMessageToAll(playerid,strText);
    return 0;
}

public OnPlayerCommandReceived(playerid, cmdtext[])
{
	if(!PlayerInfo[playerid][Logged])
	    return SendClientMessage(playerid,Vermelho,"[ERRO]: Você não tem permissão para usar comando neste momento."),0;

    if(ContFlood[playerid][0] > GetTickCount())
        return SendClientMessage(playerid, Amarelo, "|ANTI_COMANDO_FLOOD|"), 0;
    ContFlood[playerid][0] = GetTickCount() + 2000;

 	if(GetPlayerState(playerid) == PLAYER_STATE_WASTED)
        return 0;
    return 1;
}

CMD:cp(playerid,params[])
{
    new pName[MAX_PLAYER_NAME], msgCp[128],Cpmsg[128];
    GetPlayerName(playerid, pName, sizeof(pName));

    if(sscanf(params,"s[128]",Cpmsg))return SendClientMessage(playerid, Vermelho, "(ChatProfissão) {7FFFD4}USE: /cp [TEXTO]");
    {
         foreach(new i : Player)
         {
             switch(PlayerInfo[i][Profissao])
             {
                 case PROF_DESENPREGADOS: format(msgCp, sizeof(msgCp),"[ChatProfissão] %s[ID: %d] {-1}%s",pName,i,Cpmsg);
                 case PROF_CAMINHOEIRPLS: format(msgCp, sizeof(msgCp),"[ChatProfissão] %s[ID: %d] {FFFFFF}%s",pName,i,Cpmsg);
                 case PROF_AERONAVPILOTO: format(msgCp, sizeof(msgCp),"[ChatProfissão] %s[ID: %d] {FFFFFF}%s",pName,i,Cpmsg);
             }
             SendClientMessage(i,GetPlayerColor(playerid), msgCp);
         }
    }
    return 1;
}

//____________________________COMANDO DE PROFISSOES_____________________________
CMD:carregar(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);

    switch(PlayerInfo[playerid][Profissao])
    {
        case PROF_CAMINHOEIRPLS:
        {
            if(!PlayerToPoint(9.0, playerid, 2760.2341,-2449.9563,14.5394))return CmdErrorMessagePlayer(playerid);
            {
                if(DestinoCarg[playerid] == true)return SendClientMessage(playerid,Vermelho,"Você já carregou seu veiculo.");
                {
                    if(GetVehicleModel(vehicleid) != 515)return SendClientMessage(playerid,Vermelho,"Você precisa de um caminhão.");
                    {
                        if(GetVehicleModel(GetVehicleTrailer(vehicleid)) != 435)return SendClientMessage(playerid,Vermelho,"Você precisa do bau para carregar.");
                        {
                            ShowPlayerDialog(playerid, DIALOG_CARGAS, DIALOG_STYLE_TABLIST_HEADERS, "DESTINO",
                            "Estado\tLocal \tPreço do Frete\
                            \nLos Santos   \tFallen Tree \t$600,00  \
                            \nLos Santos   \tReed County \t$660,00  \
                            \nLas Venturas \tWhitewood Estates \t$700,00  \
                            \nLas Venturas \tSpinybed \t$750,00  \
                            \nSan Fierro   \tDoherty \t$800,00",\
                            "Carregar", "Cancelar");
                        }
                    }
                }
            }
        }
        case PROF_AERONAVPILOTO:
        {
            if(!IsPlayerInArea(playerid, 1921.057739, -2651.680908, 2094.536132, -2611.698974))return CmdErrorMessagePlayer(playerid);
            {
                if(DestinoCarg[playerid] == true)return SendClientMessage(playerid,Vermelho,"Você já carregou sua Aeronave.");
                {
                    if(GetVehicleModel(vehicleid) != 592)return SendClientMessage(playerid,Vermelho,"Você precisa de uma aeronave de carga.");
                    {
                        ShowPlayerDialog(playerid, DIALOG_CARGAS, DIALOG_STYLE_TABLIST_HEADERS, "DESTINO",
                        "Estado\tLocal \tPreço do Frete\
                        \nLas Venturas \tAeroporto \t$800,00 \
                        \nSan Fierro   \tAeroPoro \t$860,00",\
                        "Carregar", "Cancelar");
                    }
                }
            }
        }
        case PROF_PETROLEIRO:
        {
            if(!IsPlayerInArea(playerid, 144.952087, 1404.051757, 155.007614, 1420.670776))return CmdErrorMessagePlayer(playerid);
            {
                if(DestinoCarg[playerid] == true)return SendClientMessage(playerid,Vermelho,"Você já carregou seu caminhão.");
                {
                    if(GetVehicleModel(vehicleid) != 514)return SendClientMessage(playerid,Vermelho,"Você precisa de um caminhão.");
                    {
                        if(GetVehicleModel(GetVehicleTrailer(vehicleid)) != 584)return SendClientMessage(playerid,Vermelho,"Você precisa do tanque para carregar.");
                        {
                            ShowPlayerDialog(playerid, DIALOG_CARGAS, DIALOG_STYLE_TABLIST, "DESTINO",
                            "Bone County \nFort Carson \nTierra Robada \nTierra Robada 1 \nJuniper Hill\
                            \nEaster Basin \nAngel Pine \nWhetstone \nFlint County \nMontgomery \nDillimor \nMulholland \
                            \nIdlewood \nLas Venturas \nCome-A-Lot \nRedsands West", "Carregar", "Cancelar");
                        }
                    }
                }
            }
        }
        default:CmdErrorMessagePlayer(playerid);
    }
    return 1;
}
CMD:pegarpizza(playerid, params[])
{
    if(!PlayerToPoint(8.0, playerid, 2096.3174,-1806.4795,13.1165))return CmdErrorMessagePlayer(playerid);
    {
        if(DestinoCarg[playerid] == true)return SendClientMessage(playerid,Vermelho,"Você já pegou uma pizza para entregar.  ( ; ");
        {
            if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 448)return SendClientMessage(playerid,Vermelho,"Você não esta no veículo correto.  ( ; ");
            {
                switch(PlayerInfo[playerid][Profissao])
                {
                    case PROF_PIZZABOYLS:
                    {
                        new rand = random(sizeof(PizzaBoyLs));
                        SetPlayerCheckpoint(playerid,PizzaBoyLs[rand][0],PizzaBoyLs[rand][1],PizzaBoyLs[rand][2],3.5);
                        DestinoCarg[playerid] = true;
                        SendClientMessage(playerid,Verde,"Vá ate a marca vermelha no mapa para entregar.  ( : ");
                    }
                }
             }
        }
    }
    return 1;
}
//______________________________________________________________________________
//Comandos do Usuario
CMD:c(playerid,params[])
{
    ShowPlayerDialog(playerid, DIALOG_PLAYER, DIALOG_STYLE_LIST, "Menu Do Usuário", "+Você \nAjuda \nVip", "Ver", "Cancelar");
    return 1;
}
CMD:status(playerid,params[])
{
    new strSP[250], TexTprf[50],pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pName, MAX_PLAYER_NAME);

    switch(PlayerInfo[playerid][Profissao])
    {
        case PROF_DESENPREGADOS: TexTprf = "Desempregado";
        case PROF_CAMINHOEIRPLS: TexTprf = "Caminhoneiro";
        case PROF_AERONAVPILOTO: TexTprf = "Piloto de Avião de Cargas";
        case PROF_PETROLEIRO: TexTprf = "Petroleiro";
    }

    format(strSP,sizeof(strSP),"Sua ID no servidor: %d\
    \nSua Skin: %d\
    \nProfissão: %s\
    \nSaldo Bancarío: $%s,00\
    \nGasolina: %d Litros\
    \nEtanol: %d Litros\
    \nDiesel: %d Litros\
    \nGNV: %d Litros",playerid,PlayerInfo[playerid][Skin],TexTprf,convertNumber(PlayerInfo[playerid][sBancario], "."),PlayerInfo[playerid][Comb][0],PlayerInfo[playerid][Comb][1],PlayerInfo[playerid][Comb][2],PlayerInfo[playerid][Comb][3]);

    ShowPlayerDialog(playerid, DIALOG_STATUS, DIALOG_STYLE_MSGBOX,  pName, strSP, "OK","");
    return 1;
}

CMD:mp(playerid, params[])
{
    new id, pName[MAX_PLAYER_NAME],Str[60],str[128];
	GetPlayerName(playerid, pName, MAX_PLAYER_NAME);

    if(sscanf(params, "us[20]",id,Notifc[id]))return SendClientMessage(playerid,Vermelho,"Use: /mp [id] ou [Nick] [texto]");
    {
        if(!IsPlayerConnected(id))return SendClientMessage(playerid, Vermelho, "Este jogador não está conectado.");
        {
            format(Str, sizeof(Str), "Voce recebeu uma mensagem de: ~b~%s",pName);
            format(str, sizeof(str), "Nick: %s \nID: %d \n\n%s",pName,playerid, Notifc[id]);
            PlayerTextDrawShow(id,Notificacoes[id]);
            PlayerTextDrawSetString(id, Notificacoes[id], Str);
            SetTimerEx("DeletNotifc", 5000, false, "i", id);
            Notifc[id]=str,NotficL[id]=1;
            SendClientMessage(id, Verde, "Para ler sua mensagem digite [ /Ler ]");
            SendClientMessage(playerid, Verde, "Mensagem enviada com sucesso.");
        }
    }
    return 1;
}

CMD:ler(playerid,params[])
{
   if(!NotficL[playerid])return CmdErrorMessagePlayer(playerid);
   {
       ShowPlayerDialog(playerid, DIALOG_NOTIFICACAO, DIALOG_STYLE_MSGBOX, "Mensagem Particular", Notifc[playerid], "OK", "");
       Notifc[playerid] = "Você não te mensagen para ler.",NotficL[playerid]=0;
   }
   return 1;
}

CMD:lr(playerid,params[])
{
   if(!Dresp[playerid])return CmdErrorMessagePlayer(playerid);
   {
       ShowPlayerDialog(playerid, DIALOG_NOTIFICACAO, DIALOG_STYLE_MSGBOX, "Duvida Respondida.", _DuvidResp[playerid], "OK", "");
       Dresp[playerid] = 0;
   }
   return 1;
}

CMD:reporta(playerid, params[])
{
    new pName[MAX_PLAYER_NAME],Str[60],str[128];
	GetPlayerName(playerid, pName, MAX_PLAYER_NAME);

    if(DuvidResp)return SendClientMessage(playerid,Vermelho,"Aguarde um momento para emviar uma duvida ao admin.");
    {
        foreach(new i : Player)
        {
            if(pAdmin[i] > 0 && !IsPlayerConnected(i))return SendClientMessage(playerid,Vermelho,"Não há administradores oline. Por favor tente mais tarde. Obrigado.");
            {
                if(sscanf(params, "s[20]",Duvid[i]))return SendClientMessage(playerid,Vermelho,"Use: /reporta [texto]");
                {
                    format(Str, sizeof(Str), "O ~y~%s ~w~lhe emviou uma mensagem!",pName);
                    format(str, sizeof(str), "Nick: %s \nID: %d \n\n%s",pName,playerid, Duvid[i]);
                    PlayerTextDrawShow(i,Notificacoes[i]);
                    PlayerTextDrawSetString(i, Notificacoes[i], Str);
                    SetTimerEx("DeletNotifc", 5000, false, "i", i);
                    DuvidResp=1,Duvid[i]=str,InfoPlayerResp[i]=pName,DuvidpLer[i]=1;
                    SendClientMessage(i, Verde, "Para ler a mensagem digite [ /LD ]");
                    SendClientMessage(playerid, Verde, "Mensagem enviada com sucesso.");
                }
            }
        }
    }
    return 1;
}
//______________________________________________________________________________

CMD:y(playerid, params[])
{
    new vid = GetPlayerVehicleID(playerid);

    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
        if(ChangeVehicleGasolina(vid))
        {
           if(!PlayerInfo[playerid][Comb][0])return SendClientMessage(playerid,Vermelho,"Abasteça sua Gasolina para andar no carro.");
           ToggleVehicleEngine(vid);
        }
        if(ChangeVehicleEtanol(vid))
        {
           if(!PlayerInfo[playerid][Comb][1])return SendClientMessage(playerid,Vermelho,"Abasteça seu Etanol para andar no carro.");
           ToggleVehicleEngine(vid);
        }
        if(ChangeVehicleDiesel(vid))
        {
           if(!PlayerInfo[playerid][Comb][2])return SendClientMessage(playerid,Vermelho,"Abastesa seu Diesel para andar no veiculo.");
           ToggleVehicleEngine(vid);
        }
        if(ChangeVehicleGnv(vid))
        {
           if(!PlayerInfo[playerid][Comb][3])return SendClientMessage(playerid,Vermelho,"Abastesa sua GNV para andar na aeronave.");
           ToggleVehicleEngine(vid);
        }
    }
    return 1;
}

CMD:abastecer(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid), string[128];
    if(AreaPosto[playerid] == true)
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
            format(string, sizeof(string), "Você pode abastecer outros combustíveis fora do carro.");
        	if(ChangeVehicleGasolina(vehicleid))
        	{
        		SendClientMessage(playerid, Azul, string);
        		ShowPlayerDialog(playerid, DIALOG_PGASOLINA, DIALOG_STYLE_INPUT, "{C4C400}Gasolina", "Digite a Qunatia de gasolina \nO máximo e 60 litros \nE custa 2$ o litro.", "Abastecer", "Cancelar");
        	}
        	if(ChangeVehicleEtanol(vehicleid))
        	{
        		SendClientMessage(playerid, Azul, string);
        		ShowPlayerDialog(playerid, DIALOG_PETANOL, DIALOG_STYLE_INPUT, "{0080C0}Etanol", "Digite a Qunatia de Etanol \nO máximo e 60 litros \nE custa 2$ o litro.", "Abastecer","Cancelar");
        	}
        	if(ChangeVehicleDiesel(vehicleid))
        	{
        		SendClientMessage(playerid, Azul, string);
        		ShowPlayerDialog(playerid, DIALOG_PDIESEL, DIALOG_STYLE_INPUT, "{AE5700}Diesel", "Digite a Qunatia de Diesel \nO máximo e 250 litros \nE custa 3$ o litro.", "Abastecer","Cancelar");
        	}
        	if(ChangeVehicleGnv(vehicleid))
        	{
        		SendClientMessage(playerid, Azul, string);
        		ShowPlayerDialog(playerid, DIALOG_PGNV, DIALOG_STYLE_INPUT, "{00C4C4}GNV", "Digite a Qunatia de GNV \nO máximo e 300 litros \nE custa 4$ o litro.", "Abastecer", "Cancelar");
        	}
        }
    	else ShowPlayerDialog(playerid, DIALOG_COMBUSTIVEIS, DIALOG_STYLE_TABLIST_HEADERS, "Posto De Combustível", "\tCombustivel \tPreço \tLitro \n{C4C400}Gasolina \t\t$2 \t\t1 \n{0080C0}Etanol \t\t$2 \t\t1 \n{AE5700}Diesel \t\t$3 \t\t1 \n{00C4C4}GNV \t\t$4 \t\t1", "Ver", "Cancelar");
    }
    else SendClientMessage(playerid, Vermelho,"Você não esta em um posto de combustível.");
    return 1;
}

CMD:admins(playerid, params[])
{
	new str[250], count = 0, string[250];

    if(isnull(params))
	{
        foreach(new i : Player)
		{
			if(IsPlayerConnected(i))
			{
				if(admin[i])
				{
					switch(pAdmin[i])
                    {
                        case 1:format(str, sizeof(str), "%s (%d) {FF0000}:: {80FFFF}[MOD]\n", GetName(i), i);
    					case 2:format(str, sizeof(str), "%s (%d) {FF0000}:: {80FF80}[ADM]\n", GetName(i), i);
					    case 3:format(str, sizeof(str), "%s (%d) {FF0000}:: {FFFF80}[Chefe]\n", GetName(i), i);
    					case 4:format(str, sizeof(str), "%s (%d) {FF0000}:: {FF8080}[Guardião]\n", GetName(i), i);
    					case 5:format(str, sizeof(str), "%s (%d) {FF0000}:: [Dono]\n", GetName(i), i);
                    }
                    strcat(string, str, sizeof(string)); ++count;
				}
            }
		}
		if(!count)
		{
			ShowPlayerDialog(playerid, DIALOG_ADMINON, DIALOG_STYLE_MSGBOX, ".:: - ADM's Online - ::.", "{FF0000}Não há ADM's online no momento.", "OK", "");
		}
		else ShowPlayerDialog(playerid, DIALOG_ADMINON, DIALOG_STYLE_MSGBOX, ".:: - ADM's Online - ::.", string, "OK", "");
		return 1;
	}
    if(!strcmp(params, "rcon", true))
	{
        foreach(new i : Player)
		{
			if(IsPlayerConnected(i) && IsPlayerAdmin(i))
			{
				format(str, sizeof(str), "{0000FF}%s {FF0000}:: {00FFFF}(ID:%d) {FF0000}\n", GetName(i), i);
				strcat(string, str, sizeof(string));
				++count;
			}
		}
		if(!count)
		{
			ShowPlayerDialog(playerid, DIALOG_ADMINON, DIALOG_STYLE_MSGBOX, ".:: - ADM's RCON Online - ::.", "{FF0000}Não há ADM's RCON online no momento.", "OK", "");
		}
		else ShowPlayerDialog(playerid, DIALOG_ADMINON, DIALOG_STYLE_MSGBOX, ".:: - ADM's RCON Online - ::.", string, "OK", "");
	}
	else SendClientMessage(playerid,Vermelho,"Use {FFFFFF}[ /Admins ] ou [ /Admins Rcon ]");
	return 1;
}

//Comandos Admin logado na RCON
CMD:setar(playerid,params[])
{
   new plid, lvl;
   if(!IsPlayerAdmin(playerid))return CmdErrorMessagePlayer(playerid);
   {
       if(sscanf(params, "ud", plid, lvl))return SendClientMessage(playerid, Vermelho, "Digite: /setadmin [id] [level]");
       {
           if(lvl > 5)return SendClientMessage(playerid, Vermelho,"Não existe ADM acima de 5.");
           {
               if(!IsPlayerConnected(plid))return SendClientMessage(playerid, Azul,"Jogador não encontrado.");
               {
            	   PlayerSetPlayerAdmin(playerid, plid, lvl);
               }
           }
       }
   }
   return 1;
}
// Comandos Admin level 1 a 5
CMD:neon(playerid,params[])
{
	if(!IsPlayerInAnyVehicle(playerid))return SendClientMessage(playerid, Vermelho, "Você precisa de um carro para tunar.");
	{
		ShowPlayerDialog(playerid, DIALOG_NEONS, DIALOG_STYLE_LIST, "Neons", "{00FFFF}Azul\n{00D700}Verde\n{FF0000}Vermelho\n{FFFF00}Amarelo\n{FFFFFF}Branco\n{9955DE}Rosa\n{660000}Nenhum", "Instalar", "Cancelar");
	}
    return 1;
}

CMD:v(playerid,params[])
{
    if(IsPlayerInAnyVehicle(playerid))return SendClientMessage(playerid,Vermelho,"Você não pode criar um veículo dentro de outro.");
    {
		ShowModelSelectionMenu(playerid, CarsAdmin, "BCL");
    }
    return 1;
}

CMD:s(playerid,params[])
{
	ShowModelSelectionMenu(playerid, SkinAdmin, "BCL");
    return 1;
}

CMD:acessorios(playerid,params[])
{
    new string[150];
    Loop(x, MAX_PLAYER_ATTACHED_OBJECTS)
    {
        if(IsPlayerAttachedObjectSlotUsed(playerid, x)) format(string, sizeof(string), "%s%d _(Ocupado)\n", string, x);
        else format(string, sizeof(string), "%s%d\n", string, x);
    }
    ShowPlayerDialog(playerid, DIALOG_ACESSORIOS, DIALOG_STYLE_LIST,"{FF0000}Attachment Modification - Index Selection", string, "Select", "Cancel");
    return 1;
}

CMD:ld(playerid,params[])
{
   if(pAdmin[playerid] < 1)return CmdErrorMessagePlayer(playerid);
   {
       if(!DuvidResp)return SendClientMessage(playerid,Vermelho,"Não há duvidas para ler.");
       {
           ShowPlayerDialog(playerid, DIALOG_NOTIFICACAO, DIALOG_STYLE_MSGBOX, "Duvida !", Duvid[playerid], "OK", "");
           SendClientMessage(playerid, Verde, "Para responder a duvida digite [ /RD ]");
           DuvidResp = 0;
       }
   }
   return 1;
}

CMD:rd(playerid,params[])
{
   new str[70];

   if(pAdmin[playerid] < 1)return CmdErrorMessagePlayer(playerid);
   {
       if(!DuvidpLer[playerid])return SendClientMessage(playerid,Vermelho,"Não há duvidas para ser rspondida.");
       {
           format(str, sizeof(str),"Digite Aki a duvida do player \nNick:[%s] resposta [texto]",InfoPlayerResp[playerid]);
           ShowPlayerDialog(playerid, _DIALOG_NOTIFICACAO, DIALOG_STYLE_INPUT, "Responder Duvida", str, "Responder", "");
           DuvidpLer[playerid] = 0;
       }
   }
   return 1;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
    if(!success)
        return CmdErrorMessagePlayer(playerid);
    return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	new State = GetPlayerState(playerid);

    if(IsPlayerInAnyVehicle(playerid) && State == PLAYER_STATE_DRIVER)
	{
        return SetVehiclePos(vehicleid, fX, fY, fZ);
	}
	SetPlayerInterior(playerid, 0);
	SetPlayerPos(playerid, fX, fY, fZ);
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);

    switch(GetVehicleModel(vehicleid))
	{
		case 509 || 510 || 481: SetVehicleParamsEx(vehicleid,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
	}
    if(!engine)
    {
        if(!ispassenger)
        {
            SendClientMessage(playerid,Verde,"Para ligar ou desligar o veículo precione [Y] ou  comando [/Y].");
        }
    }
    return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}


public OnPlayerStateChange(playerid, newstate, oldstate)
{
    new vehicleid = GetPlayerVehicleID(playerid);

    switch(newstate)
	{
		case PLAYER_STATE_DRIVER:
		{
            if(PlayerInfo[playerid][Profissao] != PROF_CAMINHOEIRPLS)
            {
                Loop(i,21)
    			{
    				if(IsPlayerInVehicle(playerid, vCaminhao[i]))
    				{
    					SendClientMessage(playerid, Vermelho, "Você não é um Caminhoneiro.  ; )");
    					RemovePlayerFromVehicle(playerid);
    				}
    			}
            }
            if(PlayerInfo[playerid][Profissao] != PROF_PETROLEIRO)
            {
                Loop(i,20)
    			{
    				if(IsPlayerInVehicle(playerid, vPetroleiro[i]))
    				{
    					SendClientMessage(playerid, Vermelho, "Você não é um petroleiro.  ; )");
    					RemovePlayerFromVehicle(playerid);
    				}
    			}
            }
            if(PlayerInfo[playerid][Profissao] != PROF_PIZZABOYLS)
            {
                Loop(i,12)
    			{
    				if(IsPlayerInVehicle(playerid, vPizzaBoy[i]))
    				{
    					SendClientMessage(playerid, Vermelho, "Você não é um pizzaboy.  ; )");
    					RemovePlayerFromVehicle(playerid);
    				}
    			}
            }
            if(PlayerInfo[playerid][Profissao] != PROF_AERONAVPILOTO)
            {
                Loop(i,3)
    			{
    				if(IsPlayerInVehicle(playerid, vAeroCarg[i]))
    				{
    					SendClientMessage(playerid, Vermelho, "Você não é piloto de avião de cargas.  ; )");
    					RemovePlayerFromVehicle(playerid);
    				}
    			}
            }
            if(PlayerInfo[playerid][Profissao] != PROF_CORREIOS)
            {
                Loop(i,12)
    			{
    				if(IsPlayerInVehicle(playerid, vCorreios[i]))
    				{
    					SendClientMessage(playerid, Vermelho, "Você não trabalha nos correios.  ; )");
    					RemovePlayerFromVehicle(playerid);
    				}
    			}
            }
            if(ChangeVehicleGasolina(vehicleid)){format(stryngv, sizeof(stryngv), "~y~G ~w~%d", PlayerInfo[playerid][Comb][0]);}
			if(ChangeVehicleEtanol(vehicleid)){format(stryngv, sizeof(stryngv), "~b~~h~E ~w~%d", PlayerInfo[playerid][Comb][1]);}
			if(ChangeVehicleDiesel(vehicleid)){format(stryngv, sizeof(stryngv), "D ~w~%d", PlayerInfo[playerid][Comb][2]);}
			if(ChangeVehicleGnv(vehicleid)){format(stryngv, sizeof(stryngv), "~b~~h~~h~~h~GNV ~w~%d", PlayerInfo[playerid][Comb][3]);}

            Loop(v,5)
			{
				PlayerTextDrawShow(playerid,Velocimetro[playerid][v]);
			}
            PlayerTextDrawSetString(playerid,Velocimetro[playerid][4],stryngv);
            return 1;
		}
	}
	switch(oldstate)
	{
		case PLAYER_STATE_DRIVER:
		{
            SetVehicleParamsEx(vehicleid,VEHICLE_PARAMS_OFF,lights,alarm,doors,bonnet,boot,objective);

            Loop(v,5)//Velocimetro
			{
				PlayerTextDrawHide(playerid,Velocimetro[playerid][v]);
			}
            return 1;
		}
	}
    return 0;
}

public OnPlayerEnterCheckpoint(playerid)
{
    new str[150], ValorCaga[MAX_PLAYERS] = 200, vehicleid = GetPlayerVehicleID(playerid);

    if(DestinoCarg[playerid] == true)
    {
        if(!IsPlayerInAnyVehicle(playerid))return DisablePlayerCheckpoint(playerid);
        {
            switch(PlayerInfo[playerid][Profissao])
            {
                case PROF_CAMINHOEIRPLS:
                {
                    if(!IsTrailerAttachedToVehicle(vehicleid))return SendClientMessage(playerid,Vermelho,"Você esta sem a carga.");
                    {
                        switch(GetPVarInt(playerid,"CargItem"))
                        {
                            case 0: ValorCaga[playerid] = 600;//DESCARGA LS 1
                            case 1: ValorCaga[playerid] = 660;//DESCARGA LS 2
                            case 2: ValorCaga[playerid] = 700;//DESCARGA  LV 2
                            case 3: ValorCaga[playerid] = 750;//DESCARGA  LV 2
                            case 4: ValorCaga[playerid] = 800;//DESCARGA  SF
                        }
                        format(str,sizeof(str),"Você recebeu {C0C0C0}$%d,00{FF8000} por fazer uma emtrega em {C0C0C0}%s{FF8000}.",ValorCaga[playerid],GetPlayerArea(playerid));
                    }
                }
                case PROF_AERONAVPILOTO:
                {
                    if(vehicleid == 592)return SendClientMessage(playerid,Vermelho,"Você esta sem a carga.");
                    {
                        switch(GetPVarInt(playerid,"CargItem"))
                        {
                            case 0: ValorCaga[playerid] = 800;//DESCARGA LV
                            case 1: ValorCaga[playerid] = 860;//DESCARGA SF
                            case 2: ValorCaga[playerid] = 1300;//DESCARGA Aero Abandonado  Contrabando
                        }
                        format(str,sizeof(str),"Você recebeu {C0C0C0}$%d,00{FF8000} por fazer uma emtrega em {C0C0C0}%s{FF8000}.",ValorCaga[playerid],GetPlayerArea(playerid));
                    }
                }
                case PROF_PIZZABOYLS:
                {
                    if(vehicleid == 448)return SendClientMessage(playerid,Vermelho,"Você esta sem a Pizza.");
                    {
                        switch(random(4))
                        {
                            case 1: ValorCaga[playerid] = 500;
                            case 2: ValorCaga[playerid] = 400;
                            case 3: ValorCaga[playerid] = 300;
                            case 4: ValorCaga[playerid] = 200;
                        }
                        format(str,sizeof(str),"Você recebeu {C0C0C0}$%d,00{FF8000} por entregar uma Pizza em {C0C0C0}%s{FF8000}.",ValorCaga[playerid],GetPlayerArea(playerid));
                    }
                }
                case PROF_PETROLEIRO:
                {
                    if(!IsTrailerAttachedToVehicle(vehicleid))return SendClientMessage(playerid,Vermelho,"Você esta sem a carga.");
                    {
                        switch(random(4))
                        {
                            case 1: ValorCaga[playerid] = 500;
                            case 2: ValorCaga[playerid] = 600;
                            case 3: ValorCaga[playerid] = 700;
                            case 4: ValorCaga[playerid] = 800;
                        }
                        format(str,sizeof(str),"Você recebeu {C0C0C0}$%d,00{FF8000} por entregar em {C0C0C0}%s{FF8000}.",ValorCaga[playerid],GetPlayerArea(playerid));
                    }
                }
            }
            SendClientMessage(playerid,0xFF8000AA,str);
            DisablePlayerCheckpoint(playerid);
            TogglePlayerControllable(playerid, false);
            GivePVarMoney(playerid,ValorCaga[playerid]);
            DeletePVar(playerid,"CargItem");
            DestinoCarg[playerid]=false;
            SetTimerEx("Deascongelar", 6000, false, "i",playerid);
        }
    }
    return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(PRESSED(KEY_YES))
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
           cmd_y(playerid,"");
		}
	}
    return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
    new pip[16];
    foreach(new i : Player)
    {
        GetPlayerIp(i, pip, sizeof(pip));
        if(!strcmp(ip, pip, true))
        {
            if(pAdmin[i] < 1)return Ban(i);
            {
                if(!success)return SendClientMessage(i,Vermelho,"[x] Senha incorreta. [x]");
                {
                    SendClientMessage(i, Verde, "[+] Senha correta. [+]");
                }
            }
        }
    }
    return 1;
}

public OnPlayerUpdate(playerid)
{
    return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	new pName[MAX_PLAYER_NAME],tmp[200],str[128];
	GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
	new vehicleid = GetPlayerVehicleID(playerid);

	switch(dialogid)
	{
        case DIALOG_REGISTRO: //Dialog 00
		{
			if(!response)return Kick(playerid);

            if(strlen(inputtext) < 5 || strlen(inputtext) > 20)
            {
				format(STRX, sizeof(STRX), TEXTO_REGISTRO, pName);
				ShowPlayerDialog(playerid, DIALOG_REGISTRO, DIALOG_STYLE_PASSWORD, "{F5F5F5}Registro", STRX, "Registrar", "Sair");
			}
			else
			{
				mysql_format(SqL, Query, sizeof(Query),"INSERT INTO `contas` (Usuario, Senha) VALUES ('%s','%s')",pName, inputtext);
                mysql_query(SqL,Query,true);

                SpawnPlayer(playerid);
                CidadeSelect(playerid);
			}
            return 1;
		}
		case DIALOG_LOGIN: //Dialog 01
		{
			if(!response)return Kick(playerid);
            {
                mysql_format(SqL, Query, sizeof(Query),"SELECT * FROM `contas` WHERE `Usuario` = '%s' AND `Senha` = '%s'",pName, inputtext);
    			mysql_query(SqL,Query,true);

    			if(cache_num_rows() > 0)
    			{   //Pegando Informações dos jogadores
    				SetSpawnInfo(playerid, PlayerInfo[playerid][Skin], PlayerInfo[playerid][Skin], PlayerInfo[playerid][Casa][0],PlayerInfo[playerid][Casa][1],PlayerInfo[playerid][Casa][2], 0.0, 0, 0, 0, 0, 0, 0);
    				PlayerInfo[playerid][Logged] = true;
    				CleanChatBox(playerid,30);
    				SpawnPlayer(playerid);
    				SendClientMessage(playerid,0x00D7D7AA, "Bem vindo(a) novamente.");
    				return 1;
    			}
    			else
    			{   //Senha incorreta
    				format(STRX, sizeof(STRX), TEXTO_LOGINERRO, pName);
    				ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{F5F5F5}Login", STRX, "Logar", "Sair");
    				return 1;
    			}
            }
		}
        case DIALOG_PGASOLINA:   //dialog 02
		{
			new pGasolinaZ = strval(inputtext),
			string[60],quantia = pGasolinaZ * VALOR_GASOLINA_COMB;

            if(response)
            {
                if(GetPVarMoney(playerid) < quantia)return SendClientMessage(playerid,Vermelho,"Você não tem dinheiro suficiente.");
                {
                    if(pGasolinaZ > MAX_GASOLINA_COMB || pGasolinaZ < 1)return SendClientMessage(playerid, Vermelho, "Quantia Inválida");
    				{
    					if(AreaPosto[playerid] == true)
    					{
    						if(pGasolinaZ + PlayerInfo[playerid][Comb][0] < MAX_GASOLINA_COMB)
                            {
    							PlayerInfo[playerid][Comb][0] += pGasolinaZ;
    							format(string,60, "* Você abastaceu %d Litros por %d$", pGasolinaZ, quantia);
    						}
    						else //if(pGasolinaZ + strval(tmp))
    						{
    							pGasolinaZ = MAX_GASOLINA_COMB - PlayerInfo[playerid][Comb][0];
    							quantia = pGasolinaZ * VALOR_GASOLINA_COMB;
    							PlayerInfo[playerid][Comb][0] = MAX_GASOLINA_COMB;
    							format(string,60, "* Tanque cheio, foram colocados %d Litros por %d$", pGasolinaZ, quantia);
    						}
    						GivePVarMoney(playerid,-quantia);
    						SendClientMessage(playerid, Verde, string);
                            format(stryngv, sizeof(stryngv), "~y~G ~w~%d", PlayerInfo[playerid][Comb][0]);
                            PlayerTextDrawSetString(playerid,Velocimetro[playerid][4],stryngv);
                            return 1;
    					}
    					else SendClientMessage(playerid,Vermelho,"Você não esta em um posto de combustível.");
    	 			}
                }
			}
			return 1;
		}
		case DIALOG_PETANOL:  //Dialog 03
		{
			new pEtanolZ = strval(inputtext),
			string[60],quantia = pEtanolZ * VALOR_ETANOL_COMB;

            if(response)
            {
                if(GetPVarMoney(playerid) < quantia)return SendClientMessage(playerid,Vermelho,"Você não tem dinheiro suficiente.");
    			{
    				if(pEtanolZ > MAX_ETANOL_COMB || pEtanolZ < 1) return SendClientMessage(playerid, Vermelho, "Quantia Inválida");
    				{
    					if(AreaPosto[playerid] == true)
    					{
    						if(pEtanolZ + PlayerInfo[playerid][Comb][1] < MAX_ETANOL_COMB)
                            {
    							PlayerInfo[playerid][Comb][1] += pEtanolZ;
    							format(string,60, "* Você abastaceu %d Litros por %d$", pEtanolZ, quantia);
    						}
    						else //if(pEtanolZ + strval(tmp))
    						{
    							pEtanolZ = MAX_ETANOL_COMB - PlayerInfo[playerid][Comb][1];
    							quantia =  pEtanolZ * VALOR_ETANOL_COMB;
    							PlayerInfo[playerid][Comb][1] = MAX_ETANOL_COMB;
    							format(string,60, "* Tanque cheio, foram colocados %d Litros por %d$", pEtanolZ, quantia);
    						}
    						GivePVarMoney(playerid,-quantia);
    						SendClientMessage(playerid, Verde, string);
                            format(stryngv, sizeof(stryngv), "~b~~h~E ~w~%d", PlayerInfo[playerid][Comb][1]);
                            PlayerTextDrawSetString(playerid,Velocimetro[playerid][4],stryngv);
    						return 1;
    					}
    					else SendClientMessage(playerid,Vermelho,"Você não esta em um posto de combustível.");
    				}
                 }
			}
			return 1;
		}
		case DIALOG_PDIESEL:   //Dialog 04
		{
			new pDieselZ = strval(inputtext),
			string[60],quantia = pDieselZ * VALOR_DIESEL_COMB;

            if(response)
            {
                if(GetPVarMoney(playerid) < quantia)return SendClientMessage(playerid,Vermelho,"Você não tem dinheiro suficiente.");
    			{
    				if(pDieselZ > MAX_DIESEL_COMB || pDieselZ < 1) return SendClientMessage(playerid, Vermelho, "Quantia Inválida");
    				{
    					if(AreaPosto[playerid] == true)
    					{
    						if(pDieselZ + strval(tmp) < MAX_DIESEL_COMB)
    						{
    							PlayerInfo[playerid][Comb][2] += pDieselZ;
    							format(string,60, "* Você abastaceu %d Litros por %d$", pDieselZ, quantia);
    						}
    						else// if(pDieselZ + strval(tmp))
    						{
    							pDieselZ = MAX_DIESEL_COMB - PlayerInfo[playerid][Comb][2];
    							quantia =  pDieselZ * VALOR_DIESEL_COMB;
    							PlayerInfo[playerid][Comb][2] = MAX_DIESEL_COMB;
    							format(string,60, "* Tanque cheio, foram colocados %d Litros por %d$", pDieselZ, quantia);
    						}
    						GivePVarMoney(playerid,-quantia);
    						SendClientMessage(playerid, Verde, string);
                            format(stryngv, sizeof(stryngv), "D ~w~%d", PlayerInfo[playerid][Comb][2]);
                            PlayerTextDrawSetString(playerid,Velocimetro[playerid][4],stryngv);
                            return 1;
    					}
    					else SendClientMessage(playerid,Vermelho,"Você não esta em um posto de combustível.");
    				}
                 }
			}
			return 1;
		}
		case DIALOG_PGNV:  //Dialog 05
		{
			new pGNVZ = strval(inputtext),
			string[60],quantia = pGNVZ * VALOR_GNV_COMB;

            if(response)
            {
                if(GetPVarMoney(playerid) < quantia)return SendClientMessage(playerid,Vermelho,"Você não tem dinheiro suficiente.");
    			{
    				if(pGNVZ > MAX_GNV_COMB || pGNVZ < 1) return SendClientMessage(playerid, Vermelho, "Quantia Inválida");
    				{
    					if(AreaPosto[playerid] == true)
    					{
    						if(pGNVZ + PlayerInfo[playerid][Comb][3] < MAX_GNV_COMB)
    						{
    							PlayerInfo[playerid][Comb][3] += pGNVZ;
    							format(string,60, "* Você abastaceu %d Litros por %d$", pGNVZ, quantia);
    						}
    						else //if(pGNVZ + strval(tmp))
    						{
    							pGNVZ = MAX_GNV_COMB - PlayerInfo[playerid][Comb][3];
    							quantia =  pGNVZ * VALOR_GNV_COMB;
    							PlayerInfo[playerid][Comb][3] = MAX_GNV_COMB;
    							format(string,60, "* Tanque cheio, foram colocados %d Litros por %d$", pGNVZ, quantia);
    						}
    						GivePVarMoney(playerid,-quantia);
    						SendClientMessage(playerid, Verde, string);
                            format(stryngv, sizeof(stryngv), "~b~~h~~h~~h~GNV ~w~%d", PlayerInfo[playerid][Comb][3]);
                            PlayerTextDrawSetString(playerid,Velocimetro[playerid][4],stryngv);
                            return 1;
    					}
    					else SendClientMessage(playerid,Vermelho,"Você não esta em um posto de combustível.");
    				}
                 }
			}
			return 1;
		}
		case DIALOG_COMBUSTIVEIS: //Dialog 06
		{
			if(response)
			{
                switch(listitem)
                {
                    case 0: ShowPlayerDialog(playerid, DIALOG_PGASOLINA, DIALOG_STYLE_INPUT, "{C4C400}Gasolina", "Digite a Qunatia de gasolina \nO máximo e 60 litros \nE custa 2$ o litro.", "Abastecer", "Cancelar");
                    case 1: ShowPlayerDialog(playerid, DIALOG_PETANOL, DIALOG_STYLE_INPUT, "{0080C0}Etanol", "Digite a Qunatia de Etanol \nO máximo e 60 litros \nE custa 2$ o litro.", "Abastecer","Cancelar");
    				case 2: ShowPlayerDialog(playerid, DIALOG_PDIESEL, DIALOG_STYLE_INPUT, "{AE5700}Diesel", "Digite a Qunatia de Diesel \nO máximo e 250 litros \nE custa 3$ o litro.", "Abastecer","Cancelar");
    				case 3: ShowPlayerDialog(playerid, DIALOG_PGNV, DIALOG_STYLE_INPUT, "{00C4C4}GNV", "Digite a Qunatia de GNV \nO máximo e 300 litros \nE custa 4$ o litro.", "Abastecer", "Cancelar");
                }
			}
			return 1;
		}
		case _DIALOG_NOTIFICACAO: //Dialog 9
		{
			new id, text[128];
            if(response)
            {
                if(sscanf(inputtext,"us[20]",id,text))return ShowPlayerDialog(playerid, _DIALOG_NOTIFICACAO, DIALOG_STYLE_INPUT, "Responder Duvida", "[Nick] ou [id] depois o [text]", "Responder", "");
    			{
    				if(!IsPlayerConnected(id))return SendClientMessage(playerid, Vermelho, "Jogador não emcontrado.");
    				{
    					format(str, sizeof(str), "O Admin ~y~%s ~w~respondeu sua duvida!",pName);
    					PlayerTextDrawShow(id,Notificacoes[id]);
    					PlayerTextDrawSetString(id, Notificacoes[id], str);
    					SendClientMessage(id, Verde, "Para ler sua duvida respondida [/LR]");
    					SetTimerEx("DeletNotifc", 5000, false, "i", id);
    					_DuvidResp[id] = text, Dresp[id] = 1;
    				}
                }
                return 1;
			}
		}
    	case DIALOG_NEONS: //Dialog 10
		{
			if(response)
			{
				SetVheicleNeon(vehicleid, listitem);
			}
			return 1;
		}
        case DIALOG_ACESSORIOS: //Dialog 11
		{
			if(response)
			{
				if(IsPlayerAttachedObjectSlotUsed(playerid, listitem))
				{
					ShowPlayerDialog(playerid, DIALOG_ACESSORIOS_EDIT, DIALOG_STYLE_MSGBOX, \
					"{FF0000}Attachment Modification", "Você deseja editar o anexo em que o slot , ou excluí-lo?", "Edit", "Delete");
				}
				else
				{
					ShowModelSelectionMenu(playerid, Acessorios, "BCL");
				}
				SetPVarInt(playerid, "AttachmentIndexSel", listitem);
			}
			return 1;
		}
		case DIALOG_ACESSORIOS_EDIT: //Dialog 12
		{
			if(response)
            {
                EditAttachedObject(playerid, GetPVarInt(playerid, "AttachmentIndexSel"));
                SendClientMessage(playerid, 0xFFFFFFFF, "Dica: Use epaço {FFFF00}|------|{FFFFFF} para olhar em volta.");
            }
            else
            {
                RemovePlayerAttachedObject(playerid, GetPVarInt(playerid, "AttachmentIndexSel")),
    			RemovePlayerObj(playerid,GetPVarInt(playerid, "AttachmentIndexSel"));
    			DeletePVar(playerid, "AttachmentIndexSel");
            }
            return 1;
		}
        case DIALOG_ACESSORIOS_BONE: //Dialog 13
        {
            if(response)
            {
                SetPlayerAttachedObject(playerid, GetPVarInt(playerid, "AttachmentIndexSel"), GetPVarInt(playerid, "AttachmentModelSel"), listitem+1);
                EditAttachedObject(playerid, GetPVarInt(playerid, "AttachmentIndexSel"));
                SendClientMessage(playerid, 0xFFFFFFFF, "Dica: Use epaço {FFFF00}|------|{FFFFFF} para olhar em volta.");
            }
            DeletePVar(playerid, "AttachmentIndexSel");
            DeletePVar(playerid, "AttachmentModelSel");
            return 1;
        }
        case DIALOG_PLAYER:  //Dialog 14
		{
            if(response)
            {
                switch(listitem)
                {
                    case 0:ShowPlayerDialog(playerid, DIALOG_SELECT, DIALOG_STYLE_LIST, "Menu Do Usuário", "Acessorios \nSkin \nStatus \nVeiculos", "Ver", "Voltar");
                    default:ShowPlayerDialog(playerid, DIALOG_AJUDA, DIALOG_STYLE_LIST, "Menu Do Usuário", "Administradores \nReporta", "Ver", "Cancelar");
                }
            }
            return 1;
		}
        case DIALOG_STATUS:   //Dialog 15
        {
            if(!response)
                ShowPlayerDialog(playerid, DIALOG_SELECT, DIALOG_STYLE_LIST, "Menu Do Usuário", "Acessorios \nSkin \nStatus \nVeiculos", "Ver", "Voltar");
            return 1;
        }
        case DIALOG_SELECT:  //Dialog 16
		{
            if(response)
            {
                switch(listitem)
                {
                    case 0:	cmd_acessorios(playerid,"");
                    case 1:	cmd_s(playerid,"");
                    case 2: cmd_status(playerid,"");
                    case 3: cmd_v(playerid,"");
                }
            }else ShowPlayerDialog(playerid, DIALOG_PLAYER, DIALOG_STYLE_LIST, "Menu Do Usuário", "+Você \nAjuda \nVip", "Ver", "Cancelar");
			return 1;
		}
        case DIALOG_AJUDA: //Dialog 17
		{
            if(response)
            {
                switch(listitem)
                {
                    case 0:	cmd_admins(playerid,"");
                    case 1: cmd_reporta(playerid,"");
                }
            }else ShowPlayerDialog(playerid, DIALOG_PLAYER, DIALOG_STYLE_LIST, "Menu Do Usuário", "+Você \nAjuda \nVip", "Ver", "Cancelar");
			return 1;
		}
        case DIALOG_CARGAS: //Dialog 18
        {
            if(response)
            {
                switch(PlayerInfo[playerid][Profissao])
                {
                    case PROF_DESENPREGADOS: SendClientMessage(playerid,Vermelho,"Você não possui um empreggo.");

                    case PROF_CAMINHOEIRPLS:
                    {//Caminhoeiro
                        SetPlayerCheckpoint(playerid,Carg[listitem][0],Carg[listitem][1],Carg[listitem][2],5.5);
                        DestinoCarg[playerid] = true;
                        SetPVarInt(playerid,"CargItem",listitem);
                        SendClientMessage(playerid,Verde,"Vá ate a marca vermelha no mapa para entregar.  ( : ");
                    }
                    case PROF_AERONAVPILOTO:
                    {//Piloto de Avião de cargas
                        SetPlayerCheckpoint(playerid,AeroCarg[listitem][0],AeroCarg[listitem][1],AeroCarg[listitem][2],5.5);
                        DestinoCarg[playerid] = true;
                        SetPVarInt(playerid,"CargItem",listitem);
                        SendClientMessage(playerid,Verde,"Vá ate a marca vermelha no mapa para entregar.  ( : ");
                    }
                    case PROF_PETROLEIRO:
                    {//Petroleiro
                        SetPlayerCheckpoint(playerid,pCarg[listitem][0],pCarg[listitem][1],pCarg[listitem][2],5.5);
                        DestinoCarg[playerid] = true;
                        SendClientMessage(playerid,Verde,"Vá ate a marca vermelha no mapa para entregar.  ( : ");
                    }
                }
            }
            return 1;
        }
	}
	return 0;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
    if(clickedplayerid == playerid)
    {
        cmd_c(playerid,"");
    }
    else
    {
      // Comando para reportar e entre outros
    }
    return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    if(issuerid != INVALID_PLAYER_ID) // If not self-inflicted
    {
    }
    return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid, bodypart)
{
    PlayerPlaySound(playerid,17802,0.0,0.0,0.0);
    return 1;
}

public OnPlayerEditAttachedObject( playerid, response, index, modelid, boneid,
                                   Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ,
                                   Float:fRotX, Float:fRotY, Float:fRotZ,
                                   Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
    SetPlayerAtt(playerid,index,modelid,boneid,fOffsetX,fOffsetY,fOffsetZ,fRotX,fRotY,fRotZ,fScaleX,fScaleY,fScaleZ);
    SavePObjects(playerid, index);
    SendClientMessage(playerid,Amarelo,"Edição concluida e salva.");
    return 1;
}

bool:IsPlayerAimingAtPlayer(playerid, target)
{
        new Float:x, Float:y, Float:z;
        GetPlayerPos(target, x, y, z);
        if (IsPlayerAimingAt(playerid, x, y, z-0.75, 0.25)) return true;
        if (IsPlayerAimingAt(playerid, x, y, z-0.25, 0.25)) return true;
        if (IsPlayerAimingAt(playerid, x, y, z+0.25, 0.25)) return true;
        if (IsPlayerAimingAt(playerid, x, y, z+0.75, 0.25)) return true;
        return false;
}

//Anti-Aimbot by ipsLeon
Float:DistanceCameraTargetToLocation(Float:CamX, Float:CamY, Float:CamZ, Float:ObjX, Float:ObjY, Float:ObjZ, Float:FrX, Float:FrY, Float:FrZ)
{
    new Float:TGTDistance;

    TGTDistance = floatsqroot((CamX - ObjX) * (CamX - ObjX) + (CamY - ObjY) * (CamY - ObjY) + (CamZ - ObjZ) * (CamZ - ObjZ));

    new Float:tmpX, Float:tmpY, Float:tmpZ;

    tmpX = FrX * TGTDistance + CamX;
    tmpY = FrY * TGTDistance + CamY;
    tmpZ = FrZ * TGTDistance + CamZ;

    return floatsqroot((tmpX - ObjX) * (tmpX - ObjX) + (tmpY - ObjY) * (tmpY - ObjY) + (tmpZ - ObjZ) * (tmpZ - ObjZ));
}

Float:GetPointAngleToPoint(Float:x2, Float:y2, Float:X, Float:Y)
{
    new Float:DX, Float:DY;
    new Float:angle;

    DX = floatabs(floatsub(x2,X));
    DY = floatabs(floatsub(y2,Y));

    if (DY == 0.0 || DX == 0.0)
    {
        if(DY == 0 && DX > 0) angle = 0.0;
        else if(DY == 0 && DX < 0) angle = 180.0;
        else if(DY > 0 && DX == 0) angle = 90.0;
        else if(DY < 0 && DX == 0) angle = 270.0;
        else if(DY == 0 && DX == 0) angle = 0.0;
    }
    else
    {
        angle = atan(DX/DY);
        if(X > x2 && Y <= y2) angle += 90.0;
        else if(X <= x2 && Y < y2) angle = floatsub(90.0, angle);
        else if(X < x2 && Y >= y2) angle -= 90.0;
        else if(X >= x2 && Y > y2) angle = floatsub(270.0, angle);
    }
    return floatadd(angle, 90.0);
}

GetXYInFrontOfPoint(&Float:x, &Float:y, Float:angle, Float:distance)
{
    x += (distance * floatsin(-angle, degrees));
    y += (distance * floatcos(-angle, degrees));
}

IsPlayerAimingAt(playerid, Float:x, Float:y, Float:z, Float:radius)
{
    new Float:camera_x,Float:camera_y,Float:camera_z,Float:vector_x,Float:vector_y,Float:vector_z;
    GetPlayerCameraPos(playerid, camera_x, camera_y, camera_z);
    GetPlayerCameraFrontVector(playerid, vector_x, vector_y, vector_z);

    new Float:vertical, Float:horizontal;

    switch (GetPlayerWeapon(playerid))
    {
        case 34,35,36:
        {
            if (DistanceCameraTargetToLocation(camera_x, camera_y, camera_z, x, y, z, vector_x, vector_y, vector_z) < radius) return true;
            return false;
        }
        case 30,31: {vertical = 4.0; horizontal = -1.6;}
        case 33: {vertical = 2.7; horizontal = -1.0;}
        default: {vertical = 6.0; horizontal = -2.2;}
    }
    new Float:angle = GetPointAngleToPoint(0, 0, floatsqroot(vector_x*vector_x+vector_y*vector_y), vector_z) - 270.0;
    new Float:resize_x, Float:resize_y, Float:resize_z = floatsin(angle+vertical, degrees);
    GetXYInFrontOfPoint(resize_x, resize_y, GetPointAngleToPoint(0, 0, vector_x, vector_y)+horizontal, floatcos(angle+vertical, degrees));

    if(DistanceCameraTargetToLocation(camera_x, camera_y, camera_z, x, y, z, resize_x, resize_y, resize_z) < radius) return true;
    return false;
}
//______________________________________________________________________________

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    //Anti-Aimbot by ipsLeon             forum.sa-mp.com/showthread.php?t=571638
    switch(weaponid){ case 0..18, 39..54: return 1;}//invalid weapons

    if(hittype == BULLET_HIT_TYPE_PLAYER && IsPlayerConnected(hitid) && !IsPlayerNPC(hitid))
    {
        new Float:Shot[3], Float:Hit[3];
        GetPlayerLastShotVectors(playerid, Shot[0], Shot[1], Shot[2], Hit[0], Hit[1], Hit[2]);

        new playersurf = GetPlayerSurfingVehicleID(playerid);
        new hitsurf = GetPlayerSurfingVehicleID(hitid);
        new Float:targetpackets = NetStats_PacketLossPercent(hitid);
        new Float:playerpackets = NetStats_PacketLossPercent(playerid);

        if(~(playersurf) && ~(hitsurf) && !IsPlayerInAnyVehicle(playerid) && !IsPlayerInAnyVehicle(hitid))
        {
            if(!IsPlayerAimingAtPlayer(playerid, hitid) && !IsPlayerInRangeOfPoint(hitid, 5.0, Hit[0], Hit[1], Hit[2]))
            {
                new string[128], issuer[24];
                GetPlayerName(playerid, issuer, 24);
                AimbotWarnings[playerid]++;

                format(string, sizeof(string), "{FFFFFF}Player %s warning of aimbot or lag [Target PL: %f | Shooter PL:%f]!", issuer, targetpackets, playerpackets);

                foreach(new p : Player)
                if(IsPlayerConnected(p) && IsPlayerAdmin(p))
                SendClientMessage(p, -1, string);

                if(AimbotWarnings[playerid] > 10)
                {
                     if(targetpackets < 1.2 && playerpackets < 1.2)return Kick(playerid);
                     else
                     {
                          format(string, sizeof(string), "{FFFFFF}Player %s is probably using aimbot [Target PL: %f | Shooter PL:%f]!", issuer, targetpackets, playerpackets);
                          foreach(new p : Player)
                          if(IsPlayerConnected(p) && IsPlayerAdmin(p)) SendClientMessage(p, -1, string);
                     }
                }
                return 0;
            }
            else return 1;
        }
        else return 1;
    }
    return 1;
}

public MP_OPCTD(playerid, Text:clickedid)
{
	if(clickedid == Text:INVALID_TEXT_DRAW)
	{
		if(CitySelect[playerid])
		{
            switch(gPlayerCitySelection[playerid])
            {
                case CITY_LOS_SANTOS:PlayerInfo[playerid][Casa][0] = 2227.7061, PlayerInfo[playerid][Casa][1] = -1262.3152, PlayerInfo[playerid][Casa][2] = 23.9186;
    			case CITY_SAN_FIERRO:PlayerInfo[playerid][Casa][0] = -2014.1608, PlayerInfo[playerid][Casa][1] = 152.9872, PlayerInfo[playerid][Casa][2] = 27.6875;
    			case CITY_LAS_VENTURAS:PlayerInfo[playerid][Casa][0] = 2026.3300, PlayerInfo[playerid][Casa][1] = 1006.9761, PlayerInfo[playerid][Casa][2] = 10.8203;
            }
            SetCiteSelected(playerid);
            CheckForPlayerBd(playerid);
		}
	}
	return 1;
}

public MP_OPCPTD(playerid, PlayerText:playertextid)
{
    if(_:playertextid != INVALID_TEXT_DRAW)
	{
		if(CitySelect[playerid])
		{
			if(playertextid == pCidadeSelect[playerid][0])
            {
				--gPlayerCitySelection[playerid];
				if(gPlayerCitySelection[playerid] < CITY_LOS_SANTOS)
				{
					gPlayerCitySelection[playerid] = CITY_LAS_VENTURAS;
				}
				ClassSel_SetupSelectedCity(playerid);
			}
			if(playertextid == pCidadeSelect[playerid][1])
			{
				++gPlayerCitySelection[playerid];
				if(gPlayerCitySelection[playerid] > CITY_LAS_VENTURAS)
				{
					gPlayerCitySelection[playerid] = CITY_LOS_SANTOS;
				}
				ClassSel_SetupSelectedCity(playerid);
			}
			if(playertextid == pCidadeSelect[playerid][2])
			{
                if(CITY_LOS_SANTOS == gPlayerCitySelection[playerid])
    			{
                    PlayerInfo[playerid][Casa][0] = 2227.7061, PlayerInfo[playerid][Casa][1] = -1262.3152, PlayerInfo[playerid][Casa][2] = 23.9186;
                }
    			if(CITY_SAN_FIERRO == gPlayerCitySelection[playerid])
    			{
                    PlayerInfo[playerid][Casa][0] = -2014.1608, PlayerInfo[playerid][Casa][1] = 152.9872, PlayerInfo[playerid][Casa][2] = 27.6875;
    			}
    			if(CITY_LAS_VENTURAS == gPlayerCitySelection[playerid])
    			{
                    PlayerInfo[playerid][Casa][0] = 2026.3300, PlayerInfo[playerid][Casa][1] = 1006.9761, PlayerInfo[playerid][Casa][2] = 10.8203;
    			}
                SetCiteSelected(playerid);
                CheckForPlayerBd(playerid);
			}
		}
	}
	return 1;
}
public OnPlayerModelSelection(playerid, response, listid, modelid)
{
    new string[300];

    if(listid == CarsAdmin)
    {
        if(!response)return SendClientMessage(playerid,Vermelho, "Cancelado.");
        {
            new Float:pos[3],vehicleid,Placas = 1000 + random(9999);
            SendClientMessage(playerid, Verde, "veículo Criado.");
            GetPlayerPos(playerid, pos[0], pos[1], pos[2]);

            vehicleid = CreateVehicle(modelid, pos[0], pos[1], pos[2], 0.0, random(128), random(128), -1);
            format(string, sizeof(string),"BCL - %d", Placas);
            SetVehicleNumberPlate(vehicleid, string);
            PutPlayerInVehicle(playerid, vehicleid, 0);
            SetVehicleEngineState(vehicleid, VEHICLE_PARAMS_OFF);

            LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
			SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
        }
        return 1;
    }
    if(listid == SkinAdmin)
    {
        if(!response)return SendClientMessage(playerid,Vermelho, "Cancelado.");
        {
            SetPlayerSkin(playerid,modelid);
            PlayerInfo[playerid][Skin] = modelid;
        }
        return 1;
    }
    if(listid == Acessorios)
    {
        if(response)
        {
            SetPVarInt(playerid, "AttachmentModelSel",modelid);
            if(GetPVarInt(playerid, "AttachmentUsed") == 1) EditAttachedObject(playerid, modelid);
            else
            {
                Loop(x,sizeof(AttachmentBones))
                {
                    format(string, sizeof(string), "%s%s\n", string, AttachmentBones[x]);
                }
                ShowPlayerDialog(playerid, DIALOG_ACESSORIOS_BONE, DIALOG_STYLE_LIST, \
                "{FF0000}Anexo Modificação", string, "Select", "Cancel");
            }
        }
        else DeletePVar(playerid, "AttachmentIndexSel"), SendClientMessage(playerid,Vermelho, "Cancelado.");
        return 1;
    }
    return 1;
}

public OnQueryError(errorid, const error[], const callback[], const query[], MySQL:handle)
{
    printf("[OnQueryError (%d, %s, %s)]: Query: %s", errorid, error, callback, query);
    switch(errorid)
    {
        case CR_COMMAND_OUT_OF_SYNC: printf("[SqL: Error - Callback; %s] - Comandos fora de sincronia Para - Consulta: %s", callback, query);
        case ER_UNKNOWN_TABLE: printf("[SqL: Error - Callback; %s] - Desconhecido tabela '%s' Consulta: %s", callback, error, query);
        case ER_SYNTAX_ERROR: printf("[SqL: Error - Callback; %s] - Algo está errado em sua sintaxe - Consulta: %s", callback, query);
    }
    return 1;
}

_CallBack: CheckForPlayerBd(playerid)
{
    new pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pName, MAX_PLAYER_NAME);

    mysql_format(SqL, Query, sizeof(Query), "SELECT * FROM `contas` WHERE `Usuario` = '%s'",pName);
    mysql_query(SqL,Query,true);

    if(cache_num_rows() > 0)
	{
        cache_get_value_int(0, "Skin", PlayerInfo[playerid][Skin]);
        cache_get_value_int(0, "aAdmin", pAdmin[playerid]);
        cache_get_value_int(0, "Gasolina", PlayerInfo[playerid][Comb][0]);
        cache_get_value_int(0, "Etanol", PlayerInfo[playerid][Comb][1]);
        cache_get_value_int(0, "Diesel", PlayerInfo[playerid][Comb][2]);
        cache_get_value_int(0, "GNV", PlayerInfo[playerid][Comb][3]);
        cache_get_value_int(0, "cBancario", PlayerInfo[playerid][cBanc]);
        cache_get_value_int(0, "Dinheiro", GetPVarMoney(playerid));
        cache_get_value_int(0, "sBancario", PlayerInfo[playerid][sBancario]);
        cache_get_value_int(0, "Profissao", PlayerInfo[playerid][Profissao]);
        cache_get_value_float(0, "CasaX", PlayerInfo[playerid][Casa][0]);
        cache_get_value_float(0, "CasaY", PlayerInfo[playerid][Casa][1]);
        cache_get_value_float(0, "CasaZ", PlayerInfo[playerid][Casa][2]);

        OnacessoriosLoad(playerid);
        SetPlayerObjects(playerid);
        GivePlayerMoney(playerid,GetPVarMoney(playerid));

        switch(PlayerInfo[playerid][Profissao])
        {
            case 0:
            {
                SetPlayerColor(playerid,-1);
            }
            case 1:
            {
                SetPlayerColor(playerid,COR_CAMINHOEIRPLS);
                GangZoneShowForPlayer(playerid,gzCaminhoneiro,COR_CAMINHOEIRPLS);
            }
            case 2:
            {
                SetPlayerColor(playerid,COR_AERONAVPILOTO);
                GangZoneShowForPlayer(playerid,AeroC,COR_AERONAVPILOTO);
            }
            case 3:
            {
                SetPlayerColor(playerid,COR_PIZZABOYLS);
                GangZoneShowForPlayer(playerid,gzPizzaboyLs,COR_PIZZABOYLS);
            }
            case 4:
            {
                SetPlayerColor(playerid,COR_PETROLEIRO);
               // GangZoneShowForPlayer(playerid,gzPizzaboyLs,COR_PIZZABOYLS);
            }
        }
        if(pAdmin[playerid] > 0)
		{
			admin[playerid] = 1;
		}
	}
    return 1;
}

_CallBack: Deascongelar(playerid)
{
    TogglePlayerControllable(playerid, true);
    SendClientMessage(playerid,Verde,"Pronto. Produto entregue.");
    return 1;
}

_CallBack: CidadeSelect(playerid)
{
    PlayerTextDrawShow(playerid,pCidadeSelect[playerid][0]);
    PlayerTextDrawShow(playerid,pCidadeSelect[playerid][1]);
    PlayerTextDrawShow(playerid,pCidadeSelect[playerid][2]);
    PlayerTextDrawShow(playerid,pCidadeSelect[playerid][3]);
    PlayerTextDrawShow(playerid,pCidadeSelect[playerid][4]);
    SelectTextDraw(playerid, 0x00E8E8AA);

    SetPlayerCameraPos(playerid,1630.6136,-2286.0298,110.0);
    SetPlayerCameraLookAt(playerid,1887.6034,-1682.1442,47.6167);
    gPlayerCitySelection[playerid] = CITY_LOS_SANTOS;
    CitySelect[playerid] = 1;
    OnacessoriosLoad(playerid);
    return 1;
}

_CallBack: Speedo()
{
    foreach(new i : Player)
    {
        if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i))
		{
            if(GetVehicleModel(GetPlayerVehicleID(i)) == 509 || 510 || 481)
			{
                if(Velocimetro[i][0] != PlayerText:INVALID_TEXT_DRAW)
                {
		            format(stryngv, sizeof(stryngv), "%d", VelocidadeKM(i));
    	            PlayerTextDrawSetString(i, Velocimetro[i][0], stryngv);
                }
                if(Velocimetro[i][2] != PlayerText:INVALID_TEXT_DRAW)
                {
		            format(stryngv, sizeof(stryngv), "%s", VeiculosNome[GetVehicleModel(GetPlayerVehicleID(i))-400]);
                    PlayerTextDrawSetString(i, Velocimetro[i][2], stryngv);
                }
                if(Velocimetro[i][3] != PlayerText:INVALID_TEXT_DRAW)
                {
		            format(stryngv, sizeof(stryngv), "%s",GetPlayerArea(i));
		            PlayerTextDrawSetString(i, Velocimetro[i][3], stryngv);
	            }
            }
		}
	}
	return 1;
}

_CallBack: Combustivel()
{
    foreach(new i : Player)
	{
        new vehicleid = GetPlayerVehicleID(i);

        GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);

        if((GetVehicleModel(vehicleid) == 509 || 510 || 481))
		{
            if(engine == VEHICLE_PARAMS_ON)
			{
                if(IsPlayerInAnyVehicle(i) == 1)
                {
                    if(!GetPlayerVehicleSeat(i))
    				{
    					if(ChangeVehicleGasolina(vehicleid))
    					{
                            if(PlayerInfo[i][Comb][0] > 0)
    						{
                               --PlayerInfo[i][Comb][0];
                               format(stryngv, sizeof(stryngv), "~y~G ~w~%d", PlayerInfo[i][Comb][0]);
                            }
    						else
    						{
                                ToggleVehicleEngineOFF(vehicleid);
                                SendClientMessage(i, Vermelho, "Sua gasolina acabou vá até um posto mais próximo e abasteça.");
    						}
    					}
                        if(ChangeVehicleEtanol(vehicleid))
    					{
                            if(PlayerInfo[i][Comb][1] > 0)
    						{
                               --PlayerInfo[i][Comb][1];
                               format(stryngv, sizeof(stryngv), "~b~~h~E ~w~%d", PlayerInfo[i][Comb][1]);
                            }
    						else
    						{
                                ToggleVehicleEngineOFF(vehicleid);
                                SendClientMessage(i, Vermelho, "Seu Etanol acabou vá até um posto mais próximo e abasteça.");
    						}
    					}
    					if(ChangeVehicleDiesel(vehicleid))
    					{
                            if(PlayerInfo[i][Comb][2] > 0)
    						{
                                --PlayerInfo[i][Comb][2];
                                format(stryngv, sizeof(stryngv), "D ~w~%d", PlayerInfo[i][Comb][2]);
                            }
                            else
    						{
                                ToggleVehicleEngineOFF(vehicleid);
                                SendClientMessage(i, Vermelho, "Seu Diesel acabou vá até um posto mais próximo e abasteça.");
    						}
    					}
    					if(ChangeVehicleGnv(vehicleid))
    					{
                            if(PlayerInfo[i][Comb][3] > 0)
                            {
                                --PlayerInfo[i][Comb][3];
                                format(stryngv, sizeof(stryngv), "~b~~h~~h~~h~GNV ~w~%d", PlayerInfo[i][Comb][3]);
                            }
    						else
    						{
                                ToggleVehicleEngineOFF(vehicleid);
                                SendClientMessage(i, Vermelho, "Sua GNV acabou vá até um posto mais próximo e abasteça.");
    						}
    					}
                        PlayerTextDrawSetString(i,Velocimetro[i][4],stryngv);
    				}
                }
            }
		}
	}
	return 1;
}

_CallBack: Cronometro()
{
    gettime(horas, minutos);
    format(timestr,32,"%02d:%02d",horas, minutos);
   	TextDrawSetString(txtTimeDisp,timestr);
    SetWorldTime(horas);
    SetWeather(random(6));
    return 1;
}

_CallBack: Locais()
{
    foreach(new i : Player)
	{
		if(PlayerToPoint(8.0, i, 70.4532, 1219.1954, 18.8117)
		|| PlayerToPoint(8.0, i, -90.2719, -1169.9579, 2.3964)
		|| PlayerToPoint(8.0, i, -2411.5728, 976.1896, 45.4609)
		|| PlayerToPoint(8.0, i, 2114.8413, 919.9194, 10.8203))
		{
            GameTextForPlayer(i, "~r~/abastecer", 3000, 4);
			AreaPosto[i] = true;
		}
		else
		{
			if(AreaPosto[i] == true)
			{
                GameTextForPlayer(i, "~r~/abastecer", 3000, 4);
                AreaPosto[i] = false;
			}								  // Postos em LV
			if(PlayerToPoint(8.0, i, 2638.9553, 1107.1788, 10.8203)
			|| PlayerToPoint(8.0, i, 1595.6233, 2199.6162, 10.8203)
			|| PlayerToPoint(8.0, i, 1940.8671, -1773.2283, 13.3906)
			|| PlayerToPoint(8.0, i, -2243.8435, -2560.5598, 31.9219)
			|| PlayerToPoint(8.0, i, -1328.8868, 2677.6269, 50.0625)
            || PlayerToPoint(8.0, i, -1465.5839, 1864.1122, 32.7675))
			{
                GameTextForPlayer(i, "~r~/abastecer", 3000, 4);
				AreaPosto[i] = true;
			}
			else
			{
				if(AreaPosto[i] == true)
				{
                    AreaPosto[i] = false;
				}							  // Postos em LS/SF
				if(PlayerToPoint(8.0, i, 1382.3647, 459.0785, 20.3452)
				|| PlayerToPoint(8.0, i, -1675.4781, 413.1594, 7.1797)
				|| PlayerToPoint(8.0, i, 655.5922, -565.3943, 16.3359)
				|| PlayerToPoint(8.0, i, -1606.3616, -2713.5872, 48.5335))
				{
                    GameTextForPlayer(i, "~r~/abastecer", 3000, 4);
					AreaPosto[i] = true;
				}
				else
				{
					if(AreaPosto[i] == true)
					{
                        AreaPosto[i] = false;
					}
				}
			}
		}
        if(!IsPlayerInArea(i, 1921.057739, -2651.680908, 2094.536132, -2611.698974) &&
           !IsPlayerInArea(i, 144.952087, 1404.051757, 155.007614, 1420.670776) &&
           !IsPlayerInArea(i, 622.7727, 1670.7351, 605.0898, 1714.9214)) return PlayerTextDrawHide(i,HQobserv[i]);
        {
            PlayerTextDrawShow(i,HQobserv[i]);
        }
	}
	return 1;
}

_CallBack: DeletNotifc(playerid)
{
   PlayerTextDrawHide(playerid,Notificacoes[playerid]);
   return 1;
}

_CallBack: RandMesagens()
{
    new string[128];
	new random1 = random(sizeof(ranmessage));
	format(string, sizeof(string), "%s", ranmessage[random1]);
	SendClientMessageToAll(-1,string);
    return 1;
}
//_____________________________Stocks___________________________________________
stock GangZoneCreateEx(Float:pX,Float:pY,Float:Size, &gangzone)
{
    gangzone = GangZoneCreate(pX-Size,pY-Size,pX+Size,pY+Size);
}

stock IsPlayerInArea(playerid, Float:MinX, Float:MinY, Float:MaxX, Float:MaxY)
{
    new Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    return(X >= MinX && X <= MaxX && Y >= MinY && Y <= MaxY) ? 1 : 0;
}
stock convertNumber(amount, sep[] = ",")
{
	new
		str[16],         //http://forum.sa-mp.com/showthread.php?t=38965&page=109
		negativ = 0;     //http://forum.sa-mp.com/showpost.php?p=769443&postcount=966
	if(amount < 0) negativ = 1;
	format(str, sizeof(str), "%i", amount);
	new
		lenght = strlen(str);
	while((lenght -= 3) > negativ) strins(str, sep, lenght);
	return str;
}

stock LoadVehicleFromFile(filename[], varName[])
{
    new File:file_ptr, line[200], num, modelid, Float:px, Float:py, Float:pz, Float:r, c1, c2,str[30];
    format(str, 30,"Veiculos/%s",filename);
    file_ptr = fopen(str, io_read);
    if(!file_ptr)
        return printf("ERROR! Arquivo %s Não Existe.", str);

    if(countVehicle < MAX_VEHICLES_SPAWN)//Vai parar quando excede o numero maximo de veiculos
    {
        while(fread(file_ptr, line) != 0)
        {
            if(!sscanf(line, "p<,>ddffffdd", num, modelid, px, py, pz, r, c1, c2))
            {
                varName[num] = CreateVehicle(modelid, px, py, pz, r, c1, c2, (3 * 60));
                SetVehicleEngineState(varName[num], VEHICLE_PARAMS_OFF);
                countVehicle++;
            }
        }
    }
    return fclose(file_ptr);
}

stock LoadObjectFromFile(filename[])
{
    new File:file_ptr, line[200], modelid, Float:pX, Float:pY, Float:pZ, Float:rX, Float:rY, Float:rZ,str[30];
    format(str, 30,"Objetos/%s",filename);
    file_ptr = fopen(str, io_read);
    if(!file_ptr)
        return printf("ERROR! Arquivo %s Não Existe.", str);
    while(fread(file_ptr, line) != 0)
    {
        if(Streamer_GetMaxItems(STREAMER_TYPE_OBJECT) <= countObject)
        {
            if(!sscanf(line, "p<,>dffffff",modelid, pX, pY, pZ, rX, rY, rZ))
            {
                CreateDynamicObject(modelid, pX, pY, pZ, rX, rY, rZ);
                countObject++;
            }
        }
    }
    return fclose(file_ptr);
}

stock SetCiteSelected(playerid)
{
    CitySelect[playerid] = 0;
    mysql_format(SqL, Query, sizeof(Query), "UPDATE `contas` SET `Cidade` = '%d',`CasaX` = '%f', `CasaY` = '%f', `CasaZ` = '%f' WHERE `Usuario` = '%s'",gPlayerCitySelection[playerid],PlayerInfo[playerid][Casa][0],PlayerInfo[playerid][Casa][1],PlayerInfo[playerid][Casa][2], GetName(playerid));
    DeleteTextDraws(playerid);
    CancelSelectTextDraw(playerid);
    TogglePlayerControllable(playerid, true);
	SetCameraBehindPlayer(playerid);
    SetPlayerPos(playerid,PlayerInfo[playerid][Casa][0],PlayerInfo[playerid][Casa][1],PlayerInfo[playerid][Casa][2]);
    PlayerInfo[playerid][Logged] = true;
    CleanChatBox(playerid,30);
    gettime(horas,minutos);
    SendClientMessage(playerid,0x00D7D7AA, "Bem vindo(a) ao server.");
    mysql_query(SqL, Query, true);
    return 1;
}

stock ClassSel_SetupSelectedCity(playerid)
{
	if(gPlayerCitySelection[playerid] == -1)
    {
		gPlayerCitySelection[playerid] = CITY_LOS_SANTOS;
	}
	if(gPlayerCitySelection[playerid] == CITY_LOS_SANTOS)
    {
   		SetPlayerCameraPos(playerid,1630.6136,-2286.0298,110.0);
		SetPlayerCameraLookAt(playerid,1887.6034,-1682.1442,47.6167);
        PlayerTextDrawSetString(playerid,pCidadeSelect[playerid][3],"~g~Los Santos");
	}
	if(gPlayerCitySelection[playerid] == CITY_SAN_FIERRO)
    {
   		SetPlayerCameraPos(playerid,-1300.8754,68.0546,129.4823);
		SetPlayerCameraLookAt(playerid,-1817.9412,769.3878,132.6589);
        PlayerTextDrawSetString(playerid,pCidadeSelect[playerid][3],"~r~San Fierro");
	}
	if(gPlayerCitySelection[playerid] == CITY_LAS_VENTURAS)
    {
   		SetPlayerCameraPos(playerid,1310.6155,1675.9182,110.7390);
		SetPlayerCameraLookAt(playerid,2285.2944,1919.3756,68.2275);
        PlayerTextDrawSetString(playerid,pCidadeSelect[playerid][3],"~y~Las Venturas");
	}
    return 1;
}

stock LoadPlayerTextsDraws(playerid)
{   //Velocimetro
    Velocimetro[playerid][0] = CreatePlayerTextDraw(playerid,142.000000,368.000000, "~n~");
	PlayerTextDrawLetterSize(playerid,Velocimetro[playerid][0], 0.349999, 2.999999);
	PlayerTextDrawColor(playerid,Velocimetro[playerid][0], 16745215);
	PlayerTextDrawSetShadow(playerid,Velocimetro[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid,Velocimetro[playerid][0],80);
	PlayerTextDrawSetOutline(playerid,Velocimetro[playerid][0], 1);
	PlayerTextDrawFont(playerid,Velocimetro[playerid][0], 2);
    // km/h
    Velocimetro[playerid][1] = CreatePlayerTextDraw(playerid,176.400009, 378.759979, "Km/H");
	PlayerTextDrawLetterSize(playerid,Velocimetro[playerid][1], 0.220798, 1.474665);
	PlayerTextDrawColor(playerid,Velocimetro[playerid][1], -1409351425);
    PlayerTextDrawBackgroundColor(playerid,Velocimetro[playerid][1],80);
    PlayerTextDrawSetOutline(playerid,Velocimetro[playerid][1], 1);
	PlayerTextDrawFont(playerid,Velocimetro[playerid][1], 2);
    // Nome do Veiculo
    Velocimetro[playerid][2] = CreatePlayerTextDraw(playerid,138.100051, 354.806701, "~n~");
	PlayerTextDrawLetterSize(playerid,Velocimetro[playerid][2], 0.2, 1.4);
    PlayerTextDrawColor(playerid,Velocimetro[playerid][2], 0x5555FFAA);
    PlayerTextDrawAlignment(playerid,Velocimetro[playerid][2],1);
	PlayerTextDrawSetOutline(playerid,Velocimetro[playerid][2], 1);
    PlayerTextDrawBackgroundColor(playerid,Velocimetro[playerid][2],80);
	PlayerTextDrawFont(playerid,Velocimetro[playerid][2], 2);
    // Gps
    Velocimetro[playerid][3] = CreatePlayerTextDraw(playerid,86.000000,421.000000, "~n~");
	PlayerTextDrawLetterSize(playerid,Velocimetro[playerid][3], 0.3, 1.4);
    PlayerTextDrawColor(playerid,Velocimetro[playerid][3], 0xFFFFFFAA);
	PlayerTextDrawSetOutline(playerid,Velocimetro[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid,Velocimetro[playerid][3],0x000000AA);
	PlayerTextDrawFont(playerid,Velocimetro[playerid][3], 1);
    PlayerTextDrawAlignment(playerid,Velocimetro[playerid][3],2);
    //Combustivel
    Velocimetro[playerid][4] = CreatePlayerTextDraw(playerid, 138.000259, 397.856323, "~n~");
    PlayerTextDrawLetterSize(playerid, Velocimetro[playerid][4], 0.275200, 1.338667);
    PlayerTextDrawColor(playerid, Velocimetro[playerid][4], 0xCC6600AA);
    PlayerTextDrawSetShadow(playerid, Velocimetro[playerid][4], 1);
    PlayerTextDrawSetOutline(playerid, Velocimetro[playerid][4], 1);
    PlayerTextDrawBackgroundColor(playerid, Velocimetro[playerid][4], 80);
    PlayerTextDrawFont(playerid, Velocimetro[playerid][4], 2);
    //Escolha da cidade
    pCidadeSelect[playerid][0] = CreatePlayerTextDraw(playerid, 228.399826, 322.906616, "<<");
    PlayerTextDrawLetterSize(playerid, pCidadeSelect[playerid][0], 0.716000, 2.593067);
    PlayerTextDrawAlignment(playerid, pCidadeSelect[playerid][0], 2);
    PlayerTextDrawUseBox(playerid, pCidadeSelect[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid, pCidadeSelect[playerid][0], 0);
    PlayerTextDrawColor(playerid, pCidadeSelect[playerid][0], 0x1B1BA5AA);
    PlayerTextDrawBackgroundColor(playerid, pCidadeSelect[playerid][0], 255);
    PlayerTextDrawFont(playerid, pCidadeSelect[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, pCidadeSelect[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, pCidadeSelect[playerid][0], 1);
    PlayerTextDrawTextSize(playerid, pCidadeSelect[playerid][0], 30.0, 25.0);

    pCidadeSelect[playerid][1] = CreatePlayerTextDraw(playerid, 415.609771, 324.400024, ">>");
    PlayerTextDrawLetterSize(playerid, pCidadeSelect[playerid][1], 0.716000, 2.593067);
    PlayerTextDrawAlignment(playerid, pCidadeSelect[playerid][1], 2);
    PlayerTextDrawUseBox(playerid, pCidadeSelect[playerid][1], 1);
    PlayerTextDrawBoxColor(playerid, pCidadeSelect[playerid][1], 0);
    PlayerTextDrawColor(playerid, pCidadeSelect[playerid][1], 0x1B1BA5AA);
    PlayerTextDrawBackgroundColor(playerid, pCidadeSelect[playerid][1], 255);
    PlayerTextDrawFont(playerid, pCidadeSelect[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, pCidadeSelect[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, pCidadeSelect[playerid][1], 1);
    PlayerTextDrawTextSize(playerid, pCidadeSelect[playerid][1], 30.0, 25.0);

    pCidadeSelect[playerid][2] = CreatePlayerTextDraw(playerid, 318.800018, 334.106628, "~y~MORAR");
    PlayerTextDrawLetterSize(playerid, pCidadeSelect[playerid][2], 0.403197, 2.062924);
    PlayerTextDrawAlignment(playerid, pCidadeSelect[playerid][2], 2);
    PlayerTextDrawUseBox(playerid, pCidadeSelect[playerid][2], 1);
   	PlayerTextDrawBoxColor(playerid, pCidadeSelect[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, pCidadeSelect[playerid][2], -1);
    PlayerTextDrawFont(playerid, pCidadeSelect[playerid][2], 1);
    PlayerTextDrawSetProportional(playerid, pCidadeSelect[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, pCidadeSelect[playerid][2], 1);
    PlayerTextDrawTextSize(playerid, pCidadeSelect[playerid][2], 28.0, 37.0);

    pCidadeSelect[playerid][3] = CreatePlayerTextDraw(playerid, 319.599792, 399.813354, "~g~Los Santos");
    PlayerTextDrawLetterSize(playerid, pCidadeSelect[playerid][3], 1.25,3.0);
    PlayerTextDrawAlignment(playerid, pCidadeSelect[playerid][3], 2);
    PlayerTextDrawFont(playerid, pCidadeSelect[playerid][3], 0);
    PlayerTextDrawSetShadow(playerid, pCidadeSelect[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, pCidadeSelect[playerid][2], 0);
    PlayerTextDrawSetProportional(playerid, pCidadeSelect[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, pCidadeSelect[playerid][3], -1);

    pCidadeSelect[playerid][4] = CreatePlayerTextDraw(playerid, 386.800079, 19.013311, "Clique_nas_~b~setas_~w~para_ver_as_cidades~n~e_depois_clique_em_~y~morar_~w~na_cidade_~n~que_voce_deseja_morar.");
    PlayerTextDrawLetterSize(playerid, pCidadeSelect[playerid][4], 0.393599, 2.159999);
    PlayerTextDrawTextSize(playerid, pCidadeSelect[playerid][4], 625.400268, 0.000000);
    PlayerTextDrawAlignment(playerid, pCidadeSelect[playerid][4], 1);
    PlayerTextDrawColor(playerid, pCidadeSelect[playerid][4], -1);
    PlayerTextDrawUseBox(playerid, pCidadeSelect[playerid][4], 1);
    PlayerTextDrawBoxColor(playerid, pCidadeSelect[playerid][4], 130);
    PlayerTextDrawBackgroundColor(playerid, pCidadeSelect[playerid][4], 255);
    PlayerTextDrawFont(playerid, pCidadeSelect[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, pCidadeSelect[playerid][4], 1);
    //Mensagem qunado emviar para outro player
    Notificacoes[playerid] = CreatePlayerTextDraw(playerid, 451.875000, 128.333404, "~n~");
    PlayerTextDrawLetterSize(playerid, Notificacoes[playerid], 0.449999, 1.600000);
    PlayerTextDrawTextSize(playerid, Notificacoes[playerid], 632.500000, 73.500000);
    PlayerTextDrawAlignment(playerid, Notificacoes[playerid], 1);
    PlayerTextDrawColor(playerid, Notificacoes[playerid], -1);
    PlayerTextDrawUseBox(playerid, Notificacoes[playerid], true);
    PlayerTextDrawBoxColor(playerid, Notificacoes[playerid], 150);
    PlayerTextDrawSetShadow(playerid, Notificacoes[playerid], 0);
    PlayerTextDrawSetOutline(playerid, Notificacoes[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, Notificacoes[playerid], 51);
    PlayerTextDrawFont(playerid, Notificacoes[playerid], 1);
    PlayerTextDrawSetProportional(playerid, Notificacoes[playerid], 1);
    //Observções do Local da HQ
    HQobserv[playerid] = CreatePlayerTextDraw(playerid, 325.139221, 380.166595, "Area_de_Carga~n~~y~/Carregar");
    PlayerTextDrawLetterSize(playerid, HQobserv[playerid], 0.400000, 1.600000);
    PlayerTextDrawAlignment(playerid, HQobserv[playerid], 2);
    PlayerTextDrawColor(playerid, HQobserv[playerid], -1);
    PlayerTextDrawSetShadow(playerid, HQobserv[playerid], 0);
    PlayerTextDrawSetOutline(playerid, HQobserv[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, HQobserv[playerid], 255);
    PlayerTextDrawFont(playerid, HQobserv[playerid], 1);
    PlayerTextDrawSetProportional(playerid, HQobserv[playerid], 1);
    PlayerTextDrawSetShadow(playerid, HQobserv[playerid], 0);
    return 1;
}

stock DeleteTextDraws(playerid)
{
    PlayerTextDrawHide(playerid,pCidadeSelect[playerid][0]);
    PlayerTextDrawHide(playerid,pCidadeSelect[playerid][1]);
    PlayerTextDrawHide(playerid,pCidadeSelect[playerid][2]);
    PlayerTextDrawHide(playerid,pCidadeSelect[playerid][3]);
    PlayerTextDrawHide(playerid,pCidadeSelect[playerid][4]);

    PlayerTextDrawHide(playerid,Velocimetro[playerid][0]);
    PlayerTextDrawHide(playerid,Velocimetro[playerid][1]);
    PlayerTextDrawHide(playerid,Velocimetro[playerid][2]);
    PlayerTextDrawHide(playerid,Velocimetro[playerid][3]);

    PlayerTextDrawHide(playerid,HQobserv[playerid]);
    PlayerTextDrawHide(playerid,Notificacoes[playerid]);
    return 1;
}

stock VelocidadeKM(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		GetVehicleVelocity(GetPlayerVehicleID(playerid), Posicao[0], Posicao[1], Posicao[2]);
		Posicao[3] = floatmul(floatsqroot(floatadd(floatadd(floatpower(Posicao[0], 2), floatpower(Posicao[1], 2)),  floatpower(Posicao[2], 2))), 220.0);
		spe = floatround(Posicao[3] * 1);
	}
	else
		return false;
	return spe;
}

stock GetPlayerArea(playerid)//stock responsavel por getar a area para o GPS
{
	new str[30];
	format(str,sizeof(str), "%s", Zones[GetPlayerZone(playerid)][zone_name]);
	return str;
}

stock GetPlayerZone(playerid)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
    Loop(i,sizeof(Zones))
	{
		if(x > Zones[i][zone_minx] && y > Zones[i][zone_miny] && z > Zones[i][zone_minz] && x < Zones[i][zone_maxx] && y < Zones[i][zone_maxy] && z < Zones[i][zone_maxz])
			return i;
	}
	return 0;
}

stock PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	if(((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
        return 1;
	return 0;
}
stock CleanChatBox(playerid,line)
{
    Loop(c,line)
    {
       SendClientMessage(playerid,-1,"");
    }
}
stock LoadTextDrawsGlobal()
{
    gettime(horas ,minutos);
    format(timestr,32,"%02d:%02d",horas ,minutos);
    txtTimeDisp = TextDrawCreate(605.0,25.0,timestr);
	TextDrawUseBox(txtTimeDisp, 0);
	TextDrawFont(txtTimeDisp, 3);
	TextDrawSetShadow(txtTimeDisp,0); // no shadow
    TextDrawSetOutline(txtTimeDisp,2); // thickness 1
    TextDrawBackgroundColor(txtTimeDisp,0x000000FF);
    TextDrawColor(txtTimeDisp,0xFFFFFFFF);
    TextDrawAlignment(txtTimeDisp,3);
	TextDrawLetterSize(txtTimeDisp,0.5,1.5);
}
/*stock LoadInteriores()
{
   //Dp de Los Santos
   CreateEnterExit(0, 1554.8839,-1674.8765,16.1953, 246.783996,63.900199,1003.640625, 0.0, 6, 1, "Delegacia de {FF0000}Los Santos{FFFFFF}!");
   CreateEnterExit(1, 247.2828,62.4531,1003.6406, 1552.2042,-1674.8400,16.1830,0.0, 0, 0);
   //Pref de Los Santos
   CreateEnterExit(0, 1122.7177,-2036.8716,69.8942, 384.808624,173.804992,1008.382812, 0.0, 3, 2, "Prefeitura de {FF0000}Los Santos{FFFFFF}!");
   CreateEnterExit(2, 390.2115,173.6970,1008.3828, 1125.5276,-2036.6853,69.8811,268.3784, 0, 0);
   //Auto escola de Los Santos
   CreateEnterExit(0, 917.4703,-1003.6568,37.9989, -2029.798339,-106.675910,1035.171875, 0.0, 3, 3, "Auto Escola de {FF0000}Los Santos{FFFFFF}!");
   CreateEnterExit(3, -2026.9441,-103.6019,1035.1835, 916.8873,-1001.4281,38.0435,357.3425, 0, 0);
   //Banco de Los Santos
   CreateEnterExit(0, 326.3065,-1515.1017,36.0325, 2308.0505,-16.1197,26.7496, 0.0, 0, 4, "Banco de {FF0000}Los Santos{FFFFFF}!");
   CreateEnterExit(4, 2305.4736,-16.8508,26.7496, 328.4141,-1516.7842,35.8672,224.8246, 0, 0);
   //Loja de Roupas de Los Santos
   CreateEnterExit(0, 460.9478,-1500.6107,31.0607, 225.3882,-7.3931,1002.2109,88.3608, 5, 5, "Loja de Roupas de {FF0000}Los Santos{FFFFFF}!");
   CreateEnterExit(5, 227.5616,-7.3546,1002.2109, 459.1826,-1500.5870,31.0432,103.8768, 0, 0);
   //Ammu-Nation de Los Santos
   CreateEnterExit(0, 1368.3271,-1278.9865,13.5469, 286.148986,-40.644397,1001.515625, 0.0, 1, 6, "Ammu-Nation  de {FF0000}Los Santos{FFFFFF}!");
   CreateEnterExit(6, 284.7294,-41.6027,1001.5156, 1366.5433,-1279.3215,13.5469,92.8867, 0, 0);
   //---------------------------------San fierro--------------------------------
   //Dp de San Fierro
   CreateEnterExit(0, -1605.5649, 711.5371, 13.8672, 246.1845,110.3962, 1003.2257, 2.6308, 10, 7, "Delegacia de {FF0000}San Fierro");
   CreateEnterExit(7, 245.69, 108, 1003.2188, -1605.4934, 714.4520, 12.8833, 0.0, 0, 0);
   //Prefeitura de San Fierro
   CreateEnterExit(0, -2766.5374,375.5638,6.3347, 384.808624,173.804992,1008.382812, 0.0, 3, 8, "Prefeitura de {FF0000}San Fierro");
   CreateEnterExit(8, 390.2115,173.6970,1008.3828, -2763.8306,375.9516,6.1964,273.6185, 0, 0);
   //Auto Escola de San Fierro
   CreateEnterExit(0, -2026.7843,-102.0660,35.1641, -2029.798339,-106.675910,1035.171875, 0.0, 3, 9, "Auto Escola de {FF0000}San Fierro");
   CreateEnterExit(9, -2026.9441,-103.6019,1035.1835, -2026.9546,-99.9509,35.1641,5.1361, 0, 0);
   //Banco San Fierro
   CreateEnterExit(0, -1492.8038,919.9197,7.1875, 2308.0505,-16.1197,26.7496, 0.0, 0, 10, "Banco de {FF0000}San Fierro");
   CreateEnterExit(10, 2305.4736,-16.8508,26.7496, -1495.0249,919.7592,7.1875,88.1468, 0, 0);
   //Loja de Roupas San Fierro
   CreateEnterExit(0, -1694.5635,951.8817,24.8906, 225.3882,-7.3931,1002.2109,88.3608, 5, 11, "Loja de Roupas de {FF0000}San Fierro");
   CreateEnterExit(11, 227.5616,-7.3546,1002.2109, -1696.1865,950.3828,24.8906,126.0136, 0, 0);
   //Ammu-Nation de San Fierro
   CreateEnterExit(0, -2625.8606,208.2379,4.8125, 296.919982,-108.071998,1001.515625,0.0, 6, 12, "Ammu-Nation de {FF0000}San Fierro");
   CreateEnterExit(12, 296.9931,-112.0627,1001.5156, -2626.0891,210.5414,4.6114,0.0758, 0, 0);
   //-------------------------------Las Venturas--------------------------------
   //DP de Las Venturas
   CreateEnterExit(0, 2287.0686,2432.3596,10.8203, 288.745971,169.350997,1007.171875,0.0, 3, 13, "Delegacia de {FF0000}Las Venturas");
   CreateEnterExit(13, 289.3891,166.9270,1007.1719, 2286.6919,2430.4590,10.8203,177.3828, 0, 0);
   //Prefeitura de Las Venturas
   CreateEnterExit(0, 2412.5217,1123.8108,10.8203, 384.808624,173.804992,1008.382812,0.0, 3, 14, "Prefeitura de {FF0000}Las Venturas");
   CreateEnterExit(14, 390.2115,173.6970,1008.3828, 2415.2681,1124.3116,10.8203,274.5170, 0, 0);
   //Loja de Roupas de Las Venturas
   CreateEnterExit(0, 2101.8928,2257.4514,11.0234, 207.737991,-109.019996,1005.132812,0.0, 15, 15, "Loja de Roupas {FF0000}Las Venturas");
   CreateEnterExit(15, 207.7175,-111.2629,1005.1328, 2104.0996,2257.4758,11.0234,276.7104, 0, 0);
   //Banco de Las Venturas
   CreateEnterExit(0, 2127.5308,2380.1128,10.8203, 2308.0505,-16.1197,26.7496,0.0, 0, 16, "Banco de {FF0000}Las Venturas");
   CreateEnterExit(16, 2305.4736,-16.8508,26.7496, 2127.5068,2377.1423,10.8203,182.5412, 0, 0);
   //Ammu-Nation de Las Venturas
   CreateEnterExit(0, 776.7241,1871.5366,4.9074, 296.919982,-108.071998,1001.515625,0.0, 6, 17, "Ammu-Nation de {FF0000}Las Venturas");
   CreateEnterExit(17, 296.9514,-112.0704,1001.5156, 778.9156,1871.3258,4.9061,271.6736, 0, 0);
   //----------------------------------Outros_______________________
   //Predio
   CreateEnterExit(0, 1570.4358,-1336.9004,16.4844, 1546.6499,-1366.4626,326.2109,80.2252, 0, 0);
   CreateEnterExit(0, 1548.5173,-1363.7415,326.2183, 1571.9072,-1335.2157,16.4844,312.3840, 0, 0);
   return 1;
}
CREATE TABLE IF NOT EXISTS `contas` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `Usuario` varchar(24) NOT NULL,
  `senha` varchar(10) NOT NULL,
  `Skin` int(10) NOT NULL DEFAULT '0',
  `aAdmin` tinyint(10) NOT NULL DEFAULT '0',
  `Gasolina` int(10) NOT NULL DEFAULT '30',
  `Etanol` int(10) NOT NULL DEFAULT '30',
  `Diesel` int(10) NOT NULL DEFAULT '60',
  `GNV` int(10) NOT NULL DEFAULT '90',
  `Dinheiro` int(11) NOT NULL DEFAULT '3000',
  `cBancario` int(2) NOT NULL DEFAULT '0',
  `sBancario` int(11) NOT NULL DEFAULT '600',
  `Profissao` int(11) NOT NULL DEFAULT '0',
  `Cidade` int(10) NOT NULL DEFAULT '0',
  `CasaX` float NOT NULL DEFAULT '0.0',
  `CasaY` float NOT NULL DEFAULT '0.0',
  `CasaZ` float NOT NULL DEFAULT '0.0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `acessorios` (
  `Name` varchar(24) NOT NULL,
  `Index` varchar(24) NOT NULL,
  `Slot` int(11) NOT NULL DEFAULT '0',
  `model` int(11) NOT NULL DEFAULT '0',
  `bone` int(11) NOT NULL DEFAULT '0',
  `fX` float NOT NULL DEFAULT '0.0',
  `fY` float NOT NULL DEFAULT '0.0',
  `fZ` float NOT NULL DEFAULT '0.0',
  `rX` float NOT NULL DEFAULT '0.0',
  `rY` float NOT NULL DEFAULT '0.0',
  `rZ` float NOT NULL DEFAULT '0.0',
  `sX` float NOT NULL DEFAULT '0.0',
  `sY` float NOT NULL DEFAULT '0.0',
  `sZ` float NOT NULL DEFAULT '0.0',
  `Enabled` int(11) NOT NULL DEFAULT '0.0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;*/
