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
	draw_objects(hholes)
	draw_objects(vholes)
end


