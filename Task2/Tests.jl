using Test

include("Output.jl")
include("AIOMFAC.jl")

Tk = (273.0, 293.0, 303.0)
fi = 1.0:-0.2:0.2
components = [(("COOH", 3), ("CH2", 2), ("C", 1), ("OH", 1))]

# To generate output
function program(file)
	AIOMFAC.writeinput(file, Tk, fi, components, 1.0)
	run(`./AIOMFAC Inputfiles/$file`)
	fil = file[7:10]
	fileo = "AIOMFAC_output_$fil.txt"
	return fileo
end

# To compare two files
function test_output(f1, f2)
	println("")
	split(f1, "/") |> x -> println("Testing: "*x[end])
	u = Output.Viscosity(f1, Tk, fi)
	v = Output.Viscosity(f2, Tk, fi)

	@testset "Testing Phase Ouptut" begin
		@test u.T==v.T  
		@test u.RH == v.RH
		@test u.η == v.η    
		@test u.ση == v.ση
		@test u.flag == v.flag
	end

	function component_test(x,y)
		@test x.T == y.T
		@test x.RH == y.RH
		@test x.w == y.w
		@test x.xᵢ == y.xᵢ
		@test x.mᵢ == y.mᵢ
		@test x.γ == y.γ
		@test x.a == y.a
		@test x.flag == y.flag
	end

	x = Output.Components(f1, Tk, fi)
	y = Output.Components(f2, Tk, fi)
	
	@testset "Testing Component Output" begin
		map(component_test, x, y)
	end
end     

# To compare all files generated from the web
comp = ["Citric_Acid.txt", "Formic_Acid.txt", "Acetone.txt", "Ethanol.txt", "Phenol.txt"]
path1 = "../Web Output/Predefined List/"
path2 = "../Web Output/Defined Subgroups/"
map(test_output, path1.*comp, path2.*comp)

# Comparing web output and programmed output
println("")
println("Testing Local Install")
test_output("../Web Output/Predefined List/Citric_Acid.txt", program("input_0008.txt"))