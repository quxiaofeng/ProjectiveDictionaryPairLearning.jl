include("diagadd!.jl")

function updateA!(A::Array{Any,1}, D::Array{Any,1}, DataMat::Array{Any,1}, P::Array{Any,1}, τ::Float64, DictSize::Int64)
    # Update tempDictCoef by Eq. (8)

    for i=1:length(A)
        @inbounds TempDict::Matrix{Float64} = D[i]
        @inbounds TempData::Matrix{Float64} = DataMat[i]
        tempDictCoef::Matrix{Float64}       = TempDict' * TempDict
        tempDictDataCoef::Matrix{Float64}   = TempDict' * TempData
        @inbounds C::Matrix{Float64}        = P[i] * TempData
        diagadd!(tempDictCoef, τ)
        fma!(tempDictDataCoef, C, τ)
        @inbounds A[i]                      = tempDictCoef \ tempDictDataCoef
    end
end