return function (time)
    local t0 = os.clock()
    while os.clock() - t0 <= time do end
end