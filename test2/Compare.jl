using DataFrames
using CSV
include("Output.jl")

# Comparing Web Output for Predefined and Defined Groups
c1 = Output.compare("../Web Output/Predefined List/Citric_Acid.txt", "../Web Output/Defined Subgroups/Citric_Acid.txt")
c2 = Output.compare("../Web Output/Predefined List/Acetone.txt", "../Web Output/Defined Subgroups/Acetone.txt")
c3 = Output.compare("../Web Output/Predefined List/Ethanol.txt", "../Web Output/Defined Subgroups/Ethanol.txt")
c4 = Output.compare("../Web Output/Predefined List/Phenol.txt", "../Web Output/Defined Subgroups/Phenol.txt")

# Comparing Programmed Output with the Web Output and Extracting into DataFrame
C1 = Output.compare("AIOMFAC_output_0001.txt", "../Web Output/Defined Subgroups/Citric_Acid.txt")
Citric1 = DataFrame(Temperature_K = Output.Temp, RH = Output.RH, Viscosity = Output.Viscosity, Viscosity_Unc = Output.ViscosityUnc, Flag = Output.Flag)
Citric2 = DataFrame(Temperature_K = Output.Temp, RH = Output.RH, Water = Output.Water, xi = Output.xi, mi = Output.mi, a_coeff_x = Output.a_coeff_x, a_x = Output.a_x, Flag = Output.Flag)

C2 = Output.compare("AIOMFAC_output_0002.txt", "../Web Output/Defined Subgroups/Acetone.txt")
Acetone1 = DataFrame(Temperature_K = Output.Temp, RH = Output.RH, Viscosity = Output.Viscosity, Viscosity_Unc = Output.ViscosityUnc, Flag = Output.Flag)
Acetone2 = DataFrame(Temperature_K = Output.Temp, RH = Output.RH, Water = Output.Water, xi = Output.xi, mi = Output.mi, a_coeff_x = Output.a_coeff_x, a_x = Output.a_x, Flag = Output.Flag)

C3 = Output.compare("AIOMFAC_output_0003.txt", "../Web Output/Defined Subgroups/Ethanol.txt")
Ethanol1 = DataFrame(Temperature_K = Output.Temp, RH = Output.RH, Viscosity = Output.Viscosity, Viscosity_Unc = Output.ViscosityUnc, Flag = Output.Flag)
Ethanol2 = DataFrame(Temperature_K = Output.Temp, RH = Output.RH, Water = Output.Water, xi = Output.xi, mi = Output.mi, a_coeff_x = Output.a_coeff_x, a_x = Output.a_x, Flag = Output.Flag)

C4 = Output.compare("AIOMFAC_output_0004.txt", "../Web Output/Defined Subgroups/Phenol.txt")
Phenol1 = DataFrame(Temperature_K = Output.Temp, RH = Output.RH, Viscosity = Output.Viscosity, Viscosity_Unc = Output.ViscosityUnc, Flag = Output.Flag)
Phenol2 = DataFrame(Temperature_K = Output.Temp, RH = Output.RH, Water = Output.Water, xi = Output.xi, mi = Output.mi, a_coeff_x = Output.a_coeff_x, a_x = Output.a_x, Flag = Output.Flag)

# Data Values
#a1 = Output.data("AIOMFAC_output_0002.txt")
#Ace1 = DataFrame(Temperature_K = Output.Temp, RH = Output.RH, Viscosity = Output.Viscosity, Viscosity_Unc = Output.ViscosityUnc, Flag = Output.Flag)
#Ace2 = DataFrame(Temperature_K = Output.Temp, RH = Output.RH, Water = Output.Water, xi = Output.xi, mi = Output.mi, a_coeff_x = Output.a_coeff_x, a_x = Output.a_x, Flag = Output.Flag)
#a2 = Output.data("../Web Output/Defined Subgroups/Acetone.txt")
#ace1 = DataFrame(Temperature_K = Output.Temp, RH = Output.RH, Viscosity = Output.Viscosity, Viscosity_Unc = Output.ViscosityUnc, Flag = Output.Flag)
#ace2 = DataFrame(Temperature_K = Output.Temp, RH = Output.RH, Water = Output.Water, xi = Output.xi, mi = Output.mi, a_coeff_x = Output.a_coeff_x, a_x = Output.a_x, Flag = Output.Flag)

#Ace1 == ace1
#Ace2 == ace2

#x = CSV.open("a1.csv", "w")
#CSV.write(x, Ace1)
#CSV.close(x)

#y = CSV.open("a2.csv", "w")
#CSV.write(y, ace1)
#CSV.close(y)

#x == y
