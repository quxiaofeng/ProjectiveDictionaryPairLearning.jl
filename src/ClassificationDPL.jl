function ClassificationDPL(TtData::Matrix{Float64}, DictMat::Array{Any,1}, EncoderMat::Matrix{Float64}, DictSize::Int64)

    # Projective representation coefficients estimation
    ClassNum::Int64              = length(DictMat)
    PredictCoef::Matrix{Float64} = EncoderMat * TtData

    Error::Matrix{Float64} = zeros(ClassNum, size(TtData, 2));
    # Class-specific reconstruction error calculation
    for i=1:ClassNum
        @inbounds reconstructedTtData::Matrix{Float64} = DictMat[i] * PredictCoef[(i-1)*DictSize+1:i*DictSize, :]
        reconstructedTtData -= TtData
        @inbounds Error[i,:] = sum(abs2(reconstructedTtData), 1)
    end
    Distance::Matrix{Float64}, PredictInd::Matrix{Int64} = findmin(Error, 1)
    PredictLabel = [ind2sub(size(Error), PredictInd[i])[1] for i = 1:size(PredictInd, 2)]

    PredictLabel, Error
end
