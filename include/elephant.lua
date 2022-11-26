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
		finish=false,
		hit_freeze=false,
		hit_freeze_time=40, -- meddig eszik egy mogyit
		hit_freeze_timer=0,
		should_move=false,
		seen_player=false
	}
	e.x=(e.tx-1)*16
	e.y=(e.ty-1)*16
	e.ntx=e.tx
	e.nty=e.ty
end

function draw_elephant()
	if not e.hit_freeze then
		e.stp+=1
		if(e.stp%10==0) then e.f+=1 end
		if(e.f>1) then e.f=0 end
	end
	spr(e.sprite+e.f*4,e.x,e.y,4,4,e.d==2,false)
end

function update_elephant_d()
	ecollide_with_nut()
	ecollide_with_water()
	ecollide_with_bwall()
	
	if e.hit_freeze then
		--wait 10 frame
		if e.hit_freeze_timer<e.hit_freeze_time then
			e.hit_freeze_timer+=1
			return
		else
			e.hit_freeze=false
			e.hit_freeze_timer=0
		end
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
					end
					if (e.tx<n.tx) then
						--elefant elott
						e.ntx=e.tx-1
						e.should_move=true
						e.d=1
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
				--e.should_move=true
				e.seen_player=true
				e.d=1
			end
			if (e.tx<p.tx) then
				--elefant elott
				--e.should_move=true
				e.seen_player=true
				e.d=2
			end
		end
	end
	if(e.tx==p.tx) or (e.tx+1==p.tx) then
		if (can_see_through_y(p.ty,e.ty,p.tx)) then
			if (e.ty>p.ty) then
				--elefant felett
				--e.should_move=true
				e.seen_player=true
				e.d=4
			end
			if (e.ty<p.ty) then
				--elefant alatt
				--e.should_move=true
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
			e.should_move=false
			--e.d=0
			update_elephant_d()
		end
	end
	
	-- vege ha elefant kier
	if e.finish and (e.x>128
		or e.x+32<0 or e.y>128 
		or e.y+32<0) then
			finished=true
	end

	
end

function move_elephant()
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
			spawntrail(e.x,e.y+32,2,2,5,6)
			e.x+=e.spd
		elseif (e.d==2) then
			spawntrail(e.x+32,e.y+32,2,2,5,6)
			e.x-=e.spd
		elseif (e.d==3) then
			spawntrail(e.x+16,e.y+32,8,8,5,6)
			e.y-=e.spd
		elseif (e.d==4) then
			spawntrail(e.x+16,e.y,8,8,5,6)
			e.y+=e.spd
		end
		return
	end

	if (e.d==1) and ecan_move('r') and (e.should_move or e.seen_player)
		then --jobbra
		spawntrail(e.x,e.y+32,2,2,5,6)
		e.x+=e.spd
	elseif (e.d==2) and ecan_move('l') and (e.should_move or e.seen_player)
		then --balra
			spawntrail(e.x+32,e.y+32,2,2,5,6)
		e.x-=e.spd
	elseif (e.d==3) and ecan_move('u') and (e.should_move or e.seen_player)
		then --fel
			spawntrail(e.x+16,e.y+32,8,8,5,6)
		e.y-=e.spd
	elseif (e.d==4) and ecan_move('d') and (e.should_move or e.seen_player)
		then --le
			spawntrail(e.x+16,e.y,8,8,5,6)
		e.y+=e.spd
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