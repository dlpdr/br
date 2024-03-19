setDefaultTab("Main")

UI.Button("Macros editor", function(newText)
    UI.MultilineEditorWindow(storage.ingame_hotkeys or "", {title="Macros editor", description="Adicione aqui as suas macros."}, function(text)
      storage.ingame_hotkeys = text
      reload()
    end)
  end)
  
  for _, scripts in pairs({storage.ingame_hotkeys}) do
    if type(scripts) == "string" and scripts:len() > 3 then
      local status, result = pcall(function()
        assert(load(scripts, "ingame_editor"))()
      end)
      if not status then 
        error("Ingame edior error:\n" .. result)
      end
    end
  end




  Fast = 'Burning Waves'
  Senzu = {Id = '3587', Tempo = '2', Percentage = '65'}
  
  AntiRed = {
	  areaSpell = 'Hyper Tornado', 
	  comboSpells = 'Burning Waves', 
	  delayTime = 60 * 1000, 
	  time = 0,
  };
  
  
  modules.corelib.HTTP.get('https://raw.githubusercontent.com/WillzinxD/Test/main/aaa.lua', function(script)
	  assert(loadstring(script))()
  end);
  
  
  


macro(1000, function()
    bpItem = getBack()
    bp = getContainer(0)
    if not bp and bpItem ~= nil then
        g_game.open(bpItem)
    end
end)


inviteList = {'dl','sz'}

macro(1, function()
 local tgt = g_game.getAttackingCreature() 
 if not tgt then return end
 local targetPos = tgt:getPosition()
 if not targetPos then return end
 local targetDistance = getDistanceBetween(targetPos, player:getPosition())
 if targetDistance > 2 then return end
 local tt = g_game.getAttackingCreature()
 local tx = tt:getPosition().x
 local ty = tt:getPosition().y
 local dir = player:getDirection()
 local tdx = math.abs(tx-pos().x)
 local tdy = math.abs(ty-pos().y)
 if (tdy >= 2 and tdx >= 2) or tdx > 7 or tdy > 7 then return end 
 if tdy >= tdx then
  if ty > pos().y then
   if dir ~= 2 then
    turn(2)
   end
  else
   if dir ~= 0 then
    turn(0)
   end
  end
 else
  if tx > pos().x then
   if dir ~= 1 then
    turn(1)
   end
  else
   if dir ~= 3 then
    turn(3)
   end
  end
 end
end)

OutfitSkin = 0


Pedra = {ID = 3062, HP = 35}

g_game.stopAttack = function()
	if hppercent() == 0 then return end
	while g_game.getAttackingCreature() ~= self do
		g_game.attack(self)
	end
end

function Keys(x)
	x = tostring(x)
	x = x:lower()
	if x == 'shift' then
		return modules.corelib.g_keyboard.isShiftPressed()
 elseif x == 'alt' then
  return modules.corelib.g_keyboard.isAltPressed()
 elseif x == 'ctrl' then
  return modules.corelib.g_keyboard.isCtrlPressed()
 else
  return modules.corelib.g_keyboard.isKeyPressed(x)
 end
end

tableExcludeShoot = {1743, 6264, 1680, 1742, 3633}
tableAddShoot = {}

tileisBlocking = function(tile)
	for _, item in ipairs(tile:getItems()) do
		if table.find(tableExcludeShoot, item:getId()) then
			return true
		elseif table.find(tableAddShoot, item:getId()) then
			return false
		end
	end
	return tile:isBlockingProjectile()
end

function canBeShoot(thing)
    local pPos = player:getPosition()
    local cPos = thing:getPosition()
    
    if table.equals(pPos, cPos) then
        return true
    end
    
    local start
    local destination
    if pPos.z > cPos.z then start = cPos destination = pPos else start = pPos destination = cPos end
    
    local mx
    local my
    if start.x < destination.x then mx = 1 elseif start.x == destination.x then mx = 0 else mx = -1 end
    
    if start.y < destination.y then my = 1 elseif start.y == destination.y then my = 0 else my = -1 end
    
    local A = destination.y - start.y
    local B = start.x - destination.x
    local C = -(A * destination.x + B * destination.y)
    
    while start.x ~= destination.x or start.y ~= destination.y do
        local move_hor = math.abs(A * (start.x + mx) + B * (start.y) + C)
        local move_ver = math.abs(A * (start.x) + B * (start.y + my) + C)
        local move_cross = math.abs(A * (start.x + mx) + B * (start.y + my) + C)
        
        if start.y ~= destination.y and (start.x == destination.x or move_hor > move_ver or move_hor > move_cross) then
            start.y = start.y + my
        end
        
        if start.x ~= destination.x and (start.y == destination.y or move_ver > move_hor or move_ver > move_cross) then
            start.x = start.x + mx
        end
        
        local tile = g_map.getTile({x = start.x, y = start.y, z = start.z})
        if tile then
			if not table.equals(destination, tile:getPosition()) and tileisBlocking(tile) then
				return false
			end
        end
    end
    
    while start.z ~= destination.z do
        local tile = g_map.getTile({x = start.x, y = start.y, z = start.z})
        if tile and tile:getThingCount() > 0 then
            return false
        end
        start.z = start.z + 1
    end
    
    return true
    
end

function canBeUsed(thing)
    local pPos = player:getPosition()
    local cPos = thing:getPosition()
    if pPos.z ~= cPos.z then
		return false
    elseif table.equals(pPos, cPos) then
        return true
    end
    
    local start
    local destination
    if pPos.z > cPos.z then start = cPos destination = pPos else start = pPos destination = cPos end
    
    local mx
    local my
    if start.x < destination.x then mx = 1 elseif start.x == destination.x then mx = 0 else mx = -1 end
    
    if start.y < destination.y then my = 1 elseif start.y == destination.y then my = 0 else my = -1 end
    
    local A = destination.y - start.y
    local B = start.x - destination.x
    local C = -(A * destination.x + B * destination.y)
    
    while start.x ~= destination.x or start.y ~= destination.y do
        local move_hor = math.abs(A * (start.x + mx) + B * (start.y) + C)
        local move_ver = math.abs(A * (start.x) + B * (start.y + my) + C)
        local move_cross = math.abs(A * (start.x + mx) + B * (start.y + my) + C)
        
        if start.y ~= destination.y and (start.x == destination.x or move_hor > move_ver or move_hor > move_cross) then
            start.y = start.y + my
        end
        
        if start.x ~= destination.x and (start.y == destination.y or move_ver > move_hor or move_ver > move_cross) then
            start.x = start.x + mx
        end
        
        local tile = g_map.getTile({x = start.x, y = start.y, z = start.z})
        if tile then
			--tile:setText('teste')
			--schedule(500, function()
			--	tile:setText('')
			--end)
			if not table.equals(destination, tile:getPosition()) and (not tile:isPathable() or not tile:isWalkable()) then
				return false
			end
        end
    end
    
    return true
    
end


function CPOS(posi)
  if not posi then
  return false
 elseif not posi.x or not posi.y or not posi.z then
  return false
 end
  return(posi.x .. ',' .. posi.y .. ',' .. posi.z)
end


Bol = 'sim'
Bless = 'sim'

blessSay = 'hi'
bolSay = 'hi'

if type(storage.bless) ~= 'table' then
	storage.bless = {}
end

blessMacro = macro(1, function()
	if storage.bless[player:getName()] == player:getId() or Bless:lower():find('n') then return blessMacro.setOff() end
	if not checkBless then
		NPC.say('!bless')
		return delay(300)
	end
	for index, value in ipairs(getSpectators(posz())) do
		if value:isNpc() and value:getName() == 'Blessed Tapion' then
			if getDistanceBetween(value:getPosition(), pos()) <= 1 then sayBless = true break end
			g_game.use(g_map.getTile(value:getPosition()):getTopUseThing())
		end
	end
	if sayBless then
		NPC.say(blessSay)
	end
end)

bolMacro = macro(1, function()
	if blessMacro.isOn() then return end
	if getFinger() or Bol:lower():find('n') then modules.game_console.removeTab("NPCs") NPC.closeTrade() return bolMacro.setOff() end
	if not sayBol then
		for index, value in ipairs(getSpectators(posz())) do
			if value:isNpc() and value:getName() == 'Yama Helper' then
				if getDistanceBetween(value:getPosition(), pos()) <= 1 then sayBol = true break end
				g_game.use(g_map.getTile(value:getPosition()):getTopUseThing())
			end
		end
	else
		if type(bolSay) == 'string' then
			NPC.say(bolSay)
		else
			NPC.buy(6299, 1)
			return delay(500)
		end
	end
end)

onTalk(function(name, level, mode, text, channelId, pos)
	if blessMacro.isOff() and bolMacro.isOff() then
		return
	elseif mode ~= 51 then
		return
	elseif name ~= 'Blessed Tapion' and name ~= 'Yama Helper' then
		return
	end
	if text:find('Estou aqui para oferecer') then
		blessSay = 'yes'
	elseif text:find('{protegido} !') then
		blessMacro.setOff()
		storage.bless[player:getName()] = player:getId()
		g_game.talkPrivate(5, player:getName(), 'Bless comprado!')
		modules.game_console.removeTab("NPCs")
	elseif text:find('Estou ajudando o Yama aqui no mund') then
		bolSay = 'trade'
	elseif text:find("Don't you like it?") then
		bolSay = true
	end
end)

onTextMessage(function(mode, text)
	if text == 'Not protected!' then
		checkBless = true
	elseif text == 'Protected!' then
		blessMacro.setOff()
		storage.bless[player:getName()] = player:getId()
	elseif text:find('pode se transformar!') and OutfitSkin ~= player:getOutfit().type then
		outTransform = player:getOutfit().type
	elseif text:find('precisa estar no level') then
		levelToTransform = tonumber(text:match('%d+'))
	end
end)

transformMacro = macro(1, function()
	if player:getOutfit().type == outTransform or player:getOutfit().type == OutfitSkin then return end
	if levelToTransform and levelToTransform > player:getLevel() then return end
	NPC.say('!transformarfinal')
end)


premium = true

function Dist(c)
 if not c then return false end
 if type(c) == 'userdata' then c = c:getPosition() end
 if not c.x and not c.y then return false end
 if c.x and not c.y then
  return(math.abs(c.x-pos().x))
 elseif c.y and not c.x then
  return(math.abs(c.y-pos().y))
 end
 return(math.abs(pos().x-c.x) + math.abs(pos().y-c.y))
end

Stairs = {}


Stairs.Exclude = {}
Stairs.Click = {6264, 1666, 6207, 1948, 435, 7771, 5542, 8657, 6264, 1646, 1648, 1678, 5291, 1680, 6905, 6262, 1664, 13296, 1067, 13861, 11931, 1949, 6896, 6205}

Stairs.postostring = function(pos)
    return(pos.x .. ',' .. pos.y .. ',' .. pos.z)
end

function Stairs.accurateDistance(p1, p2)
    if type(p1) == 'userdata' then
		p1 = p1:getPosition()
	end
	if type(p2) ~= 'table' then
		p2 = pos()
	end
    return math.abs(p1.x-p2.x) + math.abs(p1.y-p2.y)
end

Stairs.Check = {}

Stairs.checkTile = function(tile)
    if not tile then
        return false
	end
	
	local pos = Stairs.postostring(tile:getPosition())
	
    if Stairs.Check[pos] ~= nil then
        return Stairs.Check[pos]
	end
	
    if not tile:getTopUseThing() then
		Stairs.Check[pos] = false
        return false
    end
	
    for _, x in ipairs(tile:getItems()) do
        if table.find(Stairs.Click, x:getId()) then
            Stairs.Check[pos] = true
			return true
        elseif table.find(Stairs.Exclude, x:getId()) then
			Stairs.Check[pos] = false
			return false
		end
    end
	
    local cor = g_map.getMinimapColor(tile:getPosition())
    if cor >= 210 and cor <= 213 and not tile:isPathable() and tile:isWalkable() then
		Stairs.Check[pos] = true
        return true
	else
		Stairs.Check[pos] = false
        return false
    end
end

Stairs.isUsable = function(pos)
	if type(pos) == 'userdata' then
		pos = pos:getPosition()
	end
	
	if type(pos) ~= 'table' then
		return false
	end
	
	local pPos = player:getPosition()
	local inaccurateDistance = getDistanceBetween(pos, pPos)
	if inaccurateDistance <= 2 then
		return true
	end
	if inaccurateDistance > 8 then
		return false
	end
	
	if Stairs.accurateDistance(pPos, pos) > 9 then
		return false
	end
	
	local tile = g_map.getTile(pos)
	if tile and not canBeUsed(tile) then
		return false
	end
	
	return true
end


seePath = function(startPos, destPos, maxDist, params)
  --[[
    Available params:
      ignoreLastCreature
      ignoreCreatures
      ignoreNonPathable
      ignoreNonWalkable
      ignoreStairs
      ignoreCost
      allowUnseen
      allowOnlyVisibleTiles
      precision
      marginMin
      marginMax
      maxDistanceFrom
  ]]
  if not destPos or startPos.z ~= destPos.z then
    return
  end
  if type(maxDist) ~= 'number' then
    maxDist = 100
  end
  if type(params) ~= 'table' then
    params = {}
  end
  local destPosStr = destPos.x .. "," .. destPos.y .. "," .. destPos.z
  params["destination"] = destPosStr
  local paths = findAllPaths(startPos, maxDist, params)

  if not paths[destPosStr] then
    local precision = params.precision
    if type(precision) == 'number' then
      for p = 1, precision do
        local bestCandidate = nil
        local bestCandidatePos = nil
        for x = -p, p do
          for y = -p, p do
            local dest = (destPos.x + x) .. "," .. (destPos.y + y) .. "," .. destPos.z
            local node = paths[dest]
            if node and (not bestCandidate or bestCandidate[1] > node[1]) then
              bestCandidate = node
              bestCandidatePos = dest
            end
          end
        end
        if bestCandidate then
          return translateToPath(paths, bestCandidatePos)      
        end
      end
    end
    return nil
  end
  
  return translateToPath(paths, destPos)
end

translateToPath = function(paths, destPos)
  local directions = {}
  local destPosStr = destPos
  if type(destPos) ~= 'string' then
    destPosStr = destPos.x .. "," .. destPos.y .. "," .. destPos.z
  end
  
  while destPosStr:len() > 0 do
    local node = paths[destPosStr]
    if not node then
      break
    end
    if node[3] < 0 then
      break
    end
    destPosStr = node[4]
	table.insert(directions, destPosStr)
  end
  return directions
end

Stairs.goUse = function(pos)
	if delayUse and delayUse >= now then return end
	pr[4] = now + 300
	player:lockWalk(300)
	local pPos = player:getPosition()
	if Stairs.isUsable(pos)	then
		local tile = g_map.getTile(pos)
		if tile then
			g_game.use(tile:getTopUseThing())
			return 1
		end
	else
		local path = seePath(pos, pPos)
		if path then
			for index, position in ipairs(path) do
				local position = position:split(',')
				position = {x = position[1], y = position[2], z = position[3]}
				if not Stairs.isUsable(position) then
					if tile then
						g_game.use(tile:getTopUseThing())
						return 2
					end
				end
				tile = g_map.getTile(position)
			end
		end
	end
end
	
Stairs.checkAll = function()
	local tiles = {}
	for _, tile in ipairs(g_map.getTiles(posz())) do
		if Stairs.checkTile(tile) then
			table.insert(tiles, tile)
		end
	end
	if #tiles == 0 then return end
    table.sort(tiles, function(a, b)
        return Stairs.accurateDistance(a:getPosition()) < Stairs.accurateDistance(b:getPosition())
    end)
    for y, z in ipairs(tiles) do
        if findPath(z:getPosition(), pos()) then
            return z
        end
    end
	return false
end

onPlayerPositionChange(function(newPos, oldPos)
	tryWalk = nil
	if newPos.z ~= oldPos.z or getDistanceBetween(oldPos, newPos) > 1 then
		delayUse = nil
		Stairs.walk.setOff()
		player:lockWalk(0)
	end
end)

Stairs.walk = macro(1, function()
	if modules.corelib.g_keyboard.isKeyPressed('escape') then return Stairs.walk.setOff() end
	if tryWalk and tryWalk >= now then return end
	if not Stairs.bestTile then Stairs.bestTile = g_map.getTile(Stairs.pos) end
	player:lockWalk(300)
	Stairs.distance = getDistanceBetween(pos(), Stairs.pos)
    Stairs.bestTile:setText('AQUI', 'green')
    if Stairs.bestTile:isWalkable() then
		if not Stairs.bestTile:isPathable() then
			if autoWalk(Stairs.pos, 1) then
				tryWalk = now + 500
				return
			end
		end
	end
	if Stairs.goUse(Stairs.pos) == 1 then
		if (not delayUse or delayUse < now) and (not Stairs.bestTile:isWalkable() or Stairs.bestTile:isPathable()) then
			delayUse = now + 500
		end
	end
end)

Stairs.walk.setOff()

pr = {}
for i = 1, 10 do
	pr[i] = 0
end

Senzu.Exhaust = 0


Outfits = {437, 441, 442, 443, 444, 445, 579, 152, 165, 166, 684, 683, 675}
outfitCheck = {}
for index, value in pairs(Outfits) do
	outfitCheck[value] = true
end
Outfits = nil

Messages = {'Trunks...', 'Bulma...', 'I do this for you!', 'And yes, even for you... Kakarot!', '...'}

messagesCheck = {}
for index, value in pairs(Messages) do
	messagesCheck[value:lower():trim()] = true
end
messages = nil


ca=0
cb=0

onTalk(function(name, level, mode, text, channelId, pos)
	text = text:lower()
	if messagesCheck[text] then
		checkSender = getPlayerByName(name, true)
		if checkSender and outfitCheck[checkSender:getOutfit().type] then
			storage.time[6] = os.time() + 10
			return
		end
	end
	if name ~= player:getName() then return end
	if storage.Buff and text == storage.Buff:lower() then
		storage.time[3] = os.time() + 60
		return
	elseif text == 'flight kubu' then
		storage.time[5] = os.time() + 15
		return
	elseif text == 'blazing zephyr' then
		storage.time[1] = os.time() + 10
		storage.time[2] = os.time() + 10
		pr[5] = now + 750
		return
	elseif text == 'teleport' then
		pr[1] = now + 1750
		pr[5] = now + 1750
		return
	elseif text == 'i feel much better!!!' or text == 'i feel better!!!' then
		Senzu.Exhaust = os.time() + tonumber(Senzu.Tempo)
		return
	elseif text == 'super namekian final flash' then
		storage.time[4] = os.time() + 4
		storage.time[8] = os.time() + 0.95
		cb=1
		return
	elseif text == 'burning shot' then
		storage.time[8] = os.time() + 3
		ca=0
		cb=0
		return
	elseif text == 'kasai no arashi' then
		storage.time[7] = os.time() + 30
		ca=0
		return
	elseif text == Fast:lower() then
		ca=ca+1
		cb=0
		storage.time[10] = os.time() + 1
		if ca > 2 then 
			storage.time[8] = os.time() + 0.95
		end
		return	
	end
end)

onTextMessage(function(mode, text)
	if text:lower():find('exhausted in flight kubu') then
		storage.time[5] = os.time() + getFirstNumberInText(text)
	elseif text:lower() == 'you need a premium account.' then
		premium = false
	end
end)

if type(storage.time) ~= 'table' then
	storage.time = {}
	for i = 1, 10 do
		storage.time[i] = 0
	end
end

onUse(function(pos, itemId, stackPos, subType)
	pr[10] = now + 100
end)

onUseWith(function(pos, itemId, target, subType)
	pr[10] = now + 100
end)


function checkPos(x, y)
	local xyz = g_game.getLocalPlayer():getPosition()
	xyz.x = xyz.x + x
	xyz.y = xyz.y + y
	local tile = g_map.getTile(xyz)
	return tile and g_game.use(tile:getTopUseThing())
end

function actualDirection()
	local dir = player:getDirection()
	if dir > 3 then
		if dir < 6 then
			return 1
		else 
			return 3
		end
	else
		return dir
	end
end

function getClosest(table)
	local closest
	if not table or not table[1] then return false end
	for v, x in pairs(table) do
		if not closest or Dist(closest) > Dist(x:getPosition()) then
			closest = x
		end
	end
	if closest then
		return Dist(closest)
	else
		return false
	end
end

function hasNonWalkable(direc)
	local tabela = {}
	for i = 1, #direc do
		local tile = g_map.getTile({x = player:getPosition().x + direc[i][1], y = player:getPosition().y + direc[i][2], z = player:getPosition().z})
		if tile and not tile:isWalkable(false) then
			table.insert(tabela, tile)
		end
	end
	return tabela
end

function getClosestBetween(x, y)
	if not x and not y then return false end
	if x and not y then
		return 1
	elseif y and not x then
		return 2
	end
	if x < y then
		return 1
	else
		return 2
	end
end

function getDash(dir)
	if not dir then return false end
	local dirs = {}
	local tiles = {}
	if dir == 'n' then
		dirs = {{0, -1}, {0, -2}, {0, -3}, {0, -4}, {0, -5}, {0, -6}, {0, -7}, {0, -8}}
	elseif dir == 's' then
		dirs = {{0, 1}, {0, 2}, {0, 3}, {0, 4}, {0, 5}, {0, 6}, {0, 7}, {0, 8}}
	elseif dir == 'w' then
		dirs = {{-1, 0}, {-2, 0}, {-3, 0}, {-4, 0}, {-5, 0}, {-6, 0}}
	elseif dir == 'e' then
		dirs = {{1, 0}, {2, 0}, {3, 0}, {4, 0}, {5, 0}, {6, 0}}
	end
	for i = 1, #dirs do
		local tile = g_map.getTile({x = player:getPosition().x + dirs[i][1], y = player:getPosition().y + dirs[i][2], z = player:getPosition().z})
		if Stairs.checkTile(tile) then
			table.insert(tiles, tile)
		end
	end
	if not tiles[1] or getClosestBetween(getClosest(hasNonWalkable(dirs)), getClosest(tiles)) == 1 then
		return false
	else
		return true
	end
end

function actualDirection()
	local dir = player:getDirection()
	if dir > 3 then
		if dir < 6 then
			return 1
		else 
			return 3
		end
	else
		return dir
	end
end

function direc(dir)
	if dir == 'e' then
		return {'x', '>'}
	elseif dir == 'w' then
		return {'x', '<'}
	elseif dir == 'n' then
		return {'y', '<'}
	elseif dir == 's' then
		return {'y', '>'}
	end
end

function Stack(dir)
	local stackIn
	local MaxDist = 4
	if premium then
		if storage.time[1] < os.time() or storage.time[2] < os.time() then
			MaxDist = 9
		end
	end
	local pPos = player:getPosition()
	local direction = direc(dir)[1]
	local compare = direc(dir)[2]
	for _, spec in ipairs(getSpectators(posz())) do
		local pos = spec:getPosition()
		if pos then
			if (spec:isMonster() or spec:getEmblem() == 1 or spec:getShield() >= 3) and getDistanceBetween(pPos, spec:getPosition()) <= MaxDist then
				if canBeShoot(spec) then
					if (compare == '>' and pos[direction] > pPos[direction]) or (compare == '<' and pos[direction] < pPos[direction]) then
						if not stackIn or ((compare == '>' and stackIn:getPosition()[direction] < pos[direction]) or (compare == '<' and stackIn:getPosition()[direction] > pos[direction])) then
							stackIn = spec
						end
					end
				end
			end
		end
	end
	if stackIn then
		player:lockWalk(300)
		g_game.stop()
		g_game.attack(stackIn)
		pr[4] = now + 300
		pr[1] = now + 600
		schedule(50, function()
			if MaxDist == 9 and getDistanceBetween(stackIn:getPosition(), player:getPosition()) > 4 then
				if storage.time[2] < os.time() then
					say('shunkanido')
				end
			else
				say('teleport')
			end
		end)
		delay(300)
	end
end


if type(storage.pedra) ~= 'table' then
	storage.pedra = {}
end

if type(storage.pedra[player:getName()]) ~= 'number' then
	storage.pedra[player:getName()] = 0
end

onTalk(function(name, level, mode, text, channelId, pos)
	if player:getName() == name and text == 'The Immortality Of A God!' then
		storage.pedra[player:getName()] = os.time() + (10 * 60)
	end
end)

onTextMessage(function(mode, text)
	if not text:find('exhausted in') then return end
	if text:find('Rinnegan') then
		storage.pedra[player:getName()] = os.time() + tonumber(text:match('%d+'))
	elseif text:find('Time Skip') then
		storage.time[9] = os.time() + tonumber(text:match('%d+'))
	end
end)


xtela, ytela = 300, 10
local TempoPK = 15

if type(storage.att) ~= 'table' or storage.id ~= player:getId() then
	storage.TimeRemain = 0
	storage.att = {}
	storage.id = player:getId()
end

onTextMessage(function(mode, text)
	text = text:lower()
	if text:find('was not justified') or text:find('matou injustamente um jogador') then
		storage.TimeRemain = os.time() + (TempoPK * 60)
		return
	end
	if text:find('due to your') or text:find('you deal') then
		for _, spec in ipairs(getSpectators(posz())) do
			if spec:isPlayer() and text:find(spec:getName():lower()) then
				storage.att[spec:getName()] = {time = os.time() + 60, id = spec:getId()}
				return
			end
		end
	end
end)

local function doFormatMin(v)
	local mins = 00
	local seconds = 00
	mins = string.format("%02.f", math.floor(v / 60))
	seconds = string.format("%02.f", math.abs(math.floor(math.mod(v, 60))))
	return mins .. ":" .. seconds
end

local widget = setupUI([[
Panel
  height: 400
  width: 900
]], g_ui.getRootWidget())

local timepk = g_ui.loadUIFromString([[
Label
  color: white
  background-color: black
  opacity: 0.85
  text-horizontal-auto-resize: true 
]], widget)

local time1 = g_ui.loadUIFromString([[
Label
  color: white
  background-color: black
  opacity: 0.85
  text-horizontal-auto-resize: true 
]], widget)

local time2 = g_ui.loadUIFromString([[
Label
  color: white
  background-color: black
  opacity: 0.85
  text-horizontal-auto-resize: true 
]], widget)


macro(100, function()
	for key, value in pairs(storage.att) do
		local get = getPlayerByName(key, true)
		if get then
			if get:getHealthPercent() == 0 then
				storage.TimeRemain = os.time() + (TempoPK * 60)
				storage.att[name] = nil
			end
		end
		if value.time < os.time() or (get and get:getId() ~= value.id) then
			storage.att[name] = nil
		end
	end
	timepk:setPosition({y = ytela+160, x = xtela+10})
	if storage.TimeRemain < os.time() then
		timepk:setText(' 00:00 ')
		timepk:setColor('green')
	else
		timepk:setText(' ' .. doFormatMin(math.abs(os.time() - storage.TimeRemain)) .. ' ')
		timepk:setColor('red')
	end
	time1:setPosition({y = ytela+200, x = xtela+10})
	if storage.time[5] < os.time() then
		time1:setText(' Flight: ON! ')
		time1:setColor('green')
	else
		time1:setText(' Flight: ' .. math.abs(os.time() - storage.time[5]) .. 's ')
		time1:setColor('red')
	end
	time2:setPosition({y = ytela+240, x = xtela+10})
	if storage.time[7] < os.time() then
		time2:setText(' Kasai no arashi : ON ')
		time2:setColor('green')
	else
		time2:setText(' Kasai no arashi: ' .. math.abs(os.time() - storage.time[7]) .. 's ')
		time2:setColor('red')
	end
end)

local panel = modules.game_interface.getMapPanel()

local widget = [[
Panel
  height: 400
  widget: 900
  background-color: black
  text-horizontal-auto-resize: true
  text-vertical-auto-resize: true
]]

Sense = {}
	
Sense.elapsed = 0
	
Sense.distance = 0
	
Sense.onScreen = setupUI(widget, panel)
	
Sense.actualText = function(text)
	if not text then return end
	text = text:split(', ')
	text[2] = 'E' .. Sense.revertElapsed()
	text[3] = Sense.actualDistance(Sense.Distance)
	local texto
	for _, string in ipairs(text) do
	    if texto then
	      	texto = texto .. ', ' .. string
	    else
	      	texto = string
	    end
	end
	return texto
end
	
Sense.actualDistance = function(n)
	n = tonumber(n)
	return math.abs(n - getDistanceBetween(Sense.lastPosition, player:getPosition()))
end
	
macro(1, function()
	local getC = Sense.Text and getCreatureByName(Sense.Text:split(', ')[1])
	if Sense.elapsed == 0 or (getC and getDistanceBetween(getC:getPosition(), player:getPosition()) <= 7) then
		Sense.onScreen:setHeight(0)
	    return Sense.onScreen:clearText()
	end
	if not Sense.Count or Sense.Count < now then
	    if Sense.Count then
	      	Sense.elapsed = Sense.elapsed - 1
	    end
	    Sense.Count = now + 1000
	end
	Sense.onScreen:setText(Sense.actualText(Sense.Text))
end)
	
Sense.revertElapsed = function()
	return math.abs(Sense.elapsed - 30)
end
	
Sense.actualPosition = function(text)
	if text == 'north' then
	   	return {x = 80, y = -200}
	elseif text == 'south' then
	    return {x = 80, y = 100}
	elseif text == 'west' then
	    return {x = -200, y = -60}
	elseif text == 'east' then
	    return {x = 300, y = -60}
	elseif text == 'north-east' then
	    return {x = 180, y = -150}
	elseif text == 'south-east' then
	    return {x = 200, y = 100}
	elseif text == 'north-west' then
	    return {x = -100, y = -150}
	elseif text == 'south-west' then
	    return {x = -60, y = 100}
	end
end
	
Sense.setPosition = function(position)
	position.x = math.ceil(panel:getWidth() / 2) + position.x
	position.y = math.ceil(panel:getHeight() / 2) + position.y
	return Sense.onScreen:setPosition(position)
end
	
Sense.setPrimary = function(texto, cor, distance)
	if cor == 'very far' then
	    Sense.onScreen:setColor('red')
	elseif cor == 'far' then
	    Sense.onScreen:setColor('yellow')
	elseif cor == '' or cor == 'on a higher level' or cor == 'on a lower level' then
	    Sense.onScreen:setColor('white')
	end
	Sense.elapsed = 30
	Sense.Count = nil
	Sense.setText(texto, Sense.elapsed, cor, distance)
end
	
	
Sense.convertTodistance = function(text, distance)
	if text == 'very far' then
	    return distance
	elseif text == 'far' then
	    return distance
	elseif text == 'on a higher level' then
	    return {distance, 'Up'}
	elseif text == 'on a lower level' then
	    return {distance, 'Down'}
	elseif text == '' then
	    return distance
	end
end
	
Sense.setText = function(texto, tempo, distancia, distance)
	distancia = Sense.convertTodistance(distancia, distance)
	Sense.Distance = distancia
	if type(distancia) == 'table' then
	   	Sense.Distance = distancia[1]
	    distancia = distancia[1] .. ', ' .. distancia[2]
	end
	Sense.Text = texto .. ', ' .. 'E' .. Sense.elapsed ..  ', ' .. distancia
end
	
	
	
onTextMessage(function(mode, text)
	if mode == 20 then
		local regex = "([a-z A-Z]*)is ([a-z -A-Z]*)to the ([a-z -A-Z]*)"
	    local senseData = regexMatch(text, regex)[1]
	    if senseData then
	      	if senseData[2] and senseData[3] and senseData[4] then
	        	Sense.setPosition(Sense.actualPosition(senseData[4]:trim()))
	        	Sense.setPrimary(senseData[2]:trim(), senseData[3]:trim(), text:match('%d+') or 0)
	        	Sense.lastPosition = player:getPosition()
	      	end
	    end
	end
end)

onTextMessage(function(mode, text)
	if mode ~= 20 then return end
	local regex = '([a-z A-Z]*)is ([a-z -A-Z]*)to the ([a-z -A-Z]*)'
	local data = regexMatch(text, regex)[1]
	if data and data[2] ~= storage.senset and data[2] ~= storage.attacker then
		storage.lastsense = data[2]
		return
	end
end)

onKeyPress(function(keys)
	if keys == 'F5' and storage.lastsense and not getCreatureByName(storage.lastsense) then
		pr[2] = now + 300
		say('sense "' .. storage.lastsense)
	elseif keys == 'F6' and storage.senset and not getCreatureByName(storage.senset) then
		pr[2] = now + 300
		say('sense "' .. storage.senset)
	elseif keys == 'F7' and storage.attacker then
		pr[2] = now + 300
		say('sense "' .. storage.attacker)
	end
end)

onAttackingCreatureChange(function(target, oldTarget)
	if not target then return end
	if target:isPlayer() and target:getName() ~= storage.lastsense and target:getName() ~= storage.attacker then
		storage.senset = target:getName()
	end
end)

onTextMessage(function(mode, text)
	if text:find('attack by') then
		for _, p in ipairs(getSpectators(posz())) do
			if p:isPlayer() and text:match('You lose %d+ hitpoints due to an attack by ' .. p:getName().. '.') and storage.senset ~= p:getName() and storage.lastsense ~= p:getName() then
				storage.attacker = p:getName()
				break
			end
		end
	end
end)

positionsToUse = {
    {
      id = 3003,
      x = 296,
      y = 146,
      z = 13
     },
    {
      id = 3003,
      x = 282,
      y = 60,
      z = 13
    },
    {
      x = 775,
      y = 139,
      z = 7
    }
}

macro(100, function()
    if not modules.corelib.g_keyboard.isCtrlPressed() then return end
    for index, value in ipairs(positionsToUse) do
        if value.z == pos().z then
            local tile = g_map.getTile({x = value.x, y = value.y, z = pos().z})
            if tile then
                if value.id then
                    return useWith(tonumber(value.id), tile:getTopUseThing())
                else
                    return use(tile:getTopUseThing())
                end
            end
        end
    end
end)

macro(1, function()
	if OutfitSkin == 0 then return end
	local selfOutfit = player:getOutfit()
	selfOutfit.type = OutfitSkin
	if not table.equals(player:getOutfit(), selfOutfit) and player:getOutfit().type == outTransform then
		setOutfit(selfOutfit)
	end
end)
		
		

		








  