function UpdateA(DictMat, DataMat, P_Mat, tau, DictSize)
# Update A by Eq. (8)

ClassNum = length(DataMat);
I_Mat    = eye(DictSize);
CoefMat  = Any[];
for i = 1:ClassNum
    TempDict = DictMat[i];
    TempData = DataMat[i];
    push!(CoefMat, (TempDict' * TempDict + tau * I_Mat) \ (TempDict' * TempData + tau * P_Mat[i] * TempData));
end

CoefMat
end