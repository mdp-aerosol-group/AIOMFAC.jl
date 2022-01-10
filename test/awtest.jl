using Cairo
using Fontconfig
using Gadfly
using DataFrames
using Colors
using Printf
using CSV

fi = 1.0:-0.2:0.2
Tk = (273.0, 293.0, 303.0)

include("../src/AIOMFAC.jl")

components = [(("COOH", 3), ("CH2", 2), ("C", 1), ("OH", 1))]
AIOMFAC.writeinput("input_0001.txt", Tk, fi, components, 1.0)	
run(`./AIOMFAC Inputfiles/input_0001.txt`)
aw, k = AIOMFAC.parseoutput("AIOMFAC_output_0001.txt")
df2 = DataFrame(aw=aw, k=k, comp="Citric Acid")

components = [(("CH3", 1), ("CH3CO", 1))]
AIOMFAC.writeinput("input_0002.txt", Tk, fi, components, 1.0)
run(`./AIOMFAC Inputfiles/input_0002.txt`)
aw, k = AIOMFAC.parseoutput("AIOMFAC_output_0002.txt")
df3 = DataFrame(aw=aw, k=k, comp="Acetone")

components = [(("CH3[alc-tail]", 1), ("CH2[OH]", 1), ("OH", 1))]
AIOMFAC.writeinput("input_0003.txt", Tk, fi, components, 1.0)
run(`./AIOMFAC Inputfiles/input_0003.txt`)
aw, k = AIOMFAC.parseoutput("AIOMFAC_output_0003.txt")
df4 = DataFrame(aw=aw, k=k, comp="Ethanol")

components = [(("ACH", 5), ("ACOH", 1))]
AIOMFAC.writeinput("input_0004.txt", Tk, fi, components, 1.0)
run(`./AIOMFAC Inputfiles/input_0004.txt`)
aw, k = AIOMFAC.parseoutput("AIOMFAC_output_0004.txt")
df5 = DataFrame(aw=aw, k=k, comp="Phenol")

df = [df2;df3;df4;df5]
colors = ["black", "darkred", "steelblue3", "darkgoldenrod", "grey", "seagreen"]
ylabels = [0, 0.5, 1]
p = plot(
	layer(df, x=:aw, y=:k, color=:comp, Geom.line),
	Guide.xlabel("Water activity (-)"),
	Guide.ylabel("κₘ"),
	Guide.colorkey(title="Composition"),
	Guide.xticks(ticks=0.5:0.1:1.0),
	Guide.yticks(ticks=0.0:0.1:1.2),
    Scale.y_continuous(labels=y -> y in ylabels ? @sprintf("%.1f", y) : ""),
	Scale.color_discrete_manual(colors...),
	Theme(plot_padding=[0pt, 11pt, 1pt, 0pt]),
	Coord.cartesian(xmin=0.5, xmax=1, ymin=0.0, ymax=1.2)
)
