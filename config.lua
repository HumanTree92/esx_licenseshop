Config = {}
Config.Locale = 'en'

Config.AircraftLicensePrice = 25000
Config.BoatingLicensePrice = 1000
Config.CommercialLicensePrice = 6000
Config.DriversLicensePrice = 3000
Config.MotorcyleLicensePrice = 4500
Config.WeaponLicensePrice = 25000
Config.WeedLicensePrice = 50000

Config.MarkerType   = 1
Config.DrawDistance = 100.0
Config.MarkerSize   = {x = 1.5, y = 1.5, z = 1.0}
Config.MarkerColor  = {r = 102, g = 102, b = 204}

Config.Zones = {}

Config.Locations = {
	{ x = 216.49, y = -1389.27, z = 29.59 } -- Next to esx_dmvschool
}

for i=1, #Config.Locations, 1 do
	Config.Zones['Shop_' .. i] = {
		Pos   = Config.Locations[i],
		Size  = Config.MarkerSize,
		Color = Config.MarkerColor,
		Type  = Config.MarkerType
	}
end
