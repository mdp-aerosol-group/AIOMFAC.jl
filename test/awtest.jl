using Cairo
using Fontconfig
using Gadfly
using DataFrames
using Colors
using Printf
using CSV

components = [(("H", 2), ("SO4", 1))]
AIOMFAC.writeinput("input_0001.txt", Tk, components, 1.0)
run(`./AIOMFAC Inputfiles/input_0001.txt`)
aw, k = AIOMFAC.parseoutput("AIOMFAC_output_0001.txt")
df2 = DataFrame(aw=aw, k=k, comp="H2SO4")

components = [(("Na", 2), ("SO4", 1))]
AIOMFAC.writeinput("input_0001.txt", Tk, components, 1.0)
run(`./AIOMFAC Inputfiles/input_0001.txt`)
aw, k = AIOMFAC.parseoutput("AIOMFAC_output_0001.txt")
df3 = DataFrame(aw=aw, k=k, comp="Na2SO4")

components = [(("NH4", 2), ("SO4", 1))]
AIOMFAC.writeinput("input_0001.txt", Tk, components, 1.0)
run(`./AIOMFAC Inputfiles/input_0001.txt`)
aw, k = AIOMFAC.parseoutput("AIOMFAC_output_0001.txt")
df4 = DataFrame(aw=aw, k=k, comp="(NH4)2SO4")

components = [(("NH4", 1), ("HSO4", 1))]
AIOMFAC.writeinput("input_0001.txt", Tk, components, 1.0)
run(`./AIOMFAC Inputfiles/input_0001.txt`)
aw, k = AIOMFAC.parseoutput("AIOMFAC_output_0001.txt")
df5 = DataFrame(aw=aw, k=k, comp="NH4HSO4")

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