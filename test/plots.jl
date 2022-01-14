using Plots
using Printf

gr(ylim = (3, 13), yticks = 3:2:13, grid = false, xlabel = "Temperature[K]", ylabel = "log₁₀η[Pa.s]", legend = :best)
include("../src/AIOMFAC.jl")

function plot_data(array, Tk,  fi)
    i = length(array)
    j = Tuple(1:i)
	list = map(x -> @sprintf("%04i", x), j)
	counter = 1

	while counter <= i
        k = list[counter]
		file = "input_$k.txt"
		components = array[counter]
		AIOMFAC.writeinput(file, Tk, fi, components, fractions)
		run(`../src/AIOMFAC Inputfiles/$file`)
		fil = file[7:10]
		fileo = "AIOMFAC_output_$fil.txt"
        
        lab = ll[counter]
	    u,v = AIOMFAC.load_data(fileo, Tk, fi)
        xx = length(findall(x-> x >= 3, u.η))
        yy = length(findall(x-> x >= 13, u.η))
        zz = length(findall(x-> x >= 7, u.η))
        tr = Tk[zz]
        o = [tr, tr]
        p = [3, 13]
        plot(   Tk,u.η, 
                labels = "$lab",
                xlim = (Tk[1+yy], Tk[xx]), 
                width = 2, 
                color = "black"
            )
        plot!(  o,p, 
                labels = "log₁₀η ≈ 7 Pa.s @ Tk = $tr K",
                color = "red",
                width = 1.2, 
                linestyle = :dash
            )    
        z = fileo[1:19]
        savefig("$z.png")

		counter+=1
	end

end
   

Tk = 200:1:400
fi = 1.0
fractions = 1.0

Citric_Acid         = [(("COOH", 3), ("CH2", 2), ("C[alc]", 1), ("OH", 1))]
Sucrose             = [(("C", 1), ("CHO[ether]", 3), ("CH[alc]", 5), ("OH", 8), ("CH2[alc]", 3))]
Ketoglutaric_Acid   = [(("COOH", 2), ("CH2CO", 1), ("CH2", 2))] 
Tartaric_Acid       = [(("COOH", 2), ("CH[alc]", 2), ("OH", 2))] 
cis_Pinonic_Acid    = [(("COOH", 1), ("CH3CO", 1), ("C", 1), ("CH", 2), ("CH2", 2), ("CH3", 2))] 
Benzoic_Acid        = [(("ACH", 5), ("AC", 1), ("COOH", 1))]
Syringaldehyde      = [(("ACH", 2), ("AC", 3), ("ACOH", 1), ("CHO[aldehyde]", 1), ("CH3O", 2))]
Cholestrol          = [(("C", 2), ("CH3", 5), ("CH2", 11), ("CH", 6), ("ACH", 1), ("AC", 1), ("OH", 1), ("CH[alc]", 1))]
Stearic_Acid        = [(("CH3", 1), ("CH2", 16), ("COOH", 1))]
Pyrene              = [(("ACH", 10), ("AC", 6))]
            
mixture = [Citric_Acid, Sucrose, Ketoglutaric_Acid, Tartaric_Acid, cis_Pinonic_Acid, Benzoic_Acid, Syringaldehyde, Cholestrol, Stearic_Acid, Pyrene]
ll = ["Citric Acid", "Sucrose", "Ketoglutaric Acid", "Tartaric Acid", "cis-Pinonic Acid", "Benzoic Acid", "Syringaldehyde", "Cholestrol", "Stearic Acid", "Pyrene"]

plot_data(mixture, Tk, fi)
