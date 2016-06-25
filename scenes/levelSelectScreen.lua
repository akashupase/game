local composer = require( "composer" )
local widget = require('widget')
local scene = composer.newScene()

---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------

-- "scene:create()"
function scene:create( event )
 local W, H = display.actualContentWidth , display.actualContentHeight
 local CX, CY = W / 2, H / 2

   local sceneGroup = self.view
   local background = display.newRect(sceneGroup, CX, CY, W +90, H)
	background.fill = {
	    type = 'gradient',
	    color1 = {0.45, 0.45, 0.2},
	    color2 = {0.5, 0.9, 0.7}
	}

    sceneGroup:insert(background)

    local visualButtons = {}

	local buttonsGroup = display.newGroup()
	buttonsGroup.x, buttonsGroup.y = _CX, 0
	-- group:insert(buttonsGroup)
	sceneGroup:insert(buttonsGroup)

	local function onLevelButtonRelease(event)
		-- sounds.play('tap')
    composer.removeScene("scenes.levelSelectScreen")
        if(event.target.id == 1) then
            composer.gotoScene('scenes.jumping1',  {time = 1000, effect = "slideUp"})
        elseif (event.target.id == 2) then
            composer.gotoScene('scenes.jumping2',  {time = 1000, effect = "slideUp"})
        elseif (event.target.id == 3) then
            composer.gotoScene('scenes.jumping3',  {time = 1000, effect = "slideUp"})
        else
            composer.gotoScene('scenes.jumping4',  {time = 1000, effect = "slideUp"})
        end
	end

    local x, y = 0, 0
	local spacing = 170
	for i = 1, composer.getVariable('levelCount') do
		local button = widget.newButton({
			id = i,
			label = i,
			labelColor = {default = {1}, over = {0.5}},
			font = native.systemFontBold,
			fontSize = 50,
			labelYOffset = -10,
			defaultFile = 'images/buttons/level.png',
			overFile = 'images/buttons/level-over.png',
			width = 130, height = 130,
			x = x * spacing + 160, y = 70 + y * spacing + 10,
			onRelease = onLevelButtonRelease
		})
		buttonsGroup:insert(button)
		table.insert(visualButtons, button)
      	-- local check = display.newImageRect('images/check.png', 48, 48)
		-- check.anchorX, check.anchorY = 1, 1
		-- check.x, check.y = button.width - 3, button.height - 18
		-- button:insert(check) -- Insert after positioning, because if inserted before, button.width/height will be different


		x = x + 1
		if x == 2 then
			x = 0
			y = y + 1
		end
	end
    -- self.gotoPreviousScene = 'scenes.menu2' -- Allow going back on back button press
  -- local background = display.newImage("images/background.png", 0, 0)
  -- background.x = display.contentCenterX
  -- background.y = display.contentCenterY

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

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
