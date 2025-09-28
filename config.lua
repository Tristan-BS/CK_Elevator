Config = {}

-- Keybindings
Config.KeyUp = 172 -- Arrow Up
Config.KeyDown = 173 -- Arrow Down

-- Distance and Visibility
Config.InteractDistance = 1.5
Config.DrawDistance     = 15.0
Config.ShowMarkers      = true
Config.Show3DText       = true

-- Settings
Config.FadeMs           = 500
Config.CooldownMs       = 1250
Config.PlayElevatorDing = true

-- Notify
Config.UseESXNotify     = true -- true = ESX.Notify, false = custom Notify
Config.RiPNotifyType    = 'default' -- default, success, error

-- Buildings
Config.Buildings = {
    {
        name = "Pillbox Hospital",
        floors = {
            { label = "EG", x = 287.7019, y = -595.4064, z = 43.1697, h = 213.8752},
            { label = "1st Floor", x = 287.8437, y = -595.2776, z = 49.7488, h = 311.6539},
            { label = "2nd Floor", x = 299.8955, y = -598.2559, z = 57.7258, h = 299.9151},
            { label = "Roof", x = 339.1771, y = -583.8883, z = 74.1656, h = 217.2460}
        }
    }
}