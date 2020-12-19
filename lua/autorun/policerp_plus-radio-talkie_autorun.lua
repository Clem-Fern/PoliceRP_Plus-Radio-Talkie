if SERVER then
    include( "policerp_plus-radio-talkie/sv_radio.lua" )
    AddCSLuaFile( "policerp_plus-radio-talkie/cl_radio.lua" )
else
    include( "policerp_plus-radio-talkie/cl_radio.lua" )
end