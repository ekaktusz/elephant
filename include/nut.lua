--nuts

function make_nuts()
	nuts=get_all_tile_pos('m')
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

function pcollide_with_nut()
	for _, n in ipairs(nuts) do
		if n.tx==p.tx and n.ty==p.ty and not p.has_nut then
			p.has_nut=true
			del(nuts,n)
			return
		end
	end
end

function ecollide_with_nut()
	for _, n in ipairs(nuts) do
 	if (n.tx>=e.tx and n.tx<=e.tx+1)
 	 and (n.ty>=e.ty and n.ty<=e.ty+1)
 	 then
		enuts[#enuts+1] = {tx=n.tx, ty=n.ty}
		del(nuts,n)
		e.d=0
		e.hit_freeze=true
		e.current_c=e.nut_eat_c
 		return
 	end
	end
end

function place_nut()
	if (p.has_nut) and not is_on_tile(p.tx,p.ty,'m') and not is_on_tile(p.tx,p.ty,'r') and not is_on_tile(p.tx,p.ty,'h')  and not is_on_tile(p.tx,p.ty,'g') then
		nuts[#nuts+1] = {tx=p.tx, ty=p.ty}
		p.has_nut=false
	end
end
