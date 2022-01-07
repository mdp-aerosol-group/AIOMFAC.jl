module AIOMFAC

export writeinput, parseoutput

using FileIO
using DataStructures

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
				write(f, "1	    $z,     ")
				map(fractions) do y
					write(f, "$(x*y/sum(fractions)),    ")
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

function parseoutput(file)
	lines = readlines("Outputfiles/"*file) 
	out = mapfoldl(hcat, lines[67:81]) do x
		map(mparse, split(x))
	end
	aw = out[3,:]./100.0
	w = out[4,:]
	Gm = @. 1.0/(1.0 - w)
	k = (@. (1.0/aw - 1.0) * (Gm - 1.0))
	return aw, k 
end

end
