function updateP!(P, CoefMat, DataInvMat, DataMat, τ)
	# Update P by Eq. (10)
    for i=1:length(P)
        @inbounds A = CoefMat[i]*DataMat[i]'
        scale!(A, τ)
        @inbounds P[i] = A*DataInvMat[i]
    end
end

