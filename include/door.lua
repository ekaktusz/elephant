function make_door()
	d={
		tx=get_tx(sprite_nums.vdoor),
		ty=get_ty(sprite_nums.vdoor),
		vsprite=142,
		hsprite=192,
		d='r' --direction
	}
	--door direction
	tmp=get_all_tile_pos(sprite_nums.vdoor)
	tty=tmp[2].ty
	ttx=tmp[2].tx
	if (tty==d.ty) then
		--horizontal
		if (tty==1) then d.d='u' end
		if (tty==8) then d.d='d' end
	end
	if (ttx==d.tx) then
		--vertical
		if (ttx==1) then d.d='l' end
		if (ttx==8) then d.d='r' end
	end
end

function draw_door()
	if not e.finish then
		if (d.d=='l' or d.d=='r') then
			spr(d.vsprite,(d.tx-1)*16,(d.ty-1)*16,2,4,d.d=='l',false)
		else
			spr(d.hsprite,(d.tx-1)*16,(d.ty-1)*16,4,2,false,d.d=='u') 
		end
	end
end
