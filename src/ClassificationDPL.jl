function ClassificationDPL(TtData, DictMat, EncoderMat, DictSize)
    
	# Projective representation coefficients estimation
	ClassNum = length(DictMat)
    PredictCoef = EncoderMat*TtData
    
    Error = zeros(ClassNum, size(TtData, 2))
    
	# Class-specific reconstruction error calculation
    for i=1:ClassNum
        @inbounds A = DictMat[i] * PredictCoef[(i-1)*DictSize+1:i*DictSize, :]
        subtract!(A, TtData)
        @inbounds Error[i,:] = sumsq(A,1)
    end
    Distance, PredictInd = findmin(Error, 1)
    PredictLabel = [ind2sub(size(Error), PredictInd[i])[1] for i=1:size(PredictInd, 2)]
    
    PredictLabel, Error
end
