
local text = "press ❎  to start"
local f = 0

function init_menu()
	clvl=1
	_update = update_menu
	_draw = draw_menu
	music(0)
	make_lvl_slclts()
	anim_timer2=92
	anim_start=false
	menu_anim_speed=5
end

function update_menu()
	if (anim_start) then
		anim_timer2-=menu_anim_speed
	end

	if btnp(5) then
		music(-1,700)
		anim_start=true
	end
	if btnp(1) then
		--switch level high
		menu_move('r')
	end
	if btnp(0) then
		--switch level low
		menu_move('l')
	end
	f+=5
	
	if (anim_timer2<0) then
		init_game(clvl)
	end
end

function menu_move(d)
		--d: l vagy r
		if (d=='r') then
			if clvl==n_lvls then return end
			clvl+=1
			for _, l in ipairs(lvl_slcts) do
	    		l.x-=20
			end
		elseif (d=='l') then
			if clvl==1 then return end
			clvl-=1
			for _, l in ipairs(lvl_slcts) do
	    		l.x+=20
			end
		end
end

function draw_menu()
	cls()
	pal()
	
	map(0)
	rectfill(0,16,128,36,13)
	rectfill(0,56,128,68,0)
	rectfill(0,36,128,50,13)
	rectfill(0,80,128,110,0)
	obprint("elephant",19,20,7,0,3)
	bprint("in the room",32,40,7,1.5)
	--print("press ❎ to start",32,64,2)
	draw_lvl_slct()
	wavy_text("press ❎  to start",f)
	
	if anim_start then
 	load_anim(anim_timer2)
	end
end

clvlslct={
	x=55,
	y=82
}

function make_lvl_slclts()
	lvl_slcts={}
	for i=1,n_lvls do
		lvl_slcts[#lvl_slcts+1]={
			x=clvlslct.x+(i-1)*20,
			y=clvlslct.y+3,
			lvl=i,
			s=140
		}
	end
end


local a=0

function draw_lvl_slct()
	--circfill(lvlslct.x,lvlslct.y,5,7)
	--spr(140,lvlslct.x,lvlslct.y,2,2)
	a+=7
	
	for _, l in ipairs(lvl_slcts) do
    if (l.lvl==clvl) then
    	rspr(102,clvlslct.x,clvlslct.y,a,2,2)
    else
    	spr(l.s,l.x,l.y,2,2)
    end
	end
	
	--spr(140,clvlslct.x,clvlslct.y,2,2)
	--rspr(102,clvlslct.x,clvlslct.y,a,2,2)
	print("level"..clvl,clvlslct.x-2,clvlslct.y+20,2)
end