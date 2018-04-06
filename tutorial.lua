
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

		
	local w = display.contentWidth -- largura da tela
	local h = display.contentHeight -- altura da tela


	local background = display.newImage(sceneGroup,"background.png",0,0,display.contentWidth , display.contentHeight + 1000000) -- cria uma nova imagem de fundo
	background.myName = "fundo"
	background.x = w * 0.5


	local tela = display.newImage(sceneGroup,"tela.png",display.contentCenterX,-200)
	local textoTutorial = display.newText(sceneGroup,"  Olá ! seja bem vindo :) ",display.contentCenterX,-200,native.systemFont,15)
	local vidro = display.newImage(sceneGroup,"vidro.png",display.contentCenterX,-200)	

	--painel 
	local painel2 = display.newImage(sceneGroup,"painel2.png",159.6,220)

	painel2.width = 380
	painel2.height = 450

	local alert = display.newImage(sceneGroup,"alert.png",0,0)

	alert.width = 50
	alert.height = 50
	alert.xScale = 0.1
	alert.yScale = 0.1

	local posicaoVerticalVls = 450	

	local sheetData2 =  { width = 13 , height = 44 , numFrames=2 }

	local sheet2 = graphics.newImageSheet("fogo.png", sheetData2)

	local sequenceData2 = 
	{
		{name ="fogo", start = 1, count = 2, time = 100, loopCount = 0 },
		{name ="parado", start = 1, count = 1, time = 100, loopCount = 1 }
	}


	local fogo = display.newSprite(sheet2,sequenceData2)
	fogo:setSequence("parado")
	local fogo2 = display.newSprite(sheet2,sequenceData2)
	fogo2:setSequence("parado")


	local vls = display.newImage("vls.png",0,0)

	vls.width = 40
	vls.height = 70
	--vls:setSequence("normal")
	vls.x = display.contentCenterX
	vls.y = posicaoVerticalVls

	local altitude = 0
	local aceleracao = 0
	local quantidadeDeExp = 0 
	local aceMinimo = 0
	local expMinimo = 0

	local textoAltitude = display.newText(sceneGroup,altitude,w*.509,48,native.systemFont,30)
	local textoAceleracao = display.newText(sceneGroup,aceleracao,w*.922,116,native.systemFont,30)
	textoAceleracao.rotation = -4
	local textoQuantidadeDeExp = display.newText(sceneGroup,quantidadeDeExp,w*.089,116,native.systemFont,30)
	textoQuantidadeDeExp.rotation = 4
	local textoExpMinimo = display.newText(sceneGroup,expMinimo,w*.070,227,native.systemFont,30)
	textoExpMinimo.rotation = 4
	local textoAceMinimo = display.newText(sceneGroup,aceMinimo,w*.94,227,native.systemFont,30)
	textoAceMinimo.rotation = -4


	local fumacaEsquerda = display.newImageRect(sceneGroup , "fumacaEsquerda.png",50,25)
	fumacaEsquerda.x = 165
	fumacaEsquerda.y = 470
	fumacaEsquerda.xScale = 0.1
	--fumacaEsquerda.yScale = 0.1



	local fumacaDireita = display.newImageRect(sceneGroup , "fumacaDireita.png",50,25)
	fumacaDireita.x = 155
	fumacaDireita.y = 470
	fumacaDireita.xScale = 0.1


	local buttons = {}

	buttons[1] = display.newImage(sceneGroup,"bAcelerar.png")
	buttons[1].width = 40
	buttons[1].height = 60
	buttons[1].x = w - buttons[1].contentWidth * .50
	buttons[1].y = 305
	buttons[1].myName = "acelerar"
	buttons[1].rotation = 0



	buttons[2] = display.newImage(sceneGroup,"bFrear.png")
	buttons[2].width = 40
	buttons[2].height = 60
	buttons[2].x = 0 + buttons[1].contentWidth * .50
	buttons[2].y = 305
	buttons[2].myName = "frear"
	buttons[2].rotation = 0



	local circulo  = display.newImage(sceneGroup,"circulo.png")
	circulo.width = 80
	circulo.height = 80
	circulo.x = 290
	circulo.y = 110
	circulo.alpha = 0 
	local circulo2  = display.newImage(sceneGroup,"circulo.png")
	circulo2.width = 80
	circulo2.height = 80
	circulo2.x = 300
	circulo2.y = 220
	circulo2.alpha = 0
	local seta = display.newImage(sceneGroup,"seta.png")
	seta.width = 50 
	seta.height = 50
	seta.x = 220
	seta.y = 140
	seta.alpha = 0
	local seta2 = display.newImage(sceneGroup,"seta.png")
	seta2.rotation = 270
	seta2.width = 50 
	seta2.height = 50
	seta2.x = 230
	seta2.y = 220
	seta2.alpha = 0
	local maiorIgual = display.newText(sceneGroup,">=",200,175,native.systemFont,30)
	maiorIgual.alpha = 0

	local mostrarvalores = display.newImage(sceneGroup,"mostrarvalores.png")
	mostrarvalores.alpha = 0
	mostrarvalores.width = 140
	mostrarvalores.height = 60
	mostrarvalores.x = display.contentWidth/2
	mostrarvalores.y = 120


	local mao = display.newImage(sceneGroup,"mao.png")
	mao.x = display.contentCenterX
	mao.y = 310
	mao.alpha = 0



	function mostrarValores()
		mostrarvalores.alpha = 1
		
	end


	local c1 = 0 
	local estadoTutorial = 0

	function textoTuto( )
		c1 = c1 + 1
		if c1 == 1 then
			textoTutorial.size = 12 
			textoTutorial.text = " Apertando no botão Verde \n no seu painel direito,\n você decola o foguete "
			estadoTutorial = 1 
		elseif c1 == 2 then
			textoTutorial.text = "Otimo ! agora se continuar\napertando o verde sua\n aceleraçao aumenta\n e vermelho frear , ok ?!"
		elseif c1 == 3 then
			textoTutorial.text = "PRESTE MUITA ATENÇÃO !\nO seu valor atual , precisar\n ser maior ou igual\n,ao que é exigido! "
		elseif c1 == 4 then 
			textoTutorial.text = "Sua experiência fica\n do lado esquerdo "
		elseif c1 == 5 then
			textoTutorial.size = 11.5 
			textoTutorial.text = " e ela é obtida ou\n desperdiçada através\ndos ícones experiência(verde)\n e falta de recurso(vermelho) "
		elseif c1 == 6 then

		end
		
	end


	local nasai = audio.loadStream( "NASAi.mp3" )
	local nasaiChannel

	local nasar = audio.loadStream( "NASAr.mp3" )
	local nasarChannel


	function estadoTuto()
		if estadoTutorial == 1 then
			transition.to(mao,{time = 100, alpha = 1})
			transition.to(mao,{time = 1500 , x = 250 ,onComplete = function ()
				transition.to(mao,{time = 1500, x = 50  }) 
			end}) 

		elseif estadoTutorial == 2 then
			mao.alpha = 0 
			fogo:setSequence("fogo")
			fogo2:setSequence("fogo")
			textoAceMinimo.text = "10"
			nasaiChannel = audio.play( nasai, { channel=3, loops=0, fadein=50  } )
			nasarChannel = audio.play( nasar, { channel=1, loops=-1, fadein=20000  } )
			transition.to(fumacaEsquerda,{time = 4500, xScale = 5.0, yScale = 6.5, x = 50 ,  y = 450 })
			transition.to(fumacaDireita,{time = 4500, xScale = 5.0, yScale = 6.5, x = 270 ,  y = 450 })
			estadoTutorial = 3
		elseif estadoTutorial == 3 then
			transition.to(fumacaEsquerda,{time = 4500, alpha = 0 })
			transition.to(fumacaDireita,{time = 4500, alpha = 0  })
		elseif estadoTutorial == 4 then
			mao.x = 200
			estadoTutorial = 5
			textoTuto()
		elseif estadoTutorial == 5 then 
			transition.to(mao,{time = 100, alpha = 1})
			transition.to(mao,{time = 1500 , x = 250 ,onComplete = function ()
				transition.to(mao,{time = 1500, x = 50  }) 
			end}) 
		elseif estadoTutorial == 6 then
			if c1 == 2 then
				textoTuto()
			end
			transition.to(mao,{time = 4000, x = 200 ,onComplete = function ( ... )
				transition.to(circulo,{time = 1500, alpha = 1, onComplete = function ( ... )
					transition.to(circulo2,{time = 1500, alpha = 1,onComplete = function ( ... )
						transition.to(seta,{time = 1500, alpha = 1,onComplete = function ( ... )
							transition.to(maiorIgual,{time = 1500, alpha = 1,onComplete = function ( ... )
								transition.to(seta2,{time = 1500, alpha = 1, onComplete = function ( ... )
									transition.to(mao,{time = 1000, x = 250 , onComplete = function ( ... )
										transition.to(circulo,{time = 200, alpha = 0  })
										transition.to(circulo2,{time = 200, alpha = 0  })
										transition.to(maiorIgual,{time = 200, alpha = 0  })
										transition.to(seta,{time = 200, alpha = 0  })
										transition.to(seta2,{time = 200, alpha = 0  }) 
										estadoTutorial = 7
									end })
								end})
							end})
						end})
					end})	
				end})
			
			end })

	
		elseif estadoTutorial == 7 then
			transition.to(fumacaEsquerda,{time = 13500, x = -400 , onComplete = function ( ... )
				if c1 == 3 then
					textoTuto()
					estadoTutorial = 8
				end
			end })
			
				
		elseif estadoTutorial == 8 then
			transition.to(fumacaEsquerda,{time = 3500, x = -800 , onComplete = function ( ... )
				textoTuto()
				estadoTutorial = 9
			end })
			
				
		elseif estadoTutorial == 9 then
			mao.x = display.contentWidth /2 - 10
			mao.y = 270 
			mao.rotation = 90
					
			transition.to(fumacaEsquerda,{time = 8500, x = -800 , onComplete = function ( ... )
			

				if estadoTutorial == 9 then  
					
					textoTutorial.text = ""
					mostrarValores()
			
				end
				

				transition.to(fumacaEsquerda,{time = 4250, x = -1800 , onComplete = function ( ... )
					transition.to(fumacaEsquerda,{time = 2250, x = -2800 , onComplete = function ( ... )
					
					if estadoTutorial == 9 then  
						estadoTutorial = 10
					end


					mostrarvalores.alpha = 0
					textoTutorial.text = "Movimentação do vls "


				
					end })
				end })
				
					
			end })
		elseif estadoTutorial  == 10 then

		end
	end

	function touchFunction(e)
		if c1 == 1 then
			estadoTutorial = 2
			a = 11
			textoAceleracao.text = a
		elseif c1 == 2 then 
			aceleracao = a + 1
			textoAceleracao.text = aceleracao 
			estadoTutorial = 6
			transition.to(mao,{time = 500, alpha = 0 }) 
		elseif estadoTutorial == 11 then
			audio.stop(nasaiChannel)
			audio.stop(nasarChannel)
			composer.gotoScene( "play" )
		end
	end

	transition.to(tela,{time = 4500, y = 100})
	transition.to(textoTutorial,{time = 4500, y = 110})
	transition.to(vidro,{time = 4500, y = 100})

	timer.performWithDelay(6500 ,textoTuto, 1 )
	timer.performWithDelay(500 ,estadoTuto, 0 )

	local movimentacao = 0.01

	local play = display.newImageRect( sceneGroup, "play.png", 100, 100 )
    play.y = 240
    play.x = display.contentCenterX
    play.alpha = 0

	function update( ... )	
		if estadoTutorial == 1 then
				buttons[1]:addEventListener("tap", touchFunction)
		elseif estadoTutorial == 3 then 
			vls.y = vls.y - movimentacao
			movimentacao = movimentacao * 1.0399
			if vls.y < h/2 + 100 then
				estadoTutorial = 4
			end
		elseif estadoTutorial == 5 then
				buttons[1]:addEventListener("tap", touchFunction)
		end

		fogo:play()
		fogo2:play()

		fogo.x = vls.x - 11 
		fogo.y = vls.y + 47

		fogo2.x = vls.x + 11
		fogo2.y = vls.y + 47 

		if estadoTutorial == 10 then
			mao.alpha = 1
			mao.x = mao.x - 0.5
			vls.x = vls.x - 0.5
			if mao.x < 100 then
				estadoTutorial = 11
			end
		elseif estadoTutorial == 11 then 
			mao.x = mao.x + 1
			vls.x = vls.x + 1
			if mao.x > 200 then 
				mao.x = mao.x - 1
				vls.x = vls.x - 1
			    play.alpha =1
				
			end
		end

	end
	play:addEventListener("tap", touchFunction)
	Runtime:addEventListener("enterFrame", update)

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
