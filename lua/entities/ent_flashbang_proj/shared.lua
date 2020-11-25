ENT.Type = "anim"
ENT.PrintName = "Flashbang Grenade Projectile"
ENT.DoNotDuplicate = true 
ENT.DisableDuplicator = true

function ENT:OnRemove()
end

function ENT:PhysicsUpdate()
end

function ENT:PhysicsCollide(data,phys)
	if data.Speed > 50 then
		self.Entity:EmitSound(Sound("weapons/flashbang/grenade_hit1.wav"))
	end
	
	local impulse = (data.OurOldVelocity - 2 * data.OurOldVelocity:Dot(data.HitNormal) * data.HitNormal)*0.25
	phys:ApplyForceCenter(impulse)
end
