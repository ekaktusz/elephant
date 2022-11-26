--wall
function make_wall()	
	walls=get_all_tile_pos('t')
	wsprite=128
end

function draw_wall()
	for _, w in ipairs(walls) do
    spr(wsprite,(w.tx-1)*16,(w.ty-1)*16,2,2)
	end
end

--breakable wall
function make_bwall()	
	bwalls=get_all_tile_pos('b')
	bdwalls={}
	bwsprite=160
	bdwsprite=130
end

function draw_bwall()
	for _, bw in ipairs(bwalls) do
    spr(bwsprite,(bw.tx-1)*16,(bw.ty-1)*16,2,2)
	end
	for _, bdw in ipairs(bdwalls) do
    spr(bdwsprite,(bdw.tx-1)*16,(bdw.ty-1)*16,2,2)
	end
	print(#bwalls)
end

function ecollide_with_bwall()
	for _, bw in ipairs(bwalls) do
 	if (bw.tx>=e.tx and bw.tx<=e.tx+1)
 	 and (bw.ty>=e.ty and bw.ty<=e.ty+1)
 	 then
		shake+=0.1
		devspeed+=0.01
 	 	bdwalls[#bdwalls+1] = {tx=bw.tx, ty=bw.ty}
	 		gamemap[bw.ty][bw.tx]='x'
	 		del(bwalls,bw)
 		return
 	end
	end
end