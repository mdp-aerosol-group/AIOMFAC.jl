module AIOMFAC

export writeinput, parseoutput

using FileIO
using DataStructures
using DataFrames
using Printf

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

const header = """
Input file for AIOMFAC-web model

mixture components:
----
component no.:	01
component name:	'Water'
subgroup no., qty:	016, 01
----
"""

const units = """++++
mixture composition and temperature:
mass fraction?	1
mole fraction?  0	
----
"""

const group = OrderedDict([
						   ("CH3", 1),
						   ("CH2", 2),
						   ("CH", 3),
						   ("C", 4),
						   ("CH2=CH", 5),
						   ("CH=CH", 6),
						   ("CH2=C", 7),
						   ("CH=C", 8),
						   ("C=C", 70),
						   ("ACH", 9),
						   ("AC", 10),
						   ("OH", 153),
						   ("ACOH", 17),
						   ("CH3CO", 18),
						   ("CH2CO", 19),
						   ("CHO[aldehyde]", 20),
						   ("CH3COO", 21),
						   ("CH2COO", 22),
						   ("CH3O", 24),
						   ("CH2O", 25),
						   ("CHO[ether]", 26),
						   ("THF[CH20]", 27),
						   ("COOH", 137),
						   ("HCOOH", 43),
						   ("CH3[alc]", 141),
						   ("CH2[alc]", 142),
						   ("CH[alc]", 143),
						   ("C[alc]", 144),
						   ("CH3[alc-tail]", 145),
						   ("CH2[alc-tail]", 146),
						   ("CH[alc-tail]", 147),
						   ("C[alc-tail]", 148),
						   ("CH3[OH]", 149),
						   ("CH2[OH]", 150),
						   ("CH[OH]", 151),
						   ("C[OH]", 152),
						   ("CH2OCH2[oxyethylene]", 154),
						   ("CH2ONO2", 155),
						   ("CHONO2", 156),
						   ("CONO2", 157),
						   ("CH2OOH[perox]", 158),
						   ("CHOOH[perox]", 159),
						   ("COOH[perox]", 160),
						   ("C(=O)OOH[perox]", 161),
						   ("CH3OOCH3[perox]", 162),
						   ("CH3OOCH2[perox]", 163),
						   ("CH3OOCH[perox]", 164),
						   ("CH3OOC[perox]", 165),
						   ("CH2OOCH2[perox]", 166),
						   ("CH2OOCH[perox]", 167),
						   ("CH2OOC[perox]", 168),
						   ("CHOOCH[perox]", 169),
						   ("CHOOC[perox]", 170),
						   ("COOC[perox]", 171),
						   ("C(=O)OONO2[perox]", 172),
						   ("CO2[aq]", 173),
						   ("H+", 205),
						   ("Li+", 201),
						   ("Na+", 202), 
						   ("K+", 203),
						   ("NH4+", 204), 
						   ("Mg++", 223),
						   ("Ca++", 221),
						   ("Cl-", 242),
						   ("Br-", 243),
						   ("I-", 244), 
						   ("NO3-", 245), 
						   ("IO3-", 246),
						   ("OH-", 247),
						   ("HSO4-", 248),
						   ("CH3SO3-", 249),
						   ("HCO3-", 250),
						   ("HMalo-", 251),
						   ("HGlut-", 252), 
						   ("SO4--", 261),
						   ("CO3--", 262),
						   ("Malo--", 263),
						   ("Glut--", 264)
						  ])


function writeinput(file, Tk, fi, components, fractions)
	open("Inputfiles/"*file, "w") do f
		write(f, header)
		map(1:length(components)) do i
			compound = components[i]
			write(f, "component no.:	$(i+1)\n")
			write(f, "component name:	'organic component'\n")
			map(compound) do x
				no = group[x[1]]
				write(f, "subgroup no., qty: $(no), $(x[2])\n")
			end
			write(f, "----\n")
		end
		write(f, units)
		write(f, "point, Tk, cp0, ...\n")
		for z in Tk
			map(fi) do x
				write(f, "1	    $z")
				map(fractions) do y
					s = @sprintf(",%0.1e", x*y/sum(fractions))
					write(f, s)
				end
				write(f,"\n")
			end	
		end
		write(f, "====")
	end

end

function mparse(x)
	return try 
		parse(Float64, x)
	catch
		0.0
	end
end

function load_data(file, Tk, fi; c = 0)
	lines = readlines("Outputfiles/"*file)
	lx = deepcopy(lines)

	tem = length(Tk)
	fm = length(fi)
	total = tem*fm
	start =  42
	last = start+total-1-c

	Vis = mapfoldl(hcat, lines[start:last]) do x
		map(mparse, split(x))
	end   

	Temp = Vis[2,:]
	RH = Vis[3,:]
	Viscosity = Vis[4,:]
	ViscosityUnc = Vis[5,:]
	Flag = Vis[6,:]
	phase = properties(Temp, RH, Viscosity, ViscosityUnc, Flag) 

	# parse components
	readlines("Outputfiles/"*file)
	
	tem = length(Tk)
	fm = length(fi)
	total = tem*fm
	start =  42
	last = start+total-1-c

	n = map(x -> @sprintf("%02i", x), Tuple(1:24))
	sch = "Mixture's component # : "
	srh = "Mixture's species, #  : "

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

	inde = 1
	for i in srh
		a = n[inde]
		z = srh * a
		inde += 1
		for find in lines
			if z == find
				count += 1
			end    
		end
	end

	counter = 1
	starti = last+11
	lasti = starti+total-1-c
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
		lasti = starti+total-1-c
		counter += 1
		push!(components, comp)
	end

	return phase, components
end    


function dfvis(file, Tk, fi)
	x = Viscosity(""*file, Tk, fi)
	y = DataFrame(
				  Temperature_K = x.T, 
				  RH = x.RH, 
				  Viscosity = x.η, 
				  Viscosity_Unc = x.ση, 
				  Flag = x.flag
				  )
	
	return y
end

function dfcom(file, Tk, fi, component)
	x = Components(""*file, Tk, fi)
	y = DataFrame(
				  Temperature_K = x[component].T, 
				  RH = x[component].RH, 
				  Water = x[component].w, 
				  xi = x[component].xᵢ, 
				  mi = x[component].mᵢ, 
				  a_coeff_x = x[component].γ, 
				  a_x = x[component].a, 
				  Flag = x[component].flag
				  )
	
	return y
end

end
