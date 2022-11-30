function draw_tile(tx,ty)
	draw_colored_tile(tx,ty,COLORS.LIGHT_GREY,COLORS.LAVENDER,COLORS.LIGHT_PEACH,COLORS.DARK_BLUE)
end

function draw_map_edge()
	local _col=4
	rectfill(0,0,128,1,_col)--fent
	rectfill(0,126,128,128,_col)--lent
	rectfill(0,0,1,128,_col)--bal
	rectfill(126,0,128,128,_col)--jobb
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

-- ty az y pozicio, a sor amiben vagunk, a tx1, tx2 peddig a két tile
function can_see_through_x(tx1,tx2,ty)
	local x1=min(tx1,tx2)
	local x2=max(tx1,tx2)
	for i=x1,x2 do
		if gamemap[ty][i]==sprite_nums.wall
		or gamemap[ty][i]==sprite_nums.bwall
		or gamemap[ty][i]==sprite_nums.hhole
		or gamemap[ty][i]==sprite_nums.vhole
		or gamemap[ty][i]==sprite_nums.plant
		or gamemap[ty][i]==sprite_nums.wc
		or gamemap[ty][i]==sprite_nums.old_tv
		or gamemap[ty][i]==sprite_nums.new_tv
		or gamemap[ty][i]==sprite_nums.green1
		or gamemap[ty][i]==sprite_nums.green2
		or gamemap[ty][i]==sprite_nums.pink1
		or gamemap[ty][i]==sprite_nums.pink2  then
			return false
		end
	end
	return true
end

function can_see_through_y(ty1,ty2,tx)
	local y1=min(ty1,ty2)
	local y2=max(ty1,ty2)
	for i=y1,y2 do
		if gamemap[i][tx]==sprite_nums.wall
		or gamemap[i][tx]==sprite_nums.bwall
		or gamemap[i][tx]==sprite_nums.hhole
		or gamemap[i][tx]==sprite_nums.vhole
		or gamemap[i][tx]==sprite_nums.plant
		or gamemap[i][tx]==sprite_nums.wc
		or gamemap[i][tx]==sprite_nums.old_tv
		or gamemap[i][tx]==sprite_nums.new_tv
		or gamemap[i][tx]==sprite_nums.green1
		or gamemap[i][tx]==sprite_nums.green2
		or gamemap[i][tx]==sprite_nums.pink1
		or gamemap[i][tx]==sprite_nums.pink2 then
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
		for _, n in ipairs(nuts) do
			if n.tx==tx and n.ty==ty then
				return true
			end
	   end
	   return false
	end
	--button
	if letter==sprite_nums.button1 then
		if b.tx==tx and b.ty==ty then
			return true
		end
		return false
	end
	--grid
	if (letter==sprite_nums.grid1) then
		for _, g in ipairs(grids) do
			if (g.tx==tx and g.ty==ty) then
				return true
			end
		end
		return false
	end
	
	--hole
	if (letter==sprite_nums.hhole or letter==sprite_nums.vhole) then
		return gamemap[ty][tx]==letter
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
	
	-- brick or manholecover
	if (letter==sprite_nums.mhc or letter==sprite_nums.hhole or letter==sprite_nums.vhole) then 
		if (gamemap[sty][stx]==letter) then --since it cant be removed
			return true
		end
	end
	
	--wall
	if (letter==sprite_nums.wall) then 
		for _, w in ipairs(walls) do
			if (w.tx==stx and w.ty==sty) then
				return true
			end
		end
	end
	
	-- break wall
	if (letter==sprite_nums.bwall) then 
		for _, bw in ipairs(bwalls) do
			if (bw.tx==stx and bw.ty==sty) then
				return true
			end
		end
	end
	
	-- water
	if (letter==sprite_nums.water1) then 
		for _, w in ipairs(water) do
			if (w.tx==stx and w.ty==sty) then
				return true
			end
		end
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
		for _, g in ipairs(grids) do
			if (g.tx==stx and g.ty==sty) then
			return true
			end
		end
	end
	
	--button
	if (letter==sprite_nums.button1) then
		if (b.tx==stx and b.ty==sty) then
			return true
		end
	end
	
	return false
end