--map
n_lvls=29
sprite_nums={
	carpet=234,
	wall=128,
	bath_wall=204,
	bwall=160,
	bdwall=130,
	mhc=196,
	button1=136,
	button2=168,
	grid1=138,
	grid2=170,
	peanut=140,
	dpeanut=200,
	rpeanut=198,
	elephant1=64,
	elephant2=68,
	scelephant1=72,
	scelephant2=76,
	vdoor=143,
	hdoor=208,
	vhole=162,
	hhole=172,
	wvhole=206,
	whhole=238,
	cheese=14,
	water1=132,
	water2=164,
	dwater=202,
	trap_open=134,
	trap_closed1=166,
	trap_closed2=232,
	trap_closed3=224,
	dtrap=226,
	player_left1=0,
	player_left2=2,
	player_top1=32,
	player_top2=34,
	old_tv=8,
	new_tv=40,
	green1=10,
	green2=12,
	pink1=42,
	pink2=44,
	plant=4,
	dplant=6,
	wc=36,
	dwc=38,
	box=228,
	dbox=230,
	lamp=46
}

light_rigids={
	sprite_nums.wall,
	sprite_nums.bwall,
	sprite_nums.hhole,
	sprite_nums.vhole,
	sprite_nums.plant,
	sprite_nums.wc,
	sprite_nums.old_tv,
	sprite_nums.new_tv,
	sprite_nums.green1,
	sprite_nums.green2,
	sprite_nums.pink1,
	sprite_nums.pink2,
	sprite_nums.box,
	sprite_nums.lamp,
	sprite_nums.bath_wall
}

lvl_tmplt= {
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
			--log(sprite_nums.vdoor..mget(i,j))
			local _sprite_num = mget(i,j)
			lvl_tmplt[j-_colsy+1][i-_colsx+1]=_sprite_num
		end
	end
end