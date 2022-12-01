function draw_tile(tx,ty)
	draw_colored_tile(tx,ty,COLORS.LIGHT_GREY,COLORS.LAVENDER,COLORS.LIGHT_PEACH,COLORS.DARK_BLUE)
end

function draw_map_edge()
	--poke(0x5f5f,0x10)
	--for i=0,15 do
	--	pal(i,i+128,2)
	--end
	--memset(0x5f78,0xff,8)
	local _x=0
	local _y=0
	local _col=1
	if d then
		local _x=(d.tx-1)*16
		local _y=(d.ty-1)*16
		draw_other_edges(d.d, _col)
		if d.d=='r' then 
			rectfill(126,0,127,_y,_col)--jobb
			rectfill(126,_y+32,127,127,_col)
		elseif d.d=='l' then
			rectfill(0,0,1,_y,_col)
			rectfill(0,_y+32,1,127,_col) 
		elseif d.d=='u' then
			rectfill(0,0,_x,1,_col)
			rectfill(_x+32,0,127,1,_col)
		elseif d.d=='d' then
			rectfill(0,126,_x,127,_col)
			rectfill(_x+32,126,127,127,_col)
		end

	else
		draw_other_edges('f',_col)
	end
end

function draw_other_edges(side, _col)
	local _sides={'l','r','u','d'}
	del(_sides,side)
	for s in all(_sides) do
		draw_edge(s, _col)
	end
end

function draw_edge(side, _col)
	if side=='u' then rectfill(0,0,127,1,_col) end  --fent
	if side=='d' then rectfill(0,126,127,127,_col) end--lent
	if side=='l' then rectfill(0,0,1,127,_col) end--bal
	if side=='r' then rectfill(126,0,127,127,_col) end--jobb
end

function draw_map()
	for i=1,8,1 do
		for j=1,8,1 do
			draw_tile(i,j)
		end
	end
end

function make_gamemap()
	gamemap=lvl_tmplt
end

function get_all_tile_pos(_sprnum)
	local t = {}
	for i = 1, 8 do
		for j = 1, 8 do
			if gamemap[i][j]==_sprnum then
				t[#t+1] = {tx=j, ty=i, sprt=_sprnum}
			end
		end
	end
	return t
end

function get_tx(_sprnum)
	for i = 1, 8 do
		for j = 1, 8 do
			if gamemap[i][j]==_sprnum then
				return j
			end
		end
 	end
	return 0
end

function get_ty(_sprnum)
	for i = 1, 8 do
		for j = 1, 8 do
			if gamemap[i][j]==_sprnum then
				return i
			end
 		end
	end
	return 0
end

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

-- ty az y pozicio, a sor amiben vagunk, a tx1, tx2 peddig a két tile
function can_see_through_x(tx1,tx2,ty)
	local x1=min(tx1,tx2)
	local x2=max(tx1,tx2)
	for i=x1,x2 do
		if has_value(light_rigids,gamemap[ty][i]) then
			return false
		end
	end
	return true
end

function can_see_through_y(ty1,ty2,tx)
	local y1=min(ty1,ty2)
	local y2=max(ty1,ty2)
	for i=y1,y2 do
		if has_value(light_rigids,gamemap[i][tx]) then
			return false
		end
	end
	return true
end

function is_end_of_map(tx,ty,d)
	--d (direction): 'l', 'r', 'd', 'u'
	if (d=='l') then return tx==1 end
	if (d=='r') then return tx==8 end
	if (d=='d') then return ty==8 end
	if (d=='u') then return ty==1 end
end

function is_on_tile(tx,ty,letter)
	--nut
	if letter==sprite_nums.peanut then
		return is_on_objects(tx,ty,nuts)
	end
	--button
	if letter==sprite_nums.button1 then
		return is_on_object(tx,ty,b)
	end
	--grid
	if (letter==sprite_nums.grid1) then
		return is_on_objects(grids)
	end
	--door
	if letter==sprite_nums.vdoor then
		if (d.d=='l' or d.d=='r') then
			return tx==d.tx and (ty==d.ty or ty==d.ty+1)
		else
			return ty==d.ty and (tx==d.tx or tx==d.tx+1)
		end
	end
	
	--hole
	if letter==sprite_nums.hhole  then
		return gamemap[ty][tx]==letter or gamemap[ty][tx]==sprite_nums.whhole
	end
	if letter==sprite_nums.vhole then
		return gamemap[ty][tx]==letter or gamemap[ty][tx]==sprite_nums.wvhole
	end
end

function is_tile_on_side(tx,ty,letter,side)
	--letter: t for wall, w for water, m for nut, p for player, e for elephant, x for nothing, a for door
	
	--side: r for right, l for left, u for up, d for down
	--calculate side cell pos
	if (side=='r') then 
		stx=tx+1 
		sty=ty 
	elseif (side=='l') then 
		stx=tx-1 
		sty=ty 
	elseif (side=='u') then 
		stx=tx
		sty=ty-1
	elseif (side=='d') then 
		stx=tx
		sty=ty+1 
	end -- not possible

	--holes
	if letter==sprite_nums.hhole then
		if (gamemap[sty][stx]==letter or gamemap[sty][stx]==sprite_nums.whhole) then
			return true
		end
	end

	if letter==sprite_nums.vhole then
		if (gamemap[sty][stx]==letter or gamemap[sty][stx]==sprite_nums.wvhole) then
			return true
		end
	end
	
	-- brick or manholecover
	if (letter==sprite_nums.mhc) then 
		if (gamemap[sty][stx]==letter) then --since it cant be removed
			return true
		end
	end
	
	--wall
	if (letter==sprite_nums.wall) then 
		return is_on_objects(stx, sty, walls)
	end
	
	-- break wall
	if (letter==sprite_nums.bwall) then 
		return is_on_objects(stx, sty, bwalls)
	end
	
	-- water
	if (letter==sprite_nums.water1) then 
		return is_on_objects(stx, sty, water)
	end
	
	-- elephant
	if letter==sprite_nums.elephant1 then
		if e.finish then 
			return false 
		end
		if (side=='l' or side=='r') then
			if side=='l' then stx=tx-2 end
			if (ty==e.ty) or (ty-1==e.ty) or (ty==e.nty) or (ty-1==e.nty) then -- egy sorban vagy eggyel alatta
				if (stx==e.tx) or (stx==e.ntx) then
					return true
				end
			end
		end
		
		-- u vagy d
		if (side=='u' or side=='d') then
			if side=='u' then sty=ty-2 end
			if (tx==e.tx or tx-1==e.tx) or (tx==e.ntx) or (tx-1==e.ntx) then -- egy oszlopban vagy eggyel elotte
				if (sty==e.ty) or (sty==e.nty) then
					return true
				end
			end
		end
		return false
	end
	
	--door
	if letter==sprite_nums.vdoor then
		if(stx==d.tx) and (sty==d.ty) then
			return true
		end
	end
	
	--grid
	if (letter==sprite_nums.grid1) then
		return is_on_objects(stx, sty, grids)
	end
	
	--button
	if (letter==sprite_nums.button1) then
		return is_on_object(stx, sty, b)
	end
	
	return false
end