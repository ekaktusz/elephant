--water
function make_water()
	water=get_all_tile_pos('w')
	dwater={}
	wtrsprite=132 --164
	dwtrsprite=202
	w_anim={
		f=0,
		stp=0,
	}
end

function draw_water()
	w_anim.stp+=1
	if(w_anim.stp%10==0) then w_anim.f+=1 end
	if(w_anim.f>1) then w_anim.f=0 end

	for _, w in ipairs(water) do
		spr(wtrsprite+w_anim.f*32,(w.tx-1)*16,(w.ty-1)*16,2,2)
	end
end

function draw_dwater()
	for _, dw in ipairs(dwater) do
		spr(dwtrsprite,(dw.tx-1)*16,(dw.ty-1)*16,2,2)
	end
end

function ecollide_with_water()
	for _, w in ipairs(water) do
 	if (w.tx>=e.tx and w.tx<=e.tx+1) and (w.ty>=e.ty and w.ty<=e.ty+1) then
		dwater[#dwater+1] = {tx=w.tx, ty=w.ty}
 		del(water,w)
 		e.d=0
		e.current_c=e.w_drink_c
 		e.hit_freeze=true
 		return
 	end
	end
end