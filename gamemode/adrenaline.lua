
function AdrenalineRush(ply)

	local mc = mc
	local pitch = 100 * GetConVarNumber("host_timescale")
	local volume = 500
    ply:EmitSound(Sound("test/test k"..math.random(1,5)..".wav"),volume,pitch)
    timer.Simple(0.2, function() ply:EmitSound(Sound("test/test o"..math.random(1,50)..".wav"),volume,pitch) end)
end

