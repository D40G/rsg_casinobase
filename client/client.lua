local QBCore = exports['qb-core']:GetCoreObject()
local inCasino = false
local spinningObject = nil
local spinningCar = nil
local carOnShow = GetHashKey('bestiagts')

-- enter casino
RegisterNetEvent("rsg_casinobase:client:casinoenterance")
AddEventHandler("rsg_casinobase:client:casinoenterance", function()
	local hasItem = QBCore.Functions.HasItem('casinomember', 1)
	local player = GetPlayerPed(-1)
	if inCasino == false then
		if hasItem then
			QBCore.Functions.Progressbar("enter-casino", "Showing Casino Membership..", 5000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done			
				DoScreenFadeOut(500)
				Wait(500)
				SetEntityCoords(player, 1093.5058, 211.01394, -48.99988)
				SetEntityHeading(player, 292.86111)
				DoScreenFadeIn(500)
				enterCasino(false)
				Citizen.Wait(1)
				enterCasino(true)
				scanned = true
				scanwait = 200
			end, function()
				QBCore.Functions.Notify("Cancelled..", "error")
			end)
		else
			QBCore.Functions.Notify("You don't have a membership card!", "error")
		end
	else
		QBCore.Functions.Notify("You are not in the Casino!", "error")
	end
end)

-- exit casino
RegisterNetEvent("rsg_casinobase:client:casinoexit")
AddEventHandler("rsg_casinobase:client:casinoexit", function()
	local hasItem = QBCore.Functions.HasItem('casinomember', 1)
	local player = GetPlayerPed(-1)
	if hasItem then
		QBCore.Functions.Progressbar("exit-casino", "Leaving Casino..", 5000, false, true, {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
			}, {
				animDict = "mp_common",
				anim = "givetake1_a",
				flags = 8,
			}, {}, {}, function() -- Done			
			DoScreenFadeOut(500)
			Wait(500)
			SetEntityCoords(player, 923.76922, 47.084514, 81.106323)
			SetEntityHeading(player, 58.976482)
			DoScreenFadeIn(500)
			enterCasino(false)
			Citizen.Wait(1)
			enterCasino(false)
			scanned = false
			scanwait = 200
		end, function()
			QBCore.Functions.Notify("Cancelled..", "error")
		end)
	else
		QBCore.Functions.Notify("You don't have a membership card!", "error")
	end
end)

function IsTable(T)
	return type(T) == 'table'
end

function SetIplPropState(interiorId, props, state, refresh)
	if refresh == nil then refresh = false end
	if IsTable(interiorId) then
		for key, value in pairs(interiorId) do
			SetIplPropState(value, props, state, refresh)
		end
	else
		if IsTable(props) then
			for key, value in pairs(props) do
				SetIplPropState(interiorId, value, state, refresh)
			end
		else
			if state then
				if not IsInteriorPropEnabled(interiorId, props) then EnableInteriorProp(interiorId, props) end
			else
				if IsInteriorPropEnabled(interiorId, props) then DisableInteriorProp(interiorId, props) end
			end
		end
		if refresh == true then RefreshInterior(interiorId) end
	end
end
  
Citizen.CreateThread(function()
	Wait(0)
	RequestIpl('vw_casino_main')
	RequestIpl('vw_dlc_casino_door')
	RequestIpl('hei_dlc_casino_door')
	RequestIpl("hei_dlc_windows_casino")
	RequestIpl("vw_casino_penthouse")
	SetIplPropState(274689, "Set_Pent_Tint_Shell", true, true)
	SetInteriorEntitySetColor(274689, "Set_Pent_Tint_Shell", 3)
	RequestIpl("hei_dlc_windows_casino_lod")
	RequestIpl("vw_casino_carpark")
	RequestIpl("vw_casino_garage")
	RequestIpl("hei_dlc_casino_aircon")
	RequestIpl("hei_dlc_casino_aircon_lod")
	RequestIpl("hei_dlc_casino_door")
	RequestIpl("hei_dlc_casino_door_lod")
	RequestIpl("hei_dlc_vw_roofdoors_locked")
	RequestIpl("vw_ch3_additions")
	RequestIpl("vw_ch3_additions_long_0")
	RequestIpl("vw_ch3_additions_strm_0")
	RequestIpl("vw_dlc_casino_door")
	RequestIpl("vw_dlc_casino_door_lod")
	RequestIpl("vw_casino_billboard")
	RequestIpl("vw_casino_billboard_lod(1)")
	RequestIpl("vw_casino_billboard_lod")
	RequestIpl("vw_int_placement_vw")
	RequestIpl("vw_dlc_casino_apart")
	
	local interiorID = GetInteriorAtCoords(1100.000, 220.000, -50.000)
	
	if IsValidInterior(interiorID) then
		RefreshInterior(interiorID)
	end
end)

-- CAR FOR WINS
function drawCarForWins()
	if DoesEntityExist(spinningCar) then
	  DeleteEntity(spinningCar)
	end
	RequestModel(carOnShow)
	while not HasModelLoaded(carOnShow) do
		Citizen.Wait(0)
	end
	SetModelAsNoLongerNeeded(carOnShow)
	spinningCar = CreateVehicle(carOnShow, 1100.0, 220.0, -51.0 + 0.05, 0.0, 0, 0)
	Wait(0)
	SetVehicleDirtLevel(spinningCar, 0.0)
	SetVehicleOnGroundProperly(spinningCar)
	Wait(0)
	FreezeEntityPosition(spinningCar, 1)
end

-- END CAR FOR WINS

function enterCasino(pIsInCasino, pFromElevator, pCoords, pHeading)
	if pIsInCasino == inCasino then return end
	inCasino = pIsInCasino
	if DoesEntityExist(spinningCar) then
	  DeleteEntity(spinningCar)
	end
	Wait(500)
	spinMeRightRoundBaby()
	showDiamondsOnScreenBaby()
	playSomeBackgroundAudioBaby()
end
  
function spinMeRightRoundBaby()
	Citizen.CreateThread(function()
	    while inCasino do
		if not spinningObject or spinningObject == 0 or not DoesEntityExist(spinningObject) then
			spinningObject = GetClosestObjectOfType(1100.0, 220.0, -51.0, 10.0, -1561087446, 0, 0, 0)
			drawCarForWins()
		end
		if spinningObject ~= nil and spinningObject ~= 0 then
			local curHeading = GetEntityHeading(spinningObject)
			local curHeadingCar = GetEntityHeading(spinningCar)
			if curHeading >= 360 then
				curHeading = 0.0
				curHeadingCar = 0.0
			elseif curHeading ~= curHeadingCar then
				curHeadingCar = curHeading
			end
			SetEntityHeading(spinningObject, curHeading + 0.075)
			SetEntityHeading(spinningCar, curHeadingCar + 0.075)
		end
		Wait(0)
	end
		spinningObject = nil
	end)
end
  
-- Casino Screens
local Playlists = {
	"CASINO_DIA_PL", -- diamonds
	"CASINO_SNWFLK_PL", -- snowflakes
	"CASINO_WIN_PL", -- win
	"CASINO_HLW_PL", -- skull
}
 
-- Render
function CreateNamedRenderTargetForModel(name, model)
	local handle = 0
	if not IsNamedRendertargetRegistered(name) then
		RegisterNamedRendertarget(name, 0)
	end
	if not IsNamedRendertargetLinked(model) then
		LinkNamedRendertarget(model)
	end
	if IsNamedRendertargetRegistered(name) then
		handle = GetNamedRendertargetRenderId(name)
	end
  
	return handle
end

-- render tv 
function showDiamondsOnScreenBaby()
	Citizen.CreateThread(function()
	  local model = GetHashKey("vw_vwint01_video_overlay")
	  local timeout = 21085 -- 5000 / 255
  
	  local handle = CreateNamedRenderTargetForModel("CasinoScreen_01", model)
  
	  RegisterScriptWithAudio(0)
	  SetTvChannel(-1)
	  SetTvVolume(0)
	  SetScriptGfxDrawOrder(4)
	  SetTvChannelPlaylist(2, "CASINO_DIA_PL", 0)
	  SetTvChannel(2)
	  EnableMovieSubtitles(1)
  
	function doAlpha()
		Citizen.SetTimeout(timeout, function()
		SetTvChannelPlaylist(2, "CASINO_DIA_PL", 0)
		SetTvChannel(2)
		doAlpha()
		end)
	end
	doAlpha()
  
	Citizen.CreateThread(function()
	while inCasino do
		SetTextRenderId(handle)
		DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
		SetTextRenderId(GetDefaultScriptRendertargetRenderId())
		Citizen.Wait(0)
	end
		SetTvChannel(-1)
		ReleaseNamedRendertarget(GetHashKey("CasinoScreen_01"))
		SetTextRenderId(GetDefaultScriptRendertargetRenderId())
		end)
   end)
end
  
function playSomeBackgroundAudioBaby()
	Citizen.CreateThread(function()
	local function audioBanks()
		while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_GENERAL", false, -1) do
			Citizen.Wait(0)
		end
		while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_01", false, -1) do
			Citizen.Wait(0)
		end
		while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_02", false, -1) do
			Citizen.Wait(0)
		end
		while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_03", false, -1) do
			Citizen.Wait(0)
		end
	end
	audioBanks()
	while inCasino do
		if not IsStreamPlaying() and LoadStream("casino_walla", "DLC_VW_Casino_Interior_Sounds") then
			PlayStreamFromPosition(1111, 230, -47)
		end
		if IsStreamPlaying() and not IsAudioSceneActive("DLC_VW_Casino_General") then
			StartAudioScene("DLC_VW_Casino_General")
		end
		Citizen.Wait(1000)
		end
		if IsStreamPlaying() then
			StopStream()
		end
		if IsAudioSceneActive("DLC_VW_Casino_General") then
			StopAudioScene("DLC_VW_Casino_General")
		end
	end)
end

-- map blip
Citizen.CreateThread(function()
    casino = AddBlipForCoord(923.78063, 47.112033, 81.106338)
    SetBlipSprite (casino, 617)
    SetBlipDisplay(casino, 4)
    SetBlipScale  (casino, 0.55)
    SetBlipAsShortRange(casino, true)
    SetBlipColour(casino, 48)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Diamond Casino")
    EndTextCommandSetBlipName(casino)
end)