// Sistema criado pelo desenvolvedor ribeiroscrit, favor manter créditos!

#define FILTERSCRIPT

#include <a_samp>
#include <sscanf2>
#include <streamer>
#include <Pawn.CMD>

#define PROF_CABLE 1

enum pInfo
{
	Profissao
};

new PlayerInfo[MAX_PLAYERS][pInfo];
new SpawnBonde[2];
new VariavelBonde[MAX_PLAYERS];
new RotaCheck[MAX_PLAYERS];
new VTimer[MAX_PLAYERS];

new Text:TextdrawMensagemTela;

new bool:IniciouServico[MAX_PLAYERS];

public OnFilterScriptInit()
{
	CreateDynamicPickup(1210, 1, -2274.487548, 536.145446, 35.199756); // Pickup Pegar Profissao!
	CreateDynamic3DTextLabel("[Profissao Cable-Car]\nDigite /trabalharaqui para trabalhar!", -1, -2274.487548, 536.145446, 35.199756, 3.0);

	SpawnBonde[0] = CreateDynamicPickup(1318, 1, -2277.501464, 526.718322, 35.171875); // Pickup Pegar Bonde - 1!
	SpawnBonde[1] = CreateDynamicPickup(1318, 1, -2277.500488, 541.180480, 35.171875); // Pickup Pegar Bonde - 1!

	CreateDynamicMapIcon(-2264.727050, 532.682373, 35.571205, 56, -1); // MapIcon Local

	// Textdraw mensagem tela
	TextdrawMensagemTela = TextDrawCreate(318.000000, 369.000000, "_");
	TextDrawAlignment(TextdrawMensagemTela, 2);
	TextDrawBackgroundColor(TextdrawMensagemTela, 255);
	TextDrawFont(TextdrawMensagemTela, 2);
	TextDrawLetterSize(TextdrawMensagemTela, 0.230000, 1.299999);
	TextDrawColor(TextdrawMensagemTela, -1);
	TextDrawSetOutline(TextdrawMensagemTela, 1);
	TextDrawSetProportional(TextdrawMensagemTela, 1);
	TextDrawSetSelectable(TextdrawMensagemTela, 0);

	// Map Hq
	CreateDynamicObject(983, -2293.080566, 553.456481, 34.871875, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -2286.680175, 553.456481, 34.871875, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -2280.280273, 553.456481, 34.871875, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -2273.880371, 553.456481, 34.871875, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -2248.680908, 553.456481, 34.871875, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -2242.281005, 553.456481, 34.871875, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -2239.881347, 553.456481, 34.871875, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -2248.680908, 518.456481, 34.871875, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -2242.281005, 518.456481, 34.871875, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -2239.881347, 518.456481, 34.871875, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -2293.080566, 518.256469, 34.871875, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -2286.680175, 518.256469, 34.871875, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -2280.280273, 518.256469, 34.871875, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -2273.880371, 518.256469, 34.871875, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -2251.880371, 540.856567, 34.871875, 0.000007, 0.000000, 0.000007, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -2251.880371, 534.456176, 34.871875, 0.000007, 0.000000, 0.000007, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -2251.880371, 528.056274, 34.871875, 0.000007, 0.000000, 0.000007, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -2251.880371, 521.656372, 34.871875, 0.000007, 0.000000, 0.000007, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -2251.880371, 547.256591, 34.871875, 0.000007, 0.000000, 0.000007, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -2251.880371, 550.256652, 34.871875, 0.000007, 0.000000, 0.000007, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(8406, -2236.500000, 533.302978, 39.171875, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -2236.681396, 521.656433, 34.871875, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(983, -2236.681396, 550.256408, 34.871875, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(1267, -2274.375976, 552.919982, 47.015625, 0.000000, 0.000000, 50.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(19124, -2270.330810, 553.375732, 34.715621, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(19124, -2252.230712, 553.375732, 34.615623, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(19124, -2270.330810, 518.275756, 34.715621, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(19124, -2252.230712, 518.275756, 34.615623, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	CreateDynamicObject(3626, -2274.263427, 533.899780, 35.415626, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(IniciouServico[playerid] == true)
	{
		DestroyVehicle(VariavelBonde[playerid]);
		DisablePlayerRaceCheckpoint(playerid);
		SetCameraBehindPlayer(playerid);
		IniciouServico[playerid] = false;
		RotaCheck[playerid] = 0;
	}
	return 1;
}
public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_ONFOOT && oldstate == PLAYER_STATE_DRIVER)
	{
		if(IniciouServico[playerid] == true)
		{
			IniciouServico[playerid] = false;
			RotaCheck[playerid] = 0;
			DestroyVehicle(VariavelBonde[playerid]);
			DisablePlayerRaceCheckpoint(playerid);
			SetCameraBehindPlayer(playerid);
			SendMensagemTela(playerid, "~r~Voce saiu de seu cable-car e ele foi destroido automaticamente!");
		}
	}
	return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	if(pickupid == SpawnBonde[0])
	{
		if(PlayerInfo[playerid][Profissao] == PROF_CABLE)
		{
			if(IniciouServico[playerid] == false)
			{
				ShowPlayerDialog(playerid, 9765, DIALOG_STYLE_MSGBOX, "Cable-Car Garagem", "Deseja retirar um cable-car da garagem?", "Sim", "Nao");
			}
		}
	}
	else if(pickupid == SpawnBonde[1])
	{
		if(PlayerInfo[playerid][Profissao] == PROF_CABLE)
		{
			if(IniciouServico[playerid] == false)
			{
				ShowPlayerDialog(playerid, 9765, DIALOG_STYLE_MSGBOX, "Cable-Car Garagem", "Deseja retirar um cable-car da garagem?", "Sim", "Nao");
			}
		}
	}
	return 1;
}

public OnPlayerUpdate(playerid)
{
	if(IsPlayerInRaceCheckpoint(playerid))
	{
		if(IniciouServico[playerid] == true)
		{
			if(IsPlayerInVehicle(playerid, VariavelBonde[playerid]))
			{
				if(RotaCheck[playerid] == 0)
				{
					if(GetVehicleSpeed(GetPlayerVehicleID(playerid)) == 0)
					{
						RotaCheck[playerid] ++;
						DisablePlayerRaceCheckpoint(playerid);
						PlayerPlaySound(playerid,3211056,0.0,0.0,0.0);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("EmbarcandoPassageiros", 5000, false, "i", playerid);
						SendMensagemTela(playerid, "Aguarde enquanto os passageiros embarcam e desembarcam do cable-car!");

						SetPlayerRaceCheckpoint(playerid, 0, -2251.690917, 127.743408, 35.622306, -2166.625000, -26.995384, 35.622306, 5.0);
						return 1;
					}
					return SendMensagemTela(playerid, "~r~Voce precisa parar completamente o cable-car!");
				}
				if(RotaCheck[playerid] == 1)
				{
					if(GetVehicleSpeed(GetPlayerVehicleID(playerid)) == 0)
					{
						RotaCheck[playerid] ++;
						DisablePlayerRaceCheckpoint(playerid);
						PlayerPlaySound(playerid,3211056,0.0,0.0,0.0);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("EmbarcandoPassageiros", 5000, false, "i", playerid);
						SendMensagemTela(playerid, "Aguarde enquanto os passageiros embarcam e desembarcam do cable-car!");

						SetPlayerRaceCheckpoint(playerid, 0, -2166.625000, -26.995384, 35.622306, -2006.500000, 141.987792, 27.997308, 5.0);
						return 1;
					}
					return SendMensagemTela(playerid, "~r~Voce precisa parar completamente o cable-car!");
				}
				if(RotaCheck[playerid] == 2)
				{
					if(GetVehicleSpeed(GetPlayerVehicleID(playerid)) == 0)
					{
						RotaCheck[playerid] ++;
						DisablePlayerRaceCheckpoint(playerid);
						PlayerPlaySound(playerid,3211056,0.0,0.0,0.0);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("EmbarcandoPassageiros", 5000, false, "i", playerid);
						SendMensagemTela(playerid, "Aguarde enquanto os passageiros embarcam e desembarcam do cable-car!");

						SetPlayerRaceCheckpoint(playerid, 0, -2006.500000, 141.987792, 27.997308, -2003.625000, 470.198913, 35.497306, 5.0);
						return 1;
					}
					return SendMensagemTela(playerid, "~r~Voce precisa parar completamente o cable-car!");
				}
				if(RotaCheck[playerid] == 3)
				{
					if(GetVehicleSpeed(GetPlayerVehicleID(playerid)) == 0)
					{
						RotaCheck[playerid] ++;
						DisablePlayerRaceCheckpoint(playerid);
						PlayerPlaySound(playerid,3211056,0.0,0.0,0.0);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("EmbarcandoPassageiros", 5000, false, "i", playerid);
						SendMensagemTela(playerid, "Aguarde enquanto os passageiros embarcam e desembarcam do cable-car!");

						SetPlayerRaceCheckpoint(playerid, 0, -2003.625000, 470.198913, 35.497306, -1865.357666, 603.250000, 35.497306, 5.0);
						return 1;
					}
					return SendMensagemTela(playerid, "~r~Voce precisa parar completamente o cable-car!");
				}
				if(RotaCheck[playerid] == 4)
				{
					if(GetVehicleSpeed(GetPlayerVehicleID(playerid)) == 0)
					{
						RotaCheck[playerid] ++;
						DisablePlayerRaceCheckpoint(playerid);
						PlayerPlaySound(playerid,3211056,0.0,0.0,0.0);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("EmbarcandoPassageiros", 5000, false, "i", playerid);
						SendMensagemTela(playerid, "Aguarde enquanto os passageiros embarcam e desembarcam do cable-car!");

						SetPlayerRaceCheckpoint(playerid, 0, -1865.357666, 603.250000, 35.497306, -1622.558105, 728.750000, 14.735166, 5.0);
						return 1;
					}
					return SendMensagemTela(playerid, "~r~Voce precisa parar completamente o cable-car!");
				}
				if(RotaCheck[playerid] == 5)
				{
					if(GetVehicleSpeed(GetPlayerVehicleID(playerid)) == 0)
					{
						RotaCheck[playerid] ++;
						DisablePlayerRaceCheckpoint(playerid);
						PlayerPlaySound(playerid,3211056,0.0,0.0,0.0);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("EmbarcandoPassageiros", 5000, false, "i", playerid);
						SendMensagemTela(playerid, "Aguarde enquanto os passageiros embarcam e desembarcam do cable-car!");

						SetPlayerRaceCheckpoint(playerid, 0, -1622.558105, 728.750000, 14.735166, -1597.198974, 848.954223, 7.997308, 5.0);
						return 1;
					}
					return SendMensagemTela(playerid, "~r~Voce precisa parar completamente o cable-car!");
				}
				if(RotaCheck[playerid] == 6)
				{
					if(GetVehicleSpeed(GetPlayerVehicleID(playerid)) == 0)
					{
						RotaCheck[playerid] ++;
						DisablePlayerRaceCheckpoint(playerid);
						PlayerPlaySound(playerid,3211056,0.0,0.0,0.0);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("EmbarcandoPassageiros", 5000, false, "i", playerid);
						SendMensagemTela(playerid, "Aguarde enquanto os passageiros embarcam e desembarcam do cable-car!");

						SetPlayerRaceCheckpoint(playerid, 0, -1597.198974, 848.954223, 7.997308, -1875.423339, 848.875000, 35.497306, 5.0);
						return 1;
					}
					return SendMensagemTela(playerid, "~r~Voce precisa parar completamente o cable-car!");
				}
				if(RotaCheck[playerid] == 7)
				{
					if(GetVehicleSpeed(GetPlayerVehicleID(playerid)) == 0)
					{
						RotaCheck[playerid] ++;
						DisablePlayerRaceCheckpoint(playerid);
						PlayerPlaySound(playerid,3211056,0.0,0.0,0.0);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("EmbarcandoPassageiros", 5000, false, "i", playerid);
						SendMensagemTela(playerid, "Aguarde enquanto os passageiros embarcam e desembarcam do cable-car!");

						SetPlayerRaceCheckpoint(playerid, 0, -1875.423339, 848.875000, 35.497306, -2001.625000, 894.114501, 45.747306, 5.0);
						return 1;
					}
					return SendMensagemTela(playerid, "~r~Voce precisa parar completamente o cable-car!");
				}
				if(RotaCheck[playerid] == 8)
				{
					if(GetVehicleSpeed(GetPlayerVehicleID(playerid)) == 0)
					{
						RotaCheck[playerid] ++;
						DisablePlayerRaceCheckpoint(playerid);
						PlayerPlaySound(playerid,3211056,0.0,0.0,0.0);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("EmbarcandoPassageiros", 5000, false, "i", playerid);
						SendMensagemTela(playerid, "Aguarde enquanto os passageiros embarcam e desembarcam do cable-car!");

						SetPlayerRaceCheckpoint(playerid, 0, -2001.625000, 894.114501, 45.747306, -1736.164062, 921.125000, 25.122308, 5.0);
						return 1;
					}
					return SendMensagemTela(playerid, "~r~Voce precisa parar completamente o cable-car!");
				}
				if(RotaCheck[playerid] == 9)
				{
					if(GetVehicleSpeed(GetPlayerVehicleID(playerid)) == 0)
					{
						RotaCheck[playerid] ++;
						DisablePlayerRaceCheckpoint(playerid);
						PlayerPlaySound(playerid,3211056,0.0,0.0,0.0);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("EmbarcandoPassageiros", 5000, false, "i", playerid);
						SendMensagemTela(playerid, "Aguarde enquanto os passageiros embarcam e desembarcam do cable-car!");

						SetPlayerRaceCheckpoint(playerid, 0, -1736.164062, 921.125000, 25.122308, -1535.695556, 961.315734, 7.497308, 5.0);
						return 1;
					}
					return SendMensagemTela(playerid, "~r~Voce precisa parar completamente o cable-car!");
				}
				if(RotaCheck[playerid] == 10)
				{
					if(GetVehicleSpeed(GetPlayerVehicleID(playerid)) == 0)
					{
						RotaCheck[playerid] ++;
						DisablePlayerRaceCheckpoint(playerid);
						PlayerPlaySound(playerid,3211056,0.0,0.0,0.0);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("EmbarcandoPassageiros", 5000, false, "i", playerid);
						SendMensagemTela(playerid, "Aguarde enquanto os passageiros embarcam e desembarcam do cable-car!");

						SetPlayerRaceCheckpoint(playerid, 0, -1535.695556, 961.315734, 7.497308, -1635.993896, 1248.951416, 7.497308, 5.0);
						return 1;
					}
					return SendMensagemTela(playerid, "~r~Voce precisa parar completamente o cable-car!");
				}
				if(RotaCheck[playerid] == 11)
				{
					if(GetVehicleSpeed(GetPlayerVehicleID(playerid)) == 0)
					{
						RotaCheck[playerid] ++;
						DisablePlayerRaceCheckpoint(playerid);
						PlayerPlaySound(playerid,3211056,0.0,0.0,0.0);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("EmbarcandoPassageiros", 5000, false, "i", playerid);
						SendMensagemTela(playerid, "Aguarde enquanto os passageiros embarcam e desembarcam do cable-car!");

						SetPlayerRaceCheckpoint(playerid, 0, -1635.993896, 1248.951416, 7.497308, -1984.369995, 1307.875000, 7.497308, 5.0);
						return 1;
					}
					return SendMensagemTela(playerid, "~r~Voce precisa parar completamente o cable-car!");
				}
				if(RotaCheck[playerid] == 12)
				{
					if(GetVehicleSpeed(GetPlayerVehicleID(playerid)) == 0)
					{
						RotaCheck[playerid] ++;
						DisablePlayerRaceCheckpoint(playerid);
						PlayerPlaySound(playerid,3211056,0.0,0.0,0.0);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("EmbarcandoPassageiros", 5000, false, "i", playerid);
						SendMensagemTela(playerid, "Aguarde enquanto os passageiros embarcam e desembarcam do cable-car!");

						SetPlayerRaceCheckpoint(playerid, 0, -1984.369995, 1307.875000, 7.497308, -2264.875000, 1075.675659, 81.099739, 5.0);
						return 1;
					}
					return SendMensagemTela(playerid, "~r~Voce precisa parar completamente o cable-car!");
				}
				if(RotaCheck[playerid] == 13)
				{
					if(GetVehicleSpeed(GetPlayerVehicleID(playerid)) == 0)
					{
						RotaCheck[playerid] ++;
						DisablePlayerRaceCheckpoint(playerid);
						PlayerPlaySound(playerid,3211056,0.0,0.0,0.0);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("EmbarcandoPassageiros", 5000, false, "i", playerid);
						SendMensagemTela(playerid, "Aguarde enquanto os passageiros embarcam e desembarcam do cable-car!");

						SetPlayerRaceCheckpoint(playerid, 0, -2264.875000, 1075.675659, 81.099739, -2264.875000, 937.012878, 66.968963, 5.0);
						return 1;
					}
					return SendMensagemTela(playerid, "~r~Voce precisa parar completamente o cable-car!");
				}
				if(RotaCheck[playerid] == 14)
				{
					if(GetVehicleSpeed(GetPlayerVehicleID(playerid)) == 0)
					{
						RotaCheck[playerid] ++;
						DisablePlayerRaceCheckpoint(playerid);
						PlayerPlaySound(playerid,3211056,0.0,0.0,0.0);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("EmbarcandoPassageiros", 5000, false, "i", playerid);
						SendMensagemTela(playerid, "Aguarde enquanto os passageiros embarcam e desembarcam do cable-car!");

						SetPlayerRaceCheckpoint(playerid, 0, -2264.875000, 937.012878, 66.968963, -2264.886718, 803.180664, 49.860771, 5.0);
						return 1;
					}
					return SendMensagemTela(playerid, "~r~Voce precisa parar completamente o cable-car!");
				}
				if(RotaCheck[playerid] == 15)
				{
					if(GetVehicleSpeed(GetPlayerVehicleID(playerid)) == 0)
					{
						RotaCheck[playerid] ++;
						DisablePlayerRaceCheckpoint(playerid);
						PlayerPlaySound(playerid,3211056,0.0,0.0,0.0);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("EmbarcandoPassageiros", 5000, false, "i", playerid);
						SendMensagemTela(playerid, "Aguarde enquanto os passageiros embarcam e desembarcam do cable-car!");

						SetPlayerRaceCheckpoint(playerid, 0, -2264.886718, 803.180664, 49.860771, -2264.829101, 546.930419, 35.520324, 5.0);
						return 1;
					}
					return SendMensagemTela(playerid, "~r~Voce precisa parar completamente o cable-car!");
				}
				if(RotaCheck[playerid] == 16)
				{
					if(GetVehicleSpeed(GetPlayerVehicleID(playerid)) == 0)
					{
						RotaCheck[playerid] ++;
						DisablePlayerRaceCheckpoint(playerid);
						PlayerPlaySound(playerid,3211056,0.0,0.0,0.0);
						TogglePlayerControllable(playerid, 0);
						SetTimerEx("EmbarcandoPassageiros", 5000, false, "i", playerid);
						SendMensagemTela(playerid, "Aguarde enquanto os passageiros embarcam e desembarcam do cable-car!");

						SetPlayerRaceCheckpoint(playerid, 1, -2264.829101, 546.930419, 35.520324, -2264.829101, 546.930419, 35.520324, 5.0);
						return 1;
					}
					return SendMensagemTela(playerid, "~r~Voce precisa parar completamente o cable-car!");
				}
				if(RotaCheck[playerid] == 17)
				{
					if(GetVehicleSpeed(GetPlayerVehicleID(playerid)) == 0)
					{
						RotaCheck[playerid] = 0;
						DisablePlayerRaceCheckpoint(playerid);
						PlayerPlaySound(playerid,3211056,0.0,0.0,0.0);

						SendMensagemTela(playerid, "Rota finalizada com sucesso, voce recebeu ~g~R$750~w~ pelo trabalho.");
						GivePlayerMoney(playerid, 750);

						DestroyVehicle(VariavelBonde[playerid]);
						IniciouServico[playerid] = false;

						SetPlayerPos(playerid, -2271.312500, 536.503173, 35.015625);
						SetPlayerFacingAngle(playerid, 274.665954);
						SetCameraBehindPlayer(playerid);
						return 1;
					}
					return SendMensagemTela(playerid, "~r~Voce precisa parar completamente o cable-car!");
				}
			}
		}
	}
	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 9765)
	{
		if(response)
		{
			VariavelBonde[playerid] = CreateVehicle(449, -2264.727050, 532.682373, 35.571205, 180.407592, 1, 1, 10);
			PutPlayerInVehicle(playerid, VariavelBonde[playerid], 0);
			IniciouServico[playerid] = true;

			SendMensagemTela(playerid, "Siga os checkpoints marcados em seu mini-mapa com o cable-car~n~Voce precisa parar nos checkpoints para os passageiros decer ou subir!");
			SetPlayerRaceCheckpoint(playerid, 0, -2331.074951, 443.020935, 34.545463, -2251.690917, 127.743408, 35.622306, 5.0);
			RotaCheck[playerid] = 0;
		}
	}
	return 1;
}

CMD:trabalharaqui(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 3.0, -2274.487548, 536.145446, 35.199756))
	{
		if(PlayerInfo[playerid][Profissao] == PROF_CABLE)
		{
			return SendClientMessage(playerid, -1, "ERRO: Voce ja esta trabalhando nesta profissao!");
		}
		else
		{
			PlayerInfo[playerid][Profissao] = PROF_CABLE;
			PlayerPlaySound(playerid,1058,0.0,0.0,0.0);

			new string[120];
			format(string, sizeof(string), "SERVER: Parabens %s, voce agora pode trabalhar com os cable-car de sao-fierro!", PlayerName(playerid));
			SendClientMessage(playerid, -1, string);
			return 1;
		}
	}
	return SendClientMessage(playerid, -1, "ERRO: Voce nao esta proximo de nenhuma hq de profissao!");
}

forward QuebrarTextMsg(playerid);
public QuebrarTextMsg(playerid)
{
	return TextDrawHideForPlayer(playerid, TextdrawMensagemTela);
}

forward EmbarcandoPassageiros(playerid);
public EmbarcandoPassageiros(playerid)
{
	new string[128];
	TogglePlayerControllable(playerid, 1);

	format(string, sizeof(string), "Siga para o proximo checkpoint em seu mini-mapa~n~~g~Checkpoints Restantes: ~w~%02d/18", RotaCheck[playerid]);
	SendMensagemTela(playerid, string);
	return 1;
}

// Stocks
stock PlayerName(playerid)
{
	new Nome[MAX_PLAYER_NAME];
	GetPlayerName(playerid, Nome, sizeof(Nome));
	return Nome;
}

stock SendMensagemTela(playerid, const text[])
{
	KillTimer(VTimer[playerid]);

	TextDrawSetString(TextdrawMensagemTela, text);
	TextDrawShowForPlayer(playerid, TextdrawMensagemTela);
	PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
	VTimer[playerid] = SetTimerEx("QuebrarTextMsg", 5500, false, "i", playerid);
	return 1;
}

stock GetVehicleSpeed(vehicleid)
{
	new Float:xPos[3];
	GetVehicleVelocity(vehicleid, xPos[0], xPos[1], xPos[2]);
	return floatround(floatsqroot(xPos[0] * xPos[0] + xPos[1] * xPos[1] + xPos[2] * xPos[2]) * 170.00);
}