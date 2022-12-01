
function make_traps()
    traps=get_all_tile_pos(sprite_nums.trap_open)
    btraps={} --broken traps
    dead_trap={
        tx=0,
        ty=0,
        f=0,
        spr1=166,
        spr2=232,
        spr3=224,
        stp=0
    }
	trap_sprite=134
    btrap_sprite=226
    destroy_time=30
    dead_sound_played=false
end

function draw_traps()
    draw_objects(traps)
end

function draw_btraps()
    draw_objects(btraps)
end

function update_btraps()
    for _, bt in ipairs(btraps) do
        if (bt.dt>0) then
            bt.dt-=1
            spawnpukk((bt.tx-1)*16+8,(bt.ty-1)*16+8,0,0,e.current_c.col1,e.current_c.col2,part)
        end
    end
end

function draw_deadtrap()
    if not game_over then
        return
    end

    dead_trap.stp+=1
	if(dead_trap.stp%10==0) then dead_trap.f+=1 end
	if(dead_trap.f>1) then dead_trap.f=0 end

    if (game_over_timer > 30) then
        spr(dead_trap.spr1+dead_trap.f*58,(dead_trap.tx-1)*16,(dead_trap.ty-1)*16,2,2)
    else
        spr(dead_trap.spr2,(dead_trap.tx-1)*16,(dead_trap.ty-1)*16,2,2)
    end
end

function ecollide_with_trap(t)
    btraps[#btraps+1] = {tx=t.tx, ty=t.ty, dt=destroy_time}
    del(traps,t) 
end

function pcollide_with_trap(t)
    if not p.hit_trap then
        p.hit_trap=true
        if not dead_sound_played then
            dead_sound_played=true
            sfx(3)
            game_over=true
            dead_trap.tx=t.tx
            dead_trap.ty=t.ty
            del(traps,t)
        end
        return
    end
end

