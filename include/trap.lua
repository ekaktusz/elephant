
function make_traps()
    traps=get_all_tile_pos('f')
    btraps={} --broken traps
	trap_sprite=134
    btrap_sprite=226
    destroy_time=30
end

function draw_traps()
    for _, t in ipairs(traps) do
    	spr(trap_sprite,(t.tx-1)*16,(t.ty-1)*16,2,2)
	end
end

function draw_btraps()
    for _, bt in ipairs(btraps) do
    	spr(btrap_sprite,(bt.tx-1)*16,(bt.ty-1)*16,2,2)
	end
end

function update_btraps()
    for _, bt in ipairs(btraps) do
        if (bt.dt>0) then
            bt.dt-=1
            spawnpukk((bt.tx-1)*16+8,(bt.ty-1)*16+8,0,0,e.current_c.col1,e.current_c.col2,part)
        end
    end
end

function ecollide_with_trap()
	for _, t in ipairs(traps) do
        if (t.tx>=e.tx and t.tx<=e.tx+1) and (t.ty>=e.ty and t.ty<=e.ty+1) then
            btraps[#btraps+1] = {tx=t.tx, ty=t.ty, dt=destroy_time}
            del(traps,t)
            return
 	    end
	end
end

function pcollide_with_trap()
	for _, t in ipairs(traps) do
		if t.tx==p.tx and t.ty==p.ty then
			    p.hit_trap=true
			return
		end
	end
end

