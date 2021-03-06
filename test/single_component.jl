using Test

include("../src/AIOMFAC.jl")

# To generate output
function program(array, Tk, fi)
	i = length(array)
    j = Tuple(1:i)
	list = map(x -> @sprintf("%04i", x), j)
	files = []
	counter = 1

	while counter <= i
        k = list[counter]
		file = "input_$k.txt"
		components = array[counter]
		AIOMFAC.writeinput(file, Tk, fi, components, fractions)
		run(`../src/AIOMFAC Inputfiles/$file`)
		fil = file[7:10]
		fileo = "AIOMFAC_output_$fil.txt"
	    push!(files, fileo)
		counter+=1
	end
	
	return files
end

# To compare two files
function test_output(f1, f2, Tk, fi)
	println("")
	split(f1, "/") |> x -> println("Testing: "*x[end])
	u,x = AIOMFAC.load_data(f1, Tk, fi)
	v,y = AIOMFAC.load_data(f2, Tk, fi)

	@testset "Testing Phase Ouptut" begin
		@test u.T ≈ v.T  
		@test u.RH ≈ v.RH
		@test u.η ≈ v.η    
		@test u.ση ≈ v.ση atol = 1e-5
		@test u.flag ≈ v.flag
	end

	function component_test(x,y)
		@test x.T ≈ y.T
		@test x.RH ≈ y.RH
		@test x.w ≈ y.w
		@test x.xᵢ ≈ y.xᵢ
		@test x.mᵢ ≈ y.mᵢ
		@test x.γ ≈ y.γ
		@test x.a ≈ y.a
		@test x.flag ≈ y.flag
	end

	@testset "Testing Component Output" begin
		map(component_test, x, y)
	end
end     

Tk = (273.0, 293.0, 303.0)
fi = 1.0:-0.2:0.2
fractions = 1.0

Citric_Acid = [(("COOH", 3), ("CH2", 2), ("C[alc]", 1), ("OH", 1))]
Acetone = [(("CH3", 1), ("CH3CO", 1))]
Ethanol = [(("CH3[alc-tail]", 1), ("CH2[OH]", 1), ("OH", 1))]
Phenol = [(("ACH", 5), ("ACOH", 1))]
array = [Citric_Acid, Acetone, Ethanol, Phenol]

# To compare all files generated from the web
comp = ["Citric_Acid.txt", "Acetone.txt", "Ethanol.txt", "Phenol.txt"]
path1 = "../WebOutput/PredefinedList/"
path2 = "../WebOutput/DefinedSubgroups/"
map((x,y) -> test_output(x,y,Tk,fi), path1.*comp, path2.*comp)

# Comparing web output and programmed output
println("")
println("Testing Local Install")
files = program(array,Tk,fi)
map((x,y) -> test_output(x,y,Tk,fi), path1.*comp, files)

:DONE
