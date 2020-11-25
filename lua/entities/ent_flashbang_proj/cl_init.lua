include('shared.lua')

local pos;

function ENT:Initialize()
	pos = self:GetPos()
	timer.Simple(2, function()
		local beeplight = DynamicLight( self:EntIndex() )
		if ( beeplight ) then
			beeplight.Pos = pos
			beeplight.r = 255
			beeplight.g = 255
			beeplight.b = 255
			beeplight.Brightness = 6
			beeplight.Size = 1000
			beeplight.Decay = 1000
			beeplight.DieTime = CurTime() + 0.15
		end 
	end)
end

csgo_flashtime = 6
csgo_flashfade = 4
csgo_flashdistance = 1280
csgo_flashdistance_min_total = 200
csgo_flashdistancefade = 1280 - 512

local tab = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = 0.0,
	["$pp_colour_contrast"] = 1.0,
	["$pp_colour_colour"] = 1.0,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0
}

function calculate_FlashIntensity(ply)
	local flashtime = ply:GetNWFloat("PSRPU_LastFlash", -999)
	local time = CurTime() - flashtime
	if time >= 0 and time < csgo_flashtime then
		local flashdistance = ply:GetNWFloat("PSRPU_FlashDistance", 0)

		local flashfac = ply:GetNWFloat("PSRPU_FlashFactor", 1)
		local distancefac = 1 - math.Clamp((flashdistance - csgo_flashdistance + csgo_flashdistancefade) / csgo_flashdistancefade, 0, 1)
		local intensity = 1 - math.Clamp(( time / distancefac - csgo_flashtime + csgo_flashfade) / csgo_flashfade, 0, 1)
		intensity = intensity * distancefac

		if flashdistance >= 0 and flashdistance < csgo_flashdistance_min_total then
			return intensity
		end
			
		intensity = intensity * math.Clamp(flashfac + 0.1, 0.35, 1)
		return intensity

	end
	return 0
end

hook.Add("RenderScreenspaceEffects", "PSRPU_SimulateBlur", function()
		local ply = LocalPlayer()
		if not IsValid(ply) then return end
		local intensity = calculate_FlashIntensity(ply)
		if intensity > 0.01 then
			tab["$pp_colour_brightness"] = math.pow(intensity, 3)
			tab["$pp_colour_colour"] = 1 - intensity * 0.33
			DrawColorModify(tab) --Draws Color Modify effect
			DrawMotionBlur(0.2, intensity, 0.03)
		end
	end)


function ENT:Think()
	pos = self:GetPos()
end

function ENT:Draw()
	self.Entity:DrawModel()
end

function ENT:IsTranslucent()
	return true
end


