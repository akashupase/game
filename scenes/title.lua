local composer = require( "composer" )
local scene = composer.newScene()
local counter=0
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
local title = display.newImage("images/title.png", 240, 140)
sceneGroup:insert(title)


title.enterFrame = enterFrame2
Runtime:addEventListener("enterFrame",title )



end

function enterFrame2(event)
counter=counter+1
if(counter >= 70) then
  composer.removeScene("scenes.title", false)
  composer.gotoScene("scenes.menu2", {
		effect = "zoomInOutFade",
        time = 400
        })


end

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

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
