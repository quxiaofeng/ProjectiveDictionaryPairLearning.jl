using ProjectiveDictionaryPairLearning
using MAT, Base.Test

###### Accelerating the normalization with testing
exampleMat = [1.0 2 3; 4 5 6; 7 8 9; 3 4 5]

normcol_equal(matin) = matin ./ repmat(sqrt(sum(matin .^ 2, 1) + eps()), size(matin, 1), 1)

tic()
exampleResult = normcol_equal(exampleMat)
normcol_equalTime = toq()

# tic()
# normalize!(exampleMat, 2 ,1)
# normalizeTime = toq()

# @test_approx_eq(exampleMat, exampleResult)
# @test normalizeTime < normcol_equalTime

# println("normcol_equalTime : $normcol_equalTime s")
# println("normalizeTime     : $normalizeTime s")

###### Accelerating the Class-specific reconstruction error calculation
# load TtData, DictMat, EncoderMat, DictSize
# prepared using
    # matwrite("class-specific.mat", @compat Dict(
    #     "TtData" => TtData,
    #     "DictMat" => DictMat,
    #     "EncoderMat" => EncoderMat,
    #     "DictSize" => DictSize
    # ))
matFileName = "class-specific.mat"
data = matread(joinpath(dirname(@__FILE__), matFileName))
TtData, DictMat, EncoderMat, DictSize = data["TtData"], data["DictMat"], data["EncoderMat"], data["DictSize"]

# prepare
ClassNum    = length(DictMat)
PredictCoef = EncoderMat * TtData

ErrorMATLAB = zeros(ClassNum, size(TtData, 2))
ErrorSubtract = zeros(ClassNum, size(TtData, 2))

tic()
# Class-specific reconstruction error calculation
for i = 1:ClassNum
    ErrorMATLAB[i, :]= sum((DictMat[i] * PredictCoef[(i - 1) * DictSize + 1 : i * DictSize, :]- TtData) .^ 2, 1)
end
ErrorMATLABTime = toq()

tic()
# Class-specific reconstruction error calculation
for i=1:ClassNum
    @inbounds tempMat = DictMat[i] * PredictCoef[(i-1)*DictSize+1:i*DictSize, :]
    tempMat -= TtData
    @inbounds ErrorSubtract[i,:] = sum(abs2(tempMat), 1)
end
ErrorSubtractTime = toq()

@test_approx_eq(ErrorMATLAB, ErrorSubtract)
@test ErrorSubtractTime < ErrorMATLABTime


println("Finished performance tests!")
