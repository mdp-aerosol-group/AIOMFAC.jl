
include("AIOMFAC.jl")
Tk = (273.0, 293.0, 303.0)

components = [(("H+", 2), ("SO4--", 1)), (("Na+", 2), ("NO3-", 1))]
AIOMFAC.writeinput("input_0010.txt", Tk, components, [0.5, 0.5])
run(`./AIOMFAC Inputfiles/input_0010.txt`)
aw, k = AIOMFAC.parseoutput("AIOMFAC_output_0010.txt")