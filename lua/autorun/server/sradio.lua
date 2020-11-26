AddCSLuaFile()
AddCSLuaFile("autorun/client/radio.lua")

// radio sound
resource.AddFile( "sound/radio/radioswitch.wav" )
resource.AddFile( "sound/radio/radiotone.wav" )
resource.AddFile( "sound/radio/r_radiotone.wav" )
resource.AddFile( "sound/radio/radiorogerbeep.wav" )

// radio hud
resource.AddFile( "materials/radio/hud/mute.png" )
resource.AddFile( "materials/radio/hud/unmute.png" )

function plyHasRadio(ply)
    return ply:HasWeapon("wep_radio")
end

local maxChanID = 5

/////////////////////////////////////////////////////////////
// Radio command
// radio_toogle_mic
concommand.Add( "radio_toogle_mic", function( ply, cmd, args )
    if(!plyHasRadio(ply)) then return end
    radio = ply:GetWeapon("wep_radio")

    if(!radio:GetPower()) then return; end

    if(radio:GetMic()) then
        // set radio mic off
        radio:SetMic(false)
    else
        // set radio mic on
        radio:SetMic(true)
    end

end)

// radio_cut_off_mic
concommand.Add( "radio_cut_off_mic", function( ply, cmd, args )
    if(!plyHasRadio(ply)) then return end
    radio = ply:GetWeapon("wep_radio")

    if(!radio:GetPower()) then return; end

    radio:SetMic(false)

end)

// radio_toogle_power
concommand.Add( "radio_toogle_power", function( ply, cmd, args )
    if(!plyHasRadio(ply)) then return end
    radio = ply:GetWeapon("wep_radio")

    if(radio:GetPower()) then
        // set radio off
        radio:SetPower(false)
        // set mic off
        radio:SetMic(false)
        
        ply:EmitSound("radio/r_radiotone.wav", 40, 100, 1, CHAN_WEAPON)
    else
        // set radio on
        radio:SetPower(true)
        
        ply:EmitSound("radio/radiotone.wav", 40, 100, 1, CHAN_WEAPON)
    end

end)

// radio_chan
concommand.Add( "radio_chan", function( ply, cmd, args )
    if(!plyHasRadio(ply)) then return end
    radio = ply:GetWeapon("wep_radio")

    if(!radio:GetPower()) then return; end

    if args[1] then 
        // set chan
        setRadioChannel(radio,args[1])
    else
        nextRadioChannel(radio)
    end

    ply:EmitSound("radio/radioswitch.wav", 40, 100, 1, CHAN_WEAPON)

end)

function setRadioChannel(radio,chan)
    if(chan >= 0 && chan <= maxChanID) then
        radio:SetChan(chan)
    end
end

function nextRadioChannel(ply)
    actualChan = radio:GetChan()
    nextChan = actualChan + 1
    if(nextChan > maxChanID) then
        radio:SetChan(0)
    else
        radio:SetChan(nextChan)
    end
end

// Voice Hook
hook.Add("PlayerCanHearPlayersVoice","PoliceRPPlusRadioVoice",function(listener,speaker)
    local S_hasRadio, S_powerState, S_micState, S_chan = getRadioInfo(speaker);
    if((S_hasRadio) and (S_powerState) and (S_micState)) then
        local L_hasRadio, L_powerState, L_micState, L_chan = getRadioInfo(listener);
        if((L_hasRadio) and (L_powerState) and (S_chan == L_chan)) then
            return true
        else
            return false
        end
    end
end);

function getRadioInfo(ply)
    local hasRadio = ply:HasWeapon("wep_radio")
    if(hasRadio) then
        radio = ply:GetWeapon("wep_radio")
        local powerState = radio:GetPower()
        local micState = radio:GetMic()
        local chan = radio:GetChan()
        return hasRadio, powerState, micState, chan
    end
    return hasRadio, false, false, 0
end