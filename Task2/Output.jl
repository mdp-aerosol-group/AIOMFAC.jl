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


function Viscosity(file)
    lines = readlines("Outputfiles/"*file)
    fi = 1.0:-0.2:0.2
    Tk = (273.0, 293.0, 303.0)
    tem = length(Tk)
    fm = length(fi)
    total = tem*fm
    start =  42
    last = start+total-1
    
    Vis = mapfoldl(hcat, lines[start:last]) do x
        map(mparse, split(x))
    end   
    
    Temp = Vis[2,:]
    RH = Vis[3,:]
    Viscosity = Vis[4,:]
    ViscosityUnc = Vis[5,:]
    Flag = Vis[6,:]
    phase = properties(Temp, RH, Viscosity, ViscosityUnc, Flag) 
    return phase
end

function Components(file)
    lines = readlines("Outputfiles/"*file)
    fi = 1.0:-0.2:0.2
    Tk = (273.0, 293.0, 303.0)
    tem = length(Tk)
    fm = length(fi)
    total = tem*fm
    start =  42
    last = start+total-1

    n = ("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24")
    sch = "Mixture's component # : "

    ind = 1
    count = 0 

    for i in sch
        a = n[ind]
        z = sch * a
        ind += 1
        for find in lines
            if z == find
                count += 1
            end    
        end
    end

    counter = 1
    starti = last+11
    lasti = starti+total-1
    components = []

    while counter <= count
        nam = lines[starti-6]
        name = nam[26:end-1]
    
        sub = lines[starti-5]
        subgroups = sub[26:end-1]

        tex = lines[starti-4]
        subgroups_tex = tex[26:end-1]
    
        Com = mapfoldl(hcat, lines[starti:lasti]) do x
            map(mparse, split(x))
        end

        T = Com[2,:]
        RH = Com[3,:]
        w = Com[4,:]
        xᵢ = Com[5,:]
        mᵢ = Com[6,:]
        γ = Com[7,:]
        a = Com[8,:]
        flag = Com[9,:]

        comp = component(name, subgroups, subgroups_tex, T, RH, w, xᵢ, mᵢ, γ, a, flag) 
        starti = lasti + 11
        lasti = starti+total-1
        counter += 1
        push!(components, comp)
    end
    return components
end    

function dfvis(file)
    x = Viscosity(""*file)
    y = DataFrame(Temperature_K = x.T, RH = x.RH, Viscosity = x.η, Viscosity_Unc = x.ση, Flag = x.flag)
    return y
end

function dfcom(file, component)
    x = Components(""*file)
    y = DataFrame(Temperature_K = x[component].T, RH = x[component].RH, Water = x[component].w, xi = x[component].xᵢ, mi = x[component].mᵢ, a_coeff_x = x[component].γ, a_x = x[component].a, Flag = x[component].flag)
    return y
end

end