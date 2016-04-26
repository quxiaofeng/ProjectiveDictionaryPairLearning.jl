include("normcol_lessequal.jl")
include("diagadd!.jl")

function add_sub!(aMat::Matrix{Float64}, bMat::Matrix{Float64}, cMat::Matrix{Float64})
   # aMat <- aMat + bMat - cMat
    Dim = size(aMat)
    for j=1:Dim[2], i=1:Dim[1]
        @inbounds aMat[i,j] += bMat[i,j] - cMat[i,j]
    end
end

function updateD!(D::Array{Any,1}, A::Array{Any,1}, DataMat::Array{Any,1})
   # Update D by Eq. (12)
    for (i, Aᵢ) in enumerate(A)
        @inbounds TempData::Matrix{Float64} = DataMat[i]
        ρ::Float64 = 1.
        rate_ρ::Float64 = 1.2
        @inbounds TempS::Matrix{Float64} = D[i]
        TempT::Matrix{Float64} = zeros(TempS)
        @inbounds preD::Matrix{Float64} = D[i]
        Iter::Int = 1
        lossᴰ::Float64 = 1.
        while lossᴰ > 1e-8 && Iter < 100

            tempMat::Matrix{Float64} = TempData*Aᵢ'
            tempMat += (TempS-TempT) .* ρ # tempMat <- tempMat + ρ(TempS - TempT)
            tempMatCoef::Matrix{Float64} = Aᵢ*Aᵢ'
            diagadd!(tempMatCoef, ρ)
            TempD::Matrix{Float64} = tempMat/tempMatCoef

            TempS = normcol_lessequal(TempD+TempT)
            add_sub!(TempT, TempD, TempS) # TemP <- TemP + (TempD-TempS)
            ρ *= rate_ρ
            lossᴰ = mean(abs2(preD-TempD))
            preD = TempD
            Iter += 1
        end
        @inbounds D[i] = preD
    end
end
