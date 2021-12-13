module Output
using DataFrames
using CSV

export test 

function mparse(x)
	return try 
		parse(Float64, x)
	catch
		0.0
	end
end

function data(file)
    lines = readlines("Outputfiles/"*file)
    Vis = mapfoldl(hcat, lines[42:56]) do x
        map(mparse, split(x))
    end   
    H2O = mapfoldl(hcat, lines[67:81]) do x
        map(mparse, split(x))
    end   
    global Temp = Vis[2,:]
    global RH = Vis[3,:]
    global Viscosity = Vis[4,:]
    global ViscosityUnc = Vis[5,:]
    global Flag = Vis[6,:]
    global Water = H2O[4,:]
    global xi = H2O[5,:]
    global mi = H2O[6,:]
    global a_coeff_x = H2O[7,:]
    global a_x = H2O[8,:]

    return Temp, RH, Viscosity, ViscosityUnc, Flag, Water, xi, mi, a_coeff_x, a_x
end

function compare(a, b)
    x = data(""*a)
    y = data(""*b)
    if x==y
        println("Files Match")
    else
        println("Files Do Not Match")
    end    
end

end