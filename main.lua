
require 'states'

allTabs = {}
allStates = {}


function lovr.load()
	path = "hdr"
	test = lovr.graphics.newTexture("hdr/example.hdr")
	items = lovr.filesystem.getDirectoryItems(path)
	
	for i, v in ipairs(items) do
		createTab(v, lovr.graphics.newTexture(path .. "/".. v), function() 
		
		setState("sky") 
		local sbox = getHDR(v)
		currentSkyBox = sbox
		
		end)
	end
	
	
	cursor = 1
	
	state = "menu"
	currentSkyBox = nil
	
	
	createState("menu", function(pass) 
		drawMenu(pass)
	end)
	createState("sky", function(pass) 
		drawSky(pass)
	end)
	
end


function getHDR(tag)
	for i, v in ipairs(allTabs) do
		if v.title == tag then
			return v.hdr
		end
	end
end

function setState(tag)
	state = tag
end

function lovr.update(dt)
	
end


function lovr.draw(pass)
	for i, v in ipairs(allStates) do
		if state == v.tag then
			v.draw(pass)
		end
	end
end


function lovr.keypressed(key)
	if key == "escape" then
		state = "menu"
	elseif key == "return" then
		if state == "menu" then
			allTabs[cursor].fn()
		end
	end
end


function lovr.wheelmoved(dx, dy)
    -- Якщо прокрутка йде вниз, збільшуємо індекс на одиницю
    if dy < 0 then
        cursor = cursor + 1
        if cursor > #allTabs then
            cursor = 1  -- Повертаємось до першого елемента
        end
    -- Якщо прокрутка йде вгору, зменшуємо індекс
    elseif dy > 0 then
        cursor = cursor - 1
        if cursor < 1 then
            cursor = #allTabs  -- Повертаємось до останнього елемента
        end
    end
end

function collision(x1, y1, w1, h1, x2, y2, w2, h2)
	return x1 < x2 + w2 and
			x1 + w1 > x2 and
			y1 < y2 + h2 and 
			y1 + h1 > y2
end


function createState(tag, draw)
	local newState = {
		tag = tag,
		draw = draw,
	}
	
	table.insert(allStates, newState)
end

function createTab(title, hdr, fn)
	local newTab = {
	title = title,
	x = 0,
	y = 1.7 - #allTabs * 2.7,
	z = -1,
	hdr = hdr,
	w = 10,
	h = 2,
	fn = fn,
	}
	
	table.insert(allTabs, newTab)
end	