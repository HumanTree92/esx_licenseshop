ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_licenseshop:loadLicenses', source, licenses)
	end)
end)

function LoadLicenses (source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_licenseshop:loadLicenses', source, licenses)
	end)
end

RegisterServerEvent('esx_licenseshop:ServerLoadLicenses')
AddEventHandler('esx_licenseshop:ServerLoadLicenses', function()
	local _source = source
	LoadLicenses(_source)
end)

-- Aircraft License
RegisterServerEvent('esx_licenseshop:buyLicenseAircraft')
AddEventHandler('esx_licenseshop:buyLicenseAircraft', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('money') >= Config.AircraftLicensePrice then
		xPlayer.removeMoney(Config.AircraftLicensePrice)

		TriggerEvent('esx_license:addLicense', _source, 'aircraft', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Boating License
RegisterServerEvent('esx_licenseshop:buyLicenseBoating')
AddEventHandler('esx_licenseshop:buyLicenseBoating', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('money') >= Config.BoatingLicensePrice then
		xPlayer.removeMoney(Config.BoatingLicensePrice)

		TriggerEvent('esx_license:addLicense', _source, 'boating', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Commercial License
RegisterServerEvent('esx_licenseshop:buyLicenseCommercial')
AddEventHandler('esx_licenseshop:buyLicenseCommercial', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('money') >= Config.CommercialLicensePrice then
		xPlayer.removeMoney(Config.CommercialLicensePrice)

		TriggerEvent('esx_license:addLicense', _source, 'drive_truck', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Drivers License
RegisterServerEvent('esx_licenseshop:buyLicenseDrivers')
AddEventHandler('esx_licenseshop:buyLicenseDrivers', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('money') >= Config.DriversLicensePrice then
		xPlayer.removeMoney(Config.DriversLicensePrice)

		TriggerEvent('esx_license:addLicense', _source, 'drive', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Motorcyle License
RegisterServerEvent('esx_licenseshop:buyLicenseMotorcyle')
AddEventHandler('esx_licenseshop:buyLicenseMotorcyle', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('money') >= Config.MotorcyleLicensePrice then
		xPlayer.removeMoney(Config.MotorcyleLicensePrice)

		TriggerEvent('esx_license:addLicense', _source, 'drive_bike', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Weapon License
RegisterServerEvent('esx_licenseshop:buyLicenseWeapon')
AddEventHandler('esx_licenseshop:buyLicenseWeapon', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('money') >= Config.WeaponLicensePrice then
		xPlayer.removeMoney(Config.WeaponLicensePrice)

		TriggerEvent('esx_license:addLicense', _source, 'weapon', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Weed License
RegisterServerEvent('esx_licenseshop:buyLicenseWeed')
AddEventHandler('esx_licenseshop:buyLicenseWeed', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('money') >= Config.WeedLicensePrice then
		xPlayer.removeMoney(Config.WeedLicensePrice)

		TriggerEvent('esx_license:addLicense', _source, 'weed_processing', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)
