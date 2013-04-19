

bind(player_death, null, null, @event,
	try(
		if(@event['cause'] == 'ENTITY_ATTACK'){
			@match = reg_match('^'.player().' was slain by (.*?)$', @event['death_message'])
			if(ponline(@match[1])){
				@leather = array(colors:red,fade:black,strength:1)
				@gold = array(colors:red,fade:yellow,strength:1)
				@chain = array(colors:'red|silver',fade:white,strength:2)
				@iron = array(colors:red,fade:white,strength:2,flicker:true)
				@diamond = array(colors:'red|teal',fade:white,strength:2,flicker:true,type:star)
				
				@killerHasArmor = false
				foreach(100..103, @slot,
					if(pinv(@match[1], @slot) != null){
						#They are wearing something
						@killerHasArmor = true
					}
				)
				@fwType = null
				# Check the dead player's inventory, and see what chestplate they were wearing
				@armorType = pinv()[102]['type']
				switch(@armorType,
					299, @fwType = @leather,
					315, @fwType = @gold,
					303, @fwType = @chain,
					307, @fwType = @iron,
					311, @fwType = @diamond
				)
				if(@fwType != null && @killerHasArmor){
					launch_firework(ploc(@match[1]), @fwType)
				}
				if(_checkPlayerHead(player()) && _checkPlayerHead(@match[1])){
					drop_item(@match[1], array(type: 397, data: 3, meta: array(owner: player())))
					broadcast(color(red).player().' was decapitated by '.@match[1].'!')
				}
			}
		}
	)
)

