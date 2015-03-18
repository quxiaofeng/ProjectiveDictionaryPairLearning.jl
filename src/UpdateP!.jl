function updateP!(P, A, DataInvMat, DataMat, τ)
# Update P by Eq. (10)

    for i=1:length(P)
        @inbounds tempMat = A[i] * DataMat[i]'
        scale!(tempMat, τ)
        @inbounds P[i] = tempMat * DataInvMat[i]
    end
end