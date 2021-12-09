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
	("CH2CH", 5),
	("CHCH", 6),
	("CH2C", 7),
	("CHC", 8),
	("CC", 70),
	("ACH", 9),
	("AC", 10),
	("OH", 153),
	("ACOH", 17),
	("CH3CO", 18),
	("CH2CO", 19),
	("CHO[ALDEHYDE]", 20),
	("CH3COO", 21),
	("CH2COO", 22),
	("CH3O", 24),
	("CH2O", 25),
	("CHO[ETHER]", 26),
	("THF[CH20]", 27),
	("COOH", 137),
	("HCOOH", 43),
	("CH3[ALC]", 141),
	("CH2[ALC]", 142),
	("CH[ALC]", 143),
	("C[ALC]", 144),
	("CH3[ALC-TAIL]", 145),
	("CH2[ALC-TAIL]", 146),
	("CH[ALC-TAIL]", 147),
	("C[ALC-TAIL", 148),
	("CH3OH", 149),
	("CH2OH", 150),
	("CHOH", 151),
	("COH", 152),
	("CHOCH2[OXYETHYLENE]", 154),
	("CH2ONO2", 155),
	("CHONO2", 156),
	("CONO2", 157),
	("CH2OOH[PEROX]", 158),
	("CHOOH[PEROX]", 159),
	("COOH[PEROX]", 160),
	("C(=O)OOH[PEROX]", 161),
	("CH3OOCH3[PEROX]", 162),
	("CH3OOCH2[PEROX]", 163),
	("CH3OOCH[PEROX]", 164),
	("CH3OOC[PEROX]", 165),
	("CH2OOCH2[PEROX]", 166),
	("CH2OOCH[PEROX]", 167),
	("CH2OOC[PEROX]", 168),
	("CHOOCH[PEROX]", 169),
	("CHOOC[PEROX]", 170),
	("COOC[PPEROX]", 171),
	("C(=O)OONO2[PEROX]", 172),
	("CO2[AQ]", 173),
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

function writeinput(file, Tk, components, fractions)
	fi = 0.001:0.01:0.9 
	open("Inputfiles/"*file, "w") do f
		write(f, header)
		map(1:length(components)) do i
			compound = components[i]
			write(f, "component no.:	$(i+1)\n")
			write(f, "component name:	'inorganic component'\n")
			map(compound) do x
				no = group[x[1]]
				write(f, "subgroup no., qty: $(no), $(x[2])\n")
			end
			write(f, "----\n")
		end
		write(f, units)
		write(f, "point, Tk, cp0, ...\n")
		map(fi) do x
			write(f, "1	    $(Tk),     ")
			map(fractions) do y
				write(f, "$(x*y/sum(fractions)),    ")
			end
			write(f,"\n")
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
	out = mapfoldl(hcat, lines[141:228]) do x
		map(mparse, split(x))
	end
	aw = out[3,:]./100.0
	w = out[4,:]
	Gm = @. 1.0/(1.0 - w)
	k = (@. (1.0/aw - 1.0) * (Gm - 1.0))
	return aw, k 
end

end
