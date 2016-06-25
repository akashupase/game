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
  -- local background = display.newImage("images/background.png", 0, 0)
  -- background.x = display.contentCenterX
  -- background.y = display.contentCenterY

   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
local answer2 = display.newImage("images/answer2.png", display.contentCenterX, display.contentCenterY - 80)
local option1 = display.newImage("images/option2_2.png",90,200)
local option2 = display.newImage("images/option2_1.png", 400, 200)
local option3 = display.newImage("images/option2_3.png", 90, 280)
local option4 = display.newImage("images/option2_4.png", 400, 280)


option1:addEventListener("touch", onOption1Touch)
option2:addEventListener("touch", onOption2Touch)
option3:addEventListener("touch", onOption3Touch)
option4:addEventListener("touch", onOption4Touch)

sceneGroup:insert(option1)
sceneGroup:insert(option2)
sceneGroup:insert(option3)
sceneGroup:insert(option4)
sceneGroup:insert(answer2)

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

function onOption1Touch( event )
print("Wrong")

return true
end

function onOption2Touch( event )
print("Right")
composer.removeScene("scenes.win2", false)
-- composer.gotoScene("scenes.win", {time = 1000, effect = "slideUp"})
      composer.gotoScene('scenes.winimage', {time = 200, effect = "zoomOutInFade"})
-- composer.gotoScene('scenes.winimage')
return true
end

function onOption3Touch( event )
print("Wrong")
return true
end

function onOption4Touch( event )
print("Wrong")
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
