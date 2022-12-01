--nuts

function make_nuts()
	nuts=get_all_tile_pos(sprite_nums.peanut)
	enuts={}
	nsprite=140
	ensprite=200
end

function draw_nuts()
	for _, n in ipairs(nuts) do
    	spr(nsprite,(n.tx-1)*16,(n.ty-1)*16,2,2)
	end
end

function draw_eaten_nuts()
	for _, n in ipairs(enuts) do
		spr(ensprite,(n.tx-1)*16,(n.ty-1)*16,2,2)
	end
end

function pcollide_with_nut(n)
	if p.has_nut then return end
	p.has_nut=true
	del(nuts,n)
	sfx(6)
end

function ecollide_with_nut(n)
	enuts[#enuts+1] = {tx=n.tx, ty=n.ty}
	del(nuts,n)
	e.d=0
	e.hit_freeze=true
	e.current_c=e.nut_eat_c
	sfx(1)
end

function place_nut()
	if (p.has_nut) and not is_on_tile(p.tx,p.ty,sprite_nums.peanut) and not is_on_tile(p.tx,p.ty,sprite_nums.grid1) 
	and not is_on_tile(p.tx,p.ty,sprite_nums.hhole) and not is_on_tile(p.tx,p.ty,sprite_nums.vhole) 
	 and not is_on_tile(p.tx,p.ty,sprite_nums.button1) then
		nuts[#nuts+1] = {tx=p.tx, ty=p.ty}
		p.has_nut=false
	end
end
