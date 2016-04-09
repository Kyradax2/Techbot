
-------------------------
---------TechBot---------
-------------------------

function love.load()
	-- main settings
	love.window.setMode(1120, 600)
	love.window.setTitle("TechBot")
	math.randomseed(os.time())

	-- graphics
		-- Uldarin
	UsR = love.graphics.newImage("assets/Uldarin/UstandingRight.png")
	UsL = love.graphics.newImage("assets/Uldarin/UstandingLeft.png")
	UsR2 = love.graphics.newImage("assets/Uldarin/UstandingRight2.png")
	UsL2 = love.graphics.newImage("assets/Uldarin/UstandingLeft2.png")
	UwR = love.graphics.newImage("assets/Uldarin/UwalkingRight.png")
	UwL = love.graphics.newImage("assets/Uldarin/UwalkingLeft.png")
	UwR2 = love.graphics.newImage("assets/Uldarin/UwalkingRight2.png")
	UwL2 = love.graphics.newImage("assets/Uldarin/UwalkingLeft2.png")
	UjR = love.graphics.newImage("assets/Uldarin/UjumpingRight.png")
	UjL = love.graphics.newImage("assets/Uldarin/UjumpingLeft.png")
	UjR2 = love.graphics.newImage("assets/Uldarin/UjumpingRight2.png")
	UjL2 = love.graphics.newImage("assets/Uldarin/UjumpingLeft2.png")
	UjR3 = love.graphics.newImage("assets/Uldarin/UjumpingRight3.png")
	UjL3 = love.graphics.newImage("assets/Uldarin/UjumpingLeft3.png")
	UjR4 = love.graphics.newImage("assets/Uldarin/UjumpingRight4.png")
	UjL4 = love.graphics.newImage("assets/Uldarin/UjumpingLeft4.png")
	UjR5 = love.graphics.newImage("assets/Uldarin/UjumpingRight5.png")
	UjL5 = love.graphics.newImage("assets/Uldarin/UjumpingLeft5.png")
	UjR6 = love.graphics.newImage("assets/Uldarin/UjumpingRight6.png")
	UjL6 = love.graphics.newImage("assets/Uldarin/UjumpingLeft6.png")
	UjR7 = love.graphics.newImage("assets/Uldarin/UjumpingRight7.png")
	UjL7 = love.graphics.newImage("assets/Uldarin/UjumpingLeft7.png")
	UjR8 = love.graphics.newImage("assets/Uldarin/UjumpingRight8.png")
	UjL8 = love.graphics.newImage("assets/Uldarin/UjumpingLeft8.png")
	Usplit = love.graphics.newImage("assets/Uldarin/Usplit.png")
		-- Objects
	greyBox = love.graphics.newImage("assets/Stuff/greyBox100x100.png")
	Floor1 = love.graphics.newImage("assets/Stuff/Floor1.png")
	Floor2 = love.graphics.newImage("assets/Stuff/Floor2.png")
	laser = love.graphics.newImage("assets/Stuff/laser.png")
	laser4 = love.graphics.newImage("assets/Stuff/laser4.png")
	lava1 = love.graphics.newImage("assets/Stuff/lava1.png")
	lava2 = love.graphics.newImage("assets/Stuff/lava2.png")
	lava3 = love.graphics.newImage("assets/Stuff/lava3.png")
		-- Backgrounds
	GO = love.graphics.newImage("assets/BG/gameOver.png")
	Start = love.graphics.newImage("assets/BG/Start.png")


	-- variables
		-- Uldarin
	U = {	sprite = UsR,
		Ux = 548,
		Uy = 340,
		CD = 0,		-- cooldown jump
		Udx = 0,	-- x acceleration
		Udy = 0,	-- y acceleration
		air = 0,	-- is in air ?
		jetPack = 20,	-- going up
		animWalk = 0,	-- walking animation
		animJump = 0,	-- jumping animation
		animStand = 0,	-- standing animation
		dead = 0,	-- are u dead ?
		split = 0,	-- split or not ?
		lastD = 'r'}	-- last direction pressed
		-- Objects
	Obj = {}
	Obj[1] = {	item = Floor1,
			x = -280,
			y = -50}
	Obj[2] = {	item = greyBox,
			x = 800,
			y = 300}
	Obj[3] = {	item = greyBox,
			x = 1200,
			y = 300}
	for i = 4, 304 do
		Obj[i] = {	item = laser,
				x = math.random(-500, 2000),
				y = -250,
				dx = 10 * math.random() - 5,
				dy = 5 * math.random() + 0.1}
	end
	for i = 305, 605 do
		Obj[i] = {	item = laser4,
				x = 0,
				y = 0}
	end
	lasa = 0

	lava = lava1
	lavay = -700
	lavax = -2000
	lavaa = 0
		-- Backgrounds
		-- Miscellaneous
	setPoint = 0 -- Space spotting
	start = 0
	difficulty = 0
	level = 0
	score = 0

	-- Audio
		-- Musics
	genos = love.audio.newSource("audio/musics/genos.wav")
	genos:setVolume(0.5)
	sad = love.audio.newSource("audio/musics/sad.wav")
		-- soundEffect
	scream = love.audio.newSource("audio/soundEffects/scream.wav")
	woosh = love.audio.newSource("audio/soundEffects/woosh.wav")
end

function love.update(dt)
	-- quit game
	if love.keyboard.isDown("escape") then
		love.event.quit()
	end

	if start == 0 then
		if love.keyboard.isDown("return") then
			start = 1
		end
	else
		if U.dead == 0 then
			score = score + 1

			-- audio
			genos:play()

			-- game over
			if Obj[1].y < -500 then
				scream:play()
				U.dead = 1
			end
			for i = 4, 504 do
				if U.split == 0 then
					if Obj[i].x < U.Ux + 1 and Obj[i].y < U.Uy + 34 and Obj[i].y > U.Uy - 22 and Obj[i].x > U.Ux - 16 then
						scream:play()
						U.dead = 1
					end
				else
					if Obj[i].x < U.Ux - 14 and Obj[i].y < U.Uy + 34 and Obj[i].y > U.Uy - 22 and Obj[i].x > U.Ux - 26 then
						scream:play()
						U.dead = 1
					end
				end
			end

			-- mouvement objects
			if start < 200 then
				start = start + 1
			end

			for i = 305, 605 do
				if lasa == 3 then
					Obj[i].x = Obj[i - 301].x + 1
					Obj[i].y = Obj[i - 301].y + 1
				end
			end

			lavay = lavay - U.Udy
			if lavax > -1800 then
				lavax = -2300
			else
				lavax = lavax + 5 
			end
			for i in pairs(Obj) do
				Obj[i].x = Obj[i].x - U.Udx
				Obj[i].y = Obj[i].y - U.Udy
				if i >= 4 and i < 34 + level*30 then
					Obj[i].x = Obj[i].x + Obj[i].dx
					if start > 199 then
						Obj[i].y = Obj[i].y + Obj[i].dy
					end
					if Obj[i].x < -500 then
						Obj[i].x = 1999
					elseif Obj[i].x > 2000 then
						Obj[i].x = -499
					end
					if Obj[i].y > 2000 then
						Obj[i].y = -250
					end
				end
			end

			-- physics 2
			if difficulty < 1000 then
				difficulty = difficulty + 1
			else
				difficulty = 0
				level = level + 1
			end

			if Obj[1].y == -50 and (not (Obj[1].x > 573) or not (Obj[1].x < -1132)) and U.air == 1 then
				U.air = 0
				U.Udy = 0
				U.CD = 8
				if U.lastD == 'l' then
					U.Ux = U.Ux + 2
				else
					U.Ux = U.Ux - 2
				end
			end

			if not love.keyboard.isDown("up") and U.air == 1 then
				U.jetPack = 0
			end

			-- key press + mouvement
			if love.keyboard.isDown("right") and U.split == 0 then
				if U.air == 0 then
					U.Udx = U.Udx + 1
					U.lastD = 'r'
				else
					U.Udx = U.Udx + 0.1
				end
				U.sprite = UsR
				U.animWalk = U.animWalk + 1
			end
			if love.keyboard.isDown("left") and U.split == 0 then
				if U.air == 0 then
					U.Udx = U.Udx - 1
					U.lastD = 'l'
				else
					U.Udx = U.Udx - 0.1
				end
				U.sprite = UsL
				U.animWalk = U.animWalk + 1
			end
			if love.keyboard.isDown("up") and U.jetPack > 0 and U.CD == 0 and U.split == 0 then
				if U.air == 0 then
					if U.lastD == 'l' then
						U.Ux = U.Ux - 2
					else
						U.Ux = U.Ux + 2
					end
				end
				U.jetPack = U.jetPack - 1
				U.Udy = -10
				U.air = 1
			end
			if love.keyboard.isDown("down") and U.air == 0 then
				U.sprite = Usplit
				if U.split == 0 then
					U.Uy = U.Uy + 20
					U.Ux = U.Ux - 7
				end
				U.split = 1
			else
				if U.split == 1 then
					U.Uy = U.Uy - 20
					U.Ux = U.Ux + 7
				end
				U.split = 0
			end

			-- physics
			if U.air == 0 and U.split == 0 then
				U.Udx = U.Udx - U.Udx/10
				U.animJump = 0
				U.jetPack = 20
				if U.CD > 0 then
					U.CD = U.CD - 1
				end
				if Obj[1].x > 573 or Obj[1].x < -1132 then
					U.air = 1
					U.Udy = 10
					U.fall = 1
					U.jetPack = 0
				end
			elseif U.split == 1 then
				U.Udx = U.Udx - U.Udx/33
			else
				woosh:play()
				if (not love.keyboard.isDown("up") or U.jetPack == 0) and U.air == 1 then
					U.Udy = 10
				end
				U.animJump = U.animJump + 1
				U.Udx = U.Udx - U.Udx/100
			end

			-- animation
			if lasa < 4 then
				lasa = lasa + 1
			else
				lasa = 0
			end

			if lavaa > 30 then
				lavaa = 0
				Obj[1].item = Floor1
				lava = lava1
			elseif lavaa > 20 then
				lavaa = lavaa + 1
				Obj[1].item = Floor2
				lava = lava3
			elseif lavaa > 10 then
				lavaa = lavaa + 1
				lava = lava2
			else
				lavaa = lavaa + 1
			end
			if U.animWalk > 30 then
				U.animWalk = 0
			end
			if U.animJump > 24 then
				U.animJump = 0
			end
			if U.animStand > 30 then
				U.animStand = 0
			end

			if U.Udx < 1 and U.Udx > -1 and U.air == 0 and U.split == 0 then
				U.animWalk = 0
				U.animStand = U.animStand + 1
				if U.animStand > 15 and U.lastD == 'r' then
					U.sprite = UsR2
				elseif U.animStand > 15 and U.lastD == 'l' then
					U.sprite = UsL2
				elseif U.lastD == 'r' then
					U.sprite = UsR
				elseif U.lastD == 'l' then
					U.sprite = UsL
				end
			else
				if U.air == 0 and U.split == 0 then
					if U.animWalk > 20 and U.lastD == 'r' then
						U.sprite = UwR2
					elseif U.animWalk > 20 and U.lastD == 'l' then
						U.sprite = UwL2
					elseif U.animWalk > 10 and U.lastD == 'r' then
						U.sprite = UwR
					elseif U.animWalk > 10 and U.lastD == 'l' then
						U.sprite = UwL
					elseif U.lastD == 'r' then
						U.sprite = UsR
					elseif U.lastD == 'l' then
						U.sprite = UsL
					end
				elseif U.split == 0 then
					if U.animJump > 21 and U.lastD == 'r' then
						U.sprite = UjR8
					elseif U.animJump > 21 and U.lastD == 'l' then
						U.sprite = UjL8
					elseif U.animJump > 18 and U.lastD == 'r' then
						U.sprite = UjR7
					elseif U.animJump > 18 and U.lastD == 'l' then
						U.sprite = UjL7
					elseif U.animJump > 15 and U.lastD == 'r' then
						U.sprite = UjR6
					elseif U.animJump > 15 and U.lastD == 'l' then
						U.sprite = UjL6
					elseif U.animJump > 12 and U.lastD == 'r' then
						U.sprite = UjR5
					elseif U.animJump > 12 and U.lastD == 'l' then
						U.sprite = UjL5
					elseif U.animJump > 9 and U.lastD == 'r' then
						U.sprite = UjR4
					elseif U.animJump > 9 and U.lastD == 'l' then
						U.sprite = UjL4
					elseif U.animJump > 6 and U.lastD == 'r' then
						U.sprite = UjR3
					elseif U.animJump > 6 and U.lastD == 'l' then
						U.sprite = UjL3
					elseif U.animJump > 3 and U.lastD == 'r' then
						U.sprite = UjR2
					elseif U.animJump > 3 and U.lastD == 'l' then
						U.sprite = UjL2
					elseif U.lastD == 'r' then
						U.sprite = UjR
					elseif U.lastD == 'l' then
						U.sprite = UjL
					end
				end
				U.animStand = 0
			end
		else
			genos:stop()
			sad:play()
		end
	end
end

function love.draw()
	if start == 0 then
		love.graphics.draw(Start, 0, 0)
	-- drawing
	elseif U.dead == 0 then
		for i in pairs(Obj) do
			love.graphics.draw(Obj[i].item, Obj[i].x, Obj[i].y)
		end
		love.graphics.draw(U.sprite, U.Ux, U.Uy)
		love.graphics.draw(lava, lavax, lavay)
		love.graphics.print("Score:", 0, 0, 0, 1, 1)
		love.graphics.print(score, 50, 0, 0, 1, 1)
	else
		if love.keyboard.isDown("return") then -- restarts the game
			-- variables
				-- Uldarin
			U = {	sprite = UsR,
				Ux = 548,
				Uy = 340,
				CD = 0,		-- cooldown jump
				Udx = 0,	-- x acceleration
				Udy = 0,	-- y acceleration
				air = 0,	-- is in air ?
				jetPack = 20,	-- going up
				animWalk = 0,	-- walking animation
				animJump = 0,	-- jumping animation
				animStand = 0,	-- standing animation
				dead = 0,	-- are u dead ?
				split = 0,	-- split or not ?
				lastD = 'r'}	-- last direction pressed
				-- Objects
			Obj = {}
			Obj[1] = {	item = Floor1,
					x = -280,
					y = -50}
			Obj[2] = {	item = greyBox,
					x = 800,
					y = 300}
			Obj[3] = {	item = greyBox,
					x = 1200,
					y = 300}
			for i = 4, 304 do
				Obj[i] = {	item = laser,
						x = math.random(-500, 2000),
						y = -250,
						dx = 10 * math.random() - 5,
						dy = 5 * math.random() + 0.1}
			end
			for i = 305, 605 do
				Obj[i] = {	item = laser4,
						x = 0,
						y = 0}
			end
			lasa = 0

			lava = lava1
			lavay = -700
			lavax = -2000
			lavaa = 0
				-- Backgrounds
				-- Miscellaneous
			setPoint = 0 -- Space spotting
			start = 0
			difficulty = 0
			level = 0
			score = 0
			sad:stop()
		end
		love.graphics.draw(GO, 0, 0)
		love.graphics.print("Score:", 500, 500, 0, 3, 3)
		love.graphics.print(score, 700, 500, 0, 3, 3)
	end
end
