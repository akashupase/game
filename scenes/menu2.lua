local composer = require( "composer" )
local scene = composer.newScene()

---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------

-- "scene:create()"
function scene:create( event )

   local sceneGroup = self.view
   local background = display.newImage("images/background2.png", 0, 0)
   background.x = display.contentCenterX
   background.y = display.contentCenterY

   local menu = display.newImage("images/Play.png", display.contentCenterX, display.contentCenterY - 100)
   local sound = display.newImage("images/mute.png", display.contentCenterX, display.contentCenterY )
   local exit = display.newImage("images/EXIT.png", display.contentCenterX, display.contentCenterY +100)
      menu:addEventListener("touch", onMenuTouch)
      sound:addEventListener("touch", onSoundTouch)
      exit:addEventListener("touch", onExitTouch)
      backgroundMusic = audio.loadStream( "background.mp3" )
     laserChannel = audio.play( backgroundMusic )

   sceneGroup:insert(background)
   sceneGroup:insert(menu)
   sceneGroup:insert(sound)
   sceneGroup:insert(exit)
--    Runtime:addEventListener( "touch", onScreenTouch)
   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end

-- "scene:show()"
function scene:show( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
   end
end

-- "scene:hide()"
function scene:hide( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
   end
end

-- "scene:destroy()"
function scene:destroy( event )

   local sceneGroup = self.view

   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end


 function onMenuTouch( event )
	if event.phase == "ended" or event.phase == "cancelled" then
		local options = {
            effect = "slideLeft",
            time = 1000
        }
        print ("Menu Touched")
        composer.gotoScene('scenes.levelSelectScreen')
        -- laserChannel1 = audio.stop( laserChannel)
		-- Detect swipe direction and change scene
    end
    return true
end

function onSoundTouch( event )
laserChannel1 = audio.stop( laserChannel)
return true
end


function onExitTouch( event )
os.exit()
return true
end
---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
