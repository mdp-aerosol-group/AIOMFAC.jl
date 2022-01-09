Tk = (273.0, 293.0, 303.0)
fi = 1.0:-0.2:0.2
include("Output.jl")

# Data Frame for Citric Acid
df1 = Output.dfvis("AIOMFAC_output_0001.txt", Tk, fi)                         # Viscosity Data Frame
df2 = Output.dfcom("AIOMFAC_output_0001.txt", Tk, fi, 1)                      # Component Data Frame (H20)
df3 = Output.dfcom("AIOMFAC_output_0001.txt", Tk, fi, 2)                      # Component Data Frame (Citric Acid)


# Data Frame for Multi Component System
dfm0 = Output.dfvis("AIOMFAC_output_0010.txt", Tk, fi)
dfm1 = Output.dfcom("AIOMFAC_output_0010.txt", Tk, fi, 1)
dfm2 = Output.dfcom("AIOMFAC_output_0010.txt", Tk, fi, 2)
dfm3 = Output.dfcom("AIOMFAC_output_0010.txt", Tk, fi, 3)
dfm4 = Output.dfcom("AIOMFAC_output_0010.txt", Tk, fi, 4)
dfm5 = Output.dfcom("AIOMFAC_output_0010.txt", Tk, fi, 5)
dfm6 = Output.dfcom("AIOMFAC_output_0010.txt", Tk, fi, 6)
