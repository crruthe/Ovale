local _, Ovale = ...
local OvaleScripts = Ovale.OvaleScripts

do
	local name = "ovale_rogue_spells"
	local desc = "[6.0.2] Ovale: Rogue spells"
	local code = [[
# Rogue spells and functions.

Define(adrenaline_rush 13750)
	SpellInfo(adrenaline_rush cd=180)
	SpellInfo(adrenaline_rush buff_cdr=cooldown_reduction_agility_buff)
	SpellAddBuff(adrenaline_rush adrenaline_rush_buff=1)
Define(adrenaline_rush_buff 13750)
	SpellInfo(adrenaline_rush_buff duration=15)
Define(ambush 8676)
	SpellInfo(ambush combo=2 energy=60 stealthed=1)
	SpellInfo(ambush buff_energy=silent_blades_buff buff_energy_amount=-6 itemset=T16_melee itemcount=2 specialization=assassination)
	SpellInfo(ambush buff_energy=silent_blades_buff buff_energy_amount=-15 itemset=T16_melee itemcount=2 specialization=combat)
	SpellInfo(ambush buff_energy=silent_blades_buff buff_energy_amount=-2 itemset=T16_melee itemcount=2 specialization=subtlety)
	SpellInfo(ambush buff_energy_less75=stealthed_buff if_spell=shadow_focus)
	SpellInfo(ambush buff_energy=shadow_dance_buff buff_energy_amount=-20 if_spell=shadow_dance)
	SpellInfo(ambush buff_no_stealthed=sleight_of_hand_buff itemset=T16_melee itemcount=4)
	SpellAddBuff(ambush silent_blades_buff=0 itemset=T16_melee itemcount=2)
	SpellAddBuff(ambush sleight_of_hand_buff=0 itemset=T16_melee itemcount=4)
	SpellAddTargetDebuff(ambush find_weakness_debuff=1 if_spell=find_weakness)
Define(anticipation 114015)
Define(anticipation_buff 115189)
	SpellInfo(anticipation_buff duration=15)
Define(anticipation_talent 18)
Define(backstab 53)
	SpellInfo(backstab combo=1 energy=35)
	SpellInfo(backstab buff_energy=silent_blades_buff buff_energy_amount=-2 itemset=T16_melee itemcount=2)
	SpellInfo(backstab buff_energy_less75=stealthed_buff if_spell=shadow_focus)
	SpellAddBuff(backstab silent_blades_buff=0 itemset=T16_melee itemcount=2)
Define(bandits_guile 84654)
Define(bandits_guile_buff 84654)
	SpellInfo(bandits_guile_buff duration=15 maxstacks=12)
Define(blade_flurry 13877)
	SpellInfo(blade_flurry cd=10)
Define(blade_flurry_buff 13877)
Define(blindside_buff 121153)
	SpellInfo(blindside_buff duration=10)
Define(cheap_shot 1833)
	SpellInfo(cheap_shot combo=2 energy=40 stealthed=1)
	SpellInfo(cheap_shot buff_energy=silent_blades_buff buff_energy_amount=-6 itemset=T16_melee itemcount=2 specialization=assassination)
	SpellInfo(cheap_shot buff_energy=silent_blades_buff buff_energy_amount=-15 itemset=T16_melee itemcount=2 specialization=combat)
	SpellInfo(cheap_shot buff_energy=silent_blades_buff buff_energy_amount=-2 itemset=T16_melee itemcount=2 specialization=subtlety)
	SpellInfo(cheap_shot buff_energy_less75=stealthed_buff if_spell=shadow_focus)
	SpellAddBuff(cheap_shot silent_blades_buff=0 itemset=T16_melee itemcount=2)
	SpellAddTargetDebuff(cheap_shot find_weakness_debuff=1 if_spell=find_weakness)
Define(crimson_tempest 121411)
	SpellInfo(crimson_tempest combo=finisher energy=35)
	SpellInfo(crimson_tempest buff_energy_less75=stealthed_buff if_spell=shadow_focus)
	SpellAddTargetDebuff(crimson_tempest crimson_tempest_debuff=1)
Define(crimson_tempest_debuff 122233)
	SpellInfo(crimson_tempest_debuff duration=12 tick=2)
Define(crimson_tempest_dot_debuff 122233)
Define(crippling_poison 3408)
	SpellAddBuff(crippling_poison crippling_poison_buff=1)
Define(crippling_poison_buff 3408)
	SpellInfo(crippling_poison_buff duration=3600)
Define(deadly_poison 2823)
	SpellAddBuff(deadly_poison deadly_poison_buff=1)
Define(deadly_poison_buff 2823)
	SpellInfo(deadly_poison_buff duration=3600)
Define(deadly_poison_dot_debuff 2818)
	SpellInfo(deadly_poison_dot_debuff duration=12 tick=3)
Define(deadly_throw 26679)
	SpellInfo(deadly_throw combo=finisher energy=35)
	SpellInfo(deadly_throw buff_energy_less75=stealthed_buff if_spell=shadow_focus)
Define(deadly_throw_talent 4)
Define(death_from_above 152150)
	SpellInfo(death_from_above combo=finisher energy=50)
	SpellInfo(death_from_above buff_energy_less75=stealthed_buff if_spell=shadow_focus)
Define(death_from_above_talent 21)
Define(deep_insight_buff 84747)
	SpellInfo(deep_insight_buff duration=15)
Define(dispatch 111240)
	SpellInfo(dispatch combo=1 energy=30 target_health_pct=35)
	SpellInfo(dispatch buff_energy=silent_blades_buff buff_energy_amount=-6 itemset=T16_melee itemcount=2)
	SpellInfo(dispatch buff_energy_less75=stealthed_buff if_spell=shadow_focus)
	SpellInfo(dispatch buff_energy_none=blindside_buff level=40)
	SpellInfo(dispatch buff_no_target_health_pct=blindside_buff level=40)
	SpellAddBuff(dispatch silent_blades_buff=0 itemset=T16_melee itemcount=2)
	SpellAddBuff(dispatch enhanced_vendetta_buff=0 if_spell=enhanced_vendetta)
Define(enhanced_shadow_dance 157669)
Define(enhanced_vanish 157666)
Define(enhanced_vendetta 158108)
Define(enhanced_vendetta_buff 158108)
	SpellInfo(enhanced_vendetta_buff duration=15)
Define(envenom 32645)
	SpellInfo(envenom combo=finisher energy=35)
	SpellInfo(envenom buff_energy_less75=stealthed_buff if_spell=shadow_focus)
	SpellAddBuff(envenom envenom_buff=1)
	SpellAddBuff(envenom slice_and_dice=refresh if_spell=!improved_slice_and_dice level=20)
	SpellAddBuff(envenom enhanced_vendetta_buff=0 if_spell=enhanced_vendetta)
Define(envenom_buff 32645)
	SpellInfo(envenom_buff duration=1 adddurationcp=1 tick=1)
Define(eviscerate 2098)
	SpellInfo(eviscerate combo=finisher energy=35)
	SpellInfo(eviscerate buff_energy_less75=stealthed_buff if_spell=shadow_focus)
Define(fan_of_knives 51723)
	SpellInfo(fan_of_knives combo=1 energy=35)
	SpellInfo(fan_of_knives buff_energy=silent_blades_buff buff_energy_amount=-6 itemset=T16_melee itemcount=2 specialization=assassination)
	SpellInfo(fan_of_knives buff_energy=silent_blades_buff buff_energy_amount=-2 itemset=T16_melee itemcount=2 specialization=subtlety)
	SpellInfo(fan_of_knives buff_energy_less75=stealthed_buff if_spell=shadow_focus)
	SpellAddBuff(fan_of_knives silent_blades_buff=0 itemset=T16_melee itemcount=2)
Define(find_weakness 91023)
Define(find_weakness_debuff 91021)
	SpellInfo(find_weakness_debuff duration=10)
Define(glyph_of_disappearance 159638)
Define(glyph_of_kick 56805)
Define(glyph_of_shiv 56810)
Define(glyph_of_stealth 63253)
Define(glyph_of_vanish 89758)
Define(glyph_of_vendetta 63249)
Define(hemorrhage 16511)
	SpellInfo(hemorrhage combo=1 energy=30)
	SpellInfo(hemorrhage buff_energy=silent_blades_buff buff_energy_amount=-2 itemset=T16_melee itemcount=2)
	SpellInfo(hemorrhage buff_energy_less75=stealthed_buff if_spell=shadow_focus)
	SpellAddBuff(hemorrhage silent_blades_buff=0 itemset=T16_melee itemcount=2)
	SpellAddTargetDebuff(hemorrhage hemorrhage_debuff=1)
Define(hemorrhage_debuff 16511)
	SpellInfo(hemorrhage_debuff duration=24 tick=3)
Define(improved_slice_and_dice 157513)
Define(internal_bleeding_debuff 154953)
	SpellInfo(internal_bleeding_debuff duration=12 tick=2)
Define(internal_bleeding_talent 14)
Define(kick 1766)
	SpellInfo(kick cd=15)
	SpellInfo(kick addcd=4 glyph=glyph_of_kick)
Define(kidney_shot 408)
	SpellInfo(kidney_shot cd=20 combo=finisher energy=25)
	SpellInfo(kidney_shot buff_energy_less75=stealthed_buff if_spell=shadow_focus)
	SpellAddTargetDebuff(kidney_shot internal_bleeding_debuff=1 talent=internal_bleeding_talent)
Define(killing_spree 51690)
	SpellInfo(killing_spree cd=120)
	SpellInfo(killing_spree buff_cdr=cooldown_reduction_agility_buff)
Define(leeching_poison 108211)
	SpellAddBuff(leeching_poison leeching_poison_buff=1)
Define(leeching_poison_buff 108211)
	SpellInfo(leeching_poison_buff duration=3600)
Define(leeching_poison_talent 8)
SpellList(lethal_poison_buff deadly_poison_buff wound_poison_buff)
Define(marked_for_death 137619)
	SpellInfo(marked_for_death cd=60 combo=5 temp_combo=1)
Define(marked_for_death_talent 17)
Define(master_of_subtlety_buff 31665)
Define(mutilate 1329)
	SpellInfo(mutilate combo=2 energy=55)
	SpellInfo(mutilate buff_energy=silent_blades_buff buff_energy_amount=-6 itemset=T16_melee itemcount=2)
	SpellInfo(mutilate buff_energy_less75=stealthed_buff if_spell=shadow_focus)
	SpellAddBuff(mutilate silent_blades_buff=0 itemset=T16_melee itemcount=2)
	SpellAddBuff(mutilate enhanced_vendetta_buff=0 if_spell=enhanced_vendetta)
SpellList(non_lethal_poison_buff crippling_poison_buff leeching_poison_buff)
Define(premeditation 14183)
	SpellInfo(premeditation cd=20 combo=2 stealthed=1 temp_combo=1)
Define(preparation 14185)
	SpellInfo(preparation cd=300)
Define(revealing_strike 84617)
	SpellInfo(revealing_strike combo=1 energy=40)
	SpellInfo(revealing_strike buff_energy=silent_blades_buff buff_energy_amount=-15 itemset=T16_melee itemcount=2)
	SpellInfo(revealing_strike buff_energy_less75=stealthed_buff if_spell=shadow_focus)
	SpellAddBuff(revealing_strike silent_blades_buff=0 itemset=T16_melee itemcount=2)
	SpellAddTargetDebuff(revealing_strike revealing_strike_debuff=1)
Define(revealing_strike_debuff 84617)
	SpellInfo(revealing_strike_debuff duration=24 tick=3)
Define(rupture 1943)
	SpellInfo(rupture combo=finisher energy=25)
	SpellInfo(rupture buff_energy_less75=stealthed_buff if_spell=shadow_focus)
	SpellAddTargetDebuff(rupture rupture_debuff=1)
Define(rupture_debuff 1943)
	SpellInfo(rupture_debuff adddurationcp=4 duration=4 tick=2)
Define(shadow_dance 51713)
	SpellInfo(shadow_dance cd=60)
	SpellInfo(shadow_dance buff_cdr=cooldown_reduction_agility_buff)
	SpellAddBuff(shadow_dance shadow_dance_buff=1)
Define(shadow_dance_buff 51713)
	SpellInfo(shadow_dance_buff duration=8)
	SpellInfo(shadow_dance_buff addduration=2 if_spell=enhanced_shadow_dance)
Define(shadow_focus 108209)
Define(shadow_focus_talent 3)
Define(shadow_reflection 152151)
	SpellInfo(shadow_reflection cd=120)
	SpellAddBuff(shadow_reflection shadow_reflection_buff=1)
Define(shadow_reflection_buff 152151)
	SpellInfo(shadow_reflection_buff duration=16)
Define(shadow_reflection_talent 20)
Define(shadowstep 36554)
	SpellInfo(shadowstep cd=20)
Define(shadowstep_talent 11)
Define(shiv 5938)
	SpellInfo(shiv cd=10 energy=20)
	SpellInfo(shiv buff_energy_less75=stealthed_buff if_spell=shadow_focus)
	SpellInfo(shiv addcd=-3 glyph=glyph_of_shiv)
Define(shuriken_toss 114014)
	SpellInfo(shuriken_toss combo=1 energy=40)
	SpellInfo(shuriken_toss buff_energy=silent_blades_buff buff_energy_amount=-6 itemset=T16_melee itemcount=2 specialization=assassination)
	SpellInfo(shuriken_toss buff_energy_less75=stealthed_buff if_spell=shadow_focus)
	SpellAddBuff(shuriken_toss silent_blades_buff=0 itemset=T16_melee itemcount=2)
Define(shuriken_toss_talent 16)
Define(silent_blades_buff 145193)
	SpellInfo(silent_blades_buff duration=30 stacking=1)
Define(sinister_strike 1752)
	SpellInfo(sinister_strike combo=1 energy=50)
	SpellInfo(sinister_strike buff_energy=silent_blades_buff buff_energy_amount=-15 itemset=T16_melee itemcount=2 specialization=combat)
	SpellInfo(sinister_strike buff_energy_less15=shadow_blades_buff if_spell=shadow_blades itemset=T15_melee itemcount=4)
	SpellInfo(sinister_strike buff_energy_less75=stealthed_buff if_spell=shadow_focus)
	SpellAddBuff(sinister_strike bandits_guile_buff=1 if_spell=bandits_guile)
	SpellAddBuff(sinister_strike silent_blades_buff=0 itemset=T16_melee itemcount=2)
Define(sleight_of_hand_buff 145211)
	SpellInfo(sleight_of_hand_buff duration=10)
Define(slice_and_dice 5171)
	SpellInfo(slice_and_dice combo=finisher energy=25)
	SpellInfo(slice_and_dice buff_energy_less75=stealthed_buff if_spell=shadow_focus)
	SpellAddBuff(slice_and_dice slice_and_dice_buff=1)
Define(slice_and_dice_buff 5171)
	SpellInfo(slice_and_dice adddurationcp=6 duration=6 tick=3)
Define(stealth 1784)
	SpellInfo(stealth cd=6 to_stance=rogue_stealth)
	SpellInfo(stealth addcd=-4 glyph=glyph_of_stealth)
	SpellAddBuff(stealth stealth=1)
Define(subterfuge_talent 2)
Define(vanish 1856)
	SpellInfo(vanish cd=120)
	SpellInfo(vanish addcd=-60 glyph=glyph_of_disappearance)
	SpellInfo(vanish addcd=-30 if_spell=enhanced_vanish)
	SpellInfo(vanish buff_cdr=cooldown_reduction_agility_buff specialization=assassination)
	SpellInfo(vanish buff_cdr=cooldown_reduction_agility_buff specialization=subtlety)
	SpellAddBuff(vanish vanish_aura=1 talent=!subterfuge_talent)
	SpellAddBuff(vanish vanish_subterfuge_buff=1 talent=subterfuge_talent)
Define(vanish_aura 11327)
	SpellInfo(vanish_aura duration=3)
	SpellInfo(vanish_aura addduration=2 glyph=glyph_of_vanish)
Define(vanish_subterfuge_buff 115193)
	SpellInfo(vanish_subterfuge_buff duration=3)
	SpellInfo(vanish_subterfuge_buff addduration=2 glyph=glyph_of_vanish)
SpellList(vanish_buff vanish_aura vanish_subterfuge_buff)
Define(vendetta 79140)
	SpellInfo(vendetta cd=120)
	SpellInfo(vendetta buff_cdr=cooldown_reduction_agility_buff)
	SpellAddBuff(vendetta enhanced_vendetta_buff=1 if_spell=enhanced_vendetta)
	SpellAddTargetDebuff(vendetta vendetta_debuff=1)
Define(vendetta_debuff 79140)
	SpellInfo(vendetta_debuff duration=20)
	SpellInfo(vendetta_debuff addduration=10 glyph=glyph_of_vendetta)
Define(wound_poison 8679)
	SpellAddBuff(wound_poison wound_poison_buff=1)
Define(wound_poison_buff 8679)
	SpellInfo(wound_poison_buff duration=3600)
]]

	OvaleScripts:RegisterScript("ROGUE", name, desc, code, "include")
end
