function make_door()
	d={
		tx=get_tx(sprite_nums.vdoor),
		ty=get_ty(sprite_nums.vdoor),
		d='r' --direction
	}
	--door direction
	if current_lvl==n_lvls then
		return
	end
	tmp=get_all_tile_pos(sprite_nums.vdoor)
	tty=tmp[2].ty
	ttx=tmp[2].tx
	if tty==d.ty then
		--horizontal
		d.sprt=sprite_nums.hdoor
		if tty==1 then d.d='u' end
		if tty==8 then d.d='d' end
	end
	if ttx==d.tx then
		--vertical
		if ttx==1 then d.d='l' end
		if ttx==8 then d.d='r' end
	end
end

function draw_door()
	if not e.finish then
		if not is_door_horizontal() then
			spr(sprite_nums.vdoor-1,(d.tx-1)*16,(d.ty-1)*16,2,4,d.d=='l',false)
		else
			spr(sprite_nums.hdoor-16,(d.tx-1)*16,(d.ty-1)*16,4,2,false,d.d=='u') 
		end
	end
end

function is_door_horizontal()
	return d.d=='u' or d.d=='d'
end