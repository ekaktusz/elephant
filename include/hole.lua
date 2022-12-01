--hole
function make_h()
	hholes=get_all_tile_pos(sprite_nums.hhole)
	vholes=get_all_tile_pos(sprite_nums.vhole)
	local wvholes=get_all_tile_pos(sprite_nums.wvhole)
	local whholes=get_all_tile_pos(sprite_nums.whhole)

	table_concat(vholes,wvholes)
	table_concat(hholes,whholes)
end

function draw_h()
	for _,h in ipairs(hholes) do
    	spr(h.sprt,(h.tx-1)*16,(h.ty-1)*16,2,2)
	end
	for _,h in ipairs(vholes) do
    	spr(h.sprt,(h.tx-1)*16,(h.ty-1)*16,2,2)
	end
end


