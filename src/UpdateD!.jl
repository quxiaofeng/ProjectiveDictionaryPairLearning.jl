include("normcol_lessequal.jl")
include("diagadd!.jl")

function add_sub!(aMat, bMat, cMat)
   # aMat <- aMat + bMat - cMat
    Dim = size(aMat)
    for j=1:Dim[2], i=1:Dim[1]
        @inbounds aMat[i,j] += bMat[i,j] - cMat[i,j]
    end
end

function updateD!(D, A, DataMat)
   # Update D by Eq. (12)
    for i=1:length(D)
        @inbounds TempCoef = A[i]
        @inbounds TempData = DataMat[i]
        ρ = 1.
        rate_ρ = 1.2
        @inbounds TempS = D[i]
        TempT = zeros(TempS)
        @inbounds preD = D[i]
        Iter = 1
        ERROR = 1.
        while ERROR > 1e-8 && Iter < 100

            tempMat = TempData*TempCoef'
            fma!(tempMat, TempS-TempT, ρ) # tempMat <- tempMat + ρ(TempS - TempT)
            tempMatCoef = TempCoef*TempCoef'
            diagadd!(tempMatCoef, ρ)
            TempD = tempMat/tempMatCoef

            TempS = normcol_lessequal(TempD+TempT)
            add_sub!(TempT, TempD, TempS) # TemP <- TemP + (TempD-TempS)
            ρ *= rate_ρ
            ERROR = meansq(preD-TempD)
            preD = TempD
            Iter += 1
        end
        @inbounds D[i] = preD
    end
end