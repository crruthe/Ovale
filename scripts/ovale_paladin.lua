local OVALE, Ovale = ...
local OvaleScripts = Ovale.OvaleScripts

-- THE REST OF THIS FILE IS AUTOMATICALLY GENERATED.
-- ANY CHANGES MADE BELOW THIS POINT WILL BE LOST.

do
	local name = "simulationcraft_paladin_retribution_t18m"
	local desc = "[7.0] SimulationCraft: Paladin_Retribution_T18M"
	local code = [[
# Based on SimulationCraft profile "Paladin_Retribution_T18M".
#	class=paladin
#	spec=retribution
#	talents=1112112

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_paladin_spells)

AddCheckBox(opt_interrupt L(interrupt) default specialization=retribution)
AddCheckBox(opt_melee_range L(not_in_melee_range) specialization=retribution)
AddCheckBox(opt_potion_strength ItemName(draenic_strength_potion) default specialization=retribution)
AddCheckBox(opt_legendary_ring_strength ItemName(legendary_ring_strength) default specialization=retribution)

AddFunction RetributionUsePotionStrength
{
	if CheckBoxOn(opt_potion_strength) and target.Classification(worldboss) Item(draenic_strength_potion usable=1)
}

AddFunction RetributionGetInMeleeRange
{
	if CheckBoxOn(opt_melee_range) and not target.InRange(rebuke) Texture(misc_arrowlup help=L(not_in_melee_range))
}

AddFunction RetributionInterruptActions
{
	if CheckBoxOn(opt_interrupt) and not target.IsFriend() and target.IsInterruptible()
	{
		if target.InRange(rebuke) Spell(rebuke)
		if not target.Classification(worldboss)
		{
			if target.InRange(fist_of_justice) Spell(fist_of_justice)
			if target.InRange(hammer_of_justice) Spell(hammer_of_justice)
			Spell(blinding_light)
			Spell(arcane_torrent_holy)
			if target.InRange(quaking_palm) Spell(quaking_palm)
			Spell(war_stomp)
		}
	}
}

### actions.default

AddFunction RetributionDefaultMainActions
{
	#call_action_list,name=single
	RetributionSingleMainActions()
}

AddFunction RetributionDefaultShortCdActions
{
	#auto_attack
	RetributionGetInMeleeRange()
	#wake_of_ashes,if=holy_power>=0&time<2
	if HolyPower() >= 0 and TimeInCombat() < 2 Spell(wake_of_ashes)
	#call_action_list,name=single
	RetributionSingleShortCdActions()
}

AddFunction RetributionDefaultCdActions
{
	#rebuke
	RetributionInterruptActions()
	#potion,name=draenic_strength,if=(buff.bloodlust.react|buff.avenging_wrath.up|target.time_to_die<=40)
	if BuffPresent(burst_haste_buff any=1) or BuffPresent(avenging_wrath_melee_buff) or target.TimeToDie() <= 40 RetributionUsePotionStrength()
	#use_item,name=thorasus_the_stone_heart_of_draenor,if=buff.avenging_wrath.up
	if BuffPresent(avenging_wrath_melee_buff) and CheckBoxOn(opt_legendary_ring_strength) Item(legendary_ring_strength usable=1)
	#holy_wrath
	Spell(holy_wrath)
	#avenging_wrath
	Spell(avenging_wrath_melee)
	#crusade,if=holy_power>=5
	if HolyPower() >= 5 Spell(crusade)

	unless HolyPower() >= 0 and TimeInCombat() < 2 and Spell(wake_of_ashes)
	{
		#blood_fury
		Spell(blood_fury_apsp)
		#berserking
		Spell(berserking)
		#arcane_torrent
		Spell(arcane_torrent_holy)
	}
}

### actions.precombat

AddFunction RetributionPrecombatCdActions
{
	#flask,type=greater_draenic_strength_flask
	#food,type=sleeper_sushi
	#snapshot_stats
	#potion,name=draenic_strength
	RetributionUsePotionStrength()
}

### actions.single

AddFunction RetributionSingleMainActions
{
	#judgment
	Spell(judgment)
	#execution_sentence,if=spell_targets.divine_storm<=3&(cooldown.judgment.remains<gcd*4.5|debuff.judgment.remains>gcd*4.67)&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
	if Enemies() <= 3 and { SpellCooldown(judgment) < GCD() * 4.5 or target.DebuffRemaining(judgment_debuff) > GCD() * 4.67 } and BuffPresent(divine_purpose_buff) and BuffRemaining(divine_purpose_buff) < GCD() * 2 Spell(execution_sentence)
	#execution_sentence,if=spell_targets.divine_storm<=3&(cooldown.judgment.remains<gcd*4.5|debuff.judgment.remains>gcd*4.67)&buff.divine_purpose.react
	if Enemies() <= 3 and { SpellCooldown(judgment) < GCD() * 4.5 or target.DebuffRemaining(judgment_debuff) > GCD() * 4.67 } and BuffPresent(divine_purpose_buff) Spell(execution_sentence)
	#execution_sentence,if=spell_targets.divine_storm<=3&(cooldown.judgment.remains<gcd*4.5|debuff.judgment.remains>gcd*4.67)&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd)
	if Enemies() <= 3 and { SpellCooldown(judgment) < GCD() * 4.5 or target.DebuffRemaining(judgment_debuff) > GCD() * 4.67 } and BuffPresent(the_fires_of_justice_buff) and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() } Spell(execution_sentence)
	#execution_sentence,if=spell_targets.divine_storm<=3&(cooldown.judgment.remains<gcd*4.5|debuff.judgment.remains>gcd*4.67)&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*2)
	if Enemies() <= 3 and { SpellCooldown(judgment) < GCD() * 4.5 or target.DebuffRemaining(judgment_debuff) > GCD() * 4.67 } and HolyPower() >= 5 and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() * 2 } Spell(execution_sentence)
	#divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&debuff.judgment.remains<gcd&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
	if target.DebuffPresent(judgment_debuff) and Enemies() >= 2 and target.DebuffRemaining(judgment_debuff) < GCD() and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() * 3 } Spell(divine_storm)
	#divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
	if target.DebuffPresent(judgment_debuff) and Enemies() >= 2 and BuffPresent(divine_purpose_buff) and BuffRemaining(divine_purpose_buff) < GCD() * 2 Spell(divine_storm)
	#divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&buff.divine_purpose.react
	if target.DebuffPresent(judgment_debuff) and Enemies() >= 2 and HolyPower() >= 5 and BuffPresent(divine_purpose_buff) Spell(divine_storm)
	#divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd)
	if target.DebuffPresent(judgment_debuff) and Enemies() >= 2 and HolyPower() >= 5 and BuffPresent(the_fires_of_justice_buff) and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() } Spell(divine_storm)
	#divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*2)
	if target.DebuffPresent(judgment_debuff) and Enemies() >= 2 and HolyPower() >= 5 and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() * 2 } Spell(divine_storm)
	#divine_storm,if=spell_targets.divine_storm>=2&cooldown.wake_of_ashes.remains<gcd*2
	if Enemies() >= 2 and SpellCooldown(wake_of_ashes) < GCD() * 2 Spell(divine_storm)
	#justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.up&debuff.judgment.remains<gcd&!equipped.whisper_of_the_nathrezim
	if target.DebuffPresent(judgment_debuff) and BuffPresent(divine_purpose_buff) and target.DebuffRemaining(judgment_debuff) < GCD() and not HasEquippedItem(whisper_of_the_nathrezim) Spell(justicars_vengeance)
	#justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2&!equipped.whisper_of_the_nathrezim
	if target.DebuffPresent(judgment_debuff) and BuffPresent(divine_purpose_buff) and BuffRemaining(divine_purpose_buff) < GCD() * 2 and not HasEquippedItem(whisper_of_the_nathrezim) Spell(justicars_vengeance)
	#justicars_vengeance,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
	if target.DebuffPresent(judgment_debuff) and HolyPower() >= 5 and BuffPresent(divine_purpose_buff) and not HasEquippedItem(whisper_of_the_nathrezim) Spell(justicars_vengeance)
	#templars_verdict,if=debuff.judgment.up&debuff.judgment.remains<gcd&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
	if target.DebuffPresent(judgment_debuff) and target.DebuffRemaining(judgment_debuff) < GCD() and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() * 3 } Spell(templars_verdict)
	#templars_verdict,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
	if target.DebuffPresent(judgment_debuff) and BuffPresent(divine_purpose_buff) and BuffRemaining(divine_purpose_buff) < GCD() * 2 Spell(templars_verdict)
	#templars_verdict,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react
	if target.DebuffPresent(judgment_debuff) and HolyPower() >= 5 and BuffPresent(divine_purpose_buff) Spell(templars_verdict)
	#templars_verdict,if=debuff.judgment.up&holy_power>=5&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*2)
	if target.DebuffPresent(judgment_debuff) and HolyPower() >= 5 and BuffPresent(the_fires_of_justice_buff) and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() * 2 } Spell(templars_verdict)
	#templars_verdict,if=debuff.judgment.up&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*2)
	if target.DebuffPresent(judgment_debuff) and HolyPower() >= 5 and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() * 2 } Spell(templars_verdict)
	#execution_sentence,if=spell_targets.divine_storm<=3&cooldown.judgment.remains<gcd*4.5&cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled
	if Enemies() <= 3 and SpellCooldown(judgment) < GCD() * 4.5 and SpellCooldown(wake_of_ashes) < GCD() * 2 and BuffPresent(wake_of_ashes_buff) Spell(execution_sentence)
	#justicars_vengeance,if=holy_power>=3&buff.divine_purpose.up&cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled&!equipped.whisper_of_the_nathrezim
	if HolyPower() >= 3 and BuffPresent(divine_purpose_buff) and SpellCooldown(wake_of_ashes) < GCD() * 2 and BuffPresent(wake_of_ashes_buff) and not HasEquippedItem(whisper_of_the_nathrezim) Spell(justicars_vengeance)
	#divine_storm,if=holy_power>=3&spell_targets.divine_storm>=2&cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|spell_targets.divine_storm>=2&buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd
	if HolyPower() >= 3 and Enemies() >= 2 and SpellCooldown(wake_of_ashes) < GCD() * 2 and BuffPresent(wake_of_ashes_buff) or Enemies() >= 2 and BuffPresent(whisper_of_the_nathrezim_buff) and BuffRemaining(whisper_of_the_nathrezim_buff) < GCD() Spell(divine_storm)
	#templars_verdict,if=holy_power>=3&cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd
	if HolyPower() >= 3 and SpellCooldown(wake_of_ashes) < GCD() * 2 and BuffPresent(wake_of_ashes_buff) or BuffPresent(whisper_of_the_nathrezim_buff) and BuffRemaining(whisper_of_the_nathrezim_buff) < GCD() Spell(templars_verdict)
	#zeal,if=charges=2&holy_power<=4
	if Charges(zeal) == 2 and HolyPower() <= 4 Spell(zeal)
	#crusader_strike,if=charges=2&!talent.the_fires_of_justice.enabled
	if Charges(crusader_strike) == 2 and not Talent(the_fires_of_justice_talent) Spell(crusader_strike)
	#blade_of_justice,if=holy_power<=3
	if HolyPower() <= 3 Spell(blade_of_justice)
	#blade_of_wrath,if=holy_power<=3
	if HolyPower() <= 3 Spell(blade_of_wrath)
	#divine_hammer,if=holy_power<=3
	if HolyPower() <= 3 Spell(divine_hammer)
	#crusader_strike,if=charges=2&talent.the_fires_of_justice.enabled
	if Charges(crusader_strike) == 2 and Talent(the_fires_of_justice_talent) Spell(crusader_strike)
	#execution_sentence,if=spell_targets.divine_storm<=3&(cooldown.judgment.remains<gcd*4.5|debuff.judgment.remains>gcd*4.67)&buff.divine_purpose.react
	if Enemies() <= 3 and { SpellCooldown(judgment) < GCD() * 4.5 or target.DebuffRemaining(judgment_debuff) > GCD() * 4.67 } and BuffPresent(divine_purpose_buff) Spell(execution_sentence)
	#execution_sentence,if=spell_targets.divine_storm<=3&(cooldown.judgment.remains<gcd*4.5|debuff.judgment.remains>gcd*4.67)&buff.the_fires_of_justice.up&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*2)
	if Enemies() <= 3 and { SpellCooldown(judgment) < GCD() * 4.5 or target.DebuffRemaining(judgment_debuff) > GCD() * 4.67 } and BuffPresent(the_fires_of_justice_buff) and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() * 2 } Spell(execution_sentence)
	#execution_sentence,if=spell_targets.divine_storm<=3&(cooldown.judgment.remains<gcd*4.5|debuff.judgment.remains>gcd*4.67)&holy_power>=4&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
	if Enemies() <= 3 and { SpellCooldown(judgment) < GCD() * 4.5 or target.DebuffRemaining(judgment_debuff) > GCD() * 4.67 } and HolyPower() >= 4 and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() * 3 } Spell(execution_sentence)
	#divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.react
	if target.DebuffPresent(judgment_debuff) and Enemies() >= 2 and BuffPresent(divine_purpose_buff) Spell(divine_storm)
	#divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.the_fires_of_justice.up&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*2)
	if target.DebuffPresent(judgment_debuff) and Enemies() >= 2 and BuffPresent(the_fires_of_justice_buff) and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() * 2 } Spell(divine_storm)
	#divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=4&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
	if target.DebuffPresent(judgment_debuff) and Enemies() >= 2 and HolyPower() >= 4 and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() * 3 } Spell(divine_storm)
	#justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
	if target.DebuffPresent(judgment_debuff) and BuffPresent(divine_purpose_buff) and not HasEquippedItem(whisper_of_the_nathrezim) Spell(justicars_vengeance)
	#templars_verdict,if=debuff.judgment.up&buff.divine_purpose.react
	if target.DebuffPresent(judgment_debuff) and BuffPresent(divine_purpose_buff) Spell(templars_verdict)
	#templars_verdict,if=debuff.judgment.up&buff.the_fires_of_justice.up&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*2)
	if target.DebuffPresent(judgment_debuff) and BuffPresent(the_fires_of_justice_buff) and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() * 2 } Spell(templars_verdict)
	#templars_verdict,if=debuff.judgment.up&holy_power>=4&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
	if target.DebuffPresent(judgment_debuff) and HolyPower() >= 4 and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() * 3 } Spell(templars_verdict)
	#zeal,if=holy_power<=4
	if HolyPower() <= 4 Spell(zeal)
	#crusader_strike,if=holy_power<=4
	if HolyPower() <= 4 Spell(crusader_strike)
	#execution_sentence,if=spell_targets.divine_storm<=3&(cooldown.judgment.remains<gcd*4.5|debuff.judgment.remains>gcd*4.67)&holy_power>=3&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
	if Enemies() <= 3 and { SpellCooldown(judgment) < GCD() * 4.5 or target.DebuffRemaining(judgment_debuff) > GCD() * 4.67 } and HolyPower() >= 3 and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() * 4 } Spell(execution_sentence)
	#divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
	if target.DebuffPresent(judgment_debuff) and Enemies() >= 2 and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() * 4 } Spell(divine_storm)
	#templars_verdict,if=debuff.judgment.up&holy_power>=3&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
	if target.DebuffPresent(judgment_debuff) and HolyPower() >= 3 and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() * 4 } Spell(templars_verdict)
}

AddFunction RetributionSingleShortCdActions
{
	unless Spell(judgment) or Enemies() <= 3 and { SpellCooldown(judgment) < GCD() * 4.5 or target.DebuffRemaining(judgment_debuff) > GCD() * 4.67 } and BuffPresent(divine_purpose_buff) and BuffRemaining(divine_purpose_buff) < GCD() * 2 and Spell(execution_sentence) or Enemies() <= 3 and { SpellCooldown(judgment) < GCD() * 4.5 or target.DebuffRemaining(judgment_debuff) > GCD() * 4.67 } and BuffPresent(divine_purpose_buff) and Spell(execution_sentence) or Enemies() <= 3 and { SpellCooldown(judgment) < GCD() * 4.5 or target.DebuffRemaining(judgment_debuff) > GCD() * 4.67 } and BuffPresent(the_fires_of_justice_buff) and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() } and Spell(execution_sentence) or Enemies() <= 3 and { SpellCooldown(judgment) < GCD() * 4.5 or target.DebuffRemaining(judgment_debuff) > GCD() * 4.67 } and HolyPower() >= 5 and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() * 2 } and Spell(execution_sentence) or target.DebuffPresent(judgment_debuff) and Enemies() >= 2 and target.DebuffRemaining(judgment_debuff) < GCD() and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() * 3 } and Spell(divine_storm) or target.DebuffPresent(judgment_debuff) and Enemies() >= 2 and BuffPresent(divine_purpose_buff) and BuffRemaining(divine_purpose_buff) < GCD() * 2 and Spell(divine_storm) or target.DebuffPresent(judgment_debuff) and Enemies() >= 2 and HolyPower() >= 5 and BuffPresent(divine_purpose_buff) and Spell(divine_storm) or target.DebuffPresent(judgment_debuff) and Enemies() >= 2 and HolyPower() >= 5 and BuffPresent(the_fires_of_justice_buff) and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() } and Spell(divine_storm) or target.DebuffPresent(judgment_debuff) and Enemies() >= 2 and HolyPower() >= 5 and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() * 2 } and Spell(divine_storm) or Enemies() >= 2 and SpellCooldown(wake_of_ashes) < GCD() * 2 and Spell(divine_storm) or target.DebuffPresent(judgment_debuff) and BuffPresent(divine_purpose_buff) and target.DebuffRemaining(judgment_debuff) < GCD() and not HasEquippedItem(whisper_of_the_nathrezim) and Spell(justicars_vengeance) or target.DebuffPresent(judgment_debuff) and BuffPresent(divine_purpose_buff) and BuffRemaining(divine_purpose_buff) < GCD() * 2 and not HasEquippedItem(whisper_of_the_nathrezim) and Spell(justicars_vengeance) or target.DebuffPresent(judgment_debuff) and HolyPower() >= 5 and BuffPresent(divine_purpose_buff) and not HasEquippedItem(whisper_of_the_nathrezim) and Spell(justicars_vengeance) or target.DebuffPresent(judgment_debuff) and target.DebuffRemaining(judgment_debuff) < GCD() and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() * 3 } and Spell(templars_verdict) or target.DebuffPresent(judgment_debuff) and BuffPresent(divine_purpose_buff) and BuffRemaining(divine_purpose_buff) < GCD() * 2 and Spell(templars_verdict) or target.DebuffPresent(judgment_debuff) and HolyPower() >= 5 and BuffPresent(divine_purpose_buff) and Spell(templars_verdict) or target.DebuffPresent(judgment_debuff) and HolyPower() >= 5 and BuffPresent(the_fires_of_justice_buff) and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() * 2 } and Spell(templars_verdict) or target.DebuffPresent(judgment_debuff) and HolyPower() >= 5 and { not Talent(crusade_talent) or SpellCooldown(crusade) > GCD() * 2 } and Spell(templars_verdict) or Enemies() <= 3 and SpellCooldown(judgment) < GCD() * 4.5 and SpellCooldown(wake_of_ashes) < GCD() * 2 and BuffPresent(wake_of_ashes_buff) and Spell(execution_sentence) or HolyPower() >= 3 and BuffPresent(divine_purpose_buff) and SpellCooldown(wake_of_ashes) < GCD() * 2 and BuffPresent(wake_of_ashes_buff) and not HasEquippedItem(whisper_of_the_nathrezim) and Spell(justicars_vengeance) or { HolyPower() >= 3 and Enemies() >= 2 and SpellCooldown(wake_of_ashes) < GCD() * 2 and BuffPresent(wake_of_ashes_buff) or Enemies() >= 2 and BuffPresent(whisper_of_the_nathrezim_buff) and BuffRemaining(whisper_of_the_nathrezim_buff) < GCD() } and Spell(divine_storm) or { HolyPower() >= 3 and SpellCooldown(wake_of_ashes) < GCD() * 2 and BuffPresent(wake_of_ashes_buff) or BuffPresent(whisper_of_the_nathrezim_buff) and BuffRemaining(whisper_of_the_nathrezim_buff) < GCD() } and Spell(templars_verdict)
	{
		#wake_of_ashes,if=cooldown.judgment.remains>gcd*2
		if SpellCooldown(judgment) > GCD() * 2 Spell(wake_of_ashes)

		unless Charges(zeal) == 2 and HolyPower() <= 4 and Spell(zeal) or Charges(crusader_strike) == 2 and not Talent(the_fires_of_justice_talent) and Spell(crusader_strike) or HolyPower() <= 3 and Spell(blade_of_justice) or HolyPower() <= 3 and Spell(blade_of_wrath) or HolyPower() <= 3 and Spell(divine_hammer) or Charges(crusader_strike) == 2 and Talent(the_fires_of_justice_talent) and Spell(crusader_strike)
		{
			#consecration
			Spell(consecration)
		}
	}
}

### Retribution icons.

AddCheckBox(opt_paladin_retribution_aoe L(AOE) default specialization=retribution)

AddIcon checkbox=!opt_paladin_retribution_aoe enemies=1 help=shortcd specialization=retribution
{
	RetributionDefaultShortCdActions()
}

AddIcon checkbox=opt_paladin_retribution_aoe help=shortcd specialization=retribution
{
	RetributionDefaultShortCdActions()
}

AddIcon enemies=1 help=main specialization=retribution
{
	RetributionDefaultMainActions()
}

AddIcon checkbox=opt_paladin_retribution_aoe help=aoe specialization=retribution
{
	RetributionDefaultMainActions()
}

AddIcon checkbox=!opt_paladin_retribution_aoe enemies=1 help=cd specialization=retribution
{
	if not InCombat() RetributionPrecombatCdActions()
	RetributionDefaultCdActions()
}

AddIcon checkbox=opt_paladin_retribution_aoe help=cd specialization=retribution
{
	if not InCombat() RetributionPrecombatCdActions()
	RetributionDefaultCdActions()
}

### Required symbols
# arcane_torrent_holy
# avenging_wrath_melee
# avenging_wrath_melee_buff
# berserking
# blade_of_justice
# blade_of_wrath
# blinding_light
# blood_fury_apsp
# consecration
# crusade
# crusade_talent
# crusader_strike
# divine_hammer
# divine_purpose_buff
# divine_storm
# draenic_strength_potion
# execution_sentence
# fist_of_justice
# hammer_of_justice
# holy_wrath
# judgment
# judgment_debuff
# justicars_vengeance
# legendary_ring_strength
# quaking_palm
# rebuke
# templars_verdict
# the_fires_of_justice_buff
# the_fires_of_justice_talent
# wake_of_ashes
# war_stomp
# whisper_of_the_nathrezim
# whisper_of_the_nathrezim_buff
# zeal
]]
	OvaleScripts:RegisterScript("PALADIN", "retribution", name, desc, code, "script")
end
