--hole
function make_h()
	holes=get_all_tile_pos('h')
	hsprite=162
end

function draw_h()
	for _,h in ipairs(holes) do
    spr(hsprite,(h.tx-1)*16,(h.ty-1)*16,2,2)
	end
end