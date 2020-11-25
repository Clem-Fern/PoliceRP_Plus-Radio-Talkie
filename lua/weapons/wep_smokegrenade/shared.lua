AddCSLuaFile()

SWEP.Base = "weapon_base_grenade"

SWEP.PrintName = "Smoke Grenade"
SWEP.SlotPos = 2

SWEP.EquipMenuData = {
	type = "item_weapon",
	desc = "Smoke Grenade"
};

SWEP.Category = "PoliceRP Plus"

SWEP.Grenade = "ent_smokegrenade_proj"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.UseHands           = true
SWEP.ViewModel          = "models/weapons/cstrike/c_eq_smokegrenade.mdl"
SWEP.WorldModel         = "models/weapons/w_eq_smokegrenade.mdl"

SWEP.AutoSwitchFrom		= true

SWEP.DrawCrosshair		= false

SWEP.LimitedStock = false

function SWEP:GetGrenadeName()
   return "ent_smokegrenade_proj"
end


