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
	make_carpet()
	make_cheeses()
	shake=0
	develop=0
	devspeed=0
	finished=false
	reading=false
	game_anim_speed=5
	game_over=false
	game_over_timer=60
	assisted_view=false
	room_text_timer=0
	tb_init(0,{help_texts[lvl]})
end

function init_game(lvl)
	_update = update_game
	_draw = draw_game
	current_lvl=lvl
	load_game_lvl(current_lvl)
end

function update_game()
	room_text_timer+=1
	if game_over then
		game_over_timer-=1
		if (game_over_timer<0) then
			load_game_lvl(current_lvl)
		end
	end

	if loaded() and not game_over then
		tb_update()
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

	if (btnp(0,1)) then
		assisted_view=not assisted_view
	end

	
	updateparts(part)
end

function draw_game()
	cls()
	--map(0,0)
	draw_map()
	--spr(140,112,32,2,2) -- mogyoro
	--spr(64,16,16,4,4)   -- elefant
	draw_assist_view()
	draw_object(carpet)
	draw_objects(walls)
	draw_bwall()
	draw_objects(mhcs)
	draw_button()
	draw_objects(enuts)
	draw_objects(dwater)
	draw_btraps()
	drawparts(ppart)
	draw_objects(cheeses)
	draw_objects(eaten_cheeses)
	draw_objects(nuts)
	if not game_over then --ilyenkor a csapda van csak
		draw_player()
	end
	draw_grids()
	drawparts(epart)
	draw_traps()
	draw_elephant()
	draw_water()
	draw_h()
	draw_map_edge()
	draw_door()
	drawparts(part)

	draw_deadtrap()

	--draw_vision_border()

	--shade_unseen_tiles()

	--draw_assist_view()

	if loaded() then tb_draw() end 

	if room_text_timer<40 then
		print_current_map_number()
	end
		
	if not loaded() then
		load_anim(anim_timer)
	end

	if finished then
		load_anim(finish_anim_timer)
	end

	if semi_finish then
		semi_finish_timer-=1
		rectfill(32,48,96,64,1)
		obprint("your winner",42,52,7,0,2)
	end

	if semi_finish_timer < 0 then
		finished=true
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


function print_current_map_number()
	rectfill(32,48,96,64,1)
	if(current_lvl<10) then
		obprint("room "..current_lvl,42,52,7,0,2)
	else
		obprint("room "..current_lvl,38,52,7,0,2)
	end
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