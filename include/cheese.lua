
function make_cheeses()
    cheeses=get_all_tile_pos(sprite_nums.cheese)
    eaten_cheeses={}
end

function pcollide_with_cheese(c)
    p.cheese_eat_time-=1
    spawnpukk((p.tx-1)*16+8,(p.ty-1)*16+8,0,0,e.nut_eat_c.col1,e.nut_eat_c.col2,part)
    if p.cheese_eat_time <0 then
        eaten_cheeses[#eaten_cheeses+1] = {tx=c.tx, ty=c.ty, sprt=sprite_nums.dpeanut} -- add to deleted waters
        del(cheeses,c)
        sfx(8)
        p.cheese_eat_time=50
    end
end