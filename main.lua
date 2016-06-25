-- Corona Cannon
-- A complete remake of Ghosts vs. Monsters sample game for Corona SDK.
-- Most of the graphics made by kenney.nl
-- Please use Corona daily build 2016.2818 or later.
-- Created by Sergey Lerg for Corona Labs.
-- License - MIT.
-- changed by ravindra chitlangi on Jun 24 2016

system.activate('multitouch')
if system.getInfo('build') >= '2015.2741' then -- Allow the game to be opened using an old Corona version
	display.setDefault('isAnchorClamped', false) -- Needed for scenes/reload_game.lua animation
end

-- Hide navigation bar on Android
if platform == 'Android' then
	native.setProperty('androidSystemUiVisibility', 'immersiveSticky')
end

local composer = require('composer')
composer.recycleOnSceneChange = true -- Automatically remove scenes from memory
composer.setVariable('levelCount', 4) -- Set how many levels there are under levels/ directory

-- Add support for back button on Android and Window Phone
-- When it's pressed, check if current scene has a special field gotoPreviousScene
-- If it's a function - call it, if it's a string - go back to the specified scene
if platform == 'Android' or platform == 'WinPhone' then

	Runtime:addEventListener('key', function(event)
		if event.phase == 'down' and event.keyName == 'back' then
			local scene = composer.getScene(composer.getSceneName('current'))
            if scene then
				if type(scene.gotoPreviousScene) == 'function' then
                	scene:gotoPreviousScene()
                	return true
				elseif type(scene.gotoPreviousScene) == 'string' then
					composer.gotoScene(scene.gotoPreviousScene, {time = 500, effect = 'slideRight'})
					return true
				end
            end
		end
	end)
end

local function goBack (scene)
	local options = {
		effect = "zoomInOutFade",
        time = 400
        }
	composer.gotoScene( scene , options)
end

local function onKeyEvent( event )
    local keyName = event.keyName
    local phase = event.phase

 	local scene = composer.getSceneName( "current" )
 	local backscene = {
 		["scenes.menu2"] = function () native.requestExit() end,
 		["scenes.levelSelectScreen"] = function () goBack ("scenes.menu2") end,
 		["scenes.jumping1"] = function () goBack ("scenes.levelSelectScreen") end,
		 ["scenes.jumping2"] = function () goBack ("scenes.levelSelectScreen") end,
		 ["scenes.jumping3"] = function () goBack ("scenes.levelSelectScreen") end,
		 ["scenes.jumping4"] = function () goBack ("scenes.levelSelectScreen") end

 		-- ["scripts.puzzle"] = function () goBack ("scripts.select") end,
 		-- ["scripts.language"] = function () goBack ("scripts.menu") end,
 		-- ["scripts.aboutus"] = function () goBack ("scripts.menu") end
 	}

    -- Listening for B as well so can test Android Back with B key
    if ("back" == keyName and phase == "down") or ("b" == keyName and phase == "down" and system.getInfo("environment") == "simulator")  then
        --print("Back", scene)
 		if (backscene[scene]) then
 			backscene[scene]()
 			return true
 		end

    end

   if event.keyName == 's' and event.phase == 'down' and system.getInfo("environment") == "simulator" then
     local scene = display.captureScreen(false)
     --if scene then
     --   print( "screenshot" )
       display.save(scene, {filename = display.pixelWidth .. 'x' .. display.pixelHeight .. '_' .. math.floor(system.getTimer()) .. '.png', isFullResolution=false})
       scene:removeSelf( )
       return true
     --end
   end

    return false
end
Runtime:addEventListener("key", onKeyEvent)

-- Please note that above Runtime events use anonymous listeners. While it's fine for these cases,
-- it is not possible to remove the event listener if needed. For instanse, an accelerometer event listener must be removed at some point
-- to reduce battery consumption.
-- The above cases are fine to use anonymous listeners because we don't need to remove them ever.


-- Show menu scene
composer.gotoScene('scenes.title', {effect = "zoomOutInFade",	time = 400})
