--[[CreateConVar( "gc_allowdropammo", 1, SERVER_CAN_EXECUTE, "Allow players to drop ammo with F1, F2, and F4" )
CreateConVar( "gc_allowdropweapons", 1, SERVER_CAN_EXECUTE, "Allow players to drop weapons with F3" )
allowdropweapons = true
allowdropammo = true

local Blacklist = {
-- Sandbox
"weapon_fists", 
"weapon_bugbait",
"weapon_rpg",

-- M9K Weapons
"m9k_fists",
"m9k_orbital_strike",

-- Dual Weapons
"dual_weapons",

-- DarkRP
"keys",
"pocket"
}

--!table.HasValue(Blacklist, Weapon:GetClass())

local function HasWeaponForAmmo(ply,weapon)
	for k, v in pairs(ply:GetWeapons()) do
		if(v:GetClass() != weapon:GetClass()) then
			if(v:GetPrimaryAmmoType() == weapon:GetPrimaryAmmoType()) then
			return true
			end
		end
	end
	return false
end

local function HowManyWeapons(ply)
ply:SetNWInt("weaponcount",0)
for k, v in pairs(ply:GetWeapons()) do
ply:SetNWInt("weaponcount",ply:GetNWInt("weaponcount") + 1)
end
end

hook.Add( "ShowHelp", "DropAmmo", function(ply)
local wep = ply:GetActiveWeapon()
	if((GetConVarNumber( "gc_allowdropammo" ) != 0) && (allowdropammo == true )) then
		if(wep:IsValid() && ply:GetAmmoCount(wep:GetPrimaryAmmoType()) != 0 && wep:GetMaxClip1() > 0) then
		CreateAmmoFunction1(ply)
		ply:SetNWInt(wep:GetPrimaryAmmoType() .. "ammo",ply:GetAmmoCount(wep:GetPrimaryAmmoType()))
		end
	end
end )

hook.Add( "ShowSpare2", "DropUnused", function(ply)
	if((GetConVarNumber( "gc_allowdropammo" ) != 0) && (allowdropammo == true )) then
		DropUnusedAmmo(ply)
	end
end )

hook.Add( "ShowSpare1", "DropWeapon", function(ply)
local wep = ply:GetActiveWeapon()
	if((GetConVarNumber( "gc_allowdropweapons" ) != 0) && (allowdropweapons == true )) then
		if(#ply:GetWeapons() > 0) then
			if(table.HasValue(Blacklist, wep:GetClass())) then
				if((ply:GetAmmoCount(wep:GetPrimaryAmmoType()) > 0) && !HasWeaponForAmmo(ply,wep)) then
				wep:SetNWInt("additammo1",ply:GetAmmoCount(wep:GetPrimaryAmmoType()))
				ply:RemoveAmmo(ply:GetAmmoCount(wep:GetPrimaryAmmoType()),wep:GetPrimaryAmmoType())
				end
				if((ply:GetAmmoCount(wep:GetSecondaryAmmoType()) > 0) && !HasWeaponForAmmo(ply,wep)) then
				wep:SetNWInt("additammo2",ply:GetAmmoCount(wep:GetSecondaryAmmoType()))
				ply:RemoveAmmo(ply:GetAmmoCount(wep:GetSecondaryAmmoType()),wep:GetSecondaryAmmoType())
				end
				if(HasWeaponForAmmo(ply,wep)) then
				ply:GiveAmmo(wep:Clip1(),wep:GetPrimaryAmmoType(),true)
				ply:GiveAmmo(wep:Clip2(),wep:GetSecondaryAmmoType(),true)
				wep:SetClip1(0)
				wep:SetClip2(0)
				end
				wep:SetNWInt("clipammo1",wep:Clip1())
				wep:SetNWInt("clipammo2",wep:Clip2())
				ply:SetNWInt(wep:GetPrimaryAmmoType() .. "ammo",ply:GetAmmoCount(wep:GetPrimaryAmmoType()))
				ply:SetNWInt(wep:GetSecondaryAmmoType() .. "ammo",ply:GetAmmoCount(wep:GetSecondaryAmmoType()))
				wep:SetNWBool("hasbeenused",true)
				ply:DropWeapon(wep)
			end
		end
	end
end )

hook.Add( "ShowTeam", "DropSecondary", function(ply)
local wep = ply:GetActiveWeapon()
	if((GetConVarNumber( "gc_allowdropammo" ) != 0) && (allowdropammo == true )) then
		if(wep:IsValid() && ply:GetAmmoCount(wep:GetSecondaryAmmoType()) != 0) then
		CreateAmmoFunction2(ply)
		ply:SetNWInt(wep:GetSecondaryAmmoType() .. "ammo",ply:GetAmmoCount(wep:GetSecondaryAmmoType()))
		end
	end
end )

function DropUnusedAmmo(ply)
for k, v in pairs(ents.FindByClass("coop_*")) do // checking a weapon
		if(ply:GetAmmoCount(v:GetPrimaryAmmoType()) > 0) then // player has ammo more than 0 of said weapon
			if(!ply:HasWeapon(v:GetClass())) then //player doesn't have the weapon
				for l, m in pairs(ply:GetWeapons()) do //for player's every weapon
					ply:SetNWInt("wrongtypefor" .. v:GetPrimaryAmmoType(),1)
					if(m:GetPrimaryAmmoType() == v:GetPrimaryAmmoType()) then
					ply:SetNWInt("wrongtypefor" .. v:GetPrimaryAmmoType(),0)
					break;
					end
				end
				if(ply:GetNWBool("wrongtypefor" .. v:GetPrimaryAmmoType()) == 1) then
				local ent = ents.Create("prop_physics")
				AmmoModel(ply,v:GetPrimaryAmmoType(),ent)
				ent:SetPos(ply:GetPos() + Vector(0,0,15))
				ent:Spawn()
				ent:SetCollisionGroup(COLLISION_GROUP_WEAPON)
				ent:SetNWBool("isammo",true)
				ent:SetNWString("ammotype",v:GetPrimaryAmmoType())
				ent:SetNWInt("amount",ply:GetAmmoCount(v:GetPrimaryAmmoType()))
				ply:SetNWInt(v:GetPrimaryAmmoType() .. "ammo",0)
				ply:SetAmmo(0,v:GetPrimaryAmmoType())
				end
			end
		end
end

for k, v in pairs(ents.FindByClass("weapon_*")) do // checking a weapon
		if(ply:GetAmmoCount(v:GetPrimaryAmmoType()) > 0) then // player has ammo more than 0 of said weapon
			if(!ply:HasWeapon(v:GetClass())) then //player doesn't have the weapon
				for l, m in pairs(ply:GetWeapons()) do //for player's every weapon
					ply:SetNWInt("wrongtypefor" .. v:GetPrimaryAmmoType(),1)
					if(m:GetPrimaryAmmoType() == v:GetPrimaryAmmoType()) then
					ply:SetNWInt("wrongtypefor" .. v:GetPrimaryAmmoType(),0)
					break;
					end
				end
				if(ply:GetNWBool("wrongtypefor" .. v:GetPrimaryAmmoType()) == 1) then
				local ent = ents.Create("prop_physics")
				AmmoModel(ply,v:GetPrimaryAmmoType(),ent)
				ent:SetPos(ply:GetPos() + Vector(0,0,15))
				ent:Spawn()
				ent:SetCollisionGroup(COLLISION_GROUP_WEAPON)
				ent:SetNWBool("isammo",true)
				ent:SetNWString("ammotype",v:GetPrimaryAmmoType())
				ent:SetNWInt("amount",ply:GetAmmoCount(v:GetPrimaryAmmoType()))
				ply:SetNWInt(v:GetPrimaryAmmoType() .. "ammo",0)
				ply:SetAmmo(0,v:GetPrimaryAmmoType())
				end
			end
		end
end
end

function AmmoModel(ply,ammotype,ent)
	if(ammotype == 1) then 
		ent:SetModel("models/Items/combine_rifle_cartridge01.mdl")
	elseif(ammotype == 3) then 
		ent:SetModel("models/Items/BoxSRounds.mdl")
	elseif(ammotype == 4) then 
		ent:SetModel("models/Items/BoxMRounds.mdl")
	elseif(ammotype == 5) then 
		ent:SetModel("models/Items/357ammo.mdl")
	elseif(ammotype == 6) then 
		ent:SetModel("models/Items/CrossbowRounds.mdl")
	elseif(ammotype == 7) then 
		ent:SetModel("models/Items/BoxBuckshot.mdl")
	elseif(ammotype == 9) then 
		ent:SetModel("models/Items/AR2_Grenade.mdl")
	elseif(ammotype == 2) then 
		ent:SetModel("models/Items/combine_rifle_ammo01.mdl")
	elseif(ammotype == 8) then 
		ent:SetModel("models/weapons/w_missile_closed.mdl")
	else
		ent:SetModel("models/Items/BoxMRounds.mdl")
	end
end 

function CreateAmmoFunction1(ply)
	local ent = ents.Create("prop_physics")
	AmmoModel(ply,ply:GetActiveWeapon():GetPrimaryAmmoType(),ent)
	ent:SetPos(ply:GetPos() + Vector(0,0,15))
	ent:Spawn()
	ent:SetCollisionGroup(COLLISION_GROUP_WEAPON )
	ent:SetNWBool("isammo",true)
	ent:SetNWString("ammotype",ply:GetActiveWeapon():GetPrimaryAmmoType())
	if(ply:GetAmmoCount(ply:GetActiveWeapon():GetPrimaryAmmoType()) < ply:GetActiveWeapon():GetMaxClip1()) then
		ent:SetNWInt("amount",ply:GetAmmoCount(ply:GetActiveWeapon():GetPrimaryAmmoType()))
		ply:RemoveAmmo(ply:GetAmmoCount(ply:GetActiveWeapon():GetPrimaryAmmoType()),ply:GetActiveWeapon():GetPrimaryAmmoType())
	else
		ent:SetNWInt("amount",ply:GetActiveWeapon():GetMaxClip1())
		ply:RemoveAmmo(ply:GetActiveWeapon():GetMaxClip1(),ply:GetActiveWeapon():GetPrimaryAmmoType())
	end
end 

function CreateAmmoFunction2(ply)
	local ent = ents.Create("prop_physics")
	AmmoModel(ply,ply:GetActiveWeapon():GetSecondaryAmmoType(),ent)
	ent:SetPos(ply:GetPos() + Vector(0,0,15))
	ent:Spawn()
	ent:SetCollisionGroup(COLLISION_GROUP_WEAPON )
	ent:SetNWBool("isammo",true)
	ent:SetNWString("ammotype",ply:GetActiveWeapon():GetSecondaryAmmoType())
	ent:SetNWInt("amount",1)
	ply:RemoveAmmo(1,ply:GetActiveWeapon():GetSecondaryAmmoType())
end

hook.Add( "KeyPress", "KeyPressAmmo", function( ply, key )
	if ( key == IN_USE && ply:GetEyeTrace().Entity:GetNWBool("isammo")) then
		ply:GiveAmmo(ply:GetEyeTrace().Entity:GetNWInt("amount"),ply:GetEyeTrace().Entity:GetNWInt("ammotype"),false)
		ply:GetEyeTrace().Entity:Remove()
	end
end )

local function PlayerDropDeathWeapon(ply)

	for l, m in pairs(ply:GetWeapons()) do
	if((GetConVarNumber( "gc_allowdropweapons" ) != 0) && (allowdropweapons == true )) then
			if(ply:GetAmmoCount(m:GetPrimaryAmmoType()) > 0) then
			m:SetNWInt("additammo1",ply:GetAmmoCount(m:GetPrimaryAmmoType()))
			ply:SetAmmo(0,m:GetPrimaryAmmoType())
			end
			if(ply:GetAmmoCount(m:GetSecondaryAmmoType()) > 0) then
			m:SetNWInt("additammo2",ply:GetAmmoCount(m:GetSecondaryAmmoType()))
			ply:SetAmmo(0,m:GetSecondaryAmmoType())
			end
		m:SetNWInt("clipammo1",m:Clip1())
		m:SetNWInt("clipammo2",m:Clip2())
		m:SetNWBool("hasbeenused",true)
		ply:SetAmmo(0,m:GetPrimaryAmmoType())
		ply:SetAmmo(0,m:GetSecondaryAmmoType())
		ply:DropWeapon(m)
		end
	end
	end

	for k, v in pairs(ents.FindByClass("coop_*")) do 
		ply:SetNWBool("taken" .. v:MapCreationID(),false)
	end
	
		for k, v in pairs(ents.FindByClass("weapon_*")) do 
		ply:SetNWBool("taken" .. v:MapCreationID(),false)
	end

	for k, v in pairs( ents.FindByClass("weapon_*") && ents.FindByClass("coop_*") ) do 
		if(!table.HasValue(Blacklist, v:GetClass())) then
			if(ply:GetAmmoCount(v:GetPrimaryAmmoType()) > 0) then
				local ent = ents.Create("prop_physics")
				AmmoModel(ply,v:GetPrimaryAmmoType(),ent)
				ent:SetPos(ply:GetPos() + Vector(0,0,15))
				ent:Spawn()
				ent:SetCollisionGroup(COLLISION_GROUP_WEAPON)
				ent:SetNWBool("isammo",true)
				ent:SetNWString("ammotype",v:GetPrimaryAmmoType())
				ent:SetNWInt("amount",ply:GetAmmoCount(v:GetPrimaryAmmoType()))
				ply:SetNWInt(v:GetPrimaryAmmoType() .. "ammo",0)
				ply:SetAmmo(0,v:GetPrimaryAmmoType())
			end	
		end
	end 
	for k, v in pairs( ents.FindByClass("weapon_*") && ents.FindByClass("coop_*") ) do 
		if(!table.HasValue(Blacklist, v:GetClass())) then
			if(ply:GetAmmoCount(v:GetSecondaryAmmoType()) > 0) then
				local ent = ents.Create("prop_physics")
				AmmoModel(ply,v:GetSecondaryAmmoType(),ent)
				ent:SetPos(ply:GetPos() + Vector(0,0,15))
				ent:Spawn()
				ent:SetCollisionGroup(COLLISION_GROUP_WEAPON)
				ent:SetNWBool("isammo",true)
				ent:SetNWString("ammotype",v:GetSecondaryAmmoType())
				ent:SetNWInt("amount",ply:GetAmmoCount(v:GetSecondaryAmmoType()))
				ply:SetNWInt(v:GetSecondaryAmmoType() .. "ammo",0)
				ply:SetAmmo(0,v:GetSecondaryAmmoType())
			end	
		end
	end 
	--ply:StripAmmo() 
end
hook.Add("DoPlayerDeath", "PlayerDeathDropWeapon", PlayerDropDeathWeapon)

hook.Add( "PlayerSpawn", "SpawningInitializeAmmo", function(ply)
	timer.Simple(0.2, function()
	for k, v in pairs( ents.FindByClass("weapon_*") && ents.FindByClass("coop_*") ) do 
		ply:SetNWInt(v:GetSecondaryAmmoType() .. "ammo",0)
		ply:SetNWInt(v:GetPrimaryAmmoType() .. "ammo",0)
		ply:SetNWBool("taken" .. v:MapCreationID(),false)
	end 
	end )
end )
--8192
local function PlayerCanPickupWeapon( ply, weap ) 
if (( CurTime() <= ( ply.UseWeaponSpawn or 0 )) && ply:GetPos():Distance(weap:GetPos()) < 25) then return end
	if(weap:CreatedByMap() && !weap:GetNWBool("hasbeenused")) then
		if (ply:KeyDown(IN_USE)) then 
			local trace = util.QuickTrace( ply:GetShootPos(), ply:GetAimVector() * 8192, ply )
			if ( trace.Entity && trace.Entity:IsValid() && trace.Entity == weap ) then
				if(table.HasValue(Blacklist, weap:GetClass())) then 
				return
				else
					if(ply:GetNWBool("taken" .. weap:MapCreationID()) != true) then
					HowManyWeapons(ply)
					if(ply:GetNWInt("weaponcount") <= 3 || weap:GetClass() == "weapon_crowbar" || ply:HasWeapon(weap:GetClass())) then	
						if(ply:HasWeapon(weap:GetClass())) then
						ply:SetNWBool("taken" .. weap:MapCreationID(),true)
						for k, v in pairs(ply:GetWeapons()) do 
						if(v:GetClass() == weap:GetClass()) then v:SetClip1(v:GetMaxClip1()) end end
						ply:SelectWeapon(weap:GetClass())
						ply:SetNWInt(weap:GetPrimaryAmmoType() .. "ammo",ply:GetAmmoCount(weap:GetPrimaryAmmoType()))
						ply:SetNWInt(weap:GetSecondaryAmmoType() .. "ammo",ply:GetAmmoCount(weap:GetSecondaryAmmoType()))
						return false
						else
						ply:SetNWBool("taken" .. weap:MapCreationID(),true)
						ply:Give(weap:GetClass())
						ply:SelectWeapon(weap:GetClass())
						ply:SetNWInt(weap:GetPrimaryAmmoType() .. "ammo",ply:GetAmmoCount(weap:GetPrimaryAmmoType()))
						ply:SetNWInt(weap:GetSecondaryAmmoType() .. "ammo",ply:GetAmmoCount(weap:GetSecondaryAmmoType()))
						return false
						end
					else if(ply:HasWeapon(weap:GetClass()))	then
					if(ply:HasWeapon(weap:GetClass())) then
					ply:SetNWBool("taken" .. weap:MapCreationID(),true)
					for k, v in pairs(ply:GetWeapons()) do 
					if(v:GetClass() == weap:GetClass()) then v:SetClip1(v:GetMaxClip1()) end end
					ply:SelectWeapon(weap:GetClass())
					ply:SetNWInt(weap:GetPrimaryAmmoType() .. "ammo",ply:GetAmmoCount(weap:GetPrimaryAmmoType()))
					ply:SetNWInt(weap:GetSecondaryAmmoType() .. "ammo",ply:GetAmmoCount(weap:GetSecondaryAmmoType()))
					return false
					end
					else
					ply:PrintMessage(HUD_PRINTCENTER,"Can't carry any more! Type !help")
					return false
					end
					end
				else
				return false
				end
				end
			else
			return false
			end
		else
		return false
		end
	else
		if (ply:KeyDown(IN_USE) && weap:GetPos():Distance(ply:GetPos()) < 25) then			
				if(ply:HasWeapon(weap:GetClass())) then
					if(table.HasValue(Blacklist, weap:GetClass())) then 
							return
					else
					for k, v in pairs(ply:GetWeapons()) do 
						if(v:GetClass() == weap:GetClass()) then 
							ply:SetNWInt(v:GetPrimaryAmmoType() .. "ammo", ply:GetAmmoCount(weap:GetPrimaryAmmoType()) + v:Clip1()) 
							ply:SetNWInt(v:GetSecondaryAmmoType() .. "ammo", ply:GetAmmoCount(weap:GetSecondaryAmmoType())) 
							v:SetNWInt("clipammo1",0) 
							v:SetNWInt("clipammo2",0) 
							ply:DropWeapon(v) 
						end 
					end
					ply:SetActiveWeapon(v)								
					return
					end
				else
					HowManyWeapons(ply)
					if(ply:GetNWInt("weaponcount") <= 3 || weap:GetClass() == "weapon_crowbar" || ply:HasWeapon(weap:GetClass())) then
						ply:SetNWInt(weap:GetPrimaryAmmoType() .. "ammo",ply:GetAmmoCount(weap:GetPrimaryAmmoType()))
						ply:SetNWInt(weap:GetSecondaryAmmoType() .. "ammo",ply:GetAmmoCount(weap:GetSecondaryAmmoType()))
						return
					else
						ply:PrintMessage(HUD_PRINTCENTER,"Can't carry any more! Type !help")
						return false
					end					
				end
		else
		return false
		end
	end
end
hook.Add( "PlayerCanPickupWeapon", "UseWeapon", PlayerCanPickupWeapon )


local function WeaponEquip(weapon)
	timer.Simple(0, function() 
	if(weapon:IsValid()) then
		local ply = weapon:GetOwner()
		if(table.HasValue(Blacklist, weapon:GetClass())) then
		return
		else
			if(weapon:GetNWBool("hasbeenused")) then
				weapon:SetClip1(weapon:GetNWInt("clipammo1"))
				weapon:SetClip2(weapon:GetNWInt("clipammo2"))
			end
			if(ply:IsValid() && weapon:IsValid()) then
				ply:SetAmmo(ply:GetNWInt(weapon:GetPrimaryAmmoType() .. "ammo"),weapon:GetPrimaryAmmoType())
				ply:SetAmmo(ply:GetNWInt(weapon:GetSecondaryAmmoType() .. "ammo"),weapon:GetSecondaryAmmoType())
				ply:GiveAmmo(weapon:GetNWInt("additammo1"),weapon:GetPrimaryAmmoType(),true)
				ply:GiveAmmo(weapon:GetNWInt("additammo2"),weapon:GetSecondaryAmmoType(),true)
			end
			if(weapon:IsValid()) then
				weapon:SetNWInt("additammo1",0)
				weapon:SetNWInt("additammo2",0)
				weapon:SetNWBool("hasbeenused",true)
			end
		end
	end
	end )
end
hook.Add("WeaponEquip","manualammo",WeaponEquip)

local function PlayerCanPickupItem( ply, item )
	if ( CurTime() <= ( ply.UseWeaponSpawn or 0 )) then return end
	if ( !ply:KeyDown( IN_USE ) ) then return false end
	local trace = util.QuickTrace( ply:GetShootPos(), ply:GetAimVector() * 8192, ply )
	if ( !trace.Entity || !trace.Entity:IsValid() || trace.Entity != item ) then
		return false
	end
end
hook.Add( "PlayerCanPickupItem", "UseItem", PlayerCanPickupItem )

local function up( ply, ent )
	return ((ent:GetClass() == "prop_physics" || ent:GetClass() == "func_physbox") && !ent:GetNWBool("isammo"))
end
hook.Add( "AllowPlayerPickup", "some_unique_name", up )

local function PlayerSpawn( ply )
	ply.UseWeaponSpawn = CurTime()
end
hook.Add( "PlayerSpawn", "UseWeapon", PlayerSpawn )
]]