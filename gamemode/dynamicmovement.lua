local jumped = 0
local vellock = true

hook.Add( "PlayerHurt", "SlowingDownHurtPlayers", function( victim, attacker, healthRemaining, damageTaken )
	if(victim:IsValid()) then
		if(horrormovement) then
			victim:SetSlowWalkSpeed(230)
			victim:SetWalkSpeed(230)
			victim:SetRunSpeed(230)
		else
			if(damageTaken < 100) then
				victim:SetSlowWalkSpeed(140 - damageTaken)
				victim:SetWalkSpeed(155 - damageTaken)
				victim:SetRunSpeed(210 - damageTaken)
			else
			victim:SetSlowWalkSpeed(10)
			victim:SetWalkSpeed(10)
			victim:SetRunSpeed(10)
			end
		end
		victim:ViewPunch( Angle( -(damageTaken / 10), 0, 0  ))
	end
		if(horrormovement) then
		--	timer.Simple( 0.5, function() if(victim:IsValid() && jumped < CurTime()) then print("player back to normal after taking damage") victim:SetSlowWalkSpeed(120) victim:SetWalkSpeed(180) victim:SetRunSpeed(140) end end )
			timer.Simple( 2, function() if(victim:IsValid()) then victim:SetSlowWalkSpeed(120) victim:SetWalkSpeed(181) victim:SetRunSpeed(140) end end )
		else
		--	timer.Simple( 0.5, function() if(victim:IsValid() && jumped < CurTime()) then victim:SetSlowWalkSpeed(140) victim:SetWalkSpeed(155) victim:SetRunSpeed(210) end end ) 
			timer.Simple( 0.5, function() if(victim:IsValid()) then victim:SetSlowWalkSpeed(140) victim:SetWalkSpeed(155) victim:SetRunSpeed(210) end end )
		end
end )


hook.Add("KeyPress", "Anti-Bhop", function(player, key)
	if(key == IN_JUMP) then
		if(CurTime() < jumped) then
			if(player:IsValid()) then
				if(!vellock) then
				player:SetVelocity(- player:GetVelocity() / 2)
				jumped = CurTime() + 3
				vellock = true
				end
				jumped = CurTime() + 3
			end
		else
			jumped = CurTime() + 3
		end
		return true
	end
end)

hook.Add( "OnPlayerHitGround", "SlowingFall", function( player, inWater, onFloater, speed )
	if(horrormovement) then
		if(player:IsValid()) then 
			player:SetSlowWalkSpeed(100) 
			player:SetWalkSpeed(100) 
			player:SetRunSpeed(100) 
		end
		timer.Simple( 0.5, function() if(player:IsValid()) then player:SetSlowWalkSpeed(120) player:SetWalkSpeed(181) player:SetRunSpeed(140) end end)
	else
		if(player:IsValid()) then 
			player:SetSlowWalkSpeed(140)
			player:SetWalkSpeed(140) 
			player:SetRunSpeed(140) 
		end
		timer.Simple( 0.5, function() if(player:IsValid()) then player:SetSlowWalkSpeed(140) player:SetWalkSpeed(155) player:SetRunSpeed(210) end end)
	end
	vellock = false
end )