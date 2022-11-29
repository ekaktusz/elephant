--grid and button

function init_grids()
	grids=get_all_tile_pos('r')
	gcsprite=138
	gosprite=170
end

function init_button()
	b = { 
		tx=get_tx('g'), --gomb
		ty=get_ty('g'),
		pressed=false,
		psprite=168,
		usprite=136
	}
end

function draw_button()
	if b.pressed then
		spr(b.psprite,(b.tx-1)*16,(b.ty-1)*16,2,2)
	else
		spr(b.usprite,(b.tx-1)*16,(b.ty-1)*16,2,2)
	end
end

function draw_grids()
	for _, g in ipairs(grids) do
		if(b.pressed) then
			spr(gosprite,(g.tx-1)*16,(g.ty-1)*16,2,2)
		else
			spr(gcsprite,(g.tx-1)*16,(g.ty-1)*16,2,2)
		end
	end
end

function press_button()
	if is_on_tile(p.tx,p.ty,'g') and not e_undergrid() then
		b.pressed= not b.pressed
		sfx(5)
	end
end

function e_undergrid()
	for _, g in ipairs(grids) do
		if (g.tx>=e.tx and g.tx<=e.tx+1) and (g.ty>=e.ty and g.ty<=e.ty+1)
			 or (g.tx>=e.ntx and g.tx<=e.ntx+1) and (g.ty>=e.nty and g.ty<=e.nty+1) then
			return true
		end
	end
	return false
end