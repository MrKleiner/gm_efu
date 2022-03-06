

if SERVER then

local FSFInjured = {
"vo/npc/male01/no02.wav"
}


function PlayerRagdoll(ply, time, ragtype)
    if (CurTime() + time) < CurTime() or ply:GetNWBool("PlayerRagdoll") or ply:GetNWBool( "Extention_Strength" ) or !ply:Alive() then return end   
	local weapon = ply:GetActiveWeapon()
    ply.LastHealth = ply:Health()
	
	if ragtype == "normal" then
	    if ply.Male == true then
					zesound = CreateSound(ply, table.Random(FSFInjured))
					zesound:Play()
					zesound:ChangeVolume(0,1)
		end
		if GetConVarNumber("playerfalling_dropweapondamage") > 0 and weapon:IsValid() and !table.HasValue( CantDrop, weapon:GetClass() ) then 
		    ply:DropWeapon(weapon) 
		end
	elseif ragtype == "Falling" and weapon:IsValid() then
	    if ply.Male == true then
					zesound = CreateSound(ply, table.Random(MFallingSound))
					zesound:Play()
					zesound:ChangeVolume(0,1)
		else
					zesound = CreateSound(ply, table.Random(FFallingSound))
					zesound:Play()
					zesound:ChangeVolume(0,1)
		end
		if GetConVarNumber("playerfalling_dropweaponfalling") > 0 and weapon:IsValid() and !table.HasValue( CantDrop, weapon:GetClass() ) then 
		    ply:DropWeapon(weapon) 
		end
	end
	
    local weps = {}
    for u, l in pairs(ply:GetWeapons()) do
        table.insert(weps,l:GetClass())
    end
	
	ply.Weps = weps
	
	if weapon:IsValid() then
	    ply.LastWeap = weapon:GetClass()
	end
	
	if ply:GetNWBool("Extention_Added") then
	    ply.SpawnExt = true
	else
	    ply.SpawnExt = false
	end
	
	ply:StripWeapons(weps)
	ply:Spectate(6)
	
    local Body = ents.Create("prop_ragdoll")
	Body:SetPos(ply:GetPos() - Vector(0,0,50))
	Body:SetAngles(ply:GetAngles())
	Body:SetModel(ply:GetModel())
	Body.Owner = ply
	Body:Spawn()
	Body:Activate()
	local plyvel = ply:GetVelocity()

	for i = 1, Body:GetPhysicsObjectCount() do
		local bone = Body:GetPhysicsObjectNum(i)
		
		if bone and bone.IsValid and bone:IsValid() then
			local bonepos, boneang = ply:GetBonePosition(Body:TranslatePhysBoneToBone(i))
			bonepos = bonepos - Vector(0,0,10)
			bone:SetPos(bonepos)
			bone:SetAngles(boneang)
			bone:AddVelocity(plyvel)
		end
	end


	ply:Spectate(6)	
	ply:SpectateEntity(Body)
	ply:SetParent(Body)	
	ply:SetNWBool("PlayerRagdoll", true)
	ply:SetNWInt("CanCalcView", true)
	ply:SetNetworkedEntity("RagdollPlayer", Body)
	ply.ResetTime = CurTime() + time
	ply.Died = false
	
end


function PlayerRagdollThink()

    for k, v in pairs(player.GetAll()) do
	    local Body = v:GetNetworkedEntity("RagdollPlayer")
        local plytrace = {}
	    plytrace.start = v:GetPos()
	    plytrace.endpos = plytrace.start + Vector(0,0,-999999999) 
	    plytrace.filter = Body
	    local plytr = util.TraceLine( plytrace )
		local dist = plytr.HitPos:Distance(v:GetPos())
	
	    if v:KeyPressed(IN_JUMP) and dist < 150 then
	        JumpTimer = CurTime() + 1
	    end
	    
		if GetConVarNumber("playerfalling_canfall") > 0 then
            local dist = plytr.HitPos:Distance(v:GetPos())
            if v:GetVelocity():Length() > GetConVarNumber("playerfalling_maxspeedtofall") and dist > GetConVarNumber("playerfalling_maxdisttofall") and !v:IsOnGround() and v:GetMoveType() != MOVETYPE_LADDER and v:GetMoveType() != MOVETYPE_NOCLIP and v:WaterLevel() == 0 and JumpTimer < CurTime() then
	            PlayerRagdoll(v, 5, "Falling")
	        end
	    end
		
        if v:GetNWBool("PlayerRagdoll") and Body:IsValid() then
		    local head = Body:GetPhysicsObjectNum( Body:TranslateBoneToPhysBone( Body:LookupBone( "ValveBiped.Bip01_Head1" ) ) )
	        if Body:GetVelocity():Length() > 200 then 
	            v.ResetTime = CurTime() + GetConVarNumber("playerfalling_waketime")
	            v.CanUp = false
				v.UpValue = 0
	        elseif Body:GetVelocity():Length() < 200 and v.CanUp == false and v.Died != true and v.ResetTime and v.ResetTime < CurTime() then 
	            v.CanUp = true
				if v.Male == true then
					zesound = CreateSound(v, table.Random(MMoanSound))
					zesound:Play()
					zesound:ChangeVolume(0,1)
		        else
					zesound = CreateSound(v, table.Random(FMoanSound))
					zesound:Play()
					zesound:ChangeVolume(0,1)
		        end
	        end
	        local MaxUp = 850
			if v.Male == true then
                MaxUp = 850
            else
                MaxUp = 700
            end
	        if v.CanUp == true and v.Died == false then
	            if v.UpValue >= 0 and v.UpValue < MaxUp then
	                v.UpValue = math.Approach(v.UpValue, MaxUp, FrameTime() * GetConVarNumber("playerfalling_UpSpeed"))
	                v.CanUp = true
	                head:ApplyForceCenter( Vector(0,0,1) * v.UpValue )
	            elseif v.UpValue >= MaxUp then
	                v.Upped = true
	            end	
	        elseif v.CanUp == false or v.ResetTime > CurTime() then
	            v.UpValue = 0
	            v.Upped = false
	        end
	
	        if v.Upped == true then
	            ResetPlayerRagdoll(v, Body)
            end
        end
    end
end	
hook.Add("Think","PlayerRagdollThink",PlayerRagdollThink)

	
function PlayerRagdollDamage( ent, dmginfo ) 
	local inflictor = dmginfo:GetInflictor()
	local attacker = dmginfo:GetAttacker()
	local amount = dmginfo:GetDamage()
	for k, v in pairs(player.GetAll()) do
		if string.find(ent:GetClass(), "prop_ragdoll") and v:GetNWBool("RagdollPlayer") and ent:GetNWBool("RagdollPlayerEnt") then 

			local RagdollPlayer = v:GetNetworkedEntity("RagdollPlayer")
			if ent != RagdollPlayer then return end
			local amount1 	= dmginfo:GetDamage()
			if attacker:IsWorld() then
			    amount1 = amount1 / GetConVarNumber("playerfalling_worlddamagedivider") 
			else
			    amount1 = amount1 / GetConVarNumber("playerfalling_damagedivider") 
			end
			local dmgpos 	= dmginfo:GetDamagePosition()
			local dmgtype 	= dmginfo:GetDamageType()
			local norm 		= ent:GetVelocity():GetNormalized()
			local CurHealth = v:Health()
			local HealthModifier = CurHealth - amount1 / 4
			
			if GetConVarNumber("playerfalling_candamage") > 0 then 
			
			    v:SetHealth(math.Clamp(HealthModifier,0,v:GetMaxHealth()))
                v.LastHealth = v:Health()
			
            end
			
			if v:Alive() and amount > 0 and NextHurt < CurTime() and v:GetNWBool("PlayerRagdoll") then
			    NextHurt = CurTime() + 0.15
			    if v.Male == true then
					zesound = CreateSound(v, table.Random(MRagdollHurtSound))
					zesound:Play()
					zesound:ChangeVolume(0,1)
		        else
					zesound = CreateSound(v, table.Random(FRagdollHurtSound))
					zesound:Play()
					zesound:ChangeVolume(0,1)
		        end
			    if amount >= 100 then
					zesound = CreateSound(v, table.Random(BreakBone))
					zesound:Play()
					zesound:ChangeVolume(0,1)
			    end
			end
		
			if HealthModifier <= 0 and v.Died == false then
			    v.Died = true
			    v:Kill()
			    ent:SetNWBool("RagdollPlayerEnt", false)
				timer.Simple( 1.5, function() ent:Remove() end)

			    v:SetNWBool("PlayerRagdoll", false)
			end
          
		end
	end
    
    if GetConVarNumber("playerfalling_canfall") > 0 and ent:IsPlayer() and !ent:GetNWBool("PlayerRadoll") and amount > GetConVarNumber("playerfalling_maxdamagetofall") then
	    timer.Simple(0.0001, function()
	        if !ent:GetNWBool("PlayerRadoll") and ent:Health() > 0 and ent:IsPlayer() then
	            PlayerRagdoll(ent, 5, "normal")
	        end
	    end)
	end
	
end
hook.Add( "EntityTakeDamage", "PlayerRagdollDammage", PlayerRagdollDamage )

function ragdolize(ply)
    if !ply:GetNWBool("PlayerRagdoll") then
        PlayerRagdoll(ply, 5, "normal")
    end
end
concommand.Add("ragdolize",ragdolize)


function RemovePlayerRagdoll(ply)
    if ply:GetNWBool("PlayerRagdoll") and ply:IsAdmin() then
	    local Body = ply:GetNetworkedEntity("RagdollPlayer")
	    ResetPlayerRagdoll(ply, Body)
	    timer.Destroy("RespawmTime")
	end
end
concommand.Add("RemovePlayerRagdoll",RemovePlayerRagdoll)

end
