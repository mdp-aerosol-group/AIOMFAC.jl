module Output

using DataFrames
using CSV

struct properties
    T
    RH
    η
    ση
    flag
end

struct component
    name
    subgroups 
    subgroups_tex
    T
    RH
    w
    xᵢ
    mᵢ
    γ
    a
    flag   
end 

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
    
    Temp = Vis[2,:]
    RH = Vis[3,:]
    Viscosity = Vis[4,:]
    ViscosityUnc = Vis[5,:]
    Flag = Vis[6,:]
    phase = properties(Temp, RH, Viscosity, ViscosityUnc, Flag)
    Water = H2O[4,:]
    xi = H2O[5,:]
    mi = H2O[6,:]
    a_coeff_x = H2O[7,:]
    a_x = H2O[8,:]

    return phase
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