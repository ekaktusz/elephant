function make_carpet()
    carpet={
        tx=get_tx(sprite_nums.carpet),
        ty=get_ty(sprite_nums.carpet)
    }
end

function draw_carpet()
    spr(sprite_nums.carpet,(carpet.tx-1)*16,(carpet.ty-1)*16,4,2)
end