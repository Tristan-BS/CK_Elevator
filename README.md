# 🚀 CK_Elevator - FiveM

A **simple multi-building elevator script for FiveM**.  
This script allows players to move between multiple floors inside buildings (e.g., Pillbox Hospital).

---

## ✨ Features
- Multiple buildings & floors configurable
- Up/Down navigation via keybinds
- 3D text & marker support
- Optional elevator "ding" sound
- Supports **ESX Notify** or [RiP-Notify](https://forum.cfx.re/)  
- Server-side teleport handling (anti-exploit & cooldown)

---

## ⚙️ Installation
1. Download or clone this repository:
   ```bash
   git clone https://github.com/Tristan-BS/CK_Elevator.git


2. Place the `ck_elevator` folder into your FiveM `resources` directory.

3. Add this to your `server.cfg`:

   ```
   ensure ck_elevator
   ```

---

## 🔑 Keybinds

* **Arrow Up (↑)** → Move one floor up
* **Arrow Down (↓)** → Move one floor down

---

## 🛠️ Configuration

All settings are in **`config.lua`**:

* `Config.KeyUp` & `Config.KeyDown` → Keybinds
* `Config.Buildings` → Add your buildings and floors
* `Config.UseESXNotify` → Toggle between ESX or RiP Notify
* `Config.CooldownMs` → Anti-spam cooldown

**Example:**

```lua
Config.Buildings = {
    {
        name = "Pillbox Hospital",
        floors = {
            { label = "EG", x = 287.70, y = -595.40, z = 43.16, h = 213.87 },
            { label = "1st Floor", x = 287.84, y = -595.27, z = 49.74, h = 311.65 },
            { label = "2nd Floor", x = 299.89, y = -598.25, z = 57.72, h = 299.91 },
            { label = "Roof", x = 339.17, y = -583.88, z = 74.16, h = 217.24 }
        }
    }
}
```

---

## 💾 Preview
<img width="368" height="717" alt="image" src="https://github.com/user-attachments/assets/d80f2e47-821d-4f45-8c6b-015b125ee2a1" />
<img width="255" height="685" alt="image" src="https://github.com/user-attachments/assets/f7a70821-c74a-431a-bdf6-49f965ca441f" />

---

## 📜 License

MIT License – feel free to use, modify, and share.

---
