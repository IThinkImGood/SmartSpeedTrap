Config = {}

-- Language setting
Config.Locale = "en" -- choose "en" or "nl" or create your own! 

Config.Zones = {
    {
        name = "SnelwegNoord",
        start = vector3(2261.99, 3827.95, 34.16),
        finish = vector3(2488.96, 4077.98, 37.49),
        limit = 120,
        fine = 500,
        dynamicFine = true,
        finePerKm = 10,
        tolerance = 6,
        minFine = 250,
        maxFine = 2500
    }
}

Config.CameraModel = "prop_cctv_pole_04"

Config.Poles = {
    { coords = vector3(2491.65, 4075.71, 37.8), heading = 250.01 },
    { coords = vector3(2261.99, 3827.95, 34.16), heading = 200.0 },
}

Config.EnableFlash = true          -- true = flash enabled, false = flash disabled
Config.FlashDuration = 400         -- duration of the flash in milliseconds
Config.FlashIntensity = 1.0        -- 0.5 = soft, 1.0 = normal, 2.0 = bright
Config.FlashShake = 0.15           -- 0.0 = no camera shake, 0.5 = strong shake
Config.FlashLightColor = {r = 255, g = 255, b = 255} -- color of the flash light
Config.FlashRadius = 25.0          -- how far the light is visible in the world

