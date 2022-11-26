part={}

function addpart(_x,_y,_type,_maxage,_col,_oldcol)
    local _p={}
    _p.x=_x
    _p.y=_y
    _p.tpe=_type
    _p.mage=_maxage
    _p.age=0
    _p.col=_col
    _p.oldcol=_oldcol
    add(part,_p)
end


function spawntrail(_x,_y,_sx,_sy,_col,_oldcol)
    local _ang = rnd()
    local _ox = sin(_ang)*_sx
    local _oy = cos(_ang)*_sy
    addpart(_x+_ox,_y+_oy,0,5+rnd(5),_col,_oldcol)
end

function updateparts()
    local _p
    for i=#part,1,-1 do
        _p=part[i]
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
            pset(_p.x,_p.y,6)
        end
    end
end