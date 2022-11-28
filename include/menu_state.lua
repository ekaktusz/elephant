
local text = "press ❎  to start"
local f = 0

function init_menu()
	clvl=1
	_update = update_menu
	_draw = draw_menu
	music(0)
	make_lvl_slclts()
	anim_timer2=92
	select_timer=120
	mission_selected=false
	anim_start=false
	menu_anim_speed=5
end

function update_menu()
	if (anim_start) then
		anim_timer2-=menu_anim_speed
	end
	if not mission_selected then
		if btnp(5) then
			music(-1,700)
			mission_selected=true
			--anim_start=true
		end
		if btnp(1) then
			--switch level high
			menu_move('r')
		end
		if btnp(0) then
			--switch level low
			menu_move('l')
		end
	end
	f+=5
	
	if (anim_timer2<0) then
		init_game(clvl)
	end

	for _, l in ipairs(lvl_slcts) do
		if(l.nx>l.x) then
			--spawntrail(clvlslct.x+8,clvlslct.y+12,4,4,4,9)
			spawnpukk(clvlslct.x+8,clvlslct.y+8,0,0,4,9)
			l.x+=5
		elseif (l.nx<l.x) then
			spawnpukk(clvlslct.x+8,clvlslct.y+8,0,0,4,9)
			l.x-=5
		end
	end


	updateparts()

	if mission_selected and not anim_start then
		select_timer-=1
		if (select_timer<100) then
			anim_start=true
		end
	end
end

function menu_move(d)
		--d: l vagy r
		if (d=='r') then
			if clvl==n_lvls then return end
			clvl+=1
			for _, l in ipairs(lvl_slcts) do
	    		l.nx-=20
			end
		elseif (d=='l') then
			if clvl==1 then return end
			clvl-=1
			for _, l in ipairs(lvl_slcts) do
	    		l.nx+=20
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

	if mission_selected then
		if (f%50<=25) then
			--circfill(64,clvlslct.y+8,10,0)
			rectfill(clvlslct.x-1,clvlslct.y,clvlslct.x+20,clvlslct.y+26,0)
		end
	end
	
	if anim_start then
 		load_anim(anim_timer2)
	end

	drawparts()

	
end

clvlslct={
	x=56,
	y=82
}

function make_lvl_slclts()
	lvl_slcts={}
	for i=1,n_lvls do
		lvl_slcts[#lvl_slcts+1]={
			x=clvlslct.x+(i-1)*20,
			y=clvlslct.y+3,
			nx=clvlslct.x+(i-1)*20,
			ny=clvlslct.y+3,
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
			--circ(64,clvlslct.y+8,10,7)
			--spr(l.s,clvlslct.x,clvlslct.y,2,2)
		else
			spr(l.s,l.x,l.y,2,2)
		end
		
	end
	
	--spr(140,clvlslct.x,clvlslct.y,2,2)
	--rspr(102,clvlslct.x,clvlslct.y,a,2,2)
	print("room"..clvl,clvlslct.x-1,clvlslct.y+20,9)
end