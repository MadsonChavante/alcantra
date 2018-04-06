
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoGame()
    composer.gotoScene( "play" )
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------




-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

    local background = display.newImageRect( sceneGroup, "fundoMenu.png", 800, 1400 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY	


    local fundo1 = display.newImageRect(sceneGroup , "fundo1.png",450 ,450)
    fundo1.y = display.contentHeight + 30  
    fundo1.x = display.contentWidth + 30
    fundo1.alpha = 0



    local fundo2 = display.newImageRect(sceneGroup , "fundo2.png",650 ,650)
    fundo2.y = display.contentHeight + 30  
    fundo2.x = display.contentWidth + 30
    fundo2.alpha = 0

    local brasil = display.newImageRect( sceneGroup, "brasil.png", 20, 20 )
    brasil.y = math.random(0,400)
    brasil.x = math.random(0,400)
    brasil.alpha = 0

    brasil.d = math.random(0,1)

	brasil.estado = math.random(3,4)



    local satelite = display.newImageRect( sceneGroup, "satelite.png", 50, 50 )
    satelite.y = 123
    satelite.x = 300
    satelite.rotation = 10
    satelite.alpha = 0




    local alcantraR = display.newImageRect(sceneGroup , "alcantraR.png", display.contentWidth - 70 , 50)
    alcantraR.y = 120
    alcantraR.x = display.contentCenterX
    alcantraR.alpha = 0


    local alcantra = display.newImageRect(sceneGroup , "alcantra.png", display.contentWidth - 70 , 40)
    alcantra.y = 90
    alcantra.x = display.contentCenterX
    alcantra.alpha = 0

    local vls = display.newImageRect( sceneGroup, "vls1.png", 0, 0 )
    vls.x = display.contentCenterX
    vls.y = display.contentHeight - 30

    vls.width = 40
    vls.height = 70

    local play = display.newImageRect( sceneGroup, "play.png", 100, 100 )
    play.y = 240
    play.x = display.contentCenterX


    local tuto = display.newImageRect( sceneGroup, "tuto.png", 100, 50 )
    tuto.y = 40
    tuto.x = display.contentCenterX  - 14
    tuto.alpha = 0



	local fumacaEsquerda = display.newImageRect(sceneGroup , "fumacaEsquerda.png",50,25)
	fumacaEsquerda.x = 165
	fumacaEsquerda.y = 470
	fumacaEsquerda.xScale = 0.1
	--fumacaEsquerda.yScale = 0.1



	local fumacaDireita = display.newImageRect(sceneGroup , "fumacaDireita.png",50,25)
	fumacaDireita.x = 155
	fumacaDireita.y = 470
	fumacaDireita.xScale = 0.1


	transition.to(brasil,{time = 3500 , alpha = 0 ,onComplete = function ()
			transition.to(brasil,{time = 2000, alpha = 0 }) 
		end}) 
	transition.to(fumacaEsquerda,{time = 4500, xScale = 5.0, yScale = 6.5, x = 50 ,  y = 450 })
	transition.to(fumacaDireita,{time = 4500, xScale = 5.0, yScale = 6.5, x = 270 ,  y = 450 , onComplete = function ()
		transition.to(alcantraR,{time = 3500, alpha = 1 })
		transition.to(alcantra,{time = 3500, alpha = 1,onComplete = function ()
			transition.to(fundo1,{time = 2000, alpha = 1,onComplete = function ()
				transition.to(fundo2,{time = 100, alpha = 1 })
				transition.to(tuto,{time = 200, alpha = 1 })
				brasil.alpha = 1
			end })
		end })


		
	end})
	
	local space = audio.loadStream( "Space.mp3" )
	local spaceChannel

	local nasa = audio.loadStream( "NASA.mp3" )
	local nasaChannel
	
	local fui = 0 
	local movimentacao = 0.01
	function update( ... )
		vls.y = vls.y - movimentacao
		fumacaDireita.y = fumacaDireita.y + movimentacao
		fumacaEsquerda.y = fumacaEsquerda.y + movimentacao

		movimentacao = movimentacao * 1.0399
		nasaChannel = audio.play( nasa, { channel=2, loops=0, fadein=5000 } )

		if tuto.alpha == 1 and fui == 0  then
			brasil.rotation = brasil.rotation + 0.1
			fundo1.rotation = fundo1.rotation + 0.03
			fundo2.rotation = fundo2.rotation + 0.1
			audio.setVolume( 0.8 , { channel=2 } )
			spaceChannel = audio.play( space, { channel=11, loops=-1, fadein=5000 } )
		end

		if brasil.estado == 3 then
				if brasil.x > display.contentWidth or brasil.d == 0 then
					brasil.x = brasil.x - 0.3
					brasil.d = 0
				end
				if brasil.x < 0 or brasil.d == 1 then
					brasil.x = brasil.x + 0.3
					brasil.d = 1 
				end 
				if brasil.y > display.contentHeight then
					brasil.estado = 4
				end
			brasil.y = brasil.y + 0.3	
		elseif brasil.estado == 4 then

			if brasil.x > display.contentWidth or brasil.d == 0 then
				brasil.x = brasil.x - 0.3
				brasil.d = 0
			end
			if brasil.x < 0 or brasil.d == 1 then
				brasil.x = brasil.x + 0.3
				brasil.d = 1 
			end 
			if brasil.y < 0 then
				brasil.estado = 3
			end
			brasil.y = brasil.y - 0.3

		end 
	end

	

	function playButton()
		fui = 1
		audio.pause( spaceChannel )
		audio.pause( nasaChannel )

		composer.gotoScene( "play" )
		
	end

	function playButton2()
		fui = 1
		audio.pause( spaceChannel )
		audio.pause( nasaChannel )
		composer.gotoScene( "tutorial" )
		
	end


	play:addEventListener("tap", playButton)

	tuto:addEventListener("tap", playButton2)

	Runtime:addEventListener("enterFrame", update)
    --local playButton = display.newText( sceneGroup, "Play", display.contentCenterX, 150, native.systemFont, 44 )
    --playButton:setFillColor( 0.82, 0.86, 1 )
 
    --local highScoresButton = display.newText( sceneGroup, "High Scores", display.contentCenterX, 200, native.systemFont, 44 )
    --highScoresButton:setFillColor( 0.75, 0.78, 1 )

    --playButton:addEventListener("tap", gotoGame)

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
