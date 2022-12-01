--wall
function make_wall()
	walls=get_all_tile_pos(sprite_nums.wall)
	local pinks1=get_all_tile_pos(sprite_nums.pink1)
	local pinks2=get_all_tile_pos(sprite_nums.pink2)
	local greens1=get_all_tile_pos(sprite_nums.green1)
	local greens2=get_all_tile_pos(sprite_nums.green2)
	local oldtvs=get_all_tile_pos(sprite_nums.old_tv)
	local newtvs=get_all_tile_pos(sprite_nums.new_tv)
	local lamps=get_all_tile_pos(sprite_nums.lamp)
	local bath_wall=get_all_tile_pos(sprite_nums.bath_wall)

	table_concat(walls,pinks1)
	table_concat(walls,pinks2)
	table_concat(walls,greens1)
	table_concat(walls,greens2)
	table_concat(walls,oldtvs)
	table_concat(walls,newtvs)
	table_concat(walls,lamps)
	table_concat(walls,bath_wall)
end

--breakable wall
function make_bwall()
	bwalls=get_all_tile_pos(sprite_nums.bwall)
	local plants=get_all_tile_pos(sprite_nums.plant)
	local wcs=get_all_tile_pos(sprite_nums.wc)
	local boxes=get_all_tile_pos(sprite_nums.box)

	table_concat(bwalls,plants)
	table_concat(bwalls,wcs)
	table_concat(bwalls,boxes)
	bdwalls={}
end

function draw_bwall()
	draw_objects(bwalls)
	draw_objects(bdwalls)
end

function ecollide_with_bwall(bw)
	shake+=0.1
	devspeed+=0.01
	e.wall_break_time=20
	e.wtx=bw.tx
	e.wty=bw.ty
	bdwalls[#bdwalls+1] = {tx=bw.tx, ty=bw.ty, sprt=get_destroyed_sprt(bw.sprt)}
	gamemap[bw.ty][bw.tx]='x'
	del(bwalls,bw)
end

function get_destroyed_sprt(_sprnum)
	if _sprnum == sprite_nums.bwall then return sprite_nums.bdwall end
	if _sprnum == sprite_nums.plant then return sprite_nums.dplant end
	if _sprnum == sprite_nums.wc then return sprite_nums.dwc end
	if _sprnum == sprite_nums.box then return sprite_nums.dbox end
end