--map
n_lvls=28 --number of levels
-- t = fal, b = torheto fal, c = csatornafedel, g = gomb, r = racs
-- m = mogyi, e = elefant, a = ajto, h = egerlyuk,
-- s = sajt, w = viz, f = egerfogo, p = player

lvl_tmplt = { --lvl 1
	{'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'},
	{'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'},
	{'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'},
	{'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'},
	{'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'},
	{'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'},
	{'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'},
	{'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'}
}

function load_game_map(_lvl)
	local _colsx=8*((_lvl-1)%16)
	local _colsy=8*flr((_lvl-1)/16)
	for i = _colsx, _colsx+7, 1 do
		for j = _colsy, _colsy+7, 1 do
			--log('a'..mget(i,j))
			local _sprite_num = mget(i,j)
			local _letter = get_letter_for_sprite_num(_sprite_num)
			log(_letter)
			lvl_tmplt[j-_colsy+1][i-_colsx+1]=_letter
		end
	end
end

function get_letter_for_sprite_num(_sprite_num)
	if (_sprite_num == 143 or _sprite_num == 208) then
		return 'a'
	elseif (_sprite_num == 64) then
		return 'e'
	elseif (_sprite_num==138) then
		return 'r'
	elseif (_sprite_num==162) then
		return 'h'
	elseif (_sprite_num==192) then
		return 'c'
	elseif (_sprite_num==140) then
		return 'm'
	elseif (_sprite_num==2 or _sprite_num==32 or _sprite_num==34) then --ez nem lehet 0
		return 'p'
	elseif (_sprite_num==134) then
		return 'f'
	elseif _sprite_num==128 or _sprite_num==10 or _sprite_num==8 or _sprite_num==40 or _sprite_num==42 or _sprite_num==46 or _sprite_num==228 then 
		return 't'
	elseif _sprite_num==160 or _sprite_num==4 or _sprite_num==36 or _sprite_num==230 then --törhető fal + cserép + wc
		return 'b'
	elseif _sprite_num==132 then
		return 'w'
	elseif _sprite_num==136 then
		return 'g'
	else -- 0
		return 'x'
	end
end

lvls={
	{ --lvl 1
		{'t', 't', 't', 't', 'x', 'x', 't', 't'},
		{'t', 'x', 'x', 'x', 'x', 'x', 'x', 't'},
		{'x', 'x', 'x', 'x', 'x', 'x', 'x', 't'},
		{'x', 'x', 'x', 't', 't', 'x', 'x', 't'},
		{'t', 'x', 'x', 't', 't', 'x', 'x', 'a'},
		{'t', 'e', 'x', 'x', 'x', 'x', 'x', 'a'},
		{'t', 'x', 'x', 't', 't', 't', 't', 't'},
		{'t', 'x', 'x', 'x', 'p', 't', 't', 't'}
	}
}