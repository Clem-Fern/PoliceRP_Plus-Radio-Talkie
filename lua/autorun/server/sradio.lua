AddCSLuaFile()
AddCSLuaFile("autorun/client/radio.lua")

// radio sound
resource.AddFile( "sound/radio/radioswitch.wav" )
resource.AddFile( "sound/radio/radiotone.wav" )
resource.AddFile( "sound/radio/r_radiotone.wav" )
resource.AddFile( "sound/radio/radiorogerbeep.wav" )

// radio hud
resource.AddFile( "materials/radio/hud/sound_mute.png" )
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

    if(radio:GetSoundMuted()) then return; end

    if(radio:GetMic()) then
        // set radio mic off
        radio:SetMic(false)
    else
        // set radio mic on
        radio:SetMic(true)
    end

end)

// radio_toogle_sound
concommand.Add( "radio_toogle_sound", function( ply, cmd, args )
    if(!plyHasRadio(ply)) then return end
    radio = ply:GetWeapon("wep_radio")

    if(radio:GetSoundMuted()) then
        // set radio sound unmuted
        radio:SetSoundMuted(false)
        
        ply:EmitSound("radio/radiotone.wav", 40, 100, 1, CHAN_WEAPON)
    else
        // set radio sound muted
        radio:SetSoundMuted(true)
        
        ply:EmitSound("radio/r_radiotone.wav", 40, 100, 1, CHAN_WEAPON)
    end

end)

// radio_chan
concommand.Add( "radio_chan", function( ply, cmd, args )
    if(!plyHasRadio(ply)) then return end
    radio = ply:GetWeapon("wep_radio")

    if args[1] then 
        // set chan
        setRadioChannel(radio,tonumber(args[1]))
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
    local S_hasRadio, S_soundMuted, S_micState, S_chan = getRadioInfo(speaker);
    if((S_hasRadio) and (!S_soundMuted) and (S_micState)) then
        local L_hasRadio, L_soundMuted, L_micState, L_chan = getRadioInfo(listener);
        if((L_hasRadio) and (!L_soundMuted) and (S_chan == L_chan)) then
            return true
        end
    end
end);

function getRadioInfo(ply)
    local hasRadio = ply:HasWeapon("wep_radio")
    if(hasRadio) then
        radio = ply:GetWeapon("wep_radio")
        local soundMuted = radio:GetSoundMuted()
        local micState = radio:GetMic()
        local chan = radio:GetChan()
        return hasRadio, soundMuted, micState, chan
    end
    return hasRadio, false, false, 0
end