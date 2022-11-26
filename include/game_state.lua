--game state
function load_game_lvl(lvl)
	anim_timer=0
	anim_timer3=92
	anim_start2=false
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
	make_gb()
	make_mhc()
	make_h()
	shake=0
	develop=0
	devspeed=0
end

function init_game(lvl)
	_update = update_game
	_draw = draw_game	
	current_lvl=lvl
	load_game_lvl(current_lvl)
	anim_timer3=1
end

function update_game()
	if loaded() then
		update_player()
		if (p.first_move) then
			update_elephant()
		end
	end
	if first_a_finished() and not loaded() then
		anim_timer+=5
	end
	if not first_a_finished() then
		anim_timer3-=5
	end
	if (btnp(4)) then
		load_game_lvl(current_lvl)
	end
end

function draw_game()
	cls()
	map(0,0)
	--spr(140,112,32,2,2) -- mogyoro
	--spr(64,16,16,4,4)   -- elefant
	draw_wall()
	draw_bwall()
	draw_mhc()
	draw_elephant()
	draw_player()
	draw_gb()
	draw_nuts()
	draw_door()
	draw_water()
	draw_h()

	if not first_a_finished() then
		load_anim(anim_timer3)
	end
		
	if first_a_finished() and not loaded() then
		load_anim(anim_timer)
	end

	doshake()
end

function load_anim(size)
	for i=90,size,-1 do
		circ(64,64,i,0)
		circ(65,64,i,0)
	end
	
	circ(64,64,size,7)
	circ(65,64,size,7)
end

function loaded()
	return anim_timer>=92
end

function first_a_finished()
	return anim_timer3<0
end