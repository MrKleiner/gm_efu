sound.Add( 
{
name = "UNIT.FSFSoldierScream",
channel = CHAN_BODY,
volume = 1, --0.800,
level = SNDLVL_TALKING,
pitch = { 95, 110 },
sound = { "efu/fsf_foundunit_1.wav","efu/fsf_foundunit_2.wav","efu/fsf_foundunit_3.wav" }
} )

sound.Add( {
	name = "UNIT.FSFSoldierPanicScream",
	channel = CHAN_BODY,
	volume = 1, --0.800,
	level = SNDLVL_TALKING,
	pitch = { 95, 110 },
	sound = { "efu/fsf_attackedbyunit_1.wav","efu/fsf_attackedbyunit_2.wav","efu/fsf_attackedbyunit_3.wav","efu/fsf_attackedbyunit_4.wav","efu/fsf_attackedbyunit_5.wav" }

} )

sound.Add( {
	name = "UNIT.FSFSoldierReload",
	channel = CHAN_BODY,
	volume = 1, --0.800,
	level = SNDLVL_TALKING,
	pitch = { 95, 110 },
	sound = { "efu/vo/ammolow1.wav","efu/vo/ammolow2.wav","efu/vo/ammolow3.wav" }

} )

sound.Add( {
	name = "UNIT.FSFDeathScreaming",
	channel = CHAN_BODY,
	volume = 1, --0.800,
	level = SNDLVL_TALKING,
	pitch = { 95, 110 },
	sound = { "efu/vo/death1.wav","efu/vo/death2.wav" }

} )

sound.Add( {
	name = "UNIT.IdleSounds",
	channel = CHAN_BODY,
	volume = 1, --0.800,
	level = SNDLVL_TALKING,
	pitch = { 95, 110 },
	sound = { "ambient/materials/creaking.wav","mc/idle_0.wav","ambient/levels/prison/radio_random14.wav" }

} )

sound.Add( {
	name = "UNIT.SeePlayer",
	channel = CHAN_BODY,
	volume = 1, --0.800,
	level = SNDLVL_TALKING,
	pitch = { 95, 110 },
	sound = { "mc/freeze_staywhereyouareleyontheground.wav","mc/dropweaponthengetdown.wav","mc/surrendernow.wav" }

} )

util.PrecacheSound("efu/fsf_attackedbyunit_1.wav")
util.PrecacheSound("efu/fsf_attackedbyunit_2.wav")
util.PrecacheSound("efu/fsf_attackedbyunit_3.wav")
util.PrecacheSound("efu/fsf_attackedbyunit_4.wav")
util.PrecacheSound("efu/fsf_attackedbyunit_5.wav")
util.PrecacheSound("efu/fsf_foundunit_1.wav")
util.PrecacheSound("efu/fsf_foundunit_2.wav")
util.PrecacheSound("efu/fsf_foundunit_3.wav")

util.PrecacheSound("efu/vo/ammolow1.wav")
util.PrecacheSound("efu/vo/ammolow2.wav")
util.PrecacheSound("efu/vo/ammolow3.wav")

util.PrecacheSound("efu/vo/death1.wav")
util.PrecacheSound("efu/vo/death2.wav")
util.PrecacheSound("efu/vo/death_distant.wav")

--[[
ply:(EmitSound('UNIT.FSFSoldierScream')
end
]]

// pairs
// ##### 

--[[GLORY TO UKRAINE]]--
