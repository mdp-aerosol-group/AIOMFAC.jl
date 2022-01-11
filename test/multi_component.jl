using Test
include("../src/AIOMFAC.jl")

function program(file, Tk, fi)
	AIOMFAC.writeinput(file, Tk, fi, components, fractions)
	run(`../src/AIOMFAC Inputfiles/$file`)
	fil = file[7:10]
	fileo = "AIOMFAC_output_$fil.txt"
	return fileo
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
fractions = [0.5, 0.5]

components = [(("H+", 2), ("SO4--", 1)), (("Na+", 1), ("NO3-", 1))]

f1 = program("input_0005.txt", Tk, fi)

test_output(f1, "../WebOutput/DefinedSubgroups/H2SO4_NaNO3.txt", Tk, fi)
