AddCSLuaFile()
include("autorun/megaphone.lua")

// Voice Hook
hook.Add("PlayerCanHearPlayersVoice","PoliceRPPlusMegaphoneVoice",function(listener,speaker)
    if((speaker:Alive()) and (speaker:GetActiveWeapon() != NULL ) and (speaker:GetActiveWeapon():GetClass() == "wep_megaphone")) then
        if(megaphone.isInRange(speaker,listener))then
            return true
        end
    end
end);