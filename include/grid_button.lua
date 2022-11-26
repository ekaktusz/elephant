--grid and button

function make_gb()
	grids=get_all_tile_pos('r') --racs
	gcsprite=138
	gosprite=170
	b={
		tx=get_tx('g'), --gomb
		ty=get_ty('g'),
		pressed=false,
		psprite=168,
		usprite=136
	}
end

function draw_gb()	
	if(b.pressed) then
		for _, g in ipairs(grids) do
					spr(gosprite,(g.tx-1)*16,(g.ty-1)*16,2,2)
		end
 	spr(b.psprite,(b.tx-1)*16,(b.ty-1)*16,2,2)
	else
		for _, g in ipairs(grids) do
					spr(gcsprite,(g.tx-1)*16,(g.ty-1)*16,2,2)
		end
		spr(b.usprite,(b.tx-1)*16,(b.ty-1)*16,2,2)
	end
end

function press_button()
	if p.tx==b.tx and p.ty==b.ty then
		b.pressed= not b.pressed
	end
end