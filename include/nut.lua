--nuts

function make_nuts()
	nuts=get_all_tile_pos('m')
	nsprite=140
end

function draw_nuts()
	for _, n in ipairs(nuts) do
    spr(nsprite,(n.tx-1)*16,(n.ty-1)*16,2,2)
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
	 		del(nuts,n)
	 		e.d=0
	 		e.hit_freeze=true
 		return
 	end
	end
end

function place_nut()
	if (p.has_nut) and not is_nut_on_tile(p.tx,p.ty)  then
	 nuts[#nuts+1] = {tx=p.tx, ty=p.ty}
		p.has_nut=false
	end
end

function is_nut_on_tile(tx,ty)
	for _, n in ipairs(nuts) do
	 	if n.tx==tx and n.ty==ty then
	 			return true
	 	end
	end
	return false
end