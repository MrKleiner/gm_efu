hook.Add( "PlayerDeath", "DeathSpectatingFunction", function( victim, inflictor, attacker )
if((GetConVarNumber( "gc_realismmode" ) == 1) || forcerealismenable) then
	timer.Simple(1,function() 
		if(victim:IsValid()) then 
			victim:SetObserverMode(OBS_MODE_IN_EYE) 
			victim:SetMoveType(MOVETYPE_OBSERVER) 
			for k, v in pairs(player.GetAll()) do if(v:IsValid() && v:Alive() && v != victim) then victim:SpectateEntity(v) return end end
		end 
	end )
end
end )

hook.Add( "KeyPress", "SpectatingKeyPress", function( ply, key )
	if(key == IN_ATTACK) then
		if(!ply:Alive()) then
		local randomplayer = table.Random(player.GetAll())
			if (randomplayer:IsValid() && randomplayer:Alive() && randomplayer != ply && randomplayer != ply:GetObserverTarget()) then
				if(randomplayer == nil) then return
				end
				ply:SpectateEntity(randomplayer)
			end 
		end
	end
	if(key == IN_JUMP) then
		if(!ply:Alive()) then
			local randomplayer = table.Random(player.GetAll())
			if (randomplayer:IsValid() && randomplayer:Alive() && randomplayer != ply && randomplayer != ply:GetObserverTarget()) then
				if(randomplayer == nil) then return
				end
				ply:SpectateEntity(randomplayer)
			end 
			if(ply:GetObserverMode() == 4) then ply:SetObserverMode(OBS_MODE_CHASE)
			elseif(ply:GetObserverMode() == 5) then ply:SetObserverMode(OBS_MODE_IN_EYE) 
			end
		end
end
end )