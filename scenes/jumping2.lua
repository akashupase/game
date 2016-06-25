local composer = require( "composer" )
local scene = composer.newScene()
local physics = require("physics")
physics.start()

local barrel = nil
local barrel1 = nil
local tapCount = 0
local isFalling = false
local player = nil

local lifeText
local lives = 5
local scoreText
local noOfPiecesCollected = 0
local noOfPieces = 8
local puzzlePiece = nil
local counter = 0
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------

 function scrollCity(self, event)
  if self.x < -364 then
    self.x = 828
  else
    self.x = self.x - 3
  end
end

function scrollCity1(self, event)
  if self.x < -364 then
    self.x = 828
  else
    self.x = self.x - 2
  end
end


-- "scene:create()"
function scene:create( event )

   local sceneGroup = self.view
   self.gotoPreviousScene = 'scenes.menu2'
  -- local background = display.newImage("images/background.png", 0, 0)
  -- background.x = display.contentCenterX
  -- background.y = display.contentCenterY
  local bg = display.newImage("images/bg.png")
  bg.anchorX, bg.anchorY = 0, 0
  bg.x = -45
   bg.y = 0
    local ground = display.newImage("images/ground1.png", 10, 310)
   ground.anchorX, ground.anchorY = 0, 0
   ground.x = -45
   ground.y = 280
   barrel = display.newImage( "images/barrel.png", 570 , 255)
   barrel1 = display.newImage( "images/barrel.png", 1040 , 255)
   local city1 = display.newImage("images/city1.png", 254 , 65)
   local city3 = display.newImage("images/city1.png", 854, 65)
   local city2 = display.newImage("images/city2.png", 254, 204)
   local city4 = display.newImage("images/city2.png", 854, 204)


    scoreText = display.newText("Pieces Collected:"..noOfPiecesCollected.."/"..noOfPieces, 30, 15, native.systemFont, 15)
  scoreText:setFillColor(0,0,0)
  lifeText = display.newText("Life:"..lives, 480, 15, native.systemFont, 15)
  lifeText:setFillColor(0,0,0)

    local playerOptions  = {
          width = 74,
          height = 90,
          numFrames = 20
      } -- Player Frame numbers

      local playerSpriteSheet = graphics.newImageSheet("images/adventure.png", playerOptions)

      local sequences_runningCat =  {
       {
           name = "run",
           start = 1,
           count = 10,
           time = 500,
           loopCount = 0,
           loopDirection = "forward"
       },
       {
           name = "jump",
           start = 11,
           count = 10,
           time = 500,
           loopCount = 1,
           loopDirection = "forward"
       }

   }

       player = display.newSprite(playerSpriteSheet, sequences_runningCat)
       player.x = 80
       player.y = 250
       player:setSequence("run")
       player:play()

    puzzlePiece = display.newImage( "images/puzzlepiece.png", 1200 , 100)

    sceneGroup:insert(bg)
    sceneGroup:insert(city1)
    sceneGroup:insert(city3)
    sceneGroup:insert(city2)
    sceneGroup:insert(city4)
    sceneGroup:insert(ground)

    sceneGroup:insert(player)
    sceneGroup:insert(barrel)
    sceneGroup:insert(barrel1)
    sceneGroup:insert(puzzlePiece)
    sceneGroup:insert(scoreText)
    sceneGroup:insert(lifeText)


   barrel.enterFrame = moveBarrel
   barrel.myName = "barrel"
   Runtime:addEventListener("enterFrame", barrel)

   barrel1.enterFrame = moveBarrel
   barrel1.myName = "barrel2"
   Runtime:addEventListener("enterFrame", barrel1)

   puzzlePiece.enterFrame = movePiece
   puzzlePiece.myName = "Puzzle"
   Runtime:addEventListener("enterFrame", puzzlePiece)

    player.enterFrame = playerMove
    player.myName = "player"
    Runtime:addEventListener("enterFrame", player)

    city1.enterFrame = scrollCity1
   Runtime:addEventListener("enterFrame", city1)
   city3.enterFrame = scrollCity1
   Runtime:addEventListener("enterFrame", city3)
   city2.enterFrame = scrollCity
   Runtime:addEventListener("enterFrame", city2)
   city4.enterFrame = scrollCity
   Runtime:addEventListener("enterFrame", city4)



    Runtime:addEventListener("touch", onTouch)

    physics.addBody( ground,"static",   {density=1.0, friction=1, bounce=0.3})
    physics.addBody(player, "dynamic", {density=3.0, friction=1, bounce=0.1})

   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.

end

function onTouch(event)
    if(event.phase == "began") then
        if tapCount == 0 then
            player:applyForce(0, -4000, player.x, player.y)
            player:setSequence("jump")
            player:play()
            tapCount = tapCount + 1
            isFalling = true
        elseif tapCount == 1 then
            player:applyForce(0, -4000, player.x, player.y)
            tapCount = tapCount + 1
            isFalling = true

        end
        -- composer.gotoScene("scenes.menu2", {time = 1000, effect = "slideUp"})
    end
end

function movePiece(self, event)
    self.x = self.x - 4
    if self.x < -50 and counter <= 3 then
        setLevelPiece()
    end
end

function playerMove(self, event)
    self.rotation = 0
-- print(self.y)
    if self.y >= 234 and isFalling == true then
    isFalling = false
    tapCount = 0
    self:setSequence("run")
    self:play()


    -- player.rotation = 0
    -- composer.removeScene("scenes.jumping4", false)
-- composer.gotoScene("scenes.menu2", {time = 1000, effect = "slideUp"})
  end
  if( checkCollisionWithBarrel(self, barrel)) then
        print("collided with"..barrel.myName)
        collidedWithBarrel(1)
    end
    if (checkCollisionWithBarrel(self, barrel1)) then
        print('collided with'..barrel1.myName)
        collidedWithBarrel(2)
    end

    if(checkCollision(self, puzzlePiece)) then
        print('collided with Puzzle')
        collectPiece()
    end

end

function setLevelPiece()
    puzzlePiece.x = 1000 --Put Random code here
    counter = counter + 1
    if(counter > noOfPieces) then
        puzzlePiece.x = 5000
    end
end

function collectPiece()
    noOfPiecesCollected = noOfPiecesCollected + 1
    scoreText.text = "Pieces Collected:"..noOfPiecesCollected.."/"..noOfPieces
    setLevelPiece()
    if noOfPiecesCollected >= noOfPieces then
      composer.removeScene("scenes.jumping2", false)
      composer.gotoScene("scenes.win2", {time = 1000, effect = "slideUp"})
  end
end

function collidedWithBarrel(index)
    -- lives
    lives = lives - 1;
    lifeText.text = "Life:"..lives
    moveBarrel2(index)
    if(lives <= 0) then
        composer.removeScene("scenes.jumping2", false)
        composer.gotoScene("scenes.levelSelectScreen", {time = 1000, effect = "slideUp"})
    end
end

function moveBarrel2(index)
    if(index == 1) then
        barrel.x = math.max(570, barrel1.x + 200) + math.random (0,30)--Respawning of the barrel
    elseif (index == 2) then
        barrel1.x = math.max(570, barrel.x + 150) + math.random (0,30) -- Respawning of Barrel 2
    end
end

function checkCollision(obj1, obj2)

    if ( obj1 == nil ) then  -- Make sure the first object exists
        return false
    end
    if ( obj2 == nil ) then  -- Make sure the other object exists
        return false
    end
 local xBuffer = 20
 local yBuffer = 10
--  print("XMin = "..obj1.contentBounds.xMin.." XMax = "..obj1.contentBounds.xMax.." YMin = "..obj1.contentBounds.yMin.." YMax = "..obj1.contentBounds.yMax)
    local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
    local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
    local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
    local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax

    return (left or right) and (up or down)

end

function checkCollisionWithBarrel(obj1, obj2)

    if ( obj1 == nil ) then  -- Make sure the first object exists
        return false
    end
    if ( obj2 == nil ) then  -- Make sure the other object exists
        return false
    end
 local xBuffer = 20
 local yBuffer = 10
--  print("XMin = "..obj1.contentBounds.xMin.." XMax = "..obj1.contentBounds.xMax.." YMin = "..obj1.contentBounds.yMin.." YMax = "..obj1.contentBounds.yMax)
    -- local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
    -- local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
    -- local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
    -- local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax

    -- return (left or right) and (up or down)
    local radius = 40
    local distance = (obj1.x - obj2.x)*(obj1.x - obj2.x) + (obj1.y - obj2.y) * (obj1.y - obj2.y)
    if(distance < radius * radius) then
        return true
    else
        return false
    end
end

function moveBarrel(self, event)
    -- print(self.myName)
    self.rotation = self.rotation - 5
    self.x = self.x - 8
    if(self.x < -50) then
        if(self.myName == "barrel") then
            moveBarrel2(1)
        else
            moveBarrel2(2)
        end
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
    print("destroy")

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
