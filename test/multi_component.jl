using Test
include("../src/AIOMFAC.jl")

function program(array, Tk, fi)
	i = length(array)
	counter = 1
	files = []
	
	while counter <= i
		file = "input_000$counter.txt"
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

	z = [1]
	i = map(x -> x.name, x) |> sortperm
	append!(z,i)
	pop!(z)
	x = x[z]

	z =[1]
	i = map(y -> y.name, y) |> sortperm
	append!(z,i)
	pop!(z)
	y = y[z]

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
		@test x.mᵢ ≈ y.mᵢ atol = 1e-5
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

comp = ["H2SO4_NaNO3.txt"]
#path1 = "../WebOutput/PredefinedList/"
path2 = "../WebOutput/DefinedSubgroups/"
#map((x,y) -> test_output(x,y,Tk,fi), path1.*comp, path2.*comp)

array = [[(("H+", 2), ("SO4--", 1)), (("Na+", 1), ("NO3-", 1))]]
files = program(array, Tk, fi)


map((x,y) -> test_output(x,y,Tk,fi), path2.*comp, files)

