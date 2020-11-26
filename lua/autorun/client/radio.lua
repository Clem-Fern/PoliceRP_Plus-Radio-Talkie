function plyHasRadio(ply)
    return ply:HasWeapon("wep_radio")
end

surface.CreateFont( "RadioHUDFontSettings", {
	font = "DermaLarge", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 40,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

local function PaintRadioHUD()
    ply = LocalPlayer();
    if(!ply:Alive()) then return; end
    if(!plyHasRadio(ply)) then return; end
    radio = ply:GetWeapon("wep_radio")

    if(radio:GetPower()) then

        draw.RoundedBox(3, 3, 3, 170, 44, Color(91, 82, 168, 150))

        if(radio:GetMic()) then
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.SetMaterial( Material("materials/radio/hud/unmute.png") )
            surface.DrawTexturedRect( 5, 5, 40, 40 )
        else
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.SetMaterial( Material("materials/radio/hud/mute.png") )
            surface.DrawTexturedRect( 5, 5, 40, 40 )
        end

        chan = radio:GetChan()
        draw.SimpleText( "CHAN-" .. tostring(chan), "RadioHUDFontSettings", 50, 4, Color(0, 0, 0, 200))

    else 
        draw.RoundedBox(3, 3, 3, 170, 44, Color(51, 58, 51, 150))
    end 

end
hook.Add( "HUDPaint", "PaintOurHud", PaintRadioHUD );

// play Roger beep
hook.Add("PlayerEndVoice", "RogerBeepOnEndVoice", function()
    ply = LocalPlayer();
    if(!ply:Alive()) then return; end
    if(!plyHasRadio(ply)) then return; end
    radio = ply:GetWeapon("wep_radio")

    if(!radio:GetPower()) then return; end

    if(radio:GetMic()) then
        ply:EmitSound("radio/radiorogerbeep.wav", 30, 100, 1, CHAN_WEAPON)
    end
end);