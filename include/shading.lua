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
function begin_dark()
    --pal({0,1,1,2,0,5,5,2,5,13,3,1,1,2,13})
    --https://www.lexaloffle.com/bbs/files/10006/db-pico-pre.png
    for i=0,15,1 do
        if (i<=7) then
            pal(i,3)
        else
            pal(i,11)
        end
    end
end

function end_dark()
    pal(0)
end

function shade_tile(tx,ty)
    poke(0x5f54,0x60)
    begin_dark()

    --ssprrect(30,50,90,100)
    ssprtilerect(tx,ty)
    
    poke(0x5f54,0)
    end_dark()
end

function after_draw()
    poke(0x5f54,0x60)
    begin_dark()

    --ssprrect(30,50,90,100)
    ssprtilerect(1,1)
    
    poke(0x5f54,0)
    end_dark()
end

function ssprline(x1,y1,x2,y2)
    sspr(x1,y1,1,y2-y1,x1,y1)
end

function ssprtilerect(tx,ty)
    local _x=(tx-1)*16
    local _y=(ty-1)*16

    ssprrect(_x,_y,_x+16,_y+16)
end


function ssprrect(x1,y1,x2,y2)
    for i=x1,x2,1 do
        ssprline(i,y1,i+1,y2)
    end
end

function shade_unseen_tiles()
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
            if not _seen then
                --shade_tile(tx,ty)
                make_tile_color(tx,ty)
            end
        end
    end
end

function shade_seen_tiles()
    if (btn(0,1)) then
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
                    if (e.seen_player) then
                        draw_colored_tile(tx,ty,COLORS.LIGHT_GREY,COLORS.DARK_PURPLE,COLORS.RED,COLORS.DARK_BLUE)
                    else
                        draw_colored_tile(tx,ty,COLORS.LIGHT_GREY,COLORS.DARK_GREEN,COLORS.GREEN,COLORS.DARK_BLUE)
                    end
                end
            end
        end
    end
end

function make_tile_color(tx,ty)
    local _x=(tx-1)*16
    local _y=(ty-1)*16
    local _col=COLORS.GREEN

    for i=1,4,1 do
        line(_x,_y+i*4,_x+i*4,_y,_col)
    end

    for i=1,4,1 do
        line(_x+i*4,_y+16,_x+16,_y+i*4,_col)
    end

    --for _dx=1,16,2 do
    --    for _dy=1,16,1 do
    --        pset(_x+_dx,_y+_dy,COLORS.BLACK)
    --    end
    --end
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