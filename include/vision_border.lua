
local _seen_tiles={}
local _max_tx=0
local _max_ty=0
local _min_tx=8
local _min_ty=8

function update_minmax(_tx,_ty)
    if (_tx>_max_tx) then _max_tx=_tx end
    if (_ty>_max_ty) then _max_ty=_ty end
    if (_tx<_min_tx) then _min_tx=_tx end
    if (_ty<_min_ty) then _min_ty=_ty end
end

function draw_vision_border()
    get_seen_tiles()
    
    for _, s in ipairs(_seen_tiles) do
        draw_border_of_tile(s.tx,s.ty)
	end
end

function draw_border_of_tile(_tx,_ty)
    local _x=(_tx-1)*16
    local _y=(_ty-1)*16
    local _col=8

    if (_tx==_max_tx) then
        --jobbcsik
        rectfill(_x+15,_y,_x+16,_y+16,_col)
    end
    if(_tx==_min_tx) then
        --balcsik
        rectfill(_x,_y,_x+1,_y+16,_col)
    end
    if(_ty==_max_ty) then
        --lentcsik
        rectfill(_x,_y+15,_x+16,_y+16,_col)
    end
    if(_ty==_min_ty) then
        --fentcsik
        rectfill(_x,_y,_x+16,_y+1,_col)
    end
end

function get_seen_tiles()
    for _tx=1,8,1 do
        for _ty=1,8,1 do
            if(e.ty==_ty) or (e.ty+1==_ty) then
				if (can_see_through_x(_tx,e.tx,_ty)) then
                    _seen_tiles[#_seen_tiles+1] = {tx=_tx, ty=_ty}
                    update_minmax(_tx,_ty)
                end
            end
            if(e.tx==_tx) or (e.tx+1==_tx) then
				if (can_see_through_y(_ty,e.ty,_tx)) then
                    _seen_tiles[#_seen_tiles+1] = {tx=_tx, ty=_ty}
                    update_minmax(_tx,_ty)
                end
            end
        end
    end
end
