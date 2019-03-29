local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

local PlayerData              = {}
local BlipList                = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local Licenses                = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	refreshBlips()
	
	TriggerServerEvent('esx_licenseshop:ServerLoadLicenses')
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	refreshBlips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	deleteBlips()
	refreshBlips()
end)

-- Open License Shop
function OpenLicenseShop()
	local ownedLicenses = {}
	
	for i=1, #Licenses, 1 do
		ownedLicenses[Licenses[i].type] = true
	end
	
	local elements = {}
	
	if not ownedLicenses['dmv'] then
		table.insert(elements, {label = _U('need_dmv')})
	end
	
	if ownedLicenses['dmv'] then
		if not ownedLicenses['aircraft'] then
			table.insert(elements, {label = _U('license_aircraft') .. ' <span style="color: green;">$' .. Config.AircraftLicensePrice .. '</span>', value = 'buy_license_aircraft'})
		end
		
		if not ownedLicenses['boating'] then
			table.insert(elements, {label = _U('license_boating') .. ' <span style="color: green;">$' .. Config.BoatingLicensePrice .. '</span>', value = 'buy_license_boating'})
		end
		
		if not ownedLicenses['drive_truck'] then
			table.insert(elements, {label = _U('license_commercial') .. ' <span style="color: green;">$' .. Config.CommercialLicensePrice .. '</span>', value = 'buy_license_commercial'})
		end
		
		if not ownedLicenses['drive'] then
			table.insert(elements, {label = _U('license_drivers') .. ' <span style="color: green;">$' .. Config.DriversLicensePrice .. '</span>', value = 'buy_license_drivers'})
		end
		
		if not ownedLicenses['drive_bike'] then
			table.insert(elements, {label = _U('license_motorcycle') .. ' <span style="color: green;">$' .. Config.MotorcyleLicensePrice .. '</span>', value = 'buy_license_motorcycle'})
		end
		
		if not ownedLicenses['weapon'] then
			table.insert(elements, {label = _U('license_weapon') .. ' <span style="color: green;">$' .. Config.WeaponLicensePrice .. '</span>', value = 'buy_license_weapon'})
		end
		
		if not ownedLicenses['weed_processing'] then
			table.insert(elements, {label = _U('license_weed') .. ' <span style="color: green;">$' .. Config.WeedLicensePrice .. '</span>', value = 'buy_license_weed'})
		end
	end
	
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'license_shop_actions', {
		title    = _U('buy_license'),
		elements = elements,
		align    = 'top-left'
	}, function(data, menu)
		if data.current.value == 'buy_license_aircraft' then
			TriggerServerEvent('esx_licenseshop:buyLicenseAircraft')
			menu.close()
		elseif data.current.value == 'buy_license_boating' then
			TriggerServerEvent('esx_licenseshop:buyLicenseBoating')
			menu.close()
		elseif data.current.value == 'buy_license_commercial' then
			TriggerServerEvent('esx_licenseshop:buyLicenseCommercial')
			menu.close()
		elseif data.current.value == 'buy_license_drivers' then
			TriggerServerEvent('esx_licenseshop:buyLicenseDrivers')
			menu.close()
		elseif data.current.value == 'buy_license_motorcycle' then
			TriggerServerEvent('esx_licenseshop:buyLicenseMotorcyle')
			menu.close()
		elseif data.current.value == 'buy_license_weapon' then
			TriggerServerEvent('esx_licenseshop:buyLicenseWeapon')
			menu.close()
		elseif data.current.value == 'buy_license_weed' then
			TriggerServerEvent('esx_licenseshop:buyLicenseWeed')
			menu.close()
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'license_menu'
		CurrentActionMsg  = _U('press_access')
		CurrentActionData = {}
	end)
end

AddEventHandler('esx_licenseshop:hasEnteredMarker', function(zone)
	CurrentAction     = 'license_menu'
	CurrentActionMsg  = _U('press_access')
	CurrentActionData = {}
end)

AddEventHandler('esx_licenseshop:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

RegisterNetEvent('esx_licenseshop:loadLicenses')
AddEventHandler('esx_licenseshop:loadLicenses', function(licenses)
	Licenses = licenses
end)

-- Draw Markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local coords = GetEntityCoords(PlayerPedId())
		local canSleep = true

		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				canSleep = false
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
		end
		
		if canSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Activate Menu when in Markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)

		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x then
				isInMarker  = true
				currentZone = k
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('esx_licenseshop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_licenseshop:hasExitedMarker', LastZone)
		end
		
		if not isInMarker then
			Citizen.Wait(500)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) then
				if CurrentAction == 'license_menu' then
					OpenLicenseShop()
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Blips
function deleteBlips()
	if BlipList[1] ~= nil then
		for i=1, #BlipList, 1 do
			RemoveBlip(BlipList[i])
			BlipList[i] = nil
		end
	end
end

function refreshBlips()
	if Config.EnableBlips then
		if Config.EnableUnemployedOnly then
			if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'unemployed' or ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'gang' then
				for k,v in pairs(Config.Locations) do
					local blip = AddBlipForCoord(v.x, v.y)

					SetBlipSprite (blip, Config.BlipLicenseShop.Sprite)
					SetBlipDisplay(blip, Config.BlipLicenseShop.Display)
					SetBlipScale  (blip, Config.BlipLicenseShop.Scale)
					SetBlipColour (blip, Config.BlipLicenseShop.Color)
					SetBlipAsShortRange(blip, true)

					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(_U('blip_license_shop'))
					EndTextCommandSetBlipName(blip)
					table.insert(BlipList, blip)
				end
			end
		else
			for k,v in pairs(Config.Locations) do
				local blip = AddBlipForCoord(v.x, v.y)

				SetBlipSprite (blip, Config.BlipLicenseShop.Sprite)
				SetBlipDisplay(blip, Config.BlipLicenseShop.Display)
				SetBlipScale  (blip, Config.BlipLicenseShop.Scale)
				SetBlipColour (blip, Config.BlipLicenseShop.Color)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('blip_license_shop'))
				EndTextCommandSetBlipName(blip)
				table.insert(BlipList, blip)
			end
		end
	end
end

-- Create Ped
Citizen.CreateThread(function()
    RequestModel(GetHashKey("a_m_y_business_03"))
	
    while not HasModelLoaded(GetHashKey("a_m_y_business_03")) do
        Wait(1)
    end
	
	if Config.EnablePeds then
		for _, item in pairs(Config.Locations) do
			local npc = CreatePed(4, 0xA1435105, item.x, item.y, item.z, item.heading, false, true)
			
			SetEntityHeading(npc, item.heading)
			FreezeEntityPosition(npc, true)
			SetEntityInvincible(npc, true)
			SetBlockingOfNonTemporaryEvents(npc, true)
		end
	end
end)
