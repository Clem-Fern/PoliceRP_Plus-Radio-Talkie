/////////////////////////////////////////////////////////////
// Radio command
// radio_toogle_mic
concommand.Add( "radio_toogle_mic", function( ply, cmd, args )
    if(!plyHasRadio(ply)) then return end
    Msg(ply:GetName() .. " has radio")

    EmitSound("radio/radiotone.wav", LocalPlayer():GetPos(), LocalPlayer():EntIndex(), CHAN_AUTO, 1, 75, 0, 100)

end)

// radio_cut_off_mic
concommand.Add( "radio_cut_off_mic", function( ply, cmd, args )
    if(!plyHasRadio(ply)) then return end
    Msg(ply:GetName() .. " has radio")

    EmitSound("radio/radioswitch.wav", LocalPlayer():GetPos(), LocalPlayer():EntIndex(), CHAN_AUTO, 1, 75, 0, 100)

end)

// radio_toogle_power
concommand.Add( "radio_toogle_power", function( ply, cmd, args )
    if(!plyHasRadio(ply)) then return end
    Msg(ply:GetName() .. " has radio")

    if(ply:GetNWBool("radio_power_state", false)) then
        // set radio off
        ply:SetNWBool("radio_power_state", false)
        EmitSound("radio/r_radiotone.wav", LocalPlayer():GetPos(), LocalPlayer():EntIndex(), CHAN_AUTO, 1, 75, 0, 100)
    else
        // set radio on
        ply:SetNWBool("radio_power_state", true)
        EmitSound("radio/radiotone.wav", LocalPlayer():GetPos(), LocalPlayer():EntIndex(), CHAN_AUTO, 1, 75, 0, 100)
    end

end)

// radio_chan
concommand.Add( "radio_chan", function( ply, cmd, args )
    if(!plyHasRadio(ply)) then return end
    Msg(ply:GetName() .. " has radio")

    EmitSound("radio/radioswitch.wav", LocalPlayer():GetPos(), LocalPlayer():EntIndex(), CHAN_AUTO, 1, 75, 0, 100)

end)

function plyHasRadio(ply)
    return ply:HasWeapon("wep_radio")
end

local function PaintRadioHUD()
    ply = LocalPlayer();
    if(!ply:Alive()) then return; end
    if(!plyHasRadio(ply)) then return; end

    if(ply:GetNWBool("radio_power_state", false)) then
        // radio ON
        print("draw HUD : radio ON")
    else
        // radio OFF
        print("draw HUD : radio OFF")
    end  

end
hook.Add( "HUDPaint", "PaintOurHud", PaintRadioHUD );