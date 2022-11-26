--third parties
function bprint(str,x,y,c,scale)
	_str_to_sprite_sheet(str)
	
	local w = #str*4
	local h = 5
	
	pal(7,c)
	palt(0,true)
	
	sspr(0,0,w,h,x,y,w*scale,h*scale)
	pal()
	
	_restore_sprites_from_usermem()
end

function obprint(str,x,y,c,co,scale)
	_str_to_sprite_sheet(str)
	
	local w = #str*4
	local h = 5
	palt(0,true)
	
	pal(7,co)
	
	
	for xx=-2,1,2 do
		for yy=-2,1,2 do
			sspr(0,0,w,h,x+xx,y+yy,w*scale,h*scale)
		end
	end
	
	pal(7,c)
	sspr(0,0,w,h,x,y,w*scale,h*scale)
	pal()
	
	_restore_sprites_from_usermem()
end

function _str_to_sprite_sheet(str)
	_copy_sprites_to_usermem()
	_black_out_sprite_row()
	set_sprite_target()
	print(str,0,0,7)
	set_screen_target()
end

function set_sprite_target()
	poke(0x5f55,0x00)
end

function set_screen_target()
	poke(0x5f55,0x60)
end

function _copy_sprites_to_usermem()
	memcpy(0x4300,0x0,0x0200)
end

function _black_out_sprite_row()
	memset(0x0,0,0x0200)
end

function _restore_sprites_from_usermem()
	memcpy(0x0,0x4300,0x0200)
end


--wavy text
function wavy_text(text,f)
	local y
 local c
 local x = 128/2 - (#text*4)/2
 for c=1,#text do
 	y = sin((x+f)/100) * 2
  color(5)
  print(sub(text,c,c),x,(64-4)+y)
  y = sin((x+10+f)/100) * 2
  color(7)
  print(sub(text,c,c),x,(64-4)+y)
  x = x+4
 end
end


--copy table
function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

--rotating sprite
function spr_r(s,x,y,a,w,h)
	sw=(w or 1)*8
	sh=(h or 1)*8
	sx=(s%8)*8
	sy=flr(s/8)*8
	x0=flr(0.5*sw)
	y0=flr(0.5*sh)
	a=a/360
	sa=sin(a)
	ca=cos(a)
	for ix=0,sw-1 do
		for iy=0,sh-1 do
			dx=ix-x0
			dy=iy-y0
			xx=flr(dx*ca-dy*sa+x0)
			yy=flr(dx*sa+dy*ca+y0)
			if (xx>=0 and xx<sw and yy>=0 and yy<=sh) then
				pset(x+ix,y+iy,sget(sx+xx,sy+yy))
			end
		end
	end
end

function rspr(s,x,y,a,w,h)
 sw=(w or 1)*8
 sh=(h or 1)*8
 sx=(s%8)*8
 sy=flr(s/8)*8
 x0=flr(0.5*sw)
 y0=flr(0.5*sh)
 a=a/360
 sa=sin(a)
 ca=cos(a)
 for ix=sw*-1,sw+4 do
  for iy=sh*-1,sh+4 do
   dx=ix-x0
   dy=iy-y0
   xx=flr(dx*ca-dy*sa+x0)
   yy=flr(dx*sa+dy*ca+y0)
   if (xx>=0 and xx<sw and yy>=0 and yy<=sh-1) then
    local col = sget(sx+xx,sy+yy)
				if col != 0 then
				   pset(x+ix,y+iy,col)
				end
   end
  end
 end
end

function doshake()
	 -- this function does the
	 -- shaking
	 -- first we generate two
	 -- random numbers between
	 -- -16 and +16
	 local shakex=16-rnd(32)
	 local shakey=16-rnd(32)
	
	 -- then we apply the shake
	 -- strength
	 shakex*=shake
	 shakey*=shake
	 
	 -- then we move the camera
	 -- this means that everything
	 -- you draw on the screen
	 -- afterwards will be shifted
	 -- by that many pixels
	 camera(shakex,shakey)
	 
	 -- finally, fade out the shake
	 -- reset to 0 when very low
	 shake = shake*0.95
	 if (shake<0.05) shake=0
	end
	
	function fadepal(_perc)
	 -- this function sets the
	 -- color palette so everything
	 -- you draw afterwards will
	 -- appear darker
	 -- it accepts a number from
	 -- 0 means normal
	 -- 1 is completely black
	 -- this function has been
	 -- adapted from the jelpi.p8
	 -- demo
	 
	 -- first we take our argument
	 -- and turn it into a 
	 -- percentage number (0-100)
	 -- also making sure its not
	 -- out of bounds  
	 local p=flr(mid(0,_perc,1)*100)
	 
	 -- these are helper variables
	 local kmax,col,dpal,j,k
	 
	 -- this is a table to do the
	 -- palette shifiting. it tells
	 -- what number changes into
	 -- what when it gets darker
	 -- so number 
	 -- 15 becomes 14
	 -- 14 becomes 13
	 -- 13 becomes 1
	 -- 12 becomes 3
	 -- etc...
	 dpal={0,1,1, 2,1,13,6,
	          4,4,9,3, 13,1,13,14}
	 
	 -- now we go trough all colors
	 for j=1,15 do
	  --grab the current color
	  col = j
	  
	  --now calculate how many
	  --times we want to fade the
	  --color.
	  --this is a messy formula
	  --and not exact science.
	  --but basically when kmax
	  --reaches 5 every color gets 
	  --turns black.
	  kmax=(p+(j*1.46))/22
	  
	  --now we send the color 
	  --through our table kmax
	  --times to derive the final
	  --color
	  for k=1,kmax do
	   col=dpal[col]
	  end
	  
	  --finally, we change the
	  --palette
	  pal(j,col)
	 end
	end


	--- textbox: https://www.lexaloffle.com/bbs/?tid=38668
	function tb_init(voice,string) -- this function starts and defines a text box.
		reading=true -- sets reading to true when a text box has been called.
		tb={ -- table containing all properties of a text box. i like to work with tables, but you could use global variables if you preffer.
		str=string, -- the strings. remember: this is the table of strings you passed to this function when you called on _update()
		voice=voice, -- the voice. again, this was passed to this function when you called it on _update()
		i=1, -- index used to tell what string from tb.str to read.
		cur=0, -- buffer used to progressively show characters on the text box.
		char=0, -- current character to be drawn on the text box.
		x=0, -- x coordinate
		y=0, -- y coordginate (106 default)
		w=127, -- text box width
		h=21, -- text box height
		col1=0, -- background color
		col2=7, -- border color
		col3=7, -- text color
		}
	end
	
	function tb_update()  -- this function handles the text box on every frame update.
		if tb.char<#tb.str[tb.i] then -- if the message has not been processed until it's last character:
			tb.cur+=0.8 -- increase the buffer. 0.5 is already max speed for this setup. if you want messages to show slower, set this to a lower number. this should not be lower than 0.1 and also should not be higher than 0.9
			if tb.cur>0.9 then -- if the buffer is larger than 0.9:
				tb.char+=1 -- set next character to be drawn.
				tb.cur=0    -- reset the buffer.
				if (ord(tb.str[tb.i],tb.char)!=32) sfx(tb.voice) -- play the voice sound effect.
			end
			if (btnp(5)) tb.char=#tb.str[tb.i] -- advance to the last character, to speed up the message.
		elseif btnp(5) then -- if already on the last message character and button ❎/x is pressed:
			if #tb.str>tb.i then -- if the number of strings to disay is larger than the current index (this means that there's another message to display next):
				tb.i+=1 -- increase the index, to display the next message on tb.str
				tb.cur=0 -- reset the buffer.
				tb.char=0 -- reset the character position.
			else -- if there are no more messages to display:
				reading=false -- set reading to false. this makes sure the text box isn't drawn on screen and can be used to resume normal gameplay.
			end
		end
	end
	
	function tb_draw() -- this function draws the text box.
		if reading then -- only draw the text box if reading is true, that is, if a text box has been called and tb_init() has already happened.
			rectfill(tb.x,tb.y,tb.x+tb.w,tb.y+tb.h,tb.col1) -- draw the background.
			rect(tb.x,tb.y,tb.x+tb.w,tb.y+tb.h,tb.col2) -- draw the border.
			print(sub(tb.str[tb.i],1,tb.char),tb.x+2,tb.y+2,tb.col3) -- draw the text.
		end
	end