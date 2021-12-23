using DataFrames
using CSV

include("Output.jl")

# Data Frame for Citric Acid
df1 = Output.dfvis("AIOMFAC_output_0001.txt")                         # Viscosity Data Frame
df2 = Output.dfcom("AIOMFAC_output_0001.txt", 1)                      # Component Data Frame (H20)
df3 = Output.dfcom("AIOMFAC_output_0001.txt", 2)                      # Component Data Frame (Citric Acid)
