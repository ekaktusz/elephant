--hole
function make_h()
	hholes=get_all_tile_pos(sprite_nums.hhole)
	vholes=get_all_tile_pos(sprite_nums.vhole)
end

function draw_h()
	for _,h in ipairs(hholes) do
    	spr(sprite_nums.hhole,(h.tx-1)*16,(h.ty-1)*16,2,2)
	end
	for _,h in ipairs(vholes) do
    	spr(sprite_nums.vhole,(h.tx-1)*16,(h.ty-1)*16,2,2)
	end
end


