--manholecover

function make_mhc()
	mhcs=get_all_tile_pos('c')
	mhcsprite=196
end

function draw_mhc()
	for _,mhc in ipairs(mhcs) do
    spr(mhcsprite,(mhc.tx-1)*16,(mhc.ty-1)*16,2,2)
	end
end
