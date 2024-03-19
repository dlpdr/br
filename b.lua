setDefaultTab("BR")


UI.Separator()
UI.Label("     ESSENTIALS     "):setColor("black")
UI.Separator()

macro(1, 'PAUSAUM', function()
	if Stairs.walk.isOn() then return end
	if standTime() <= 150 then
		if Stairs.bestTile and Stairs.bestTile:getTopUseThing() then
			Stairs.bestTile:setText('')
		end
		Stairs.bestTile = Stairs.checkAll()
		Stairs.pos = Stairs.bestTile and Stairs.bestTile:getPosition()
	end
	if modules.corelib.g_keyboard.isKeyPressed('space') and Stairs.bestTile and not modules.game_console:isChatEnabled() then
		Stairs.walk.setOn()
		return
	elseif Stairs.bestTile then
		Stairs.bestTile:setText('AQUI', 'red')
	end
end)

macro(1, 'ATK TARGET', function()
    if modules.corelib.g_keyboard.isKeyPressed('escape') then storageTarget = nil return delay(200) end
    if isInPz() then return end
    local target = g_game.getAttackingCreature()
    if target then
      storageTarget = target:getId()
      return
    end
    if not storageTarget then return end
    local inScreen = getCreatureById(storageTarget)
    if not inScreen or inScreen.inPz or inScreen.whiteList then return end
    g_game.attack(inScreen)
  end)

 macro(1, 'PEDRA', function()
	if modules.game_console:isChatEnabled() then return end
	if (hppercent() <= Pedra.HP or Keys('v')) and storage.pedra[player:getName()] < os.time() then
		pr[3] = now + 300
		pr[4] = now + 300
		useWith(Pedra.ID, player)
		g_game.stop()
		player:lockWalk(100)
	end
end)

macro(100, 'STACK', function()
	if pr[5] > now then return end
	if not Keys('f') then return end
    pr[1] = now + 100
	if Keys('w') then
		Stack('n')
	elseif Keys('s') then
		Stack('s')
	elseif Keys('a') then
		Stack('w')
	elseif Keys('d') then
		Stack('e')
	end
end)

macro(1, 'BUG MAP', function()
	local dir = actualDirection()
	if modules.game_console:isChatEnabled() then return end
	if pr[4] and pr[4] >= now then return 
	elseif Keys('w') then
		if dir ~= 0 then turn(0) end 
		if getDash('n') then
			g_game.walk(0)
		else  
			checkPos(0, -5)
		end
	elseif Keys('e') then
		checkPos(3, -3)
	elseif Keys('q') then
		checkPos(-3, -3)
	elseif Keys('z') then
		checkPos(-3, 3)
	elseif Keys('c') then
		checkPos(3, 3)
	elseif Keys('d') then
		if dir ~= 1 then turn(1) end
		if getDash('e') then
			g_game.walk(1)
		else  
			checkPos(5, 0)
		end
	elseif Keys('s') then
		if dir ~= 2 then turn(2) end
		if getDash('s') then
			g_game.walk(2)
		else
			checkPos(0, 5)
		end
	elseif Keys('a') then
		if dir ~= 3 then turn(3) end
		if getDash('w') then
			g_game.walk(3)
		else
			checkPos(-5, 0)
		end
	end
end)

macro(1, 'SENZU', function()
	if (pr[3] and pr[3] >= now) or Senzu.Exhaust >= os.time() then return end
	if hppercent() <= tonumber(Senzu.Percentage) or manapercent() <= 20 then
		pr[10] = now + 100
		useWith(tonumber(Senzu.Id), player)
	end
end) 

macro(1, function()
	local tgt = g_game.getAttackingCreature()
	if cb ~= 1 and not Keys('f3') and tgt then
		local targetPos = tgt:getPosition()
		if not targetPos then return end
		local targetDistance = getDistanceBetween(targetPos, player:getPosition())
		if Keys('r') then
			if targetDistance > 0 then
				if targetDistance > 4 or tgt:isPlayer() then
					if storage.time[1] < os.time() then
						pr[1] = now + 100
						return say('blazing zephyr')
					end
				else
					pr[1] = now + 100 
					return say('Teleport')
				end
			end
		elseif Keys('f') and storage.time[7] < os.time() then
			pr[1] = now + 100
			return 
		end
	end
end)

macro(100, 'COMBO', function()
	local tgt = g_game.getAttackingCreature()
	if (pr[1] and pr[1] >= now) or not tgt then 
		ca=0
		cb=0
		return 
	end
	if tgt:getHealthPercent() <= 30 and tgt:isPlayer() then
        	if storage.time[1] < os.time() then
			return say('Blazing Zephyr')
		end
	end
	if Keys('3') and storage.time[4] < os.time() and storage.time[8] < os.time() and cb == 0 then
		say('Super Namekian Final Flash')
	elseif (ca > 2 or cb == 1) and storage.time[8] < os.time() then
		say('Burning Shot')
	elseif ca > 1 and storage.time[7] < os.time() then
		say('kasai no arashi') 
	elseif storage.time[10] < os.time() then
		say(Fast)
	end
end)

addTextEdit("Buff", storage.Buff, function(widget, text) 
	storage.Buff = text
   end)

macro(1, 'ALL IN ONE', function()
	canHeal = false
	if not hasHaste() then
		say('Super Speed')
	end
	if Keys('t') and storage.time[5] < os.time() and not modules.game_console:isChatEnabled() then
		pr[1] = now + 200
		return say('flight kubu')
	elseif pr[2] and pr[2] >= now then
		return
	elseif (hppercent() <= 40 or Keys('F1') or storage.time[6] >= os.time()) and not hasManaShield() and premium and not fullmystic.isOn() then
		return say('mystic defense')
	elseif not Keys('F2') and hppercent() >= 80 and not player:isWalking() and not player:isServerWalking() and premium and hasManaShield() and storage.time[6] < os.time() and not fullmystic.isOn() and pr[10] < now then
		pr[3] = now + 500
		if Senzu.Exhaust < os.time() then
			return say('mystic kai')
		end
      elseif storage.Buff and storage.time[3] < os.time() and (hppercent() >= 80 or not storage.Buff:lower():find('power up')) and not isInPz() and (storage.TimeRemain - os.time() > 60 or not isPzLocked() or g_game.isAttacking()) then
		if cb ~= 1 and not storage.Buff:lower():find('power up') then
			pr[1] = now + 300
		end
		return say(storage.Buff)
	end
	if hppercent() <= 99 then
		return say('Big Regeneration')
	end
	canHeal = true
end)

UI.Separator()
UI.Label("     UTILITIES     "):setColor("black")
UI.Separator()


macro(100, "ctl", function()
	local tgt = g_game.getAttackingCreature()
	if not tgt then return end
	if tgt then
	   local targetPos = tgt:getPosition()
	   if not targetPos then return end
	   local targetDistance = getDistanceBetween(targetPos, player:getPosition())
	   if targetDistance > 2 then
	   say("Burning Shot")
	   else
	   say("Burning Intersec")
	   end
	 end
   end)


fullmystic = macro(1, 'FULL DEF', function()
	if not hasManaShield() then
		say('mystic defense')
	end
end)


macro(100, 'PT ALL', function()
    if player:isPartyMember() and not player:isPartyLeader() then return end
    for _, spectator in ipairs(getSpectators(true)) do
        if spectator:getEmblem() == 1 or table.find(inviteList, spectator:getName(), true) then
            if spectator:getShield() > 0 and not player:isPartyLeader() then
                g_game.partyJoin(spectator:getId())
            elseif player:isPartyLeader() and spectator:getShield() == 0 then
                g_game.partyInvite(spectator:getId())
             end
         end
    end
end)


AntiRed.macro = macro(100, "ANT-RED", function()
    local spectators = getSpectators(true);
    local monstersNextTo = getMonstersInRange(pos(), 5);
    for _, creature in pairs(spectators) do
        if (creature:getName() ~= player:getName() and creature:isPlayer() and creature:getEmblem() ~= 1) then
            AntiRed.time = now + AntiRed.delayTime;
            break;
        end
    end
    if (monstersNextTo >= 2 and AntiRed.time < now and player:getSkull() < 3) then
        say(AntiRed.areaSpell);
    elseif (g_game.isAttacking() and (AntiRed.time >= now or player:getSkull() >= 3 or monstersNextTo < 2)) then
        local arraySpells = AntiRed.comboSpells:explode(",");
        for _, spell in ipairs(arraySpells) do
          say(spell);
        end
    end
end);

macro(100, 'AREA', function()
	local target = g_game.getAttackingCreature()
	if target then 
		say('Burning Intersec')
	end
end)

macro(1, 'SUP ALL', function()
	if pr[10] >= now or not canHeal then return end
	local healHim
	for _, spec in ipairs(getSpectators(posz())) do
		if spec:isPlayer() then
			if spec:getEmblem() == 1 or spec:getShield() >= 3  then
				if spec ~= player and canBeShoot(spec) then
					if spec:getSpeed() < 1500 then
						return useWith(3199, spec)
					end
					if spec:getHealthPercent() <= 90 and (not healHim or healHim:getHealthPercent() > spec:getHealthPercent()) then
						healHim = spec
					end
				end
			end
		end
	end
	if healHim then
		useWith(3195, healHim)
		useWith(3160, healHim)
	end
end)


local troca = {
    leg1 = 3364,
    leg2 = 7470,
	amulet1 = 7473,
	amulet2 = 7657
}

macro(100, "CHANGE", function()
	local tgt = g_game.getAttackingCreature()
	if not tgt then 
		if check1 ~= troca.leg2 then
			moveToSlot(troca.leg2, SlotLeg)
		end
		if check2 ~= troca.amulet2 then
			moveToSlot(troca.amulet2, SlotNeck)	
		end
		return
	end
	local targetPos = tgt:getPosition()
	if not targetPos then return end
	local targetDistance = getDistanceBetween(targetPos, player:getPosition())
	local check1 = getLeg() and getLeg():getId()
	local check2 = getNeck() and getNeck():getId()
	if hppercent() >= 95 and targetDistance < 2 then
		if check1 ~= troca.leg1 then
			moveToSlot(troca.leg1, SlotLeg)
		elseif check2 ~= troca.amulet1 then
			moveToSlot(troca.amulet1, SlotNeck)
		end
	elseif check1 ~= troca.leg2 then
		moveToSlot(troca.leg2, SlotLeg)
	elseif check2 ~= troca.amulet2 then
		moveToSlot(troca.amulet2, SlotNeck)
	end
end)

macro(100, "MW ATRAS", function()
	if modules.game_console:isChatEnabled() then return end
	if not modules.corelib.g_keyboard.isKeyPressed('2') then return end
	pr[1] = now + 200
	local dir = actualDirection()
	local tile
	if dir == 1 then
		tile = g_map.getTile({x = pos().x - 1, y = pos().y, z = pos().z})
	elseif dir == 3 then
		tile = g_map.getTile({x = pos().x + 1, y = pos().y, z = pos().z})
	elseif dir == 2 then
		tile = g_map.getTile({x = pos().x, y = pos().y - 1, z = pos().z})
	elseif dir == 0 then
		tile = g_map.getTile({x = pos().x, y = pos().y + 1, z = pos().z})
	end
	return tile and tile:isWalkable() and useWith(3080, tile:getTopLookThing())
end)
