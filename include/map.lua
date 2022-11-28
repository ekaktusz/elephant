function draw_tile(tx,ty)
	local _x1=(tx-1)*16
	local _y1=(ty-1)*16
	local _x2=tx*16
	local _y2=ty*16
	rectfill(_x1  ,_y1  ,_x2  ,_y2,6) --  4 sarok
	rectfill(_x1  ,_y1+1,_x2  ,_y2-1,15) -- háttér
	rectfill(_x1+1,_y1  ,_x2-1,_y2,15) -- háttér
	rectfill(_x1+1,_y1+1,_x2-1,_y2-1,1) -- 4 sötétkék pötty
	rectfill(_x1+2,_y1+1,_x2-2,_y2-1,15)  --8 háttérszínű geci megint
	rectfill(_x1+1,_y1+2,_x2-1,_y2-2,15) --8 háttérszínű geci megint
	rectfill(_x1+1,_y1+3,_x2-1,_y2-3,13) --lila outline
	rectfill(_x1+2,_y1+2,_x2-2,_y2-2,13)
	rectfill(_x1+3,_y1+1,_x2-3,_y2-1,13)

	rectfill(_x1+2,_y1+4,_x2-2,_y2-4,15) --belső háttér
	rectfill(_x1+3,_y1+3,_x2-3,_y2-3,15)
	rectfill(_x1+4,_y1+2,_x2-4,_y2-2,15)

	--if (tx==1) then
	--	rectfill(_x1,_y1,_x1+1,_y2,4)
	--elseif (tx==8) then 
	--	rectfill(_x2-2,_y1,_x2,_y2,4)
	--end
	--if (ty==1) then
	--	rectfill(_x1,_y1,_x2,_y1+1,4)
	--elseif (ty==8) then
	--	rectfill(_x1,_y2-2,_x2,_y2,4)
	--end
	

	--if (tx==8) then--jobboldal
	--	rectfill(_x2-2,_y1,_x2,_y2,13)
	--	rectfill(_x1+2,_y1+4,_x2-2,_y2-4,15)
	--	pset(_x2,_y1,6)
	--	pset(_x2,_y2,6)
	--	pset(_x2,_y1+1,1)
	--	pset(_x2,_y2-1,1)
	--	pset(_x2-1,_y1,1)
	--	pset(_x2-1,_y2,1)
	
	
	--end
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
	gamemap=deepcopy(lvls[current_lvl])
end

function get_all_tile_pos(obj)
	local t = {}
	for i = 1, 8 do
 	for j = 1, 8 do
  	if gamemap[i][j]==obj then
  		t[#t+1] = {tx=j, ty=i}
  	end
 	end
 end
 return t
end

function get_tx(obj)
	for i = 1, 8 do
 	for j = 1, 8 do
  	if gamemap[i][j]==obj then
  		return j
  	end
 	end
 end
	return 0
end

function get_ty(obj)
	for i = 1, 8 do
 	for j = 1, 8 do
  	if gamemap[i][j]==obj then
  		return i
  	end
 	end
 end
 return 0
end

function can_see_through_x(tx1,tx2,ty)
	local x1=min(tx1,tx2)
	local x2=max(tx1,tx2)
	for i=x1,x2 do
		if gamemap[ty][i]=='t'
		or gamemap[ty][i]=='b'
		or gamemap[ty][i]=='h' then
			return false
		end
	end
	return true
end

function can_see_through_y(ty1,ty2,tx)
	local y1=min(ty1,ty2)
	local y2=max(ty1,ty2)
	for i=y1,y2 do
		if gamemap[i][tx]=='t'
		or gamemap[i][tx]=='b'
		or gamemap[i][tx]=='h' then
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
	if letter=='m' then
		for _, n in ipairs(nuts) do
			if n.tx==tx and n.ty==ty then
				return true
			end
	   end
	   return false
	end
	--button
	if letter=='g' then
		if b.tx==tx and b.ty==ty then
			return true
		end
		return false
	end
	--grid
	if (letter=='r') then
		for _, g in ipairs(grids) do
			if (g.tx==tx and g.ty==ty) then
				return true
			end
		end
		return false
	end
	
	--hole
	if (letter=='h') then
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
	if (letter=='t' or letter=='c' or letter=='h') then 
		if (gamemap[sty][stx]==letter) then --since it cant be removed
			return true
		end
	end
	
	
	-- break wall
	if (letter=='b') then 
		for _, bw in ipairs(bwalls) do
			if (bw.tx==stx and bw.ty==sty) then
				return true
			end
		end
	end
	
	-- water
	if (letter=='w') then 
		for _, w in ipairs(water) do
			if (w.tx==stx and w.ty==sty) then
				return true
			end
		end
	end
	
	-- elephant
	if letter=='e' then
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
	if letter=='a' then
		if(stx==d.tx) and (sty==d.ty) then
			return true
		end
	end
	
	--grid
	if (letter=='r') then
		for _, g in ipairs(grids) do
			if (g.tx==stx and g.ty==sty) then
			return true
			end
		end
	end
	
	--button
	if (letter=='g') then
		if (b.tx==stx and b.ty==sty) then
			return true
		end
	end
	
	return false
end