COLORS={
    BLACK=0,
    DARK_BLUE=1,
    DARK_PURPLE=2,
    DARK_GREEN=3,
    BROWN=4,
    DARK_GREY=5,
    LIGHT_GREY=6,
    WHITE=7,
    RED=8,
    ORANGE=9,
    YELLOW=10,
    GREEN=11,
    BLUE=12,
    LAVENDER=13,
    PINK=14,
    LIGHT_PEACH=15
}

function draw_assist_view()
    if assisted_view then
        for tx=1,8,1 do
            for ty=1,8,1 do
                local _seen=false
                if(e.ty==ty) or (e.ty+1==ty) then
                    if (can_see_through_x(tx,e.tx,ty)) then
                        _seen=true
                    end
                end
                if(e.tx==tx) or (e.tx+1==tx) then
                    if (can_see_through_y(ty,e.ty,tx)) then
                        _seen=true
                    end
                end
                if _seen then
                    --shade_tile(tx,ty)
                    if (can_elephant_see_the_player()) then
                        draw_colored_tile(tx,ty,COLORS.LIGHT_GREY,COLORS.DARK_PURPLE,COLORS.RED,COLORS.DARK_BLUE)
                    else
                        draw_colored_tile(tx,ty,COLORS.LIGHT_GREY,COLORS.DARK_GREEN,COLORS.GREEN,COLORS.DARK_BLUE)
                    end
                end
            end
        end
    end
end

function draw_colored_tile(tx,ty,_col1,_col2,_col3,_col4)
	local _x1=(tx-1)*16
	local _y1=(ty-1)*16
	local _x2=tx*16
	local _y2=ty*16
	rectfill(_x1  ,_y1  ,_x2  ,_y2,_col1) --  4 sarok
	rectfill(_x1  ,_y1+1,_x2  ,_y2-1,_col3) -- háttér
	rectfill(_x1+1,_y1  ,_x2-1,_y2,_col3) -- háttér
	rectfill(_x1+1,_y1+1,_x2-1,_y2-1,_col4) -- 4 sötétkék pötty
	rectfill(_x1+2,_y1+1,_x2-2,_y2-1,_col3)  --8 háttérszínű geci megint
	rectfill(_x1+1,_y1+2,_x2-1,_y2-2,_col3) --8 háttérszínű geci megint
	rectfill(_x1+1,_y1+3,_x2-1,_y2-3,_col2) --lila outline
	rectfill(_x1+2,_y1+2,_x2-2,_y2-2,_col2)
	rectfill(_x1+3,_y1+1,_x2-3,_y2-1,_col2)

	rectfill(_x1+2,_y1+4,_x2-2,_y2-4,_col3) --belső háttér
	rectfill(_x1+3,_y1+3,_x2-3,_y2-3,_col3)
	rectfill(_x1+4,_y1+2,_x2-4,_y2-2,_col3)
end