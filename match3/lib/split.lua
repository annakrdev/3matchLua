return function ( str, del )
 
    local t = {}
 
    repeat
        local b, e = str:find( del, 1, true )
 
        if b ~= nil then
            t[ #t + 1 ] = str:sub( 1, b - 1 )
            str = str:sub( e + 1 )
        end 
    until b == nil 
 
    t[ #t + 1 ] = str
 
    return t
end