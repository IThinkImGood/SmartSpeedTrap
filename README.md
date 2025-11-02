# Smart Speed Trap — README.md

> **Smart Speed Trap** — Standalone, open-source average-speed / trajectory speed-check system for **QBCore**  
> This repo is free to use and modify — no Tebex / licensing required.

---

## 📦 Overview
Smart Speed Trap measures the average speed of a vehicle between two configured points (bidirectional). It supports:
- QBCore integration (remove money from bank / notify players)  
- Fixed or dynamic fines (configurable per zone)  
- Tolerance, min/max fines and per-km fine factor  
- Spawnable camera poles (visible props)  
- Optional flash effect on violation (configurable: enable, duration, intensity, shake, color, radius)  
- Locales (English + Dutch included)  
- Fully open-source: core scripts are readable and editable

---

> This distribution is **code-free** (open source). No Tebex or obfuscation involved.

---

## ⚙️ Requirements
- QBCore installed on your FiveM server  
- FiveM server (fxserver) compatible with your QBCore version

---

## 🚀 Installation
1. Place the `SmartSpeedTrap` folder in your server `resources` directory.  
2. Add to `server.cfg`:
```cfg
ensure SmartSpeedTrap
```
3. Restart your server or run `ensure SmartSpeedTrap`.

---

## 🛠 Configuration (`config.lua`)
Open `config.lua` and change values to fit your server:

```lua
Config = {}

-- Locale
Config.Locale = "en" -- "en" or "nl"

-- Zones: define start and finish (vector3), limit and fine settings
Config.Zones = {
    {
        name = "SnelwegNoord",
        start = vector3(2261.99, 3827.95, 34.16),
        finish = vector3(2488.96, 4077.98, 37.49),
        limit = 120,           -- km/h
        fine = 500,            -- base fine in euros
        dynamicFine = true,    -- true = fine grows with speed
        finePerKm = 10,        -- euros per km/h over the limit
        tolerance = 6,         -- margin before fines apply
        minFine = 250,         -- minimum fine
        maxFine = 2500         -- maximum fine
    }
}

-- Camera model and poles (visible props only)
Config.CameraModel = "prop_cctv_pole_04"
Config.Poles = {
    { coords = vector3(2491.65, 4075.71, 37.8), heading = 250.01 },
    { coords = vector3(2261.99, 3827.95, 34.16), heading = 200.0 },
}

-- Flash settings (visual)
Config.EnableFlash = true
Config.FlashDuration = 400         -- milliseconds
Config.FlashIntensity = 1.0
Config.FlashShake = 0.15
Config.FlashLightColor = { r = 255, g = 255, b = 255 }
Config.FlashRadius = 25.0
```

---

## 🧩 Locales
Add or edit language files in `locales/`. Example (`locales/en.lua`):
```lua
Locales = {}
Locales['en'] = {
    speed_ok = "Average speed %.1f km/h (limit %d)",
    speed_fine = "[Speed Check] %.1f km/h (limit %d) – Fine €%d",
    entered_zone = "You entered a speed check zone",
    left_zone = "You left the speed check zone"
}
```

Switch language by editing `Config.Locale`.

---

## 🔧 Usage & Behavior
- Players driving through the start and finish points will have their travel time recorded.  
- Average speed is calculated and compared to `limit + tolerance`.  
- If over the threshold, the configured fine is applied (fixed or dynamic).  
- If `Config.EnableFlash` is `true`, the player receives a flash effect at the relevant camera location when fined.  
- Notifications are shown using QBCore notifications.

---

## 🧪 Testing checklist
- [ ] Resource starts with `ensure` and shows no console errors.  
- [ ] Enter and exit the zone in a vehicle; ensure average speed calculation is correct.  
- [ ] Fines are applied correctly (check fixed and dynamic modes).  
- [ ] Flash effect triggers when enabled.  
- [ ] Locales show the expected language strings.

---

## 💡 Extensions & Ideas
You can enhance Smart Speed Trap by adding:
- Discord logging (webhook) for admin logs  
- Police alerts for severe overspeeding (> X km/h) with blip on map  
- SQL logging for stored fines and invoice system  
- Admin NUI to add/remove zones on the fly  
- Weather/time dependent speed limits

---

## 🚨 Notes & Best Practices
- This repo is open-source by your request — be mindful when sharing or modifying it.  
- If you choose to distribute a customized paid version later, consider protecting only the distribution assets you want to keep private. For now everything is editable.  
- Keep `config.lua` and `locales/*.lua` easy to edit for server admins.

---

## 📝 License
This project is provided as-is and **open-source**. Use, modify and distribute freely.  
If you want a short license file, add `LICENSE` and copy the MIT text or any other license you prefer.

---

## ☎️ Support
If you need help setting up or customizing Smart Speed Trap, paste your `config.lua` and server logs when asking for help — that speeds up troubleshooting.
