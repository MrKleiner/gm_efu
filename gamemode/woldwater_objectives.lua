--[[
O B J E C T I V E S  A R E  A L R E A D Y  M O U N T E D  I N T O  T H E  M A P
]]--

function Objective1()
for k, v in pairs(player.GetAll()) do
if v then
v:PrintMessage( HUD_PRINTCENTER, "GET INSIDE THE FACILITY" )
v:StartLoopingSound( "efu/fsf_tracker_loop.wav" )
end
end
end

function Objective2()
for k, v in pairs(player.GetAll()) do
if v then
v:PrintMessage( HUD_PRINTCENTER, "FIND KEYS FOR OFFICES" )
v:StartLoopingSound( "efu/fsf_tracker_loop.wav" )
end
end
end

function Objective3()
for k, v in pairs(player.GetAll()) do
if v then
v:PrintMessage( HUD_PRINTCENTER, "FIND DOCUMENTS" )
v:StartLoopingSound( "efu/fsf_tracker_loop.wav" )
end
end
end

function Objective4()
for k, v in pairs(player.GetAll()) do
if v then
v:PrintMessage( HUD_PRINTCENTER, "TURN LIGHT GENERATOR ON IN CANALS" )
v:StartLoopingSound( "efu/fsf_tracker_loop.wav" )
end
end
end

timer.Simple( 3, Objective1 )
--timer.Simple( 1, Objective2 )
--timer.Simple( 1, Objective3 )
--timer.Simple( 1, Objective4 )