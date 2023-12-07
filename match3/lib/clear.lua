return function ()
    if not os.execute("clear") and not os.execute("cls") then
        for i = 1,100 do
            print("\n")
        end
    end
end