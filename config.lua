Config = {}
Config.Locale = 'en'

Config.MarkerType   = 1
Config.DrawDistance = 100.0
Config.MarkerSize   = {x = 2.0, y = 2.0, z = 1.0}
Config.MarkerColor  = {r = 102, g = 102, b = 204}

Config.BlipLicenseShop = {
	Sprite = 408,
	Color = 0,
	Display = 2,
	Scale = 1.0
}

Config.AircraftLicensePrice = 25000
Config.BoatingLicensePrice = 1000
Config.CommercialLicensePrice = 6000
Config.DriversLicensePrice = 3000
Config.MotorcyleLicensePrice = 4500
Config.WeaponLicensePrice = 25000
Config.WeedLicensePrice = 50000

Config.EnableUnemployedOnly = true -- If true it will only show Blips to Unemployed Players | false shows it to Everyone.
Config.EnableBlips = true -- If true then it will show blips | false does the Opposite.
Config.EnablePeds = true -- If true then it will add Peds on Markers | false does the Opposite.

Config.Locations = {
	{ x = 241.06, y = -1378.91, z = 32.74, heading = 148.29 } -- Next to esx_dmvschool
}

Config.Zones = {}

for i=1, #Config.Locations, 1 do
	Config.Zones['Shop_' .. i] = {
		Pos   = Config.Locations[i],
		Size  = Config.MarkerSize,
		Color = Config.MarkerColor,
		Type  = Config.MarkerType
	}
end
