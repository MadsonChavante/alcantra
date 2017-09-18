-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code heredisplay.setStatusBar (display.HiddenStatusBar) -- esconde a barra de status 

display.setStatusBar (display.HiddenStatusBar) -- esconde a barra de status 

local composer = require( "composer" )

local scene = composer.newScene()


local w = display.contentWidth -- largura da tela
local h = display.contentHeight -- altura da tela

--inicializaçao de atributos 
local estadoDaMovimentacao = 1
local posicaoDofundo = -1000
local  movimentoDeFundo  = 0
local  vlsMovimentacaoVertical = 0
local  posicaoVerticalVls = display.contentHeight - 50
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
	return math.random(-200,-10)
end



local background = display.newImage("background.png",0,0,display.contentWidth , display.contentHeight + 1000) -- cria uma nova imagem de fundo
background.myName = "fundo"



local sheetData =  { width = 45 , height = 45, numFrames=4 }
-- width: largura de cada frame
-- height: altura de cada frame
-- numFrames: número de frames da sprite

local sheet = graphics.newImageSheet("fogo.png", sheetData)
-- cria uma nova imagem usando a sprite "gaara.png" e as propriedades vistas acima

local sequenceData = 
{
	{name = "experiencia", start = 1, count = 2, time = 500, loopCount = 0 },
	-- name: nome desse movimento
	-- start: frame da sprite onde a animação começa (nesse caso começa no primeiro frame da sprite)
	-- count: número de frames para essa animação (nesse caso essa animação só terá um frame, o primeiro, aquele q o gaara tá parado pra baixo)
	-- time: tempo de duração da animação (está zero pq essa animação só tem um quadro
	-- loopCount: número de vezes que a animação é executada, nesse caso a animação só é executada uma vez, pois só tem um frame
	{name = "dinheiro",	start = 3, count = 2 , time = 500 , loopCount = 0}

}



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


local vls = display.newSprite(sheet2,sequenceData2)

vls.width = 0
vls.height = 0
vls:setSequence("normal")
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
 physics.addBody( vls, "dynamic", {density=400, radius=10, bounce=0.0  }, { box={ halfWidth=8, halfHeight=50, x=0, y=2}, isSensor=true })

iconis[1].isFixedRotation = true
iconis[2].isFixedRotation = true


background.x = display.contentCenterX
background.y = posicaoDofundo

background.height = 3000
background.width = w


local textoGameOver =  display.newText("",w*.5,h*.5,native.systemFont,40)



local touchFunction = function(e)
	local eventName = e.phase
	local direction = e.target.myName
	
	--if eventName == "began" or eventName == "moved" then
	if direction == "acelerar" and estadoDojogo ~= 2 and aceleracao < 150 then 
		if aceleracao == 0 then
			movimentoDeFundo = movimentoDeFundo + 1
			vlsMovimentacaoVertical = vlsMovimentacaoVertical - 1
			movimentoDeFundo = movimentoDeFundo + 1
			estadoDojogo = 1
			aceleracao = aceleracao + 10
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
		if estadoDojogo == 2 then

		textoGameOver.text = ""

		 vls.rotation = 0
		 estadoDaMovimentacao = 1
		 posicaoDofundo = -1000
		 movimentoDeFundo  = 0
		 vlsMovimentacaoVertical = 0
		 posicaoVerticalVls = display.contentHeight - 50
		 altitude = 0
		 aceleracao = 0
		 estadoDojogo = 0 -- 0 - vls na base 1 - vls fora dela 2 - game over 
		 quantidadeDeExp = 0
		 expMinimo = 0
		 aceMinimo = 10
		 vls.x = display.contentCenterX
		 background.y = posicaoDofundo
		--posicaoHorizontalIconis()
		--posicaoVerticalIconis()
		iconis[1].x =  posicaoHorizontalIconis()
		iconis[1].y = posicaoVerticalIconis()
		sequence(iconis[1])
		iconis[1].objType = "1"
		vls:setSequence("normal")
		contador3 = 0
		contador4 = 0
		contador2 = 0
		contador22 = 0
		





		--poisicaoHorizontalIconis()
		--poisicaoVerticalIconis()
		iconis[2].x =  posicaoHorizontalIconis()
		iconis[2].y = posicaoVerticalIconis()
		sequence(iconis[2])
		iconis[2].objType = "2"


		end
		if e.phase == "moved" then
			if vls.x > e.x then
				vls.rotation = -3
			end
			if vls.x < e.x then
				vls.rotation = 3
			end
			if vls.x == e.x then
				vls.rotation = 0
			end
			
			vls.x = e.x

		end
		if e.phase == "ended" then
			vls.rotation = 0
		end

	end
end

--painel 
local painel2 = display.newImage("painel2.png",160.5,155)

painel2.width = 380
painel2.height = 320

local minimo = display.newImage("minimo.png",160,440)

minimo.width = 360
minimo.height = 100


local alert = display.newImage("alert.png",0,0)

alert.width = 50
alert.height = 50
alert.xScale = 0.1
alert.yScale = 0.1

function mostrarAlerta(x)
	if x == 1 then
		print("entrou aqui ")
		alert.x = 283
		alert.y = 370
	else
		alert.x = 35
		alert.y = 370
	end
	

	
	transition.to(alert,{time = 1000, xScale = 0.8, yScale = 0.8, onComplete = function ()
		transition.to(alert,{time = 1000, xScale = 0.4, yScale = 0.4})
		-- body
	end})
	
end

local textoAltitude = display.newText(altitude,w*.24,52,native.systemFont,30)
local textoAceleracao = display.newText(aceleracao,w*.665,52,native.systemFont,30)
local textoQuantidadeDeExp = display.newText(quantidadeDeExp,w*.06,113,native.systemFont,30)
textoQuantidadeDeExp.rotation = 3
local textoExpMinimo = display.newText(expMinimo,w*.112,445,native.systemFont,30)
local textoAceMinimo = display.newText(aceMinimo,w*.89,445,native.systemFont,30)


local buttons = {}

buttons[1] = display.newImage("bAcelerar.png")
buttons[1].width = 40
buttons[1].height = 60
buttons[1].x = w - buttons[1].contentWidth * .45
buttons[1].y = 250
buttons[1].myName = "acelerar"
buttons[1].rotation = 0



buttons[2] = display.newImage("bFrear.png")
buttons[2].width = 40
buttons[2].height = 60
buttons[2].x = 0 + buttons[1].contentWidth * .45
buttons[2].y = 250
buttons[2].myName = "frear"
buttons[2].rotation = 0



local j=1

for j=1, #buttons do 
	buttons[j]:addEventListener("touch", touchFunction)
end

vls:addEventListener("touch", touchFunction)
background:addEventListener("touch", touchFunction)


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
end


function verificandoValoresMinimos()
	--verificando valores minimmos
	
	if aceMinimo > aceleracao and estadoDojogo == 1 then
		
		contador3 = contador3 + 1
		mostrarAlerta(1)
		if contador3 == 3 then
			if altitude > 100 then
				vls:setSequence("explossao2")
			elseif altitude < 100 then
				vls:setSequence("explossao")
			end
			iconis[1]:pause()
			iconis[2]:pause()
			vls:play()
			estadoDojogo = 2
			textoGameOver.text = "Game Over"
		end
	elseif contador4 == 0 then
		contador3 = 0
		alert.x = -50
		alert.y = -50
	end
	if expMinimo > quantidadeDeExp and estadoDojogo == 1 then
		contador4 = contador4 + 1
		mostrarAlerta(2)
		if contador4 == 3 then
			if altitude > 100 then
				vls:setSequence("explossao2")
			elseif altitude < 100 then
				vls:setSequence("explossao")
			end
			iconis[1]:pause()
			iconis[2]:pause()
			vls:play()
			estadoDojogo = 2
			textoGameOver.text = "Game Over"
		end
	elseif contador3 == 0 then
		contador4 = 0
		alert.x = -40
		alert.y = -40
	end

	-- body
end

-- Associate collision handler function with character
vls.collision = sensorCollide
vls:addEventListener( "collision" ) 

function separacao(x)
	if x == 1 then
		vls:setSequence("s")
		vls:play()
		--vls:setSequence("separacao1")
		--vls:play()
	end
			
	-- body
end


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

--mostrando na tela textos atualizados 
textoAltitude.text = altitude
textoAceleracao.text = aceleracao
textoQuantidadeDeExp.text = quantidadeDeExp 
textoExpMinimo.text = expMinimo
textoAceMinimo.text = aceMinimo

iconis[1]:play() --executa a animação, é necessário usar essa função para ativar a animação
iconis[2]:play()


-- incrementando a altitude do foguete 
if estadoDojogo ~= 0 then
	contador = contador + movimentoDeFundo
end
if posicaoVerticalVls <= ajuda and estadoDojogo ~= 0 then
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

 
--anilisando separaçao
if altitude == 100 then
	separacao(1)
	--vls:setSequence("n")
	--vls:play()
end

-- analisando se algum iconi saiu da tela
local j = 1
for j=1, #iconis do 
	if iconis[j].y > h + 30 then
		replicacao(j)

	end
end




end

end

Runtime:addEventListener("enterFrame", update)-----------------------------------------------------------------------------------------


