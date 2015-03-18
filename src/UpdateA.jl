include("diagadd.jl")

function updateA!(CoefMat, DictMat, DataMat, P, τ, DictSize)
	# Update A by Eq. (8)
    for i=1:length(CoefMat)
        @inbounds TempDict = DictMat[i]
        @inbounds TempData = DataMat[i]
        A = TempDict'*TempDict
        B = TempDict'*TempData
        @inbounds C = P[i]*TempData
        diagadd!(A, τ)
        fma!(B, C, τ)
        @inbounds CoefMat[i] = A\B
    end
end
