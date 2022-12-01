function ecollide_with_objects(object_set, what_to_do)
    local etx = e.tx
    local ety = e.ty
	for o in all(object_set) do
		if (o.tx>=etx and o.tx<=etx+1) and (o.ty>=ety and o.ty<=ety+1) then
			what_to_do(o)
			return
		end
	end
end

function pcollide_with_objects(object_set, what_to_do)
    local ptx = p.tx
    local pty = p.ty
	for o in all(object_set) do
		if o.tx==ptx and o.ty==pty then
			what_to_do(o)
			return
		end
	end
end

function ecollide_with_object(object, what_to_do)
    local etx = e.tx
    local ety = e.ty
    log("etx: ")
    if (object.tx>=etx and object.tx<=etx+1) and (object.ty>=ety and object.ty<=ety+1) then
        what_to_do(object)
    end
end

function pcollide_with_object(object, what_to_do)
    local ptx = p.tx
    local pty = p.ty
    if object.tx==ptx and object.ty==pty then
        what_to_do(object)
    end
end

function draw_objects(object_set)
    for o in all(object_set) do
        draw_object(o)
    end
end

function draw_object(object)
    local _w = object.w or 2
    local _h = object.h or 2
    spr(object.sprt,(object.tx-1)*16,(object.ty-1)*16,_w,_h)
end