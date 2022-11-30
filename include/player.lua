--player
function make_player()
	p={
		x=0,
		y=0,
		tx=get_tx('p'),
		ty=get_ty('p'),
		dx=0,
		dy=0,
		w=15,
		h=15,
		d=0,
		walk={[0]={0,2},{32,34},{1,1},{2,2}},
		t=0,
		f=1,
		stp=4,
		walking=false,
		spd=2,
		has_nut=false,
		first_move=false,
		hit_trap=false,
		vegtelen=0
	}
	p.x=(p.tx-1)*16
	p.y=(p.ty-1)*16
end

function draw_player()
	if (p.walking) then anim_player() end

	--drawparts()
	
 palt(0,true)   --hide black
 --0 left, 1 right, 2 up, 3 down
 tmp=0
 if p.d>1 then
 	tmp=1
 end
 
 spr(p.walk[tmp][p.f],p.x,p.y,2,2,p.d==1,p.d==3)
	--draw nut on player
	if (p.has_nut) then
		spr(nsprite,p.x,p.y,2,2)
	end
end

function anim_player()
	p.t=(p.t+1)%p.stp
	if (p.t==0) p.f=p.f%#p.walk[p.d]+1
end

function update_player()
	pcollide_with_trap()
	p.vegtelen+=1
	move_player()
	if (btnp(5)) then
		--handle nut taking
		if p.has_nut then
			place_nut()
		else
			pcollide_with_nut()
		end
		press_button()
		--this is where the button press should be
	end
	if (btnp(0) or btnp(1) or btnp(2) or btnp(3) or btnp(4)) then
		p.first_move=true
	end
	if p.walking then
		spawntrail(p.x+8,p.y+8,4,4,5,6,ppart)
		if (p.vegtelen%5==0) then
			sfx(4)
		end
	end
	updateparts(ppart)
end

function pcan_move(d)
	--d: direction 'l' 'r' 'u' 'd'
	if  is_end_of_map(p.tx,p.ty,d) or 
		   is_tile_on_side(p.tx,p.ty,'e',d) or
		   is_tile_on_side(p.tx,p.ty,'w',d) or
		   is_tile_on_side(p.tx,p.ty,'t',d) or
		   is_tile_on_side(p.tx,p.ty,'b',d) or
		   is_tile_on_side(p.tx,p.ty,'c',d) then
		return false
	end
	return true
end

function move_player() 
 --if mid-tile...
 if (p.walking and (p.x%tile_size)>0 or (p.y%tile_size)>0) then
  if (btn(d_op[p.d])) then
  	p.dx*=-1
  	p.dy*=-1
  	p.d=d_op[p.d]
  end     
 	--...keep 
 	p.x+=p.dx
 	p.y+=p.dy
       
 	--but if we get to a tile, stop
 	if (p.x%tile_size==0 and p.y%tile_size==0) then
  	p.dx=0
  	p.dy=0
  	p.walking=false
  	p.t,p.f=0,1 --reset anim vars
 		--gamemap[p.ty][p.tx]='x'
	 	p.tx=p.x/tile_size+1
	 	p.ty=p.y/tile_size+1
	 	if (p.tx==9) then
	 		--win
	 		--next_level()
			finished=true
	 		--p.tx=1
	 		--p.x=(p.tx-1)*16
	 	end
 		--gamemap[p.ty][p.tx]='p'
 	end
 	--but if on a tile, allow new input
		else
  	if (btn(0)) then
   	p.d=0
   	if pcan_move('l') then
   		p.walking=true
   		p.dx=-p.spd
   	end
  	elseif (btn(1)) then
   	p.d=1
    if pcan_move('r') then
   		p.walking=true
   		p.dx=p.spd
   	end
  	elseif (btn(2))
   then
   	p.d=2
   	if pcan_move('u') then
   		p.walking=true
   		p.dy=-p.spd
   	end
  	elseif (btn(3)) then
   	p.d=3
   	if pcan_move('d') then
   		p.walking=true
   		p.dy=p.spd
   	end
   end
  

  if (btn()>0) then
   p.x+=p.dx
   p.y+=p.dy
  else
   p.dx=0
  	p.dy=0
 	end
	end
end

function can_elephant_see_the_player()
	-- is in line with player
	if(e.ty==p.ty) or (e.ty+1==p.ty) then
		if (can_see_through_x(p.tx,e.tx,p.ty)) then
			if (e.tx>p.tx) then
				return true
			end
			if (e.tx<p.tx) then
				return true
			end
		end
	end
	if(e.tx==p.tx) or (e.tx+1==p.tx) then
		if (can_see_through_y(p.ty,e.ty,p.tx)) then
			if (e.ty>p.ty) then
				return true
			end
			if (e.ty<p.ty) then
				return true
			end
		end
	end
	return false
end