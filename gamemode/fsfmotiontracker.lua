	timer.Create( "cheapfragtick", 1, 0, function() 
		for k, v in pairs(player.GetAll()) do
			v.EmitSoundend
		end
	end )