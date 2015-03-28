using NumericExtensions

function ClassificationDPL(TtData, DictMat, EncoderMat, DictSize)

    # Projective representation coefficients estimation
    ClassNum    = length(DictMat)
    PredictCoef = EncoderMat * TtData

    Error = zeros(ClassNum, size(TtData, 2));
    # Class-specific reconstruction error calculation
    for i=1:ClassNum
        @inbounds reconstructedTtData = DictMat[i] * PredictCoef[(i-1)*DictSize+1:i*DictSize, :]
        subtract!(reconstructedTtData, TtData)
        @inbounds Error[i,:] = sumsq(reconstructedTtData, 1)
    end
    Distance, PredictInd = findmin(Error, 1)
    PredictLabel = [ind2sub(size(Error), PredictInd[i])[1] for i = 1:size(PredictInd, 2)]

    PredictLabel, Error, Distance
end
