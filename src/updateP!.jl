function updateP!(P::Array{Any,1}, A::Array{Any,1}, DataInvMat::Array{Any,1}, DataMat::Array{Any,1}, τ::Float64)
# Update P by Eq. (10)

    for i=1:length(P)
        @inbounds tempMat = A[i] * DataMat[i]'
        scale!(tempMat, τ)
        @inbounds P[i] = tempMat * DataInvMat[i]
    end
end