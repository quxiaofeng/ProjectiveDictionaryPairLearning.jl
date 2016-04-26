function updateP!(P::Array{Any,1}, A::Array{Any,1}, DataInvMat::Array{Any,1}, DataMat::Array{Any,1}, τ::Float64)
# Update P by Eq. (10)

    for (i, Aᵢ) in enumerate(A)
        @inbounds tempMat::Matrix{Float64} = Aᵢ * DataMat[i]'
        scale!(tempMat, τ)
        @inbounds P[i] = tempMat * DataInvMat[i]
    end
end