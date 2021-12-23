using Test
include("Output.jl")

# Predefined vs Defined Subgroups

# Citric Acid
c1 = Output.Viscosity("../Web Output/Predefined List/Citric_Acid.txt")
C1 = Output.Components("../Web Output/Predefined List/Citric_Acid.txt")
c2 = Output.Viscosity("../Web Output/Defined Subgroups/Citric_Acid.txt")
C2 = Output.Components("../Web Output/Defined Subgroups/Citric_Acid.txt")

# Phase Test
@test c1.T == c2.T
@test c1.RH == c2.RH
@test c1.η == c2.η
@test c1.ση == c2.ση
@test c1.flag == c2.flag

# Components Test
@test C1[1].T == C2[1].T
@test C1[2].T == C2[2].T
@test C1[1].RH == C2[1].RH
@test C1[2].RH == C2[2].RH
@test C1[1].w == C2[1].w
@test C1[2].w == C2[2].w
@test C1[1].xᵢ == C2[1].xᵢ
@test C1[2].xᵢ == C2[2].xᵢ
@test C1[1].mᵢ == C2[1].mᵢ
@test C1[2].mᵢ == C2[2].mᵢ
@test C1[1].γ == C2[1].γ
@test C1[2].γ == C2[2].γ
@test C1[1].a == C2[1].a
@test C1[2].a == C2[2].a
@test C1[1].flag == C2[1].flag
@test C1[2].flag == C2[2].flag


# Formic Acid
f1 = Output.Viscosity("../Web Output/Predefined List/Formic_Acid.txt")
F1 = Output.Components("../Web Output/Predefined List/Formic_Acid.txt")
f2 = Output.Viscosity("../Web Output/Defined Subgroups/Formic_Acid.txt")
F2 = Output.Components("../Web Output/Defined Subgroups/Formic_Acid.txt")

# Phase Test
@test f1.T == f2.T
@test f1.RH == f2.RH
@test f1.η == f2.η
@test f1.ση == f2.ση
@test f1.flag == f2.flag

# Components Test
@test F1[1].T == F2[1].T
@test F1[2].T == F2[2].T
@test F1[1].RH == F2[1].RH
@test F1[2].RH == F2[2].RH
@test F1[1].w == F2[1].w
@test F1[2].w == F2[2].w
@test F1[1].xᵢ == F2[1].xᵢ
@test F1[2].xᵢ == F2[2].xᵢ
@test F1[1].mᵢ == F2[1].mᵢ
@test F1[2].mᵢ == F2[2].mᵢ
@test F1[1].γ == F2[1].γ
@test F1[2].γ == F2[2].γ
@test F1[1].a == F2[1].a
@test F1[2].a == F2[2].a
@test F1[1].flag == F2[1].flag
@test F1[2].flag == F2[2].flag


# Acetone 
a1 = Output.Viscosity("../Web Output/Predefined List/Acetone.txt")
A1 = Output.Components("../Web Output/Predefined List/Acetone.txt")
a2 = Output.Viscosity("../Web Output/Defined Subgroups/Acetone.txt")
A2 = Output.Components("../Web Output/Defined Subgroups/Acetone.txt")

# Phase Test
@test a1.T == a2.T
@test a1.RH == a2.RH
@test a1.η == a2.η
@test a1.ση == a2.ση
@test a1.flag == a2.flag

# Aomponents Test
@test A1[1].T == A2[1].T
@test A1[2].T == A2[2].T
@test A1[1].RH == A2[1].RH
@test A1[2].RH == A2[2].RH
@test A1[1].w == A2[1].w
@test A1[2].w == A2[2].w
@test A1[1].xᵢ == A2[1].xᵢ
@test A1[2].xᵢ == A2[2].xᵢ
@test A1[1].mᵢ == A2[1].mᵢ
@test A1[2].mᵢ == A2[2].mᵢ
@test A1[1].γ == A2[1].γ
@test A1[2].γ == A2[2].γ
@test A1[1].a == A2[1].a
@test A1[2].a == A2[2].a
@test A1[1].flag == A2[1].flag
@test A1[2].flag == A2[2].flag



# Ethanol 
e1 = Output.Viscosity("../Web Output/Predefined List/Ethanol.txt")
E1 = Output.Components("../Web Output/Predefined List/Ethanol.txt")
e2 = Output.Viscosity("../Web Output/Defined Subgroups/Ethanol.txt")
E2 = Output.Components("../Web Output/Defined Subgroups/Ethanol.txt")

# Phase Test
@test e1.T == e2.T
@test e1.RH == e2.RH
@test e1.η == e2.η
@test e1.ση == e2.ση
@test e1.flag == e2.flag

# Components Test
@test E1[1].T == E2[1].T
@test E1[2].T == E2[2].T
@test E1[1].RH == E2[1].RH
@test E1[2].RH == E2[2].RH
@test E1[1].w == E2[1].w
@test E1[2].w == E2[2].w
@test E1[1].xᵢ == E2[1].xᵢ
@test E1[2].xᵢ == E2[2].xᵢ
@test E1[1].mᵢ == E2[1].mᵢ
@test E1[2].mᵢ == E2[2].mᵢ
@test E1[1].γ == E2[1].γ
@test E1[2].γ == E2[2].γ
@test E1[1].a == E2[1].a
@test E1[2].a == E2[2].a
@test E1[1].flag == E2[1].flag
@test E1[2].flag == E2[2].flag


# Phenol 
p1 = Output.Viscosity("../Web Output/Predefined List/Phenol.txt")
P1 = Output.Components("../Web Output/Predefined List/Phenol.txt")
p2 = Output.Viscosity("../Web Output/Defined Subgroups/Phenol.txt")
P2 = Output.Components("../Web Output/Defined Subgroups/Phenol.txt")

# Phase Test
@test p1.T == p2.T
@test p1.RH == p2.RH
@test p1.η == p2.η
@test p1.ση == p2.ση
@test p1.flag == p2.flag

# Components Test
@test P1[1].T == P2[1].T
@test P1[2].T == P2[2].T
@test P1[1].RH == P2[1].RH
@test P1[2].RH == P2[2].RH
@test P1[1].w == P2[1].w
@test P1[2].w == P2[2].w
@test P1[1].xᵢ == P2[1].xᵢ
@test P1[2].xᵢ == P2[2].xᵢ
@test P1[1].mᵢ == P2[1].mᵢ
@test P1[2].mᵢ == P2[2].mᵢ
@test P1[1].γ == P2[1].γ
@test P1[2].γ == P2[2].γ
@test P1[1].a == P2[1].a
@test P1[2].a == P2[2].a
@test P1[1].flag == P2[1].flag
@test P1[2].flag == P2[2].flag



# Web Output vs Programmed

# Citric Acid
c3 = Output.Viscosity("AIOMFAC_output_0001.txt")
C3 = Output.Components("AIOMFAC_output_0001.txt")

# Phase Test
@test c1.T == c3.T
@test c1.RH == c3.RH
@test c1.η == c3.η
@test c1.ση == c3.ση
@test c1.flag == c3.flag

# Components Test
@test C1[1].T == C3[1].T
@test C1[2].T == C3[2].T
@test C1[1].RH == C3[1].RH
@test C1[2].RH == C3[2].RH
@test C1[1].w == C3[1].w
@test C1[2].w == C3[2].w
@test C1[1].xᵢ == C3[1].xᵢ
@test C1[2].xᵢ == C3[2].xᵢ
@test C1[1].mᵢ == C3[1].mᵢ
@test C1[2].mᵢ == C3[2].mᵢ
@test C1[1].γ == C3[1].γ
@test C1[2].γ == C3[2].γ
@test C1[1].a == C3[1].a
@test C1[2].a == C3[2].a
@test C1[1].flag == C3[1].flag
@test C1[2].flag == C3[2].flag


# Acetone 
a3 = Output.Viscosity("AIOMFAC_output_0002.txt")
A3 = Output.Components("AIOMFAC_output_0002.txt")

# Phase Test
@test a1.T == a3.T
@test a1.RH == a3.RH
@test a1.η == a3.η
@test a1.ση == a3.ση
@test a1.flag == a3.flag

# Aomponents Test
@test A1[1].T == A3[1].T
@test A1[2].T == A3[2].T
@test A1[1].RH == A3[1].RH
@test A1[2].RH == A3[2].RH
@test A1[1].w == A3[1].w
@test A1[2].w == A3[2].w
@test A1[1].xᵢ == A3[1].xᵢ
@test A1[2].xᵢ == A3[2].xᵢ
@test A1[1].mᵢ == A3[1].mᵢ
@test A1[2].mᵢ == A3[2].mᵢ
@test A1[1].γ == A3[1].γ
@test A1[2].γ == A3[2].γ
@test A1[1].a == A3[1].a
@test A1[2].a == A3[2].a
@test A1[1].flag == A3[1].flag
@test A1[2].flag == A3[2].flag


# Ethanol 
e3 = Output.Viscosity("AIOMFAC_output_0003.txt")
E3 = Output.Components("AIOMFAC_output_0003.txt")

# Phase Test
@test e1.T == e3.T
@test e1.RH == e3.RH
@test e1.η == e3.η
@test e1.ση == e3.ση
@test e1.flag == e3.flag

# Components Test
@test E1[1].T == E3[1].T
@test E1[2].T == E3[2].T
@test E1[1].RH == E3[1].RH
@test E1[2].RH == E3[2].RH
@test E1[1].w == E3[1].w
@test E1[2].w == E3[2].w
@test E1[1].xᵢ == E3[1].xᵢ
@test E1[2].xᵢ == E3[2].xᵢ
@test E1[1].mᵢ == E3[1].mᵢ
@test E1[2].mᵢ == E3[2].mᵢ
@test E1[1].γ == E3[1].γ
@test E1[2].γ == E3[2].γ
@test E1[1].a == E3[1].a
@test E1[2].a == E3[2].a
@test E1[1].flag == E3[1].flag
@test E1[2].flag == E3[2].flag


# Phenol 
p3 = Output.Viscosity("AIOMFAC_output_0004.txt")
P3 = Output.Components("AIOMFAC_output_0004.txt")

# Phase Test
@test p1.T == p3.T
@test p1.RH == p3.RH
@test p1.η == p3.η
@test p1.ση == p3.ση
@test p1.flag == p3.flag

# Components Test
@test P1[1].T == P3[1].T
@test P1[2].T == P3[2].T
@test P1[1].RH == P3[1].RH
@test P1[2].RH == P3[2].RH
@test P1[1].w == P3[1].w
@test P1[2].w == P3[2].w
@test P1[1].xᵢ == P3[1].xᵢ
@test P1[2].xᵢ == P3[2].xᵢ
@test P1[1].mᵢ == P3[1].mᵢ
@test P1[2].mᵢ == P3[2].mᵢ
@test P1[1].γ == P3[1].γ
@test P1[2].γ == P3[2].γ
@test P1[1].a == P3[1].a
@test P1[2].a == P3[2].a
@test P1[1].flag == P3[1].flag
@test P1[2].flag == P3[2].flag
