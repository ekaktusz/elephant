part={}

function addpart(_x,_y,_dx,_dy,_g,_type,_maxage,_col,_oldcol)
    local _p={}
    _p.x=_x --x coord
    _p.y=_y -- y coord
    _p.tpe=_type -- no use yet
    _p.mage=_maxage --max age of part
    _p.age=0 --current age of part
    _p.col=_col --first color
    _p.oldcol=_oldcol --fading out color
    _p.dx=_dx --starting dx
    _p.dy=_dy --starting dy
    _p.g=_g --gravity
    add(part,_p)
end

function spawnpukk(_x,_y,_sx,_sy,_col,_oldcol)
    local _ox = sin(_ang)*_sx
    local _oy = cos(_ang)*_sy
    local _dx = rnd(2.5)-1.25
    local _dy = -rnd(2)
    local _i = 30
    local _g = 0.2
    local _mage = 6+rnd(5)
    if (rnd(100)<=_i) then
        addpart(_x+_ox,_y+_oy,_dx,_dy,_g,0,_mage,_col,_oldcol)
    end
end


function spawntrail(_x,_y,_sx,_sy,_col,_oldcol)
    for i=1,2,1 do
    local _ang = rnd()
    local _ox = sin(_ang)*_sx
    local _oy = cos(_ang)*_sy
    
    addpart(_x+_ox,_y+_oy,0,0,0,0,5+rnd(5),_col,_oldcol)
    end
end

function updateparts()
    local _p
    for i=#part,1,-1 do
        _p=part[i]
        _p.dy+=_p.g
        _p.y+=_p.dy
        _p.x+=_p.dx
        _p.age+=1
        if _p.age>_p.mage then
            del(part,part[i])
        else
            if (_p.age/_p.mage)>0.5 then
                _p.col=_p.oldcol
            end
        end
    end
end

function drawparts()
    for i=1,#part do
        _p=part[i]
        if _p.tpe==0 then
            pset(_p.x,_p.y,_p.col)
        end
    end
end