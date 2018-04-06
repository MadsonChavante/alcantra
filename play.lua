
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- ----------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------




-- create()
function scene:create( event )

local appodeal = require "plugin.appodeal" 

local function adListener( event )

    if ( event.phase == "init" ) then  -- Successful initialization
        print( event.isError )
    end
end

-- Initialize the Appodeal plugin
appodeal.init( adListener, { appKey="24f5beee36bf72ef15abcbb9ad0ab5ae08421659903ab548" } )


local w = display.contentWidth -- largura da tela
local h = display.contentHeight -- altura da tela

--inicializaçao de atributos 
local estadoDaMovimentacao = 1
local posicaoDofundo = -8000
local  movimentoDeFundo  = 0
local  vlsMovimentacaoVertical = 0
local  posicaoVerticalVls = display.contentHeight - 30
local altitude = 0
local aceleracao = 0
local estadoDojogo = 0 -- 0 - vls na base 1 - vls fora dela 2 - game over 
local  quantidadeDeExp = 0
local  expMinimo = 0
local  aceMinimo = 10
local  contador4 = 0
local  contador3 = 0
local contador2 = 0
local contador22 = 0
local estadoAlerta = 0

local  function posicaoHorizontalIconis()
	local x = math.random(1,3)
	if x == 1 then
		return 160
	end
	if x == 2 then
	 	return 80
	end
	if x == 3 then
		return 240
	end


	end

local function posicaoVerticalIconis()
	return math.random(-400,-10)
end



local background = display.newImage("background.png",0,0,display.contentWidth , display.contentHeight + 1000000) -- cria uma nova imagem de fundo
background.myName = "fundo"


local sheetData2 =  { width = 13 , height = 44 , numFrames=2 }
-- width: largura de cada frame
-- height: altura de cada frame
-- numFrames: número de frames da sprite

local sheet2 = graphics.newImageSheet("fogo.png", sheetData2)
-- cria uma nova imagem usando a sprite "gaara.png" e as propriedades vistas acima

local sequenceData2 = 
{
	{name ="fogo", start = 1, count = 2, time = 100, loopCount = 0 },
	{name ="parado", start = 1, count = 1, time = 100, loopCount = 1 }
	-- name: nome desse movimento
	-- start: frame da sprite onde a animação começa (nesse caso começa no primeiro frame da sprite)
	-- count: número de frames para essa animação (nesse caso essa animação só terá um frame, o primeiro, aquele q o gaara tá parado pra baixo)
	-- time: tempo de duração da animação (está zero pq essa animação só tem um quadro
	-- loopCount: número de vezes que a animação é executada, nesse caso a animação só é executada uma vez, pois só tem um frame
}


local sheetData =  { width = 65.3 , height = 64.3 , numFrames=4 }
-- width: largura de cada frame
-- height: altura de cada frame
-- numFrames: número de frames da sprite

local sheet = graphics.newImageSheet("icone.png", sheetData)
-- cria uma nova imagem usando a sprite "gaara.png" e as propriedades vistas acima

local sequenceData = 
{
	{name = "experiencia", start = 1, count = 2, time = 150, loopCount = 0 },
	-- name: nome desse movimento
	-- start: frame da sprite onde a animação começa (nesse caso começa no primeiro frame da sprite)
	-- count: número de frames para essa animação (nesse caso essa animação só terá um frame, o primeiro, aquele q o gaara tá parado pra baixo)
	-- time: tempo de duração da animação (está zero pq essa animação só tem um quadro
	-- loopCount: número de vezes que a animação é executada, nesse caso a animação só é executada uma vez, pois só tem um frame
	{name = "dinheiro",	start = 3, count = 2 , time = 150 , loopCount = 0}

}

--[[

local sheetData2 =  { width = 120 , height = 107.29, numFrames=11 }
-- width: largura de cada frame
-- height: altura de cada frame
-- numFrames: número de frames da sprite

local sheet2 = graphics.newImageSheet("vls.png", sheetData2)
-- cria uma nova imagem usando a sprite "gaara.png" e as propriedades vistas acima

local sequenceData2 = 
{
	{name = "explossao", start = 2, count = 2, time = 350, loopCount = 1 },
	{name = "normal", start = 1, count = 1, time = 500, loopCount = 1 },
	{name = "n", start = 9, count = 1, time = 500, loopCount = 1 },
	{name = "s", start = 4, count = 6, time = 450, loopCount = 1 },
	{name = "explossao2", start = 10, count = 2, time = 350, loopCount = 1 }
	-- name: nome desse movimento
	-- start: frame da sprite onde a animação começa (nesse caso começa no primeiro frame da sprite)
	-- count: número de frames para essa animação (nesse caso essa animação só terá um frame, o primeiro, aquele q o gaara tá parado pra baixo)
	-- time: tempo de duração da animação (está zero pq essa animação só tem um quadro
	-- loopCount: número de vezes que a animação é executada, nesse caso a animação só é executada uma vez, pois só tem um frame

}

]]

local fogo = display.newSprite(sheet2,sequenceData2)
fogo:setSequence("parado")
local fogo2 = display.newSprite(sheet2,sequenceData2)
fogo2:setSequence("parado")


local  function sequence(i)
	local x = math.random(0,2)
	if x == 1 then
		i.myName = "dinheiro"
		i:setSequence("dinheiro")
	end
	if x == 2 then
		i.myName = "experiencia"
	 	i:setSequence("experiencia")
	end
	end


local moviFogo = 0

local iconis = {}

--posicaoHorizontalIconis()
--posicaoVerticalIconis()
iconis[1] = display.newSprite(sheet,sequenceData)
iconis[1].x =  posicaoHorizontalIconis()
iconis[1].y = posicaoVerticalIconis()
sequence(iconis[1])
iconis[1].objType = "1"


--posicaoHorizontalIconis()
--posicaoVerticalIconis()
iconis[2] = display.newSprite(sheet,sequenceData)
iconis[2].x =  posicaoHorizontalIconis()
iconis[2].y = posicaoVerticalIconis()
sequence(iconis[2])
iconis[2].objType = "2"




iconis[3] = display.newSprite(sheet,sequenceData)
iconis[3].x =  posicaoHorizontalIconis()
iconis[3].y = posicaoVerticalIconis()
sequence(iconis[3])
iconis[3].objType = "3"




iconis[4] = display.newSprite(sheet,sequenceData)
iconis[4].x =  posicaoHorizontalIconis()
iconis[4].y = posicaoVerticalIconis()
sequence(iconis[4])
iconis[4].objType = "4"


local final = display.newImage("final.png")
final.x = 150
final.width =display.contentWidth + 200
final.height = 250
final.y = -200


local vls = display.newImage("vls.png",0,0)

vls.width = 40
vls.height = 70
--vls:setSequence("normal")
vls.x = display.contentCenterX
vls.y = posicaoVerticalVls
vls.myName = "vls"
--local background = display.newRect(0,0, display.contentWidth ,display.contentHeight)
--background:setFillColor( 255, 255, 255 )  0


local physics = require("physics")
 physics.start()
 --physics.setDrawMode( "hybrid" )
 physics.setGravity(0, 0) -- Adiciona a variavel gravidade na fisica


 physics.addBody(iconis[1], "dynamic", {bounce=0.0, friction=0.3})
 physics.addBody(iconis[2], "dynamic", {bounce=0.0, friction=0.3})
 physics.addBody(iconis[3], "dynamic", {bounce=0.0, friction=0.3})
 physics.addBody(iconis[4], "dynamic", {bounce=0.0, friction=0.3})
 physics.addBody( vls, "dynamic", {density=400, radius=10, bounce=0.0  }, { box={ halfWidth=8, halfHeight=50, x=0, y=2}, isSensor=true })

iconis[1].isFixedRotation = true
iconis[2].isFixedRotation = true
iconis[3].isFixedRotation = true
iconis[4].isFixedRotation = true


background.x = display.contentCenterX
background.y = posicaoDofundo 

background.height = 30000
background.width = w



local fumacaEsquerda = display.newImageRect("fumacaEsquerda.png",50,25)
fumacaEsquerda.x = 165
fumacaEsquerda.y = 470
fumacaEsquerda.xScale = 0.1
fumacaEsquerda.alpha = 0


local fumacaDireita = display.newImageRect(  "fumacaDireita.png",50,25)
fumacaDireita.x = 155
fumacaDireita.y = 470
fumacaDireita.xScale = 0.1
fumacaDireita.alpha = 0

local final2 = display.newImage("final2.png")
final2.x = 150
final2.width =display.contentWidth + 200
final2.height = 1000
final2.y = -300

local gamerover = display.newImage("gamerover.png")
gamerover.width = 290
gamerover.height = 310
gamerover.x = display.contentCenterX - 2
gamerover.y = 270
gamerover.alpha = 0
appodeal.show( "interstitial" )

local textoAltitude2 = display.newText(altitude,160,175,native.systemFont,30)
local textoAceleracao2 = display.newText(aceleracao,225,383,native.systemFont,30)
local textoQuantidadeDeExp2 = display.newText(quantidadeDeExp,225,323,native.systemFont,30)
textoAceleracao2.alpha = 0
textoAltitude2.alpha = 0
textoQuantidadeDeExp2.alpha = 0  

local nasai = audio.loadStream( "NASAi.mp3" )
local nasaiChannel

local nasar = audio.loadStream( "NASAr.mp3" )
local nasarChannel

local  aux = 0

local touchFunction = function(e)
	local eventName = e.phase
	local direction = e.target.myName
	
	--if eventName == "began" or eventName == "moved" then
	if direction == "acelerar" and estadoDojogo ~= 2 and aceleracao < 150 then 
		if aceleracao == 0 then
			nasaiChannel = audio.play( nasai, { channel=10, loops=0, fadein=50  } )
			nasarChannel = audio.play( nasar, { channel=9, loops=-1, fadein=2000  } )
			movimentoDeFundo = movimentoDeFundo + 1
			vlsMovimentacaoVertical = vlsMovimentacaoVertical - 1
			movimentoDeFundo = movimentoDeFundo + 1
			estadoDojogo = 1
			aceleracao = aceleracao + 10
			fumacaEsquerda.alpha = 1
			fumacaDireita.alpha = 1
			transition.to(fumacaEsquerda,{time = 4500, xScale = 5.0, yScale = 6.5, x = 50 ,  y = 450 })
			transition.to(fumacaDireita,{time = 4500, xScale = 5.0, yScale = 6.5, x = 270 ,  y = 450 })
			fogo:setSequence("fogo")
			fogo:play()
			fogo2:setSequence("fogo")
			fogo2:play()
			fumacaDireita.e = 1
	 	
	 	else
			movimentoDeFundo = movimentoDeFundo + 0.1
			vlsMovimentacaoVertical = vlsMovimentacaoVertical - 0.1
			movimentoDeFundo = movimentoDeFundo + 0.1
			estadoDojogo = 1
			aceleracao = aceleracao + 1
		end

	end
	if direction == "frear" and aceleracao > 0  then
		posicaoVerticalVls = posicaoVerticalVls + 0.1  
		movimentoDeFundo = movimentoDeFundo - 0.1
		vlsMovimentacaoVertical = vlsMovimentacaoVertical + 0.1
		movimentoDeFundo = movimentoDeFundo - 0.1
		if aceleracao > 0 then
			aceleracao = aceleracao - 1
		end
	end
	if direction == "fundo" and estadoDojogo ~= 0 then
		
		--reiniciando o jogo
		if aux >= 2 then

		gamerover.alpha = 0

		 vls.rotation = 0
		 estadoDaMovimentacao = 1
		 posicaoDofundo = -8000
		 movimentoDeFundo  = 0
		 vlsMovimentacaoVertical = 0
		 posicaoVerticalVls = display.contentHeight - 30
		 altitude = 0
		 aceleracao = 0
		 estadoDojogo = 0 -- 0 - vls na base 1 - vls fora dela 2 - game over 
		 quantidadeDeExp = 0
		 expMinimo = 0
		 aceMinimo = 10
		 vls.x = display.contentCenterX
		 background.y = posicaoDofundo
		
		fogo:setSequence("parado")
		fogo2:setSequence("parado")
		moviFogo = 0
		fogo.rotation = 0
		fogo2.rotation = 0
        


		fumacaEsquerda = display.newImageRect("fumacaEsquerda.png",50,25)
		fumacaEsquerda.x = 165
		fumacaEsquerda.y = 470
		fumacaEsquerda.xScale = 0.1
		fumacaEsquerda.alpha = 0


	 	fumacaDireita = display.newImageRect(  "fumacaDireita.png",50,25)
		fumacaDireita.x = 155
		fumacaDireita.y = 470
		fumacaDireita.xScale = 0.1
		fumacaDireita.alpha = 0


		iconis[1].x =  posicaoHorizontalIconis()
		iconis[1].y = posicaoVerticalIconis()
		sequence(iconis[1])
		iconis[1].objType = "1"
		contador3 = 0
		contador4 = 0
		contador2 = 0
		contador22 = 0
		

		iconis[2].x =  posicaoHorizontalIconis()
		iconis[2].y = posicaoVerticalIconis()
		sequence(iconis[2])
		iconis[2].objType = "2"


		iconis[3].x =  posicaoHorizontalIconis()
		iconis[3].y = posicaoVerticalIconis()
		sequence(iconis[3])
		iconis[3].objType = "3"


		iconis[4].x =  posicaoHorizontalIconis()
		iconis[4].y = posicaoVerticalIconis()
		sequence(iconis[4])
		iconis[4].objType = "4"



		textoAceleracao2.alpha = 0
		textoAltitude2.alpha = 0
		textoQuantidadeDeExp2.alpha = 0 
		
		audio.stop(exploChannel)

		aux = 0
		end
		
		if e.phase == "moved"  and e.x > vls.x-50 and e.x < vls.x + 50 then
			if vls.x > e.x then
				vls.rotation = -3
				fogo.rotation = -4
				fogo2.rotation = -4
				moviFogo = 3
				
			end
			if vls.x < e.x then
				vls.rotation = 3
				fogo.rotation = 4
				fogo2.rotation = 4
				moviFogo = -3
			end
			if vls.x == e.x then
				vls.rotation = 0
				fogo.rotation = 0
				fogo2.rotation = 0
				moviFogo = 0
			end
			
			vls.x = e.x

		end
		if e.phase == "ended" then
			vls.rotation = 0
			moviFogo = 0
			fogo.rotation = 0
			fogo2.rotation = 0

			-- duplo toque 
			if estadoDojogo == 2 then
				aux = aux + 1
			end
			

		end

	end
end

--painel 
local painel2 = display.newImage("painel2.png",159.6,220)

painel2.width = 380
painel2.height = 450

local alert = display.newImage("alert.png",0,0)

alert.width = 50
alert.height = 50
alert.xScale = 0.1
alert.yScale = 0.1

function mostrarAlerta(x)
	if x == 1 then
		alert.x = 295
		alert.y = 175
		alert.rotation = -4
	else
		alert.x = 25
		alert.y = 175
		alert.rotation = 4
	end
	

	
	transition.to(alert,{time = 1000, xScale = 0.5, yScale = 0.5, onComplete = function ()
		transition.to(alert,{time = 1000, xScale = 0.1, yScale = 0.1})
		-- body
	end})
	
end

local textoAltitude = display.newText(altitude,w*.509,48,native.systemFont,30)
local textoAceleracao = display.newText(aceleracao,w*.922,116,native.systemFont,30)
textoAceleracao.rotation = -4
local textoQuantidadeDeExp = display.newText(quantidadeDeExp,w*.089,116,native.systemFont,30)
textoQuantidadeDeExp.rotation = 4
local textoExpMinimo = display.newText(expMinimo,w*.070,227,native.systemFont,30)
textoExpMinimo.rotation = 4
local textoAceMinimo = display.newText(aceMinimo,w*.94,227,native.systemFont,30)
textoAceMinimo.rotation = -4


local buttons = {}

buttons[1] = display.newImage("bAcelerar.png")
buttons[1].width = 40
buttons[1].height = 60
buttons[1].x = w - buttons[1].contentWidth * .50
buttons[1].y = 305
buttons[1].myName = "acelerar"
buttons[1].rotation = 0



buttons[2] = display.newImage("bFrear.png")
buttons[2].width = 40
buttons[2].height = 60
buttons[2].x = 0 + buttons[1].contentWidth * .50
buttons[2].y = 305
buttons[2].myName = "frear"
buttons[2].rotation = 0



local j=1

for j=1, #buttons do 
	buttons[j]:addEventListener("touch", touchFunction)
end

vls:addEventListener("touch", touchFunction)
background:addEventListener("touch", touchFunction)

local alertaPainel0 = display.newImage("alertPainel0.png")

alertaPainel0.x = 244
alertaPainel0.y = 56.4
alertaPainel0.width = 47.3
alertaPainel0.height = 25
alertaPainel0.isVisible = true

local alertaPainel1 = display.newImage("alertPainel1.png")

alertaPainel1.x = 244
alertaPainel1.y = 56.4
alertaPainel1.width = 47.3
alertaPainel1.height = 25
alertaPainel1.isVisible = false

local  function verificandoAlertaPainel( ... )
	if estadoAlerta == 1 then
		alertaPainel1.isVisible = true
		alertaPainel0.isVisible = false
	else
		alertaPainel1.isVisible = false
		alertaPainel0.isVisible = true
	
	end
end 

local function replicacao(i)
	-- body
	iconis[i].y = posicaoVerticalIconis()
	iconis[i].x = posicaoHorizontalIconis()
	sequence(iconis[i])
end


local function sensorCollide( self, event )
	if  "began" == event.phase then
		if event.other.myName == "experiencia" then
			quantidadeDeExp = quantidadeDeExp + 1
		end
		if event.other.myName == "dinheiro" then
			quantidadeDeExp = quantidadeDeExp - 2
		end
	end
		if event.other.objType == "1" then
       		transition.to(iconis[1],{time = 1 , y = 800 , transition = easing.inExpo})
   		end
   		if event.other.objType == "2" then
       		transition.to(iconis[2],{time = 1 , y = 800 , transition = easing.inExpo})
   		end
   		if event.other.objType == "3" then
       		transition.to(iconis[3],{time = 1 , y = 800 , transition = easing.inExpo})
   		end
   		if event.other.objType == "4" then
       		transition.to(iconis[4],{time = 1 , y = 800 , transition = easing.inExpo})
   		end


end

local explo = audio.loadStream( "Explo.mp3" )
local exploChannel


function verificandoValoresMinimos()
	--verificando valores minimmos
	
	if aceMinimo > aceleracao and estadoDojogo == 1 then
		
		contador3 = contador3 + 1
		estadoAlerta = 1
		mostrarAlerta(1)
		if contador3 == 3 then

			exploChannel = audio.play( explo , { channel=4, loops=0, fadein= 0 } )

			iconis[1]:pause()
			iconis[2]:pause()
			iconis[3]:pause()
			iconis[4]:pause()
			fogo:pause()
			fogo2:pause()
			estadoDojogo = 2
			
			gamerover.alpha = 1
			
			audio.stop(nasaiChannel)
			audio.stop(nasarChannel)

			textoAceleracao2.text = aceleracao
			textoAltitude2.text = altitude
			textoQuantidadeDeExp2.text = quantidadeDeExp


			textoAceleracao2.alpha = 1
			textoAltitude2.alpha = 1
			textoQuantidadeDeExp2.alpha = 1 	

		end
	elseif contador4 == 0 then
		contador3 = 0
		estadoAlerta = 0
		alert.x = -50
		alert.y = -50
	end
	if expMinimo > quantidadeDeExp and estadoDojogo == 1 then
		contador4 = contador4 + 1
		estadoAlerta = 1
		mostrarAlerta(2)
		if contador4 == 3 then
			exploChannel = audio.play( explo , { channel=4, loops=0, fadein= 0 } )

			iconis[1]:pause()
			iconis[2]:pause()
			iconis[3]:pause()
			iconis[4]:pause()
			estadoDojogo = 2
			
			gamerover.alpha = 1
			
			audio.stop(nasaiChannel)
			audio.stop(nasarChannel)


			textoAceleracao2.text = aceleracao
			textoAltitude2.text = altitude
			textoQuantidadeDeExp2.text = quantidadeDeExp


			textoAceleracao2.alpha = 1
			textoAltitude2.alpha = 1
			textoQuantidadeDeExp2.alpha = 1 
		
		end
	elseif contador3 == 0 then
		contador4 = 0
		estadoAlerta = 0
		alert.x = -40
		alert.y = -40
	end

	-- body
end

-- Associate collision handler function with character
vls.collision = sensorCollide
vls:addEventListener( "collision" ) 


local ajuda = posicaoVerticalVls
local contador = 0
local contador3 = 0
local auxAceMinimo = 1
local auxExpMinimo = 1


timer.performWithDelay( 2000, verificandoValoresMinimos , 0 )

local update = function()
if estadoDojogo == 2 then
	contador2 = 0 

else

	if altitude > 3000 then
		final2.y =final2.y + 0.5
		final.y =final.y + 0.2
		vls.y = vls.y - 0.1
		iconis[1].x = -210
		iconis[2].x = -210
		iconis[3].x = -210
		iconis[4].x = -210
		estadoDojogo = 66
		if final.y > 138 then
			final.y =final.y - 0.2
		end
		if final2.y > 438 then
			final2.y =final2.y - 0.5
		end
	end
	

verificandoAlertaPainel()

--mostrando na tela textos atualizados 
textoAltitude.text = altitude
textoAceleracao.text = aceleracao
textoQuantidadeDeExp.text = quantidadeDeExp 
textoExpMinimo.text = expMinimo
textoAceMinimo.text = aceMinimo

iconis[1]:play() --executa a animação, é necessário usar essa função para ativar a animação
iconis[2]:play()
iconis[3]:play() --executa a animação, é necessário usar essa função para ativar a animação
iconis[4]:play()

if estadoDojogo == 0 then
	vls.x = display.contentCenterX
	vls.rotation = 0 
end

-- incrementando a altitude do foguete 
if estadoDojogo ~= 0 then
	contador = contador + movimentoDeFundo
end
if posicaoVerticalVls <= ajuda and estadoDojogo  == 1  then
	if contador > 10 then
	    altitude = altitude + 1
	    auxAceMinimo = auxAceMinimo + 1
	    auxExpMinimo = auxExpMinimo + 1
	    contador = 0
	end
	ajuda = posicaoVerticalVls
elseif posicaoVerticalVls > ajuda and estadoDojogo ~= 0 then
	if contador > 10 then
	    altitude = altitude + 1
	    auxAceMinimo = auxAceMinimo + 1
	    auxExpMinimo = auxExpMinimo + 1
	    contador = 0
	end
	ajuda = posicaoVerticalVls
end


--incrementando  a aceleraçao minimo
if auxAceMinimo >= 50 and aceMinimo <= 100 then
	contador2 = contador2 + 1 
	if contador2 <= 3 then
		aceMinimo = aceMinimo + 5
	else	
		aceMinimo = aceMinimo + 1
	end
	auxAceMinimo = 0
end

--incrementando  a exp minimo
if auxExpMinimo >= 100 and expMinimo < 100 then
	contador22 = contador22 + 1 
	if contador2 <= 2 then
		expMinimo = expMinimo + 0
	elseif contador2 <= 4 then 	
		expMinimo = expMinimo + 1
	else
		expMinimo = expMinimo + 2
	end
	auxExpMinimo = 0
end



if estadoDaMovimentacao == 0 then
	if posicaoDofundo < 1400 then
		posicaoDofundo = posicaoDofundo + movimentoDeFundo
	end
	iconis[1].y = iconis[1].y + movimentoDeFundo 
	iconis[2].y = iconis[2].y + movimentoDeFundo
	iconis[3].y = iconis[3].y + movimentoDeFundo
	iconis[4].y = iconis[4].y + movimentoDeFundo 
	background.y = posicaoDofundo
end
if estadoDaMovimentacao == 1 then
	posicaoVerticalVls = posicaoVerticalVls + vlsMovimentacaoVertical
	vls.y = posicaoVerticalVls
end
if posicaoVerticalVls <= h*0.7 then 
	estadoDaMovimentacao = 0 
end
if posicaoVerticalVls > h*0.7 then
	estadoDaMovimentacao = 1	
end

 

-- analisando se algum iconi saiu da tela
local j = 1
for j=1, #iconis do 
	if iconis[j].y > h + 30 then
		replicacao(j)

	end
end


fogo.x = vls.x - 11 + moviFogo
fogo.y = vls.y + 47

fogo2.x = vls.x + 10 + moviFogo
fogo2.y = vls.y + 47 


if fumacaDireita.e == 1 then 
	transition.to(fumacaEsquerda,{time = 4500, alpha = 0 })
	transition.to(fumacaDireita,{time = 4500,  alpha = 0})
	fumacaDireita.e = 0


end


end

end

Runtime:addEventListener("enterFrame", update)-----------------------------------------------------------------------------------------



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
