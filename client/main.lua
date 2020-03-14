local CurrentActionData, Licenses = {}, {}
local HasAlreadyEnteredMarker, IsInMainMenu = false, false
local LastZone, CurrentAction, CurrentActionMsg
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	TriggerServerEvent('esx_licenseshop:ServerLoadLicenses')
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx_licenseshop:loadLicenses')
AddEventHandler('esx_licenseshop:loadLicenses', function(licenses)
	Licenses = licenses
end)

-- Open License Shop
function OpenLicenseShop()
	IsInMainMenu = true
	local ownedLicenses = {}

	for i=1, #Licenses, 1 do
		ownedLicenses[Licenses[i].type] = true
	end

	local elements = {}

	if not ownedLicenses['dmv'] then
		table.insert(elements, {label = _U('need_dmv')})
	end

	if ownedLicenses['dmv'] then
		if Config.AdvancedVehicleShop then
			if not ownedLicenses['aircraft'] then
				table.insert(elements, {label = _U('license_aircraft') .. ' <span style="color: green;">$' .. Config.AircraftLicensePrice .. '</span>', value = 'buy_license_aircraft'})
			end

			if not ownedLicenses['boating'] then
				table.insert(elements, {label = _U('license_boating') .. ' <span style="color: green;">$' .. Config.BoatingLicensePrice .. '</span>', value = 'buy_license_boating'})
			end
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
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'buy_license_aircraft' then
			TriggerServerEvent('esx_licenseshop:buyLicenseAircraft')
			IsInMainMenu = false
			menu.close()
		elseif data.current.value == 'buy_license_boating' then
			TriggerServerEvent('esx_licenseshop:buyLicenseBoating')
			IsInMainMenu = false
			menu.close()
		elseif data.current.value == 'buy_license_commercial' then
			TriggerServerEvent('esx_licenseshop:buyLicenseCommercial')
			IsInMainMenu = false
			menu.close()
		elseif data.current.value == 'buy_license_drivers' then
			TriggerServerEvent('esx_licenseshop:buyLicenseDrivers')
			IsInMainMenu = false
			menu.close()
		elseif data.current.value == 'buy_license_motorcycle' then
			TriggerServerEvent('esx_licenseshop:buyLicenseMotorcyle')
			IsInMainMenu = false
			menu.close()
		elseif data.current.value == 'buy_license_weapon' then
			TriggerServerEvent('esx_licenseshop:buyLicenseWeapon')
			IsInMainMenu = false
			menu.close()
		elseif data.current.value == 'buy_license_weed' then
			TriggerServerEvent('esx_licenseshop:buyLicenseWeed')
			IsInMainMenu = false
			menu.close()
		end
	end, function(data, menu)
		IsInMainMenu = false
		menu.close()

		CurrentAction     = 'license_menu'
		CurrentActionMsg  = _U('press_access')
		CurrentActionData = {}
	end)
end

-- Entered Marker
AddEventHandler('esx_licenseshop:hasEnteredMarker', function(zone)
	if zone == 'LicenseShop1' then
		CurrentAction     = 'license_menu'
		CurrentActionMsg  = _U('press_access')
		CurrentActionData = {}
	end
end)

-- Exited Marker
AddEventHandler('esx_licenseshop:hasExitedMarker', function(zone)
	if not IsInMainMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

-- Resource Stop
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if IsInMainMenu then
			ESX.UI.Menu.CloseAll()
		end
	end
end)

-- Blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.Zones) do
		local blip = AddBlipForCoord(v.Pos)

		SetBlipSprite (blip, Config.BlipLicenseShop.Sprite)
		SetBlipColour (blip, Config.BlipLicenseShop.Color)
		SetBlipDisplay(blip, Config.BlipLicenseShop.Display)
		SetBlipScale  (blip, Config.BlipLicenseShop.Scale)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('blip_license_shop'))
		EndTextCommandSetBlipName(blip)
	end
end)

-- Create Ped
Citizen.CreateThread(function()
    if Config.EnablePeds then
		RequestModel(GetHashKey("a_m_y_business_03"))

		while not HasModelLoaded(GetHashKey("a_m_y_business_03")) do
			Wait(1)
		end

		for k,v in pairs(Config.Zones) do
			local npc = CreatePed(4, 0xA1435105, v.Pos, v.Heading, false, true)

			SetEntityHeading(npc, v.Heading)
			FreezeEntityPosition(npc, true)
			SetEntityInvincible(npc, true)
			SetBlockingOfNonTemporaryEvents(npc, true)
		end
	end
end)

-- Enter / Exit marker events & Draw Markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local isInMarker, letSleep, currentZone = false, true

		for k,v in pairs(Config.Zones) do
			local distance = #(playerCoords - v.Pos)

			if distance < Config.DrawDistance then
				letSleep = false

				if Config.MarkerInfo.Type ~= -1 then
					DrawMarker(Config.MarkerInfo.Type, v.Pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerInfo.x, Config.MarkerInfo.y, Config.MarkerInfo.z, Config.MarkerInfo.r, Config.MarkerInfo.g, Config.MarkerInfo.b, 100, false, true, 2, false, nil, nil, false)
				end

				if distance < Config.MarkerInfo.x then
					isInMarker, currentZone = true, k
				end
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker, LastZone = true, currentZone
			TriggerEvent('esx_licenseshop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_licenseshop:hasExitedMarker', LastZone)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'license_menu' then
					TriggerServerEvent('esx_licenseshop:ServerLoadLicenses')
					OpenLicenseShop()
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)
