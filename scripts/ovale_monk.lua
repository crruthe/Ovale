local OVALE, Ovale = ...
local OvaleScripts = Ovale.OvaleScripts

-- THE REST OF THIS FILE IS AUTOMATICALLY GENERATED.
-- ANY CHANGES MADE BELOW THIS POINT WILL BE LOST.

do
	local name = "simulationcraft_monk_mistweaver_t18m"
	local desc = "[7.0] SimulationCraft: Monk_Mistweaver_T18M"
	local code = [[
# Based on SimulationCraft profile "Monk_Mistweaver_T18M".
#	class=monk
#	spec=mistweaver
#	talents=1313323

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_monk_spells)

AddCheckBox(opt_potion_intellect ItemName(draenic_intellect_potion) default specialization=mistweaver)
AddCheckBox(opt_chi_burst SpellName(chi_burst) default specialization=mistweaver)

AddFunction MistweaverUsePotionIntellect
{
	if CheckBoxOn(opt_potion_intellect) and target.Classification(worldboss) Item(draenic_intellect_potion usable=1)
}

AddFunction MistweaverUseItemActions
{
	Item(Trinket0Slot usable=1)
	Item(Trinket1Slot usable=1)
}

### actions.default

AddFunction MistweaverDefaultMainActions
{
	#run_action_list,name=aoe,if=active_enemies>=3
	if Enemies() >= 3 MistweaverAoeMainActions()
	#call_action_list,name=st,if=active_enemies<3
	if Enemies() < 3 MistweaverStMainActions()
}

AddFunction MistweaverDefaultShortCdActions
{
	#run_action_list,name=aoe,if=active_enemies>=3
	if Enemies() >= 3 MistweaverAoeShortCdActions()

	unless Enemies() >= 3 and MistweaverAoeShortCdPostConditions()
	{
		#call_action_list,name=st,if=active_enemies<3
		if Enemies() < 3 MistweaverStShortCdActions()
	}
}

AddFunction MistweaverDefaultCdActions
{
	#auto_attack
	#invoke_xuen
	Spell(invoke_xuen)
	#use_item,name=intuitions_gift
	MistweaverUseItemActions()
	#use_item,name=mirror_of_the_blademaster
	MistweaverUseItemActions()
	#blood_fury,if=target.time_to_die<18
	if target.TimeToDie() < 18 Spell(blood_fury_apsp)
	#berserking,if=target.time_to_die<18
	if target.TimeToDie() < 18 Spell(berserking)
	#arcane_torrent,if=chi.max-chi>=1&target.time_to_die<18
	if MaxChi() - Chi() >= 1 and target.TimeToDie() < 18 Spell(arcane_torrent_chi)
	#potion,name=draenic_intellect,if=buff.bloodlust.react|target.time_to_die<=60
	if BuffPresent(burst_haste_buff any=1) or target.TimeToDie() <= 60 MistweaverUsePotionIntellect()
}

### actions.aoe

AddFunction MistweaverAoeMainActions
{
	#spinning_crane_kick,if=!talent.refreshing_jade_wind.enabled
	if not Talent(refreshing_jade_wind_talent) Spell(spinning_crane_kick)
	#refreshing_jade_wind
	Spell(refreshing_jade_wind)
	#blackout_kick
	Spell(blackout_kick)
	#tiger_palm,if=talent.rushing_jade_wind.enabled
	if Talent(rushing_jade_wind_talent) Spell(tiger_palm)
}

AddFunction MistweaverAoeShortCdActions
{
	unless not Talent(refreshing_jade_wind_talent) and Spell(spinning_crane_kick) or Spell(refreshing_jade_wind)
	{
		#chi_burst
		if CheckBoxOn(opt_chi_burst) Spell(chi_burst)
	}
}

AddFunction MistweaverAoeShortCdPostConditions
{
	not Talent(refreshing_jade_wind_talent) and Spell(spinning_crane_kick) or Spell(refreshing_jade_wind) or Spell(blackout_kick) or Talent(rushing_jade_wind_talent) and Spell(tiger_palm)
}

### actions.precombat
### actions.st

AddFunction MistweaverStMainActions
{
	#rising_sun_kick,if=buff.teachings_of_the_monastery.up
	if BuffPresent(teachings_of_the_monastery_buff) Spell(rising_sun_kick)
	#blackout_kick,if=buff.teachings_of_the_monastery.up
	if BuffPresent(teachings_of_the_monastery_buff) Spell(blackout_kick)
	#tiger_palm,if=buff.teachings_of_the_monastery.down
	if BuffExpires(teachings_of_the_monastery_buff) Spell(tiger_palm)
}

AddFunction MistweaverStShortCdActions
{
	unless BuffPresent(teachings_of_the_monastery_buff) and Spell(rising_sun_kick) or BuffPresent(teachings_of_the_monastery_buff) and Spell(blackout_kick)
	{
		#chi_burst
		if CheckBoxOn(opt_chi_burst) Spell(chi_burst)
	}
}

### Mistweaver icons.

AddCheckBox(opt_monk_mistweaver_aoe L(AOE) default specialization=mistweaver)

AddIcon checkbox=!opt_monk_mistweaver_aoe enemies=1 help=shortcd specialization=mistweaver
{
	MistweaverDefaultShortCdActions()
}

AddIcon checkbox=opt_monk_mistweaver_aoe help=shortcd specialization=mistweaver
{
	MistweaverDefaultShortCdActions()
}

AddIcon enemies=1 help=main specialization=mistweaver
{
	MistweaverDefaultMainActions()
}

AddIcon checkbox=opt_monk_mistweaver_aoe help=aoe specialization=mistweaver
{
	MistweaverDefaultMainActions()
}

AddIcon checkbox=!opt_monk_mistweaver_aoe enemies=1 help=cd specialization=mistweaver
{
	MistweaverDefaultCdActions()
}

AddIcon checkbox=opt_monk_mistweaver_aoe help=cd specialization=mistweaver
{
	MistweaverDefaultCdActions()
}

### Required symbols
# arcane_torrent_chi
# berserking
# blackout_kick
# blood_fury_apsp
# chi_burst
# draenic_intellect_potion
# invoke_xuen
# refreshing_jade_wind
# refreshing_jade_wind_talent
# rising_sun_kick
# rushing_jade_wind_talent
# spinning_crane_kick
# teachings_of_the_monastery_buff
# tiger_palm
]]
	OvaleScripts:RegisterScript("MONK", "mistweaver", name, desc, code, "script")
end

do
	local name = "simulationcraft_monk_windwalker_t18m"
	local desc = "[7.0] SimulationCraft: Monk_Windwalker_T18M"
	local code = [[
# Based on SimulationCraft profile "Monk_Windwalker_T18M".
#	class=monk
#	spec=windwalker
#	talents=3030032

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_monk_spells)

AddCheckBox(opt_melee_range L(not_in_melee_range) specialization=windwalker)
AddCheckBox(opt_potion_agility ItemName(draenic_agility_potion) default specialization=windwalker)
AddCheckBox(opt_legendary_ring_agility ItemName(legendary_ring_agility) default specialization=windwalker)
AddCheckBox(opt_chi_burst SpellName(chi_burst) default specialization=windwalker)
AddCheckBox(opt_storm_earth_and_fire SpellName(storm_earth_and_fire) specialization=windwalker)

AddFunction WindwalkerUsePotionAgility
{
	if CheckBoxOn(opt_potion_agility) and target.Classification(worldboss) Item(draenic_agility_potion usable=1)
}

AddFunction WindwalkerGetInMeleeRange
{
	if CheckBoxOn(opt_melee_range) and not target.InRange(tiger_palm) Texture(misc_arrowlup help=L(not_in_melee_range))
}

### actions.default

AddFunction WindwalkerDefaultMainActions
{
	#storm_earth_and_fire,if=artifact.strike_of_the_windlord.enabled&cooldown.strike_of_the_windlord.up&cooldown.fists_of_fury.remains<=9&cooldown.rising_sun_kick.remains<=5
	if BuffPresent(strike_of_the_windlord_buff) and not SpellCooldown(strike_of_the_windlord) > 0 and SpellCooldown(fists_of_fury) <= 9 and SpellCooldown(rising_sun_kick) <= 5 and CheckBoxOn(opt_storm_earth_and_fire) and Enemies() > 1 and { Enemies() < 3 and BuffStacks(storm_earth_and_fire_buff) < 1 or Enemies() >= 3 and BuffStacks(storm_earth_and_fire_buff) < 2 } Spell(storm_earth_and_fire)
	#storm_earth_and_fire,if=!artifact.strike_of_the_windlord.enabled&cooldown.fists_of_fury.remains<=9&cooldown.rising_sun_kick.remains<=5
	if not BuffPresent(strike_of_the_windlord_buff) and SpellCooldown(fists_of_fury) <= 9 and SpellCooldown(rising_sun_kick) <= 5 and CheckBoxOn(opt_storm_earth_and_fire) and Enemies() > 1 and { Enemies() < 3 and BuffStacks(storm_earth_and_fire_buff) < 1 or Enemies() >= 3 and BuffStacks(storm_earth_and_fire_buff) < 2 } Spell(storm_earth_and_fire)
	#rushing_jade_wind,if=buff.serenity.up&!prev_gcd.rushing_jade_wind
	if BuffPresent(serenity_buff) and not PreviousGCDSpell(rushing_jade_wind) Spell(rushing_jade_wind)
	#whirling_dragon_punch
	Spell(whirling_dragon_punch)
	#fists_of_fury
	Spell(fists_of_fury)
	#call_action_list,name=st,if=active_enemies<3
	if Enemies() < 3 WindwalkerStMainActions()
	#call_action_list,name=aoe,if=active_enemies>=3
	if Enemies() >= 3 WindwalkerAoeMainActions()
}

AddFunction WindwalkerDefaultShortCdActions
{
	#auto_attack
	WindwalkerGetInMeleeRange()
	#touch_of_death,if=!artifact.gale_burst.enabled
	if not BuffPresent(gale_burst_buff) Spell(touch_of_death)
	#touch_of_death,if=artifact.gale_burst.enabled&cooldown.strike_of_the_windlord.up&!talent.serenity.enabled&cooldown.fists_of_fury.remains<=9&cooldown.rising_sun_kick.remains<=5
	if BuffPresent(gale_burst_buff) and not SpellCooldown(strike_of_the_windlord) > 0 and not Talent(serenity_talent) and SpellCooldown(fists_of_fury) <= 9 and SpellCooldown(rising_sun_kick) <= 5 Spell(touch_of_death)
	#touch_of_death,if=artifact.gale_burst.enabled&cooldown.strike_of_the_windlord.up&talent.serenity.enabled&cooldown.fists_of_fury.remains<=3&cooldown.rising_sun_kick.remains<8
	if BuffPresent(gale_burst_buff) and not SpellCooldown(strike_of_the_windlord) > 0 and Talent(serenity_talent) and SpellCooldown(fists_of_fury) <= 3 and SpellCooldown(rising_sun_kick) < 8 Spell(touch_of_death)

	unless BuffPresent(strike_of_the_windlord_buff) and not SpellCooldown(strike_of_the_windlord) > 0 and SpellCooldown(fists_of_fury) <= 9 and SpellCooldown(rising_sun_kick) <= 5 and CheckBoxOn(opt_storm_earth_and_fire) and Enemies() > 1 and { Enemies() < 3 and BuffStacks(storm_earth_and_fire_buff) < 1 or Enemies() >= 3 and BuffStacks(storm_earth_and_fire_buff) < 2 } and Spell(storm_earth_and_fire) or not BuffPresent(strike_of_the_windlord_buff) and SpellCooldown(fists_of_fury) <= 9 and SpellCooldown(rising_sun_kick) <= 5 and CheckBoxOn(opt_storm_earth_and_fire) and Enemies() > 1 and { Enemies() < 3 and BuffStacks(storm_earth_and_fire_buff) < 1 or Enemies() >= 3 and BuffStacks(storm_earth_and_fire_buff) < 2 } and Spell(storm_earth_and_fire)
	{
		#serenity,if=artifact.strike_of_the_windlord.enabled&cooldown.strike_of_the_windlord.up&cooldown.fists_of_fury.remains<=3&cooldown.rising_sun_kick.remains<8
		if BuffPresent(strike_of_the_windlord_buff) and not SpellCooldown(strike_of_the_windlord) > 0 and SpellCooldown(fists_of_fury) <= 3 and SpellCooldown(rising_sun_kick) < 8 Spell(serenity)
		#serenity,if=!artifact.strike_of_the_windlord.enabled&cooldown.fists_of_fury.remains<=3&cooldown.rising_sun_kick.remains<8
		if not BuffPresent(strike_of_the_windlord_buff) and SpellCooldown(fists_of_fury) <= 3 and SpellCooldown(rising_sun_kick) < 8 Spell(serenity)
		#energizing_elixir,if=energy<energy.max&chi<=1&buff.serenity.down
		if Energy() < MaxEnergy() and Chi() <= 1 and BuffExpires(serenity_buff) Spell(energizing_elixir)

		unless BuffPresent(serenity_buff) and not PreviousGCDSpell(rushing_jade_wind) and Spell(rushing_jade_wind)
		{
			#strike_of_the_windlord,if=artifact.strike_of_the_windlord.enabled
			if BuffPresent(strike_of_the_windlord_buff) Spell(strike_of_the_windlord)

			unless Spell(whirling_dragon_punch) or Spell(fists_of_fury)
			{
				#call_action_list,name=st,if=active_enemies<3
				if Enemies() < 3 WindwalkerStShortCdActions()

				unless Enemies() < 3 and WindwalkerStShortCdPostConditions()
				{
					#call_action_list,name=aoe,if=active_enemies>=3
					if Enemies() >= 3 WindwalkerAoeShortCdActions()
				}
			}
		}
	}
}

AddFunction WindwalkerDefaultCdActions
{
	#invoke_xuen
	Spell(invoke_xuen)
	#potion,name=draenic_agility,if=buff.serenity.up|buff.storm_earth_and_fire.up|(!talent.serenity.enabled&trinket.proc.agility.react)|buff.bloodlust.react|target.time_to_die<=60
	if BuffPresent(serenity_buff) or BuffPresent(storm_earth_and_fire_buff) or not Talent(serenity_talent) and BuffPresent(trinket_proc_agility_buff) or BuffPresent(burst_haste_buff any=1) or target.TimeToDie() <= 60 WindwalkerUsePotionAgility()
	#use_item,name=maalus_the_blood_drinker
	if CheckBoxOn(opt_legendary_ring_agility) Item(legendary_ring_agility usable=1)
	#blood_fury
	Spell(blood_fury_apsp)
	#berserking
	Spell(berserking)
	#arcane_torrent,if=chi.max-chi>=1
	if MaxChi() - Chi() >= 1 Spell(arcane_torrent_chi)
}

### actions.aoe

AddFunction WindwalkerAoeMainActions
{
	#spinning_crane_kick,if=!prev_gcd.spinning_crane_kick
	if not PreviousGCDSpell(spinning_crane_kick) Spell(spinning_crane_kick)
	#rushing_jade_wind,if=chi>=2&!prev_gcd.rushing_jade_wind
	if Chi() >= 2 and not PreviousGCDSpell(rushing_jade_wind) Spell(rushing_jade_wind)
	#chi_wave,if=energy.time_to_max>2|buff.serenity.down
	if TimeToMaxEnergy() > 2 or BuffExpires(serenity_buff) Spell(chi_wave)
	#tiger_palm,if=(buff.serenity.down&chi<=2)&!prev_gcd.tiger_palm
	if BuffExpires(serenity_buff) and Chi() <= 2 and not PreviousGCDSpell(tiger_palm) Spell(tiger_palm)
}

AddFunction WindwalkerAoeShortCdActions
{
	unless not PreviousGCDSpell(spinning_crane_kick) and Spell(spinning_crane_kick)
	{
		#strike_of_the_windlord
		Spell(strike_of_the_windlord)

		unless Chi() >= 2 and not PreviousGCDSpell(rushing_jade_wind) and Spell(rushing_jade_wind) or { TimeToMaxEnergy() > 2 or BuffExpires(serenity_buff) } and Spell(chi_wave)
		{
			#chi_burst,if=energy.time_to_max>2|buff.serenity.down
			if { TimeToMaxEnergy() > 2 or BuffExpires(serenity_buff) } and CheckBoxOn(opt_chi_burst) Spell(chi_burst)
		}
	}
}

### actions.opener
### actions.precombat

AddFunction WindwalkerPrecombatCdActions
{
	#flask,type=greater_draenic_agility_flask
	#food,type=salty_squid_roll
	#snapshot_stats
	#potion,name=draenic_agility
	WindwalkerUsePotionAgility()
}

### actions.st

AddFunction WindwalkerStMainActions
{
	#rising_sun_kick
	Spell(rising_sun_kick)
	#rushing_jade_wind,if=chi>1&!prev_gcd.rushing_jade_wind
	if Chi() > 1 and not PreviousGCDSpell(rushing_jade_wind) Spell(rushing_jade_wind)
	#chi_wave,if=energy.time_to_max>2|buff.serenity.down
	if TimeToMaxEnergy() > 2 or BuffExpires(serenity_buff) Spell(chi_wave)
	#blackout_kick,if=(chi>1|buff.bok_proc.up)&buff.serenity.down&!prev_gcd.blackout_kick
	if { Chi() > 1 or BuffPresent(bok_proc_buff) } and BuffExpires(serenity_buff) and not PreviousGCDSpell(blackout_kick) Spell(blackout_kick)
	#tiger_palm,if=(buff.serenity.down&chi<=2)&!prev_gcd.tiger_palm
	if BuffExpires(serenity_buff) and Chi() <= 2 and not PreviousGCDSpell(tiger_palm) Spell(tiger_palm)
}

AddFunction WindwalkerStShortCdActions
{
	unless Spell(rising_sun_kick)
	{
		#strike_of_the_windlord
		Spell(strike_of_the_windlord)

		unless Chi() > 1 and not PreviousGCDSpell(rushing_jade_wind) and Spell(rushing_jade_wind) or { TimeToMaxEnergy() > 2 or BuffExpires(serenity_buff) } and Spell(chi_wave)
		{
			#chi_burst,if=energy.time_to_max>2|buff.serenity.down
			if { TimeToMaxEnergy() > 2 or BuffExpires(serenity_buff) } and CheckBoxOn(opt_chi_burst) Spell(chi_burst)
		}
	}
}

AddFunction WindwalkerStShortCdPostConditions
{
	Spell(rising_sun_kick) or Chi() > 1 and not PreviousGCDSpell(rushing_jade_wind) and Spell(rushing_jade_wind) or { TimeToMaxEnergy() > 2 or BuffExpires(serenity_buff) } and Spell(chi_wave) or { Chi() > 1 or BuffPresent(bok_proc_buff) } and BuffExpires(serenity_buff) and not PreviousGCDSpell(blackout_kick) and Spell(blackout_kick) or BuffExpires(serenity_buff) and Chi() <= 2 and not PreviousGCDSpell(tiger_palm) and Spell(tiger_palm)
}

### Windwalker icons.

AddCheckBox(opt_monk_windwalker_aoe L(AOE) default specialization=windwalker)

AddIcon checkbox=!opt_monk_windwalker_aoe enemies=1 help=shortcd specialization=windwalker
{
	WindwalkerDefaultShortCdActions()
}

AddIcon checkbox=opt_monk_windwalker_aoe help=shortcd specialization=windwalker
{
	WindwalkerDefaultShortCdActions()
}

AddIcon enemies=1 help=main specialization=windwalker
{
	WindwalkerDefaultMainActions()
}

AddIcon checkbox=opt_monk_windwalker_aoe help=aoe specialization=windwalker
{
	WindwalkerDefaultMainActions()
}

AddIcon checkbox=!opt_monk_windwalker_aoe enemies=1 help=cd specialization=windwalker
{
	if not InCombat() WindwalkerPrecombatCdActions()
	WindwalkerDefaultCdActions()
}

AddIcon checkbox=opt_monk_windwalker_aoe help=cd specialization=windwalker
{
	if not InCombat() WindwalkerPrecombatCdActions()
	WindwalkerDefaultCdActions()
}

### Required symbols
# arcane_torrent_chi
# berserking
# blackout_kick
# blood_fury_apsp
# bok_proc_buff
# chi_brew
# chi_burst
# chi_wave
# draenic_agility_potion
# energizing_elixir
# fists_of_fury
# gale_burst
# invoke_xuen
# legendary_ring_agility
# rising_sun_kick
# rushing_jade_wind
# serenity
# serenity_buff
# serenity_talent
# spinning_crane_kick
# storm_earth_and_fire
# storm_earth_and_fire_buff
# strike_of_the_windlord
# tiger_palm
# touch_of_death
# whirling_dragon_punch
]]
	OvaleScripts:RegisterScript("MONK", "windwalker", name, desc, code, "script")
end
