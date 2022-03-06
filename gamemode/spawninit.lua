horrormovement = false

hook.Add( "PlayerSpawn", "SpawningInitialize", function(player)
	--ply:SetNWInt("playerClass", 1)

	timer.Simple(0.3,function()
		if(player:IsValid()) then
		player:SetCollisionGroup(15)
		--player:SetTeam(1)
		player:SetCanZoom(false)
		if(horrormovement) then
			player:SetSlowWalkSpeed(120)
			player:SetWalkSpeed(180) 
			player:SetRunSpeed(300)
			player:SetMaxSpeed(300)
			player:SetJumpPower(200)
		else
			player:SetSlowWalkSpeed(140)
			player:SetWalkSpeed(155) 
			player:SetRunSpeed(300)
			player:SetMaxSpeed(300)
			player:SetJumpPower(160)
		end
		player:ConCommand([[mat_colorcorrection 1]])
		player:ConCommand([[cl_showhints 0]])
		end
		end )
	player:SetMoveType(MOVETYPE_WALK)
end )

hook.Add( "PlayerSay", "help", function( ply, text, public )
	text = string.lower( text ) -- Make the chat message entirely lowercase
	local disabled = 0
	if ( text == "!help" ) then
		if((GetConVarNumber( "gc_allowdropammo" ) != 0) && (allowdropammo == true )) then
			ply:PrintMessage( HUD_PRINTTALK, "F1 - Drop one primary magazine from your active weapon" )
			ply:PrintMessage( HUD_PRINTTALK, "F2 - Drop one secondary magazine from your active weapon" )
		else
			disabled = disabled + 1
		end
		if((GetConVarNumber( "gc_allowdropweapons" ) != 0) && (allowdropweapons == true )) then
			ply:PrintMessage( HUD_PRINTTALK, "F3 - Drop your active weapon" )
		else
			disabled = disabled + 1
		end
		if((GetConVarNumber( "gc_allowdropammo" ) != 0) && (allowdropammo == true )) then
			ply:PrintMessage( HUD_PRINTTALK, "F4 - Drop ammo you don't need" )
		else
			disabled = disabled + 1
		end
		if((GetConVarNumber( "gc_allowbringplayers" ) != 0) && (forcebringdisable == false)) then
			ply:PrintMessage( HUD_PRINTTALK, "'!bring' - Teleport all players to your location" )
		else
			disabled = disabled + 1
		end
		if(disabled == 4) then
			ply:PrintMessage( HUD_PRINTTALK, "No available actions, everything is either disabled by the server or the map." )
		end
		return ""
	end
end )

hook.Add( "PlayerInitialSpawn", "SpawnHelp", spawn )