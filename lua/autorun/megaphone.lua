megaphone = megaphone or {}

megaphone.facing_fact = 0.84
megaphone.distance = 2000

function megaphone.isInRange(speaker,listener)
    local sV = speaker:GetPos()
    local lV = listener:GetPos()
    local distance = sV:Distance(lV)
    if(distance < megaphone.distance) then
        local dir = speaker:EyeAngles():Forward()
        local facingdir = (lV - (speaker.GetShootPos and speaker:GetShootPos() or sV)):GetNormalized()
        local facingfact = facingdir:Dot(dir)

        if(facingfact > megaphone.facing_fact) then return true end
    end
    return false
end

function megaphone.count(speaker)
    local count = 0
    for _,listener in pairs(player.GetAll())do
        if(speaker == listener) then continue end
        if(megaphone.isInRange(speaker,listener)) then
            count = count + 1
        end
    end
    return count    
end