
Tk = (273.0, 293.0, 303.0)
tem = length(Tk)
fi = 1.0:-0.2:0.2
fm = length(fi)
total = tem*fm
start =  42
last = start+total-1


lines = readlines("Outputfiles/AIOMFAC_output_0001.txt")

tests = readlines("Inputfiles/input_0001.txt")
n = ("01", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15")
sch = "component no.:	"

ind = 1
count = 0   

for i in sch
    a = n[ind]
    z = sch * a
    global ind += 1
    for find in tests
        if z == find
            global count += 1
        end    
    end
end



function mparse(x)
	return try 
		parse(Float64, x)
	catch
		0.0
	end
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
    global starti = lasti + 11
    global lasti = starti+total-1
    global counter += 1
    push!(components, comp)
end

components[1].xᵢ
components[2].xᵢ

