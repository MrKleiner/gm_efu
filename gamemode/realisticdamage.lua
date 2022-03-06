CreateConVar( "gc_realisticdamage", 1, SERVER_CAN_EXECUTE, "Enable/Disable realistic damage." )
forcerealisticdamage = false

local function AmountOfPlayers()
	if(#player.GetHumans() <= 3) then
	return 1
		else if((#player.GetHumans() <= 5) && (#player.GetHumans() > 3)) then
		return 2
			else if((#player.GetHumans() <= 8) && (#player.GetHumans() > 5)) then
			return 4
				else if(#player.GetHumans() > 8) then
				return 5
				end
			end
		end
	end
end


hook.Add( "ScalePlayerDamage", "realisticPlayerdamageFUNC", function(ply, hitgroup, dmginfo)
	if((GetConVarNumber( "gc_realisticdamage" ) != 0) || forcerealisticdamage) then
		if(hitgroup == HITGROUP_GENERIC && ply:Armor() == 0) then dmginfo:ScaleDamage(AmountOfPlayers() * 0.5) end
		if(hitgroup == HITGROUP_GENERIC && ply:Armor() > 0) then dmginfo:ScaleDamage(AmountOfPlayers() * 0.5) end
		if(hitgroup == HITGROUP_HEAD && ply:Armor() == 0) then dmginfo:ScaleDamage(AmountOfPlayers()) end
		if(hitgroup == HITGROUP_HEAD && ply:Armor() > 0) then dmginfo:ScaleDamage(AmountOfPlayers() * 0.9) end
		if(hitgroup == HITGROUP_CHEST && ply:Armor() == 0) then dmginfo:ScaleDamage(AmountOfPlayers() * 0.9) end
		if(hitgroup == HITGROUP_CHEST && ply:Armor() > 0) then dmginfo:ScaleDamage(AmountOfPlayers() * 0.7) end
		if(hitgroup == HITGROUP_STOMACH && ply:Armor() == 0) then dmginfo:ScaleDamage(AmountOfPlayers() * 0.9) end
		if(hitgroup == HITGROUP_STOMACH && ply:Armor() > 0) then dmginfo:ScaleDamage(AmountOfPlayers() * 0.7) end
		if(hitgroup == (HITGROUP_LEFTLEG || HITGROUP_RIGHTLEG || HITGROUP_LEFTARM || HITGROUP_RIGHTARM)) then dmginfo:ScaleDamage(AmountOfPlayers() * 0.5) end
	end
end)

hook.Add( "ScaleNPCDamage", "realisticNPCdamageFUNC", function(npc, hitgroup, dmginfo)
	if((GetConVarNumber( "gc_realisticdamage" ) != 0) || forcerealisticdamage) then
		if(hitgroup == HITGROUP_HEAD) then dmginfo:ScaleDamage(3 / AmountOfPlayers()) end
		if(hitgroup == HITGROUP_CHEST) then dmginfo:ScaleDamage(2 / AmountOfPlayers()) end
		if(hitgroup == HITGROUP_STOMACH) then dmginfo:ScaleDamage(2 / AmountOfPlayers()) end
	end
end)


