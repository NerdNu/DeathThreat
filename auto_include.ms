

proc(_checkSlotForEnchantment, @item,
	@hasProt3 = false
	foreach(@item['enchants'], @enchant,
		if(@enchant['etype'] == 'PROTECTION_ENVIRONMENTAL' && @enchant['elevel'] >= 3){
			@hasProt3 = true
			break()
		}
	)
	return(@hasProt3)
)

/**
 * Returns true if the player is wearing all diamond or iron armor (or some mix of the two)
 * and the chestplate and pants are enchanted with prot III or higher
 */
proc(_checkPlayerHead, @player,
        @playerArmor = pinv(@player)
        @hasAllArmor = true
        #if(@playerArmor[103] == null || (@playerArmor[103]['type'] != 310 && @playerArmor[103]['type'] != 306)){
        #        @hasAllArmor = false
        #}
	if(@playerArmor[102] == null || (@playerArmor[102]['type'] != 311 && @playerArmor[102]['type'] != 307)){
		@hasAllArmor = false
	}
	if(@playerArmor[101] == null || (@playerArmor[101]['type'] != 312 && @playerArmor[101]['type'] != 308)){
		@hasAllArmor = false
	}
	#if(@playerArmor[100] == null || (@playerArmor[100]['type'] != 313 && @playerArmor[100]['type'] != 309)){
	#	@hasAllArmor = false
	#}
	@hasProperEnchants = false
	if(@hasAllArmor){
		# We can assume that the slots aren't null now
		@hasProperEnchants = (_checkSlotForEnchantment(@playerArmor[102]) && _checkSlotForEnchantment(@playerArmor[101]))
	}
	return(@hasAllArmor && @hasProperEnchants)
)
