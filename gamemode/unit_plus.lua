function FSFRadio()
for k, v in pairs(player.GetAll()) do
if v then
v:PrintMessage( HUD_PRINTCENTER, "EscapeFromUnit - Alpha Build" )
v:StartLoopingSound( "efu/fsf_tracker_loop.wav" )
end
end
end

timer.Simple( 10, FSFRadio )
