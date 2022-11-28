--map
n_lvls=8 --number of levels
-- t = fal, b = torheto fal, c = csatornafedel, g = gomb, r = racs
-- m = mogyi, e = elefant, a = ajto, h = egerlyuk, w = viz
lvls={
	{ --lvl1
		{'t', 't', 't', 't', 'x', 'x', 't', 't'},
		{'t', 'x', 'x', 'x', 'x', 'x', 'x', 't'},
		{'x', 'x', 'x', 'x', 'x', 'x', 'x', 't'},
		{'x', 'x', 'x', 't', 't', 'x', 'x', 't'},
		{'t', 'x', 'x', 't', 't', 'x', 'x', 'a'},
		{'t', 'e', 'x', 'x', 'x', 'x', 'x', 'a'},
		{'t', 'x', 'x', 't', 't', 't', 't', 't'},
		{'t', 'x', 'x', 'x', 'p', 't', 't', 't'}
	},
	{ --lvl2
		{'p', 'x', 'x', 't', 't', 't', 't', 't'},
		{'t', 'e', 'x', 't', 't', 't', 't', 't'},
		{'t', 'x', 'x', 't', 't', 't', 't', 't'},
		{'t', 'x', 'x', 't', 't', 't', 't', 't'},
		{'t', 'x', 'x', 'x', 'x', 'x', 'x', 'a'},
		{'t', 'x', 'x', 'x', 'x', 'm', 'x', 'a'},
		{'t', 't', 't', 't', 't', 't', 't', 't'},
		{'t', 't', 't', 't', 't', 't', 't', 't'}
	},
	{ --lvl3
		{'p', 'x', 'x', 'x', 'x', 'x', 't', 't'},
		{'t', 't', 't', 't', 't', 'x', 't', 't'},
		{'t', 't', 't', 'x', 'x', 'm', 't', 't'},
		{'t', 't', 't', 'x', 't', 'x', 't', 't'},
		{'t', 't', 't', 'e', 'x', 'x', 'x', 'a'},
		{'t', 't', 't', 'x', 'x', 'x', 'x', 'a'},
		{'t', 't', 't', 't', 't', 't', 't', 't'},
		{'t', 't', 't', 't', 't', 't', 't', 't'}
	},
	{ --lvl4
		{'t', 't', 'g', 'a', 'a', 't', 't', 't'},
		{'t', 't', 'x', 'x', 'x', 't', 't', 't'},
		{'t', 't', 'x', 'x', 'x', 't', 't', 't'},
		{'t', 't', 'r', 'r', 'r', 't', 't', 't'},
		{'t', 't', 'x', 'e', 'x', 't', 't', 't'},
		{'t', 't', 'x', 'x', 'x', 't', 't', 't'},
		{'t', 't', 'x', 'x', 'x', 't', 't', 't'},
		{'t', 't', 'p', 'x', 'x', 't', 't', 't'}
	},
	{ --lvl5
		{'t', 't', 't', 't', 't', 't', 't', 't'},
		{'t', 't', 't', 'x', 'x', 'm', 't', 't'},
		{'t', 't', 't', 't', 'x', 't', 't', 't'},
		{'e', 'x', 'x', 'x', 'x', 'x', 'x', 'a'},
		{'x', 'x', 'x', 'p', 'x', 'x', 'x', 'a'},
		{'t', 't', 't', 't', 't', 't', 't', 't'},
		{'t', 't', 't', 't', 't', 't', 't', 't'},
		{'t', 't', 't', 't', 't', 't', 't', 't'}
	},
	{ --lvl6
		{'p', 'x', 'x', 'x', 'x', 'x', 'x', 'm'},
		{'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'},
		{'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'},
		{'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'},
		{'t', 't', 't', 'x', 'x', 'x', 'x', 'x'},
		{'e', 'x', 'x', 'x', 'x', 'x', 'x', 'a'},
		{'x', 'x', 'x', 'x', 'x', 'x', 'x', 'a'},
		{'t', 't', 't', 'x', 'x', 'x', 'x', 'x'}
	},
	{ --testlvl7
		{'x', 'x', 'g', 'c', 'x', 'x', 'c', 'm'},
		{'t', 't', 'h', 't', 't', 't', 'r', 'r'},
		{'x', 'c', 'e', 'x', 'x', 'b', 'x', 'x'},
		{'x', 'c', 'x', 'x', 'x', 'b', 'x', 'x'},
		{'x', 't', 'x', 'x', 'x', 't', 'r', 'r'},
		{'x', 't', 'x', 'x', 'x', 't', 'x', 'x'},
		{'x', 'x', 'p', 'm', 'x', 'h', 'x', 'x'},
		{'x', 'x', 'x', 'x', 'x', 't', 'a', 'a'}
	},
	{ --testlvl8
		{'a', 'a', 'x', 'g', 'x', 'x', 'x', 'x'},
		{'r', 'r', 'c', 'c', 'c', 'b', 'r', 'r'},
		{'x', 'r', 'x', 'e', 'x', 'b', 'x', 'm'},
		{'x', 'r', 'x', 'x', 'x', 'b', 'x', 'x'},
		{'r', 'r', 'b', 'x', 'x', 't', 'r', 'r'},
		{'x', 'x', 'b', 'x', 'x', 't', 'c', 'c'},
		{'x', 'x', 'b', 'm', 'x', 'x', 'x', 'x'},
		{'m', 'x', 'h', 'p', 'x', 'x', 'x', 'x'}
	}
}

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