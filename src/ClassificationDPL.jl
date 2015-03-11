function ClassificationDPL(TtData, DictMat, EncoderMat, DictSize)

# Projective representation coefficients estimation
ClassNum    = size(DictMat, 1);
PredictCoef = EncoderMat * TtData;

Error = zeros(ClassNum, size(TtData, 2));
# Class-specific reconstruction error calculation
for i = 1:ClassNum
    Error[i, :]= sum((DictMat[i] * PredictCoef[(i - 1) * DictSize + 1 : i * DictSize, :]- TtData) .^ 2, 1);
end
Distance, PredictInd = findmin(Error, 1);
PredictLabel = [ind2sub(size(Error), PredictInd[i])[1] for i = 1:size(PredictInd, 2)];

PredictLabel, Error
end