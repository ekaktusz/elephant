--game state
function load_game_lvl(lvl)
	load_game_map(lvl)
	anim_timer=0
	finish_anim_timer=92
	tile_size=16
	d_op={[0]=1,0,3,2}
	make_gamemap(lvl)
	make_wall()
	make_nuts()
	make_player()
	make_elephant()
	make_door()
	make_water()
	make_bwall()
	init_button()
	init_grids()
	make_traps()
	make_mhc()
	make_h()
	shake=0
	develop=0
	devspeed=0
	finished=false
	reading=false
	game_anim_speed=5
	tb_init(0,{"the elephants are afraid of \nmice. this textbox could help \nthe player with the puzzles"})
end

function init_game(lvl)
	_update = update_game
	_draw = draw_game
	current_lvl=10
	load_game_lvl(current_lvl)
end

function update_game()
	if loaded() then
		update_player()
		if (p.first_move) then
			update_elephant()
			update_btraps()
		end
	end
	if not loaded() then
		anim_timer+=game_anim_speed
	end
	if (btnp(4)) then
		load_game_lvl(current_lvl)
	end
	if finished then
		finish_anim_timer-=game_anim_speed
		if (finish_anim_timer<0) then
			next_level()
		end
	end

	if current_lvl==1 then tb_update() end
	
	updateparts(part)
end

function draw_game()
	cls()
	--map(0,0)
	draw_map()
	--spr(140,112,32,2,2) -- mogyoro
	--spr(64,16,16,4,4)   -- elefant
	shade_seen_tiles()
	draw_wall()
	draw_bwall()
	draw_mhc()
	draw_button()
	draw_eaten_nuts()
	draw_dwater()
	draw_btraps()
	drawparts(ppart)
	draw_player()
	draw_grids()
	drawparts(epart)
	draw_traps()
	draw_elephant()
	draw_nuts()
	draw_water()
	draw_h()
	draw_map_edge()
	draw_door()
	drawparts(part)

	--draw_vision_border()

	--shade_unseen_tiles()

	--shade_seen_tiles()

	if current_lvl==1 then tb_draw() end 
		
	if not loaded() then
		load_anim(anim_timer)
	end

	if finished then
		load_anim(finish_anim_timer)
	end
	doshake()
end

function load_anim(size,icx,icy)
	cx=icx or 64
	cy=icy or 64
	for i=90,size,-1 do
		circ(cx,cy,i,0)
		circ(cx+1,cy,i,0)
	end
	
	circ(cx,cy,size,7)
	circ(cx+1,cy,size,7)
end

function loaded()
	return anim_timer>=92
end

function switch_level(lvl)
	load_game_lvl(lvl)
end

function next_level()
	--itt kene lejatszani az uj animot
	current_lvl+=1
	if (current_lvl>n_lvls) then
		init_menu()
		return
	end
	switch_level(current_lvl)
end