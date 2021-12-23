using DataFrames
using CSV

include("Output.jl")

# Data Frame for Citric Acid
df1 = Output.dfvis("AIOMFAC_output_0001.txt")                         # Viscosity Data Frame
df2 = Output.dfcom("AIOMFAC_output_0001.txt", 1)                      # Component Data Frame (H20)
df3 = Output.dfcom("AIOMFAC_output_0001.txt", 2)                      # Component Data Frame (Citric Acid)


# Data Frame for Multi Component System
dfm0 = Output.dfvis("AIOMFAC_output_0010.txt")
dfm1 = Output.dfcom("AIOMFAC_output_0010.txt", 1)
dfm2 = Output.dfcom("AIOMFAC_output_0010.txt", 2)
dfm3 = Output.dfcom("AIOMFAC_output_0010.txt", 3)
dfm4 = Output.dfcom("AIOMFAC_output_0010.txt", 4)
dfm5 = Output.dfcom("AIOMFAC_output_0010.txt", 5)
dfm6 = Output.dfcom("AIOMFAC_output_0010.txt", 6)
