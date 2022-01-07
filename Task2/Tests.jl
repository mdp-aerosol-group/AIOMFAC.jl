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
    a = (""*f1)
    b = (""*f2)
    u = Output.Viscosity(a, Tk, fi)
    v = Output.Viscosity(b, Tk, fi)
    x = Output.Components(a, Tk, fi)
    y = Output.Components(b, Tk, fi)
    @test u.T==v.T  
    @test u.RH == v.RH
    @test u.η == v.η    
    @test u.ση == v.ση
    @test u.flag == v.flag

    ind = length(x)

    count = 1
    while count <= ind
        @test x[count].T == y[count].T
        @test x[count].RH == y[count].RH
        @test x[count].w == y[count].w
        @test x[count].xᵢ == y[count].xᵢ
        @test x[count].mᵢ == y[count].mᵢ
        @test x[count].γ == y[count].γ
        @test x[count].a == y[count].a
        @test x[count].flag == y[count].flag
        count += 1    
    end        
end     

# To compare all files generated from the web
comp = ["Citric_Acid.txt", "Formic_Acid.txt", "Acetone.txt", "Ethanol.txt", "Phenol.txt"]

function test_all(comp)
    path1 = "../Web Output/Predefined List/"
    path2 = "../Web Output/Defined Subgroups/"

    ind = length(comp)
    count = 1
    while count <= ind
        a = path1*comp[count]
        b = path2*comp[count]
        test_output(a,b)
        count += 1
    end    
end

# Comparing all files from web
test_all(comp)

# Comparing two files individually
test_output("../Web Output/Predefined List/Citric_Acid.txt", "../Web Output/Defined Subgroups/Citric_Acid.txt")

# Comparing web output and programmed output
test_output("../Web Output/Predefined List/Citric_Acid.txt", program("input_0008.txt"))

# Phase and component data
phase, compo = Output.load_data("AIOMFAC_output_0010.txt", Tk, fi)

# Dataframe for phase and component
dfm0 = Output.dfvis("AIOMFAC_output_0010.txt", Tk, fi)
dfm1 = Output.dfcom("AIOMFAC_output_0010.txt", Tk, fi, 2)
