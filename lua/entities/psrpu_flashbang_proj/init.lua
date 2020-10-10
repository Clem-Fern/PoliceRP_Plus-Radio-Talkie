AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	
	self.Entity:SetModel("models/weapons/w_eq_flashbang_thrown.mdl")
	
	self:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:DrawShadow( false )
	self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	
	timer.Simple(2, function()
		if self.Entity then self:Explosion() end
	end )
end

function ENT:EntityFacingFactor( theirent )
	local dir = theirent:EyeAngles():Forward()
	local facingdir = (self:GetPos() - (theirent.GetShootPos and theirent:GetShootPos() or theirent:GetPos())):GetNormalized()
	return (facingdir:Dot(dir)+1)/2
end

function ENT:Explosion()

	self.Entity:EmitSound(Sound("weapons/flashbang/flashbang_explode"..math.random(1,2)..".wav"));
	
	local tr = {}
	tr.start = self:GetPos()
	tr.mask = MASK_SOLID

	for _, v in ipairs(player.GetAll()) do
		tr.endpos = v:GetShootPos()
		tr.filter = { self, v, v:GetActiveWeapon() }
		local traceres = util.TraceLine(tr)

		if !traceres.Hit or traceres.Fraction>=1 or traceres.Fraction<=0 then -- direct view on grenade
			v:SetNWFloat("PSRPU_LastFlash", CurTime())
			v:SetNWFloat("PSRPU_FlashDistance", v:GetShootPos():Distance(self:GetPos()))
			v:SetNWFloat("PSRPU_FlashFactor", self:EntityFacingFactor(v))
			if v:GetNWFloat("PSRPU_FlashDistance",v:GetShootPos():Distance(self:GetPos())) < 1500 and v:GetNWFloat("FlashFactor",self:EntityFacingFactor(v)) < tr.endpos:Distance(self:GetPos(v)) then
				if v:GetNWFloat("PSRPU_FlashDistance",v:GetShootPos():Distance(self:GetPos())) < 1000 then
					v:SetDSP( 37 , false )
				elseif v:GetNWFloat("PSRPU_FlashDistance",v:GetShootPos():Distance(self:GetPos())) < 800 then
					v:SetDSP( 36 , false )
				elseif v:GetNWFloat("PSRPU_FlashDistance",v:GetShootPos():Distance(self:GetPos())) < 600 then
					v:SetDSP( 35, false )
				end
			end
		end
	end
	self.Entity:Remove();
end

function ENT:OnTakeDamage()
end

function ENT:Use()
end

function ENT:StartTouch()
end

function ENT:EndTouch()
end

function ENT:Touch()
end