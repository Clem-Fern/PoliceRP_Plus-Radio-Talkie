include('shared.lua')

local pos;

function ENT:Initialize()
	pos = self:GetPos()
	timer.Simple(2, function()
		local smokeparticles = {
      		Model("particle/particle_smokegrenade"),
      		Model("particle/particle_noisesphere")
   		}; 
		local em = ParticleEmitter(self:GetPos())

      	local r = 20
      	for i=1, 80 do
        	local prpos = VectorRand() * r
        	prpos.z = prpos.z + 64
        	local p = em:Add(table.Random(smokeparticles), self:GetPos() + prpos)
        	if p then
            	local gray = math.random(100, 200)
            	p:SetColor(gray, gray, gray)
            	p:SetStartAlpha(255)
            	p:SetEndAlpha(220)
            	p:SetVelocity(VectorRand() * math.Rand(1300, 1700))
            	p:SetLifeTime(0)
            
            	p:SetDieTime(math.Rand(70, 120))

            	p:SetStartSize(math.random(450, 470))
            	p:SetEndSize(math.random(1, 80))
            	p:SetRoll(math.random(-180, 180))
            	p:SetRollDelta(math.Rand(-0.1, 0.1))
            	p:SetAirResistance(600)

            	p:SetCollide(true)
            	p:SetBounce(0.4)

            	p:SetLighting(false)
        	end
      	end
      	em:Finish()
	end)
end