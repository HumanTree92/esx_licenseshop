ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_licenseshop:loadLicenses', source, licenses)
	end)
end)

function LoadLicenses(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_licenseshop:loadLicenses', source, licenses)
	end)
end

RegisterServerEvent('esx_licenseshop:ServerLoadLicenses')
AddEventHandler('esx_licenseshop:ServerLoadLicenses', function()
	local _source = source
	LoadLicenses(_source)
end)

-- Buy Aircraft License
RegisterServerEvent('esx_licenseshop:buyLicenseAircraft')
AddEventHandler('esx_licenseshop:buyLicenseAircraft', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= Config.LicenseAircraft then
		xPlayer.removeMoney(Config.LicenseAircraft)

		TriggerEvent('esx_license:addLicense', _source, 'aircraft', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Boating License
RegisterServerEvent('esx_licenseshop:buyLicenseBoating')
AddEventHandler('esx_licenseshop:buyLicenseBoating', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= Config.LicenseBoating then
		xPlayer.removeMoney(Config.LicenseBoating)

		TriggerEvent('esx_license:addLicense', _source, 'boating', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Melee License
RegisterServerEvent('esx_licenseshop:buyLicenseMelee')
AddEventHandler('esx_licenseshop:buyLicenseMelee', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= Config.LicenseMelee then
		xPlayer.removeMoney(Config.LicenseMelee)

		TriggerEvent('esx_license:addLicense', _source, 'weapon_melee', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Handgun License
RegisterServerEvent('esx_licenseshop:buyLicenseHandgun')
AddEventHandler('esx_licenseshop:buyLicenseHandgun', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= Config.LicenseHandgun then
		xPlayer.removeMoney(Config.LicenseHandgun)

		TriggerEvent('esx_license:addLicense', _source, 'weapon_handgun', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy SMG License
RegisterServerEvent('esx_licenseshop:buyLicenseSMG')
AddEventHandler('esx_licenseshop:buyLicenseSMG', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= Config.LicenseSMG then
		xPlayer.removeMoney(Config.LicenseSMG)

		TriggerEvent('esx_license:addLicense', _source, 'weapon_smg', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Shotgun License
RegisterServerEvent('esx_licenseshop:buyLicenseShotgun')
AddEventHandler('esx_licenseshop:buyLicenseShotgun', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= Config.LicenseShotgun then
		xPlayer.removeMoney(Config.LicenseShotgun)

		TriggerEvent('esx_license:addLicense', _source, 'weapon_shotgun', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Assault License
RegisterServerEvent('esx_licenseshop:buyLicenseAssault')
AddEventHandler('esx_licenseshop:buyLicenseAssault', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= Config.LicenseAssault then
		xPlayer.removeMoney(Config.LicenseAssault)

		TriggerEvent('esx_license:addLicense', _source, 'weapon_assault', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy LMG License
RegisterServerEvent('esx_licenseshop:buyLicenseLMG')
AddEventHandler('esx_licenseshop:buyLicenseLMG', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= Config.LicenseLMG then
		xPlayer.removeMoney(Config.LicenseLMG)

		TriggerEvent('esx_license:addLicense', _source, 'weapon_lmg', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Sniper License
RegisterServerEvent('esx_licenseshop:buyLicenseSniper')
AddEventHandler('esx_licenseshop:buyLicenseSniper', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= Config.LicenseSniper then
		xPlayer.removeMoney(Config.LicenseSniper)

		TriggerEvent('esx_license:addLicense', _source, 'weapon_sniper', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Commercial License
RegisterServerEvent('esx_licenseshop:buyLicenseCommercial')
AddEventHandler('esx_licenseshop:buyLicenseCommercial', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= Config.LicenseCommercial then
		xPlayer.removeMoney(Config.LicenseCommercial)

		TriggerEvent('esx_license:addLicense', _source, 'drive_truck', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Drivers License
RegisterServerEvent('esx_licenseshop:buyLicenseDrivers')
AddEventHandler('esx_licenseshop:buyLicenseDrivers', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= Config.LicenseDrivers then
		xPlayer.removeMoney(Config.LicenseDrivers)

		TriggerEvent('esx_license:addLicense', _source, 'drive', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Drivers Permit
RegisterServerEvent('esx_licenseshop:buyLicenseDriversP')
AddEventHandler('esx_licenseshop:buyLicenseDriversP', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= Config.LicenseDriversP then
		xPlayer.removeMoney(Config.LicenseDriversP)

		TriggerEvent('esx_license:addLicense', _source, 'dmv', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Motorcyle License
RegisterServerEvent('esx_licenseshop:buyLicenseMotorcyle')
AddEventHandler('esx_licenseshop:buyLicenseMotorcyle', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= Config.LicenseMotocycle then
		xPlayer.removeMoney(Config.LicenseMotocycle)

		TriggerEvent('esx_license:addLicense', _source, 'drive_bike', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Weed License
RegisterServerEvent('esx_licenseshop:buyLicenseWeed')
AddEventHandler('esx_licenseshop:buyLicenseWeed', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= Config.LicenseWeed then
		xPlayer.removeMoney(Config.LicenseWeed)

		TriggerEvent('esx_license:addLicense', _source, 'weed_processing', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

-- Buy Weapon License
RegisterServerEvent('esx_licenseshop:buyLicenseWeapon')
AddEventHandler('esx_licenseshop:buyLicenseWeapon', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= Config.LicenseWeapon then
		xPlayer.removeMoney(Config.LicenseWeapon)

		TriggerEvent('esx_license:addLicense', _source, 'weapon', function()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)
