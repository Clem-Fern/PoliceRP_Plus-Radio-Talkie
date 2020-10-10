AddCSLuaFile("shared.lua")

SWEP.Base = "weapon_base_grenade"

SWEP.PrintName = "Flashbang"
SWEP.SlotPos = 2

SWEP.EquipMenuData = {
	type = "item_weapon",
	desc = "Flashbang"
};

SWEP.Category = "PSRP Utils"

SWEP.Grenade = "psrpu_flashbang_proj"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ViewModel	= "models/weapons/cstrike/c_eq_flashbang.mdl"
SWEP.WorldModel = "models/weapons/w_eq_flashbang.mdl"

SWEP.AutoSwitchFrom		= true

SWEP.DrawCrosshair		= false

SWEP.LimitedStock = false

function SWEP:GetGrenadeName()
   return "psrpu_flashbang_proj"
end