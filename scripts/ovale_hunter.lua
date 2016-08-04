local OVALE, Ovale = ...
local OvaleScripts = Ovale.OvaleScripts

-- THE REST OF THIS FILE IS AUTOMATICALLY GENERATED.
-- ANY CHANGES MADE BELOW THIS POINT WILL BE LOST.

do
	local name = "simulationcraft_hunter_bm_t18m"
	local desc = "[7.0] SimulationCraft: Hunter_BM_T18M"
	local code = [[
# Based on SimulationCraft profile "Hunter_BM_T18M".
#	class=hunter
#	spec=beast_mastery
#	talents=3102012

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_hunter_spells)

AddCheckBox(opt_potion_agility ItemName(draenic_agility_potion) default specialization=beast_mastery)
AddCheckBox(opt_legendary_ring_agility ItemName(legendary_ring_agility) default specialization=beast_mastery)

AddFunction BeastMasteryUsePotionAgility
{
	if CheckBoxOn(opt_potion_agility) and target.Classification(worldboss) Item(draenic_agility_potion usable=1)
}

AddFunction BeastMasterySummonPet
{
	if pet.IsDead()
	{
		if not DebuffPresent(heart_of_the_phoenix_debuff) Spell(heart_of_the_phoenix)
		Spell(revive_pet)
	}
	if not pet.Present() and not pet.IsDead() and not PreviousSpell(revive_pet) Texture(ability_hunter_beastcall help=L(summon_pet))
}

### actions.default

AddFunction BeastMasteryDefaultMainActions
{
	#dire_frenzy,if=cooldown.bestial_wrath.remains>2
	if SpellCooldown(bestial_wrath) > 2 Spell(dire_frenzy)
	#barrage,if=spell_targets.barrage>1|(spell_targets.barrage=1&focus>90)
	if Enemies() > 1 or Enemies() == 1 and Focus() > 90 Spell(barrage)
	#multishot,if=spell_targets.multi_shot>=3&pet.buff.beast_cleave.down
	if Enemies() >= 3 and pet.BuffExpires(pet_beast_cleave_buff) Spell(multishot)
	#kill_command
	if pet.Present() and not pet.IsIncapacitated() and not pet.IsFeared() and not pet.IsStunned() Spell(kill_command)
	#chimaera_shot,if=focus<90
	if Focus() < 90 Spell(chimaera_shot)
	#cobra_shot,if=talent.killer_cobra.enabled&(cooldown.bestial_wrath.remains>=4&(buff.bestial_wrath.up&cooldown.kill_command.remains>=2)|focus>119)|!talent.killer_cobra.enabled&focus>90
	if Talent(killer_cobra_talent) and { SpellCooldown(bestial_wrath) >= 4 and BuffPresent(bestial_wrath_buff) and SpellCooldown(kill_command) >= 2 or Focus() > 119 } or not Talent(killer_cobra_talent) and Focus() > 90 Spell(cobra_shot)
}

AddFunction BeastMasteryDefaultShortCdActions
{
	#a_murder_of_crows
	Spell(a_murder_of_crows)
	#dire_beast,if=cooldown.bestial_wrath.remains>2
	if SpellCooldown(bestial_wrath) > 2 Spell(dire_beast)

	unless SpellCooldown(bestial_wrath) > 2 and Spell(dire_frenzy) or { Enemies() > 1 or Enemies() == 1 and Focus() > 90 } and Spell(barrage)
	{
		#titans_thunder,if=cooldown.dire_beast.remains>=3|talent.dire_frenzy.enabled
		if SpellCooldown(dire_beast) >= 3 or Talent(dire_frenzy_talent) Spell(titans_thunder)
		#bestial_wrath
		Spell(bestial_wrath)
	}
}

AddFunction BeastMasteryDefaultCdActions
{
	#auto_shot
	#use_item,name=maalus_the_blood_drinker
	if CheckBoxOn(opt_legendary_ring_agility) Item(legendary_ring_agility usable=1)
	#arcane_torrent,if=focus.deficit>=30
	if FocusDeficit() >= 30 Spell(arcane_torrent_focus)
	#blood_fury
	Spell(blood_fury_ap)
	#berserking
	Spell(berserking)

	unless Spell(a_murder_of_crows)
	{
		#stampede,if=(buff.bloodlust.up)|target.time_to_die<=15
		if BuffPresent(burst_haste_buff any=1) or target.TimeToDie() <= 15 Spell(stampede)

		unless SpellCooldown(bestial_wrath) > 2 and Spell(dire_beast) or SpellCooldown(bestial_wrath) > 2 and Spell(dire_frenzy)
		{
			#aspect_of_the_wild,if=buff.bestial_wrath.up
			if BuffPresent(bestial_wrath_buff) Spell(aspect_of_the_wild)
		}
	}
}

### actions.precombat

AddFunction BeastMasteryPrecombatShortCdActions
{
	#flask,type=greater_draenic_agility_flask
	#food,type=salty_squid_roll
	#summon_pet
	BeastMasterySummonPet()
}

AddFunction BeastMasteryPrecombatCdActions
{
	#snapshot_stats
	#potion,name=draenic_agility
	BeastMasteryUsePotionAgility()
}

### BeastMastery icons.

AddCheckBox(opt_hunter_beast_mastery_aoe L(AOE) default specialization=beast_mastery)

AddIcon checkbox=!opt_hunter_beast_mastery_aoe enemies=1 help=shortcd specialization=beast_mastery
{
	if not InCombat() BeastMasteryPrecombatShortCdActions()
	BeastMasteryDefaultShortCdActions()
}

AddIcon checkbox=opt_hunter_beast_mastery_aoe help=shortcd specialization=beast_mastery
{
	if not InCombat() BeastMasteryPrecombatShortCdActions()
	BeastMasteryDefaultShortCdActions()
}

AddIcon enemies=1 help=main specialization=beast_mastery
{
	BeastMasteryDefaultMainActions()
}

AddIcon checkbox=opt_hunter_beast_mastery_aoe help=aoe specialization=beast_mastery
{
	BeastMasteryDefaultMainActions()
}

AddIcon checkbox=!opt_hunter_beast_mastery_aoe enemies=1 help=cd specialization=beast_mastery
{
	if not InCombat() BeastMasteryPrecombatCdActions()
	BeastMasteryDefaultCdActions()
}

AddIcon checkbox=opt_hunter_beast_mastery_aoe help=cd specialization=beast_mastery
{
	if not InCombat() BeastMasteryPrecombatCdActions()
	BeastMasteryDefaultCdActions()
}

### Required symbols
# a_murder_of_crows
# arcane_torrent_focus
# aspect_of_the_wild
# barrage
# berserking
# bestial_wrath
# bestial_wrath_buff
# blood_fury_ap
# chimaera_shot
# cobra_shot
# dire_beast
# dire_frenzy
# dire_frenzy_talent
# draenic_agility_potion
# kill_command
# killer_cobra_talent
# legendary_ring_agility
# multishot
# pet_beast_cleave_buff
# revive_pet
# stampede
# titans_thunder
]]
	OvaleScripts:RegisterScript("HUNTER", "beast_mastery", name, desc, code, "script")
end

do
	local name = "simulationcraft_hunter_mm_t18m"
	local desc = "[7.0] SimulationCraft: Hunter_MM_T18M"
	local code = [[
# Based on SimulationCraft profile "Hunter_MM_T18M".
#	class=hunter
#	spec=marksmanship
#	talents=1103021

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_hunter_spells)

AddCheckBox(opt_potion_agility ItemName(draenic_agility_potion) default specialization=marksmanship)
AddCheckBox(opt_legendary_ring_agility ItemName(legendary_ring_agility) default specialization=marksmanship)

AddFunction MarksmanshipUsePotionAgility
{
	if CheckBoxOn(opt_potion_agility) and target.Classification(worldboss) Item(draenic_agility_potion usable=1)
}

AddFunction MarksmanshipSummonPet
{
	if not Talent(lone_wolf_talent)
	{
		if pet.IsDead()
		{
			if not DebuffPresent(heart_of_the_phoenix_debuff) Spell(heart_of_the_phoenix)
			Spell(revive_pet)
		}
		if not pet.Present() and not pet.IsDead() and not PreviousSpell(revive_pet) Texture(ability_hunter_beastcall help=L(summon_pet))
	}
}

### actions.default

AddFunction MarksmanshipDefaultMainActions
{
	#marked_shot,if=!talent.sidewinders.enabled&prev_gcd.sentinel&debuff.hunters_mark.up
	if not Talent(sidewinders_talent) and PreviousGCDSpell(sentinel) and target.DebuffPresent(hunters_mark_debuff) Spell(marked_shot)
	#call_action_list,name=careful_aim,if=(talent.careful_aim.enabled&target.health.pct>80)&spell_targets.barrage=1
	if Talent(careful_aim_talent) and target.HealthPercent() > 80 and Enemies() == 1 MarksmanshipCarefulAimMainActions()
	#barrage
	Spell(barrage)
	#windburst
	Spell(windburst)
	#call_action_list,name=patientless,if=!talent.patient_sniper.enabled
	if not Talent(patient_sniper_talent) MarksmanshipPatientlessMainActions()
	#arcane_shot,if=(talent.steady_focus.enabled&buff.steady_focus.down&focus.time_to_max>=2)|(talent.true_aim.enabled&(debuff.true_aim.stack<1&focus.time_to_max>=2|debuff.true_aim.remains<2))
	if Talent(steady_focus_talent) and BuffExpires(steady_focus_buff) and TimeToMaxFocus() >= 2 or Talent(true_aim_talent) and { target.DebuffStacks(true_aim_debuff) < 1 and TimeToMaxFocus() >= 2 or target.DebuffRemaining(true_aim_debuff) < 2 } Spell(arcane_shot)
	#multishot,if=(talent.steady_focus.enabled&buff.steady_focus.down&focus.time_to_max>=2&spell_targets.multishot>1)
	if Talent(steady_focus_talent) and BuffExpires(steady_focus_buff) and TimeToMaxFocus() >= 2 and Enemies() > 1 Spell(multishot)
	#sidewinders,if=spell_targets.sidewinders>1&(!debuff.hunters_mark.up&(buff.marking_targets.up|buff.trueshot.up|charges=2|focus<80&(charges<=1&recharge_time<=5)))
	if Enemies() > 1 and not target.DebuffPresent(hunters_mark_debuff) and { BuffPresent(marking_targets_buff) or BuffPresent(trueshot_buff) or Charges(sidewinders) == 2 or Focus() < 80 and Charges(sidewinders) <= 1 and SpellChargeCooldown(sidewinders) <= 5 } Spell(sidewinders)
	#explosive_shot
	Spell(explosive_shot)
	#marked_shot,if=talent.sidewinders.enabled&(!talent.patient_sniper.enabled|debuff.vulnerability.remains<2)|!talent.sidewinders.enabled
	if Talent(sidewinders_talent) and { not Talent(patient_sniper_talent) or target.DebuffRemaining(vulnerability_debuff) < 2 } or not Talent(sidewinders_talent) Spell(marked_shot)
	#aimed_shot,if=cast_time<debuff.vulnerability.remains&(focus+cast_regen>80|debuff.hunters_mark.down)
	if CastTime(aimed_shot) < target.DebuffRemaining(vulnerability_debuff) and { Focus() + FocusCastingRegen(aimed_shot) > 80 or target.DebuffExpires(hunters_mark_debuff) } Spell(aimed_shot)
	#black_arrow
	Spell(black_arrow)
	#multishot,if=spell_targets.multishot>1&(!debuff.hunters_mark.up&buff.marking_targets.up&cast_regen+action.aimed_shot.cast_regen<=focus.deficit)
	if Enemies() > 1 and not target.DebuffPresent(hunters_mark_debuff) and BuffPresent(marking_targets_buff) and FocusCastingRegen(multishot) + FocusCastingRegen(aimed_shot) <= FocusDeficit() Spell(multishot)
	#arcane_shot,if=(!debuff.hunters_mark.up&buff.marking_targets.up)|focus.time_to_max>=2
	if not target.DebuffPresent(hunters_mark_debuff) and BuffPresent(marking_targets_buff) or TimeToMaxFocus() >= 2 Spell(arcane_shot)
	#sidewinders,if=!debuff.hunters_mark.up&(buff.marking_targets.up|buff.trueshot.up|charges=2|focus<80&(charges<=1&recharge_time<=5))
	if not target.DebuffPresent(hunters_mark_debuff) and { BuffPresent(marking_targets_buff) or BuffPresent(trueshot_buff) or Charges(sidewinders) == 2 or Focus() < 80 and Charges(sidewinders) <= 1 and SpellChargeCooldown(sidewinders) <= 5 } Spell(sidewinders)
}

AddFunction MarksmanshipDefaultShortCdActions
{
	unless not Talent(sidewinders_talent) and PreviousGCDSpell(sentinel) and target.DebuffPresent(hunters_mark_debuff) and Spell(marked_shot)
	{
		unless Talent(careful_aim_talent) and target.HealthPercent() > 80 and Enemies() == 1 and MarksmanshipCarefulAimShortCdPostConditions()
		{
			#a_murder_of_crows
			Spell(a_murder_of_crows)

			unless Spell(barrage)
			{
				#piercing_shot,if=!talent.patient_sniper.enabled&focus>50
				if not Talent(patient_sniper_talent) and Focus() > 50 Spell(piercing_shot)

				unless Spell(windburst)
				{
					#call_action_list,name=patientless,if=!talent.patient_sniper.enabled
					if not Talent(patient_sniper_talent) MarksmanshipPatientlessShortCdActions()

					unless not Talent(patient_sniper_talent) and MarksmanshipPatientlessShortCdPostConditions() or { Talent(steady_focus_talent) and BuffExpires(steady_focus_buff) and TimeToMaxFocus() >= 2 or Talent(true_aim_talent) and { target.DebuffStacks(true_aim_debuff) < 1 and TimeToMaxFocus() >= 2 or target.DebuffRemaining(true_aim_debuff) < 2 } } and Spell(arcane_shot) or Talent(steady_focus_talent) and BuffExpires(steady_focus_buff) and TimeToMaxFocus() >= 2 and Enemies() > 1 and Spell(multishot) or Enemies() > 1 and not target.DebuffPresent(hunters_mark_debuff) and { BuffPresent(marking_targets_buff) or BuffPresent(trueshot_buff) or Charges(sidewinders) == 2 or Focus() < 80 and Charges(sidewinders) <= 1 and SpellChargeCooldown(sidewinders) <= 5 } and Spell(sidewinders) or Spell(explosive_shot)
					{
						#piercing_shot,if=talent.patient_sniper.enabled&focus>80
						if Talent(patient_sniper_talent) and Focus() > 80 Spell(piercing_shot)
					}
				}
			}
		}
	}
}

AddFunction MarksmanshipDefaultCdActions
{
	#auto_shot
	#use_item,name=maalus_the_blood_drinker
	if CheckBoxOn(opt_legendary_ring_agility) Item(legendary_ring_agility usable=1)
	#arcane_torrent,if=focus.deficit>=30
	if FocusDeficit() >= 30 Spell(arcane_torrent_focus)
	#blood_fury
	Spell(blood_fury_ap)
	#berserking
	Spell(berserking)
	#trueshot,if=(target.time_to_die>195|target.health.pct<5)|buff.bullseye.stack>15
	if target.TimeToDie() > 195 or target.HealthPercent() < 5 or BuffStacks(bullseye_buff) > 15 Spell(trueshot)
}

### actions.careful_aim

AddFunction MarksmanshipCarefulAimMainActions
{
	#windburst
	Spell(windburst)
	#arcane_shot,if=(talent.steady_focus.enabled&buff.steady_focus.down&spell_targets.arcane_shot=1)|(talent.true_aim.enabled&(debuff.true_aim.stack<1&focus.time_to_max>=2|debuff.true_aim.remains<2))
	if Talent(steady_focus_talent) and BuffExpires(steady_focus_buff) and Enemies() == 1 or Talent(true_aim_talent) and { target.DebuffStacks(true_aim_debuff) < 1 and TimeToMaxFocus() >= 2 or target.DebuffRemaining(true_aim_debuff) < 2 } Spell(arcane_shot)
	#marked_shot,if=talent.sidewinders.enabled&(!talent.patient_sniper.enabled|debuff.vulnerability.remains<2)|!talent.sidewinders.enabled
	if Talent(sidewinders_talent) and { not Talent(patient_sniper_talent) or target.DebuffRemaining(vulnerability_debuff) < 2 } or not Talent(sidewinders_talent) Spell(marked_shot)
	#aimed_shot,if=debuff.hunters_mark.down&cast_time<debuff.vulnerability.remains
	if target.DebuffExpires(hunters_mark_debuff) and CastTime(aimed_shot) < target.DebuffRemaining(vulnerability_debuff) Spell(aimed_shot)
	#multishot,if=spell_targets.multishot>1&(buff.marking_targets.up|focus.time_to_max>=2)
	if Enemies() > 1 and { BuffPresent(marking_targets_buff) or TimeToMaxFocus() >= 2 } Spell(multishot)
	#arcane_shot,if=spell_targets.arcane_shot=1&(buff.marking_targets.up|focus.time_to_max>=2)
	if Enemies() == 1 and { BuffPresent(marking_targets_buff) or TimeToMaxFocus() >= 2 } Spell(arcane_shot)
	#sidewinders,if=!debuff.hunters_mark.up&(buff.marking_targets.up|buff.trueshot.up|charges=2|focus<80&(charges<=1&recharge_time<=5))
	if not target.DebuffPresent(hunters_mark_debuff) and { BuffPresent(marking_targets_buff) or BuffPresent(trueshot_buff) or Charges(sidewinders) == 2 or Focus() < 80 and Charges(sidewinders) <= 1 and SpellChargeCooldown(sidewinders) <= 5 } Spell(sidewinders)
}

AddFunction MarksmanshipCarefulAimShortCdPostConditions
{
	Spell(windburst) or { Talent(steady_focus_talent) and BuffExpires(steady_focus_buff) and Enemies() == 1 or Talent(true_aim_talent) and { target.DebuffStacks(true_aim_debuff) < 1 and TimeToMaxFocus() >= 2 or target.DebuffRemaining(true_aim_debuff) < 2 } } and Spell(arcane_shot) or { Talent(sidewinders_talent) and { not Talent(patient_sniper_talent) or target.DebuffRemaining(vulnerability_debuff) < 2 } or not Talent(sidewinders_talent) } and Spell(marked_shot) or target.DebuffExpires(hunters_mark_debuff) and CastTime(aimed_shot) < target.DebuffRemaining(vulnerability_debuff) and Spell(aimed_shot) or Enemies() > 1 and { BuffPresent(marking_targets_buff) or TimeToMaxFocus() >= 2 } and Spell(multishot) or Enemies() == 1 and { BuffPresent(marking_targets_buff) or TimeToMaxFocus() >= 2 } and Spell(arcane_shot) or not target.DebuffPresent(hunters_mark_debuff) and { BuffPresent(marking_targets_buff) or BuffPresent(trueshot_buff) or Charges(sidewinders) == 2 or Focus() < 80 and Charges(sidewinders) <= 1 and SpellChargeCooldown(sidewinders) <= 5 } and Spell(sidewinders)
}

### actions.patientless

AddFunction MarksmanshipPatientlessMainActions
{
	#arcane_shot,if=debuff.vulnerability.stack<3&buff.marking_targets.up&debuff.hunters_mark.down&spell_targets.arcane_shot=1
	if target.DebuffStacks(vulnerability_debuff) < 3 and BuffPresent(marking_targets_buff) and target.DebuffExpires(hunters_mark_debuff) and Enemies() == 1 Spell(arcane_shot)
	#marked_shot,if=debuff.vulnerability.stack<3|debuff.hunters_mark.remains<5|(focus<50|focus>80)
	if target.DebuffStacks(vulnerability_debuff) < 3 or target.DebuffRemaining(hunters_mark_debuff) < 5 or Focus() < 50 or Focus() > 80 Spell(marked_shot)
	#explosive_shot
	Spell(explosive_shot)
	#aimed_shot,if=debuff.hunters_mark.down&cast_time<debuff.vulnerability.remains
	if target.DebuffExpires(hunters_mark_debuff) and CastTime(aimed_shot) < target.DebuffRemaining(vulnerability_debuff) Spell(aimed_shot)
	#marked_shot,if=debuff.hunters_mark.remains>5
	if target.DebuffRemaining(hunters_mark_debuff) > 5 Spell(marked_shot)
	#black_arrow
	Spell(black_arrow)
	#multishot,if=spell_targets.multishot>1&(cast_regen+action.aimed_shot.cast_regen<=focus.deficit)
	if Enemies() > 1 and FocusCastingRegen(multishot) + FocusCastingRegen(aimed_shot) <= FocusDeficit() Spell(multishot)
	#arcane_shot,if=cast_regen+action.aimed_shot.cast_regen<=focus.deficit&spell_targets.arcane_shot=1
	if FocusCastingRegen(arcane_shot) + FocusCastingRegen(aimed_shot) <= FocusDeficit() and Enemies() == 1 Spell(arcane_shot)
}

AddFunction MarksmanshipPatientlessShortCdActions
{
	unless target.DebuffStacks(vulnerability_debuff) < 3 and BuffPresent(marking_targets_buff) and target.DebuffExpires(hunters_mark_debuff) and Enemies() == 1 and Spell(arcane_shot) or { target.DebuffStacks(vulnerability_debuff) < 3 or target.DebuffRemaining(hunters_mark_debuff) < 5 or Focus() < 50 or Focus() > 80 } and Spell(marked_shot)
	{
		#sentinel,if=!talent.sidewinders.enabled&debuff.hunters_mark.down&spell_targets.sentinel>1
		if not Talent(sidewinders_talent) and target.DebuffExpires(hunters_mark_debuff) and Enemies() > 1 Spell(sentinel)
	}
}

AddFunction MarksmanshipPatientlessShortCdPostConditions
{
	target.DebuffStacks(vulnerability_debuff) < 3 and BuffPresent(marking_targets_buff) and target.DebuffExpires(hunters_mark_debuff) and Enemies() == 1 and Spell(arcane_shot) or { target.DebuffStacks(vulnerability_debuff) < 3 or target.DebuffRemaining(hunters_mark_debuff) < 5 or Focus() < 50 or Focus() > 80 } and Spell(marked_shot) or Spell(explosive_shot) or target.DebuffExpires(hunters_mark_debuff) and CastTime(aimed_shot) < target.DebuffRemaining(vulnerability_debuff) and Spell(aimed_shot) or target.DebuffRemaining(hunters_mark_debuff) > 5 and Spell(marked_shot) or Spell(black_arrow) or Enemies() > 1 and FocusCastingRegen(multishot) + FocusCastingRegen(aimed_shot) <= FocusDeficit() and Spell(multishot) or FocusCastingRegen(arcane_shot) + FocusCastingRegen(aimed_shot) <= FocusDeficit() and Enemies() == 1 and Spell(arcane_shot)
}

### actions.precombat

AddFunction MarksmanshipPrecombatShortCdActions
{
	#flask,type=greater_draenic_agility_flask
	#food,type=salty_squid_roll
	#summon_pet
	MarksmanshipSummonPet()
}

AddFunction MarksmanshipPrecombatCdActions
{
	#snapshot_stats
	#potion,name=draenic_agility
	MarksmanshipUsePotionAgility()
}

### Marksmanship icons.

AddCheckBox(opt_hunter_marksmanship_aoe L(AOE) default specialization=marksmanship)

AddIcon checkbox=!opt_hunter_marksmanship_aoe enemies=1 help=shortcd specialization=marksmanship
{
	if not InCombat() MarksmanshipPrecombatShortCdActions()
	MarksmanshipDefaultShortCdActions()
}

AddIcon checkbox=opt_hunter_marksmanship_aoe help=shortcd specialization=marksmanship
{
	if not InCombat() MarksmanshipPrecombatShortCdActions()
	MarksmanshipDefaultShortCdActions()
}

AddIcon enemies=1 help=main specialization=marksmanship
{
	MarksmanshipDefaultMainActions()
}

AddIcon checkbox=opt_hunter_marksmanship_aoe help=aoe specialization=marksmanship
{
	MarksmanshipDefaultMainActions()
}

AddIcon checkbox=!opt_hunter_marksmanship_aoe enemies=1 help=cd specialization=marksmanship
{
	if not InCombat() MarksmanshipPrecombatCdActions()
	MarksmanshipDefaultCdActions()
}

AddIcon checkbox=opt_hunter_marksmanship_aoe help=cd specialization=marksmanship
{
	if not InCombat() MarksmanshipPrecombatCdActions()
	MarksmanshipDefaultCdActions()
}

### Required symbols
# a_murder_of_crows
# aimed_shot
# arcane_shot
# arcane_torrent_focus
# barrage
# berserking
# black_arrow
# blood_fury_ap
# bullseye_buff
# careful_aim_talent
# draenic_agility_potion
# explosive_shot
# hunters_mark_debuff
# legendary_ring_agility
# lone_wolf_talent
# marked_shot
# marking_targets_buff
# multishot
# patient_sniper_talent
# piercing_shot
# revive_pet
# sentinel
# sidewinders
# sidewinders_talent
# steady_focus_buff
# steady_focus_talent
# true_aim_debuff
# true_aim_talent
# trueshot
# trueshot_buff
# vulnerability_debuff
# windburst
]]
	OvaleScripts:RegisterScript("HUNTER", "marksmanship", name, desc, code, "script")
end

do
	local name = "simulationcraft_hunter_sv_t18m"
	local desc = "[7.0] SimulationCraft: Hunter_SV_T18M"
	local code = [[
# Based on SimulationCraft profile "Hunter_SV_T18M".
#	class=hunter
#	spec=survival
#	talents=3302022

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_hunter_spells)

AddCheckBox(opt_potion_agility ItemName(draenic_agility_potion) default specialization=survival)
AddCheckBox(opt_legendary_ring_agility ItemName(legendary_ring_agility) default specialization=survival)
AddCheckBox(opt_trap_launcher SpellName(trap_launcher) default specialization=survival)

AddFunction SurvivalUsePotionAgility
{
	if CheckBoxOn(opt_potion_agility) and target.Classification(worldboss) Item(draenic_agility_potion usable=1)
}

AddFunction SurvivalSummonPet
{
	if not Talent(lone_wolf_talent)
	{
		if pet.IsDead()
		{
			if not DebuffPresent(heart_of_the_phoenix_debuff) Spell(heart_of_the_phoenix)
			Spell(revive_pet)
		}
		if not pet.Present() and not pet.IsDead() and not PreviousSpell(revive_pet) Texture(ability_hunter_beastcall help=L(summon_pet))
	}
}

### actions.default

AddFunction SurvivalDefaultMainActions
{
	#carve,if=talent.serpent_sting.enabled&active_enemies>=3&(!dot.serpent_sting.ticking|dot.serpent_sting.remains<=gcd.max)
	if Talent(serpent_sting_talent) and Enemies() >= 3 and { not target.DebuffPresent(serpent_sting_debuff) or target.DebuffRemaining(serpent_sting_debuff) <= GCD() } Spell(carve)
	#raptor_strike,cycle_targets=1,if=talent.serpent_sting.enabled&active_enemies<=2&(!dot.serpent_sting.ticking|dot.serpent_sting.remains<=gcd.max)|talent.way_of_the_moknathal.enabled&(buff.moknathal_tactics.remains<gcd.max|buff.moknathal_tactics.down)
	if Talent(serpent_sting_talent) and Enemies() <= 2 and { not target.DebuffPresent(serpent_sting_debuff) or target.DebuffRemaining(serpent_sting_debuff) <= GCD() } or Talent(way_of_the_moknathal_talent) and { BuffRemaining(moknathal_tactics_buff) < GCD() or BuffExpires(moknathal_tactics_buff) } Spell(raptor_strike)
	#mongoose_bite,if=buff.mongoose_fury.up|cooldown.fury_of_the_eagle.remains<5|charges=3
	if BuffPresent(mongoose_fury_buff) or SpellCooldown(fury_of_the_eagle) < 5 or Charges(mongoose_bite) == 3 Spell(mongoose_bite)
	#lacerate,if=dot.lacerate.ticking&dot.lacerate.remains<=3|target.time_to_die>=5
	if target.DebuffPresent(lacerate_debuff) and target.DebuffRemaining(lacerate_debuff) <= 3 or target.TimeToDie() >= 5 Spell(lacerate)
	#flanking_strike,if=talent.way_of_the_moknathal.enabled&(focus>=55&buff.moknathal_tactics.remains>=3)|focus>=55
	if Talent(way_of_the_moknathal_talent) and Focus() >= 55 and BuffRemaining(moknathal_tactics_buff) >= 3 or Focus() >= 55 Spell(flanking_strike)
	#butchery,if=spell_targets.butchery>=2
	if Enemies() >= 2 Spell(butchery)
	#carve,if=spell_targets.carve>=4
	if Enemies() >= 4 Spell(carve)
	#throwing_axes
	Spell(throwing_axes)
	#raptor_strike,if=focus>75-cooldown.flanking_strike.remains*focus.regen
	if Focus() > 75 - SpellCooldown(flanking_strike) * FocusRegenRate() Spell(raptor_strike)
}

AddFunction SurvivalDefaultShortCdActions
{
	#explosive_trap
	if CheckBoxOn(opt_trap_launcher) and not Glyph(glyph_of_explosive_trap) Spell(explosive_trap)
	#dragonsfire_grenade
	Spell(dragonsfire_grenade)

	unless Talent(serpent_sting_talent) and Enemies() >= 3 and { not target.DebuffPresent(serpent_sting_debuff) or target.DebuffRemaining(serpent_sting_debuff) <= GCD() } and Spell(carve) or { Talent(serpent_sting_talent) and Enemies() <= 2 and { not target.DebuffPresent(serpent_sting_debuff) or target.DebuffRemaining(serpent_sting_debuff) <= GCD() } or Talent(way_of_the_moknathal_talent) and { BuffRemaining(moknathal_tactics_buff) < GCD() or BuffExpires(moknathal_tactics_buff) } } and Spell(raptor_strike)
	{
		#fury_of_the_eagle,if=buff.mongoose_fury.up&buff.mongoose_fury.remains<=gcd.max*2
		if BuffPresent(mongoose_fury_buff) and BuffRemaining(mongoose_fury_buff) <= GCD() * 2 Spell(fury_of_the_eagle)

		unless { BuffPresent(mongoose_fury_buff) or SpellCooldown(fury_of_the_eagle) < 5 or Charges(mongoose_bite) == 3 } and Spell(mongoose_bite)
		{
			#steel_trap
			if CheckBoxOn(opt_trap_launcher) Spell(steel_trap)
			#a_murder_of_crows
			Spell(a_murder_of_crows)

			unless { target.DebuffPresent(lacerate_debuff) and target.DebuffRemaining(lacerate_debuff) <= 3 or target.TimeToDie() >= 5 } and Spell(lacerate)
			{
				#snake_hunter,if=action.mongoose_bite.charges<=1&buff.mongoose_fury.remains>gcd.max*4
				if Charges(mongoose_bite) <= 1 and BuffRemaining(mongoose_fury_buff) > GCD() * 4 Spell(snake_hunter)

				unless { Talent(way_of_the_moknathal_talent) and Focus() >= 55 and BuffRemaining(moknathal_tactics_buff) >= 3 or Focus() >= 55 } and Spell(flanking_strike) or Enemies() >= 2 and Spell(butchery) or Enemies() >= 4 and Spell(carve)
				{
					#spitting_cobra
					Spell(spitting_cobra)
				}
			}
		}
	}
}

AddFunction SurvivalDefaultCdActions
{
	#auto_attack
	#arcane_torrent,if=focus.deficit>=30
	if FocusDeficit() >= 30 Spell(arcane_torrent_focus)
	#blood_fury
	Spell(blood_fury_ap)
	#berserking
	Spell(berserking)
	#use_item,name=maalus_the_blood_drinker
	if CheckBoxOn(opt_legendary_ring_agility) Item(legendary_ring_agility usable=1)

	unless CheckBoxOn(opt_trap_launcher) and not Glyph(glyph_of_explosive_trap) and Spell(explosive_trap) or Spell(dragonsfire_grenade) or Talent(serpent_sting_talent) and Enemies() >= 3 and { not target.DebuffPresent(serpent_sting_debuff) or target.DebuffRemaining(serpent_sting_debuff) <= GCD() } and Spell(carve) or { Talent(serpent_sting_talent) and Enemies() <= 2 and { not target.DebuffPresent(serpent_sting_debuff) or target.DebuffRemaining(serpent_sting_debuff) <= GCD() } or Talent(way_of_the_moknathal_talent) and { BuffRemaining(moknathal_tactics_buff) < GCD() or BuffExpires(moknathal_tactics_buff) } } and Spell(raptor_strike)
	{
		#aspect_of_the_eagle
		Spell(aspect_of_the_eagle)
	}
}

### actions.precombat

AddFunction SurvivalPrecombatMainActions
{
	#harpoon
	Spell(harpoon)
}

AddFunction SurvivalPrecombatShortCdActions
{
	#flask,type=greater_draenic_agility_flask
	#food,type=pickled_eel
	#summon_pet
	SurvivalSummonPet()
}

AddFunction SurvivalPrecombatShortCdPostConditions
{
	Spell(harpoon)
}

AddFunction SurvivalPrecombatCdActions
{
	#snapshot_stats
	#potion,name=draenic_agility
	SurvivalUsePotionAgility()
}

AddFunction SurvivalPrecombatCdPostConditions
{
	Spell(harpoon)
}

### Survival icons.

AddCheckBox(opt_hunter_survival_aoe L(AOE) default specialization=survival)

AddIcon checkbox=!opt_hunter_survival_aoe enemies=1 help=shortcd specialization=survival
{
	if not InCombat() SurvivalPrecombatShortCdActions()
	unless not InCombat() and SurvivalPrecombatShortCdPostConditions()
	{
		SurvivalDefaultShortCdActions()
	}
}

AddIcon checkbox=opt_hunter_survival_aoe help=shortcd specialization=survival
{
	if not InCombat() SurvivalPrecombatShortCdActions()
	unless not InCombat() and SurvivalPrecombatShortCdPostConditions()
	{
		SurvivalDefaultShortCdActions()
	}
}

AddIcon enemies=1 help=main specialization=survival
{
	if not InCombat() SurvivalPrecombatMainActions()
	SurvivalDefaultMainActions()
}

AddIcon checkbox=opt_hunter_survival_aoe help=aoe specialization=survival
{
	if not InCombat() SurvivalPrecombatMainActions()
	SurvivalDefaultMainActions()
}

AddIcon checkbox=!opt_hunter_survival_aoe enemies=1 help=cd specialization=survival
{
	if not InCombat() SurvivalPrecombatCdActions()
	unless not InCombat() and SurvivalPrecombatCdPostConditions()
	{
		SurvivalDefaultCdActions()
	}
}

AddIcon checkbox=opt_hunter_survival_aoe help=cd specialization=survival
{
	if not InCombat() SurvivalPrecombatCdActions()
	unless not InCombat() and SurvivalPrecombatCdPostConditions()
	{
		SurvivalDefaultCdActions()
	}
}

### Required symbols
# a_murder_of_crows
# arcane_torrent_focus
# aspect_of_the_eagle
# berserking
# blood_fury_ap
# butchery
# carve
# draenic_agility_potion
# dragonsfire_grenade
# explosive_trap
# flanking_strike
# fury_of_the_eagle
# glyph_of_explosive_trap
# harpoon
# lacerate
# lacerate_debuff
# legendary_ring_agility
# lone_wolf_talent
# moknathal_tactics_buff
# mongoose_bite
# mongoose_fury_buff
# raptor_strike
# revive_pet
# serpent_sting_debuff
# serpent_sting_talent
# snake_hunter
# spitting_cobra
# steel_trap
# throwing_axes
# trap_launcher
# way_of_the_moknathal_talent
]]
	OvaleScripts:RegisterScript("HUNTER", "survival", name, desc, code, "script")
end
