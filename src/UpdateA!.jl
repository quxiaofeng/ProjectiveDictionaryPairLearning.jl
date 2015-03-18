include("diagadd!.jl")

function updateA!(A, D, DataMat, P, τ, DictSize)
    # Update tempDictCoef by Eq. (8)

    for i=1:length(A)
        @inbounds TempDict = D[i]
        @inbounds TempData = DataMat[i]
        tempDictCoef       = TempDict' * TempDict
        tempDictDataCoef   = TempDict' * TempData
        @inbounds C        = P[i] * TempData
        diagadd!(tempDictCoef, τ)
        fma!(tempDictDataCoef, C, τ)
        @inbounds A[i]     = tempDictCoef \ tempDictDataCoef
    end
end