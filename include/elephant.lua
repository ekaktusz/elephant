--elephant
function make_elephant()
	e={
		sprite=64,
		x=16,
		y=16,
		tx=get_tx('e'),
		ty=get_ty('e'),
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
		last_horizontal_dir='r'
	}
	e.x=(e.tx-1)*16
	e.y=(e.ty-1)*16
	e.ntx=e.tx
	e.nty=e.ty
	frame_counter=0
end

function draw_elephant()
	--poke(0x5f54,0x60)

	--palette shift everything a shade darker
	

	if not e.hit_freeze then
		e.stp+=1
		if(e.stp%e.anim_speed==0) then e.f+=1 end
		if(e.f>1) then e.f=0 end
	end
	spr(e.sprite+e.f*4,e.x,e.y,4,4,e.last_horizontal_dir=='l',false)

	--reset things to normal
	--poke(0x5f54,0)
	 --szem
	--if e.seen_player then
	--	if (e.d==1) then
	--		if (e.f==0 ) then
	--			rectfill(e.x+24,e.y+8,e.x+27,e.y+11,7) --szemfeherje
	--			rectfill(e.x+26,e.y+10,e.x+27,e.y+11,1) --pupilla
	--		else 
	--			rectfill(e.x+24,e.y+9,e.x+27,e.y+12,7)
	--			rectfill(e.x+26,e.y+11,e.x+27,e.y+12,1)
	--		end
	--	elseif (e.d==2) then
	--		if (e.f==0 ) then
	--			rectfill(e.x+4,e.y+8,e.x+7,e.y+11,7) --szemfeherje
	--			rectfill(e.x+4,e.y+10,e.x+5,e.y+11,1) --pupilla
	--			
	--		else 
	--			rectfill(e.x+4,e.y+9,e.x+7,e.y+12,7) --szemfeherje
	--			rectfill(e.x+4,e.y+11,e.x+5,e.y+12,1) --pupilla
	--	end
	--	elseif (e.d==3) then
--
	--	elseif (e.d==4) then
--
	--	end	
	--end
	
	--if (e.d==1 or e.d==3 or e.d==4 or e.d==0) then
	--	if (e.f==0 ) then
	--		rectfill(e.x+24,e.y+8,e.x+27,e.y+11,7) --szemfeherje
	--		rectfill(e.x+26,e.y+10,e.x+27,e.y+11,1) --pupilla
	--		if(e.eyes_closed) then
	--			rectfill(e.x+24,e.y+8,e.x+27,e.y+11,6)
	--		end
	--	else 
	--		rectfill(e.x+24,e.y+9,e.x+27,e.y+12,7)
	--		rectfill(e.x+26,e.y+11,e.x+27,e.y+12,1)
	--		if(e.eyes_closed) then
	--			rectfill(e.x+24,e.y+9,e.x+27,e.y+12,6)
	--		end
	--	end
	--elseif (e.d==2) then
	--	if (e.f==0 ) then
	--		rectfill(e.x+4,e.y+8,e.x+7,e.y+11,7) --szemfeherje
	--		rectfill(e.x+4,e.y+10,e.x+5,e.y+11,1) --pupilla
	--		if(e.eyes_closed) then
	--			rectfill(e.x+4,e.y+8,e.x+7,e.y+11,6)
	--		end
	--	else 
	--		rectfill(e.x+4,e.y+9,e.x+7,e.y+12,7) --szemfeherje
	--		rectfill(e.x+4,e.y+11,e.x+5,e.y+12,1) --pupilla
	--		if(e.eyes_closed) then
	--			rectfill(e.x+4,e.y+9,e.x+7,e.y+12,6)
	--		end
	--	end
	--end
end

function update_elephant_d()
	frame_counter+=1
	if (frame_counter%100<=20) then
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

	if (e.hit_freeze) then
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
						e.d=2
						e.last_horizontal_dir='l'
					end
					if (e.tx<n.tx) then
						--elefant elott
						e.ntx=e.tx-1
						e.should_move=true
						e.d=1
						e.last_horizontal_dir='r'
					end
				end
			end
			if(e.tx==n.tx) or (e.tx+1==n.tx) then
				if (can_see_through_y(n.ty,e.ty,n.tx)) then
					if (e.ty>n.ty) then
						--elefant felett
						e.should_move=true
						e.d=3
					end
					if (e.ty<n.ty) then
						--elefant alatt
						e.should_move=true
						e.d=4
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
				e.d=1
				e.last_horizontal_dir='r'
			end
			if (e.tx<p.tx) then
				--elefant elott
				e.seen_player=true
				e.d=2
				e.last_horizontal_dir='l'
			end
		end
	end
	if(e.tx==p.tx) or (e.tx+1==p.tx) then
		if (can_see_through_y(p.ty,e.ty,p.tx)) then
			if (e.ty>p.ty) then
				--elefant felett
				e.seen_player=true
				e.d=4
			end
			if (e.ty<p.ty) then
				--elefant alatt
				e.seen_player=true
				e.d=3
			end
		end
	end
end

function ecollide_with_d()
	if (e.d==1 and d.d=='r' and is_tile_on_side(e.tx,e.ty,'a','r')) or
	   (e.d==2 and d.d=='l' and is_tile_on_side(e.tx+1,e.ty,'a','l')) or
	   (e.d==3 and d.d=='u' and is_tile_on_side(e.tx,e.ty+1,'a','u')) or
	   (e.d==4 and d.d=='d' and is_tile_on_side(e.tx,e.ty,'a','d'))
	then		
		e.finish=true
	end
end

function update_elephant() 
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

function move_elephant()

	e.anim_speed=10
	if (e.seen_player) then
		if (e.d==1 and not ecan_move('r')) or
		   (e.d==2 and not ecan_move('l')) or
		   (e.d==3 and not ecan_move('u')) or
		   (e.d==4 and not ecan_move('d'))
		then
			e.seen_player=false
		end
	end
	
	if (e.finish) then
		if (e.d==1) then
			spawntrail(e.x,e.y+32,2,2,5,6,epart)
			e.x+=e.spd
		elseif (e.d==2) then
			spawntrail(e.x+32,e.y+32,2,2,5,6,epart)
			e.x-=e.spd
		elseif (e.d==3) then
			spawntrail(e.x+16,e.y+32,8,8,5,6,epart)
			e.y-=e.spd
		elseif (e.d==4) then
			spawntrail(e.x+16,e.y,8,8,5,6,epart)
			e.y+=e.spd
		end
		return
	end

	if (e.d==1) and ecan_move('r') and (e.should_move or e.seen_player)
		then --jobbra
		spawntrail(e.x,e.y+32,2,2,5,6,epart)
		e.x+=e.spd
		e.anim_speed=5
	elseif (e.d==2) and ecan_move('l') and (e.should_move or e.seen_player)
		then --balra
			spawntrail(e.x+32,e.y+32,2,2,5,6,epart)
		e.x-=e.spd
		e.anim_speed=5
	elseif (e.d==3) and ecan_move('u') and (e.should_move or e.seen_player)
		then --fel
			spawntrail(e.x+16,e.y+32,8,8,5,6,epart)
		e.y-=e.spd
		e.anim_speed=5
	elseif (e.d==4) and ecan_move('d') and (e.should_move or e.seen_player)
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
	   eis_tile_on_side('p',d) or
	   eis_tile_on_side('t',d) or
	   eis_tile_on_side('h',d) or
	   (eis_tile_on_side('r',d) and not b.pressed) then
		return false
	end
	return true
end