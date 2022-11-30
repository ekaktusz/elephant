--elephant
function make_elephant()
	e={
		sprite=sprite_nums.elephant1,
		x=16,
		y=16,
		tx=get_tx(sprite_nums.elephant1),
		ty=get_ty(sprite_nums.elephant1),
		ntx=0,
		nty=0,
		w=31,
		h=31,
		f=0,
		stp=0,
		spd=1,
		d=0,
		nut_eat_c={col1=4,col2=9},
		w_drink_c={col1=12,col2=1},
		current_c={col1=4,col2=9},
		wall_break_time=0,
		wtx=0,
		wty=0,
		finish=false,
		hit_freeze=false,
		hit_freeze_time=40, -- meddig eszik egy mogyit
		hit_freeze_timer=0,
		should_move=false,
		seen_player=false,
		anim_speed=10,
		eyes_closed=false,
		last_horizontal_dir='r',
		vegtelen=0,
		ending_sound_played=false,
		scared=false,
		scared_time=20,
		scared_timer=0,
		scared_anim_played_up=false,
		scared_anim_played_down=false,
		scared_anim_played_left=false,
		scared_anim_played_right=false
	}
	e.x=(e.tx-1)*16
	e.y=(e.ty-1)*16
	e.ntx=e.tx
	e.nty=e.ty
	frame_counter=0
end

function draw_elephant()

	--palette shift everything a shade darker
	if not e.hit_freeze then
		e.stp+=1
		if(e.stp%e.anim_speed==0) then e.f+=1 end
		if(e.f>1) then e.f=0 end
	end

	spr(e.sprite+e.f*4,e.x,e.y,4,4,e.last_horizontal_dir=='l',false)

	if not e.scared then draw_eyes() end
end

function draw_eyes()
	local _x=e.x
	local _y=e.y
	if e.last_horizontal_dir=='r' then
		if e.f==0 then
			rectfill( _x+24, _y+8, _x+27, _y+11,7) --szemfeherje
			rectfill( _x+26, _y+10, _x+27, _y+11,1) --pupilla
			if(e.eyes_closed) then
				rectfill( _x+24, _y+6, _x+27, _y+11,6)
				rectfill( _x+24, _y+11, _x+27, _y+11,5)
			end
		else 
			rectfill( _x+24, _y+9, _x+27, _y+12,7)
			rectfill( _x+26, _y+11, _x+27, _y+12,1)
			if(e.eyes_closed) then
				rectfill( _x+24, _y+7, _x+27, _y+12,6)
				rectfill( _x+24, _y+12, _x+27, _y+12,5)
			end
		end
	else
		if (e.f==0 ) then
			rectfill( _x+4, _y+8, _x+7, _y+11,7) --szemfeherje
			rectfill( _x+4, _y+10, _x+5, _y+11,1) --pupilla
			if(e.eyes_closed) then
				rectfill( _x+4, _y+6, _x+7, _y+11,6)
				rectfill( _x+4, _y+11, _x+7, _y+11,5)
			end
		else 
			rectfill( _x+4, _y+9, _x+7, _y+12,7) --szemfeherje
			rectfill( _x+4, _y+11, _x+5, _y+12,1) --pupilla
			if(e.eyes_closed) then
				rectfill( _x+4, _y+7, _x+7, _y+12,6) --szürkítés
				rectfill( _x+4, _y+12, _x+7, _y+12,5) --also vonal
			end
		end
	end
end

function update_elephant_d()

	frame_counter+=1
	if (frame_counter%120<=5) then
		e.eyes_closed=true
	else
		e.eyes_closed=false
	end
	ecollide_with_nut()
	ecollide_with_water()
	ecollide_with_bwall()
	ecollide_with_trap()
	
	if e.hit_freeze then
		--wait 10 frame
		if (e.last_horizontal_dir=='r') then
			spawnpukk(e.x+24,e.y+24,0,0,e.current_c.col1,e.current_c.col2,part)
		else
			spawnpukk(e.x+8,e.y+24,0,0,e.current_c.col1,e.current_c.col2,part)
		end
		if e.hit_freeze_timer<e.hit_freeze_time then
			e.hit_freeze_timer+=1
			return
		else
			e.hit_freeze=false
			e.hit_freeze_timer=0
		end
	end

	if e.wall_break_time>0 then
		spawnbrr((e.wtx-1)*16+8,(e.wty-1)*16-8,16,16,4,5,part)
		e.wall_break_time-=1
	end

	if e.hit_freeze or e.scared then
		return
	end


	if (not e.seen_player) then
		-- is in line with nut
		for _, n in ipairs(nuts) do
			if(e.ty==n.ty) or (e.ty+1==n.ty) then
				if (can_see_through_x(n.tx,e.tx,n.ty)) then
					if (e.tx>n.tx) then
						--elefant mogott
						e.should_move=true
						e.d='l'
						e.last_horizontal_dir='l'
					end
					if (e.tx<n.tx) then
						--elefant elott
						e.ntx=e.tx-1
						e.should_move=true
						e.d='r'
						e.last_horizontal_dir='r'
					end
				end
			end
			if(e.tx==n.tx) or (e.tx+1==n.tx) then
				if (can_see_through_y(n.ty,e.ty,n.tx)) then
					if (e.ty>n.ty) then
						--elefant felett
						e.should_move=true
						e.d='u'
					end
					if (e.ty<n.ty) then
						--elefant alatt
						e.should_move=true
						e.d='d'
					end
				end
			end
		end
	end

	-- is in line with player
	if(e.ty==p.ty) or (e.ty+1==p.ty) then
		if (can_see_through_x(p.tx,e.tx,p.ty)) then
			if (e.tx>p.tx) then
				--elefant mogott
				e.seen_player=true
				e.d='r'
				e.last_horizontal_dir='r'
			end
			if (e.tx<p.tx) then
				--elefant elott
				e.seen_player=true
				e.d='l'
				e.last_horizontal_dir='l'
			end
		end
	end
	if(e.tx==p.tx) or (e.tx+1==p.tx) then
		if (can_see_through_y(p.ty,e.ty,p.tx)) then
			if (e.ty>p.ty) then
				--elefant felett
				e.seen_player=true
				e.d='d'
			end
			if (e.ty<p.ty) then
				--elefant alatt
				e.seen_player=true
				e.d='u'
			end
		end
	end
end

function ecollide_with_d()
	if (e.d=='r' and d.d=='r' and is_tile_on_side(e.tx,e.ty,sprite_nums.vdoor,'r')) or
	   (e.d=='l' and d.d=='l' and is_tile_on_side(e.tx+1,e.ty,sprite_nums.vdoor,'l')) or
	   (e.d=='u' and d.d=='u' and is_tile_on_side(e.tx,e.ty+1,sprite_nums.vdoor,'u')) or
	   (e.d=='d' and d.d=='d' and is_tile_on_side(e.tx,e.ty,sprite_nums.vdoor,'d'))
	then		
		e.finish=true
	end
end

function update_elephant() 

	if e.scared then
		--e.sprite=e.scared_sprite
		--sfx(7)
		if e.scared_timer<e.scared_time then
			e.scared_timer+=1
			return
		else
			e.scared=false
			e.scared_timer=0
			e.sprite=sprite_nums.elephant1
		end
		return
	end

	if e.finish then
		if not e.ending_sound_played then
			e.ending_sound_played=true
			sfx(2)
		end
	end

	e.vegtelen+=1
	move_elephant()
	ecollide_with_d()
	
	if not e.finish then
		if (e.x%tile_size==0 and e.y%tile_size==0) then
			e.tx=e.x/16+1
			e.ty=e.y/16+1
			e.ntx=e.tx
			e.nty=e.ty
			e.should_move=false
			--e.d=0
			update_elephant_d()
		else
			if (e.vegtelen%5==0) then
				sfx(0)
			end
			if (e.x>(e.tx-1)*16) then --jobbra megy és mid tile
				e.ntx=e.tx+1
			elseif (e.x<(e.tx-1)*16) then --balra megy és mid tile
				e.ntx=e.tx-1
			elseif (e.y>(e.ty-1)*16) then --lefele megy és mid tile
				e.nty=e.ty+1
			elseif (e.y<(e.ty-1)*16) then --felfele megy és mid tile
				e.nty=e.ty-1
			end

		end
	end
	
	-- vege ha elefant kier
	if e.finish and (e.x>128
		or e.x+32<0 or e.y>128 
		or e.y+32<0) then
			finished=true
	end
	updateparts(epart)
	
end

function update_scare(d,scared_anim_b)
    if e.d==d and ecan_move(d) and e.seen_player and not scared_anim_b then
		sfx(7)
		e.scared=true
		scared_anim_b=true --addig tru amig falhoz nem ér
		e.sprite=sprite_nums.scelephant1
	end
	if scared_anim_b and e.d==d and not ecan_move(d) then
		scared_anim_b=false --ujra meg tud ijedni?
	end
	return scared_anim_b
end

function move_elephant()

	e.anim_speed=10
	if (e.seen_player) then
		if (e.d=='r' and not ecan_move('r')) or
		   (e.d=='l' and not ecan_move('l')) or
		   (e.d=='u' and not ecan_move('u')) or
		   (e.d=='d' and not ecan_move('d'))
		then
			e.seen_player=false
		end
	end
	
	if (e.finish) then
		if (e.d=='r') then
			spawntrail(e.x,e.y+32,2,2,5,6,epart)
			e.x+=e.spd
		elseif (e.d=='l') then
			spawntrail(e.x+32,e.y+32,2,2,5,6,epart)
			e.x-=e.spd
		elseif (e.d=='u') then
			spawntrail(e.x+16,e.y+32,8,8,5,6,epart)
			e.y-=e.spd
		elseif (e.d=='d') then
			spawntrail(e.x+16,e.y,8,8,5,6,epart)
			e.y+=e.spd
		end
		return
	end
	
	e.scared_anim_played_left=update_scare('l',e.scared_anim_played_left)
	e.scared_anim_played_right=update_scare('r',e.scared_anim_played_right)
	e.scared_anim_played_up=update_scare('u',e.scared_anim_played_up)
	e.scared_anim_played_down=update_scare('d',e.scared_anim_played_down)


	if (e.d=='r') and ecan_move('r') and (e.should_move or e.seen_player)
		then --jobbra
		spawntrail(e.x,e.y+32,2,2,5,6,epart)
		e.x+=e.spd
		e.anim_speed=5
	elseif (e.d=='l') and ecan_move('l') and (e.should_move or e.seen_player)
		then --balra
			spawntrail(e.x+32,e.y+32,2,2,5,6,epart)
		e.x-=e.spd
		e.anim_speed=5
	elseif (e.d=='u') and ecan_move('u') and (e.should_move or e.seen_player)
		then --fel
			spawntrail(e.x+16,e.y+32,8,8,5,6,epart)
		e.y-=e.spd
		e.anim_speed=5
	elseif (e.d=='d') and ecan_move('d') and (e.should_move or e.seen_player)
		then --le
			spawntrail(e.x+16,e.y,8,8,5,6,epart)
		e.y+=e.spd
		e.anim_speed=5
	end
end

function eis_tile_on_side(letter,d)
	return (is_tile_on_side(e.tx,e.ty,letter,d)
		or is_tile_on_side(e.tx+1,e.ty,letter,d)
		or is_tile_on_side(e.tx,e.ty+1,letter,d)
		or is_tile_on_side(e.tx+1,e.ty+1,letter,d))
end

function eis_end_of_map(d)
	return (is_end_of_map(e.tx,e.ty,d) 
		or is_end_of_map(e.tx+1,e.ty,d) 
		or is_end_of_map(e.tx,e.ty+1,d) 
		or is_end_of_map(e.tx+1,e.ty+1,d))
end

function ecan_move(d)
	--d: direction 'l' 'r' 'u' 'd'
	if eis_end_of_map(d) or 
	   eis_tile_on_side(sprite_nums.player_top1,d) or
	   eis_tile_on_side(sprite_nums.wall,d) or
	   eis_tile_on_side(sprite_nums.hhole,d) or
	   eis_tile_on_side(sprite_nums.vhole,d) or
	   (eis_tile_on_side(sprite_nums.grid1,d) and not b.pressed) then
		return false
	end
	return true
end