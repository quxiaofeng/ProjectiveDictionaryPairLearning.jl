using ProjectiveDictionaryPairLearning
using MAT, NumericExtensions, Base.Test

###### Testing TrainDPL
# load DictMat, EncoderMat, TrData, TrLabel, DictSize, tau, lambda, gamma
# prepared using
    # matwrite("testDataForTrainDpl.mat", @compat Dict(
    #     "DictMat" => DictMat,
    #     "EncoderMat" => EncoderMat,
    #     "TrData" => TrData,
    #     "TrLabel" => TrLabel,
    #     "DictSize" => DictSize,
    #     "tau" => tau,
    #     "lambda" => lambda,
    #     "gamma" => gamma,
    # ))
matFileName = "testDataForTrainDpl.mat"
data = matread(joinpath(dirname(@__FILE__), matFileName))
DictMat, EncoderMat, TrData, TrLabel = data["DictMat"], data["EncoderMat"], data["TrData"], data["TrLabel"]
DictSize, tau, lambda, gamma = data["DictSize"], data["tau"], data["lambda"], data["gamma"]

DEMO=true
TestDictMat, TestEncoderMat = TrainDPL(TrData, TrLabel, DictSize, tau, lambda, gamma, DEMO)

for i = 1:length(DictSize)
    @test_approx_eq(DictMat[i], TestDictMat[i])
end
@test_approx_eq(EncoderMat, TestEncoderMat)

println("Finished unit tests!")
