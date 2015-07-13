import ProjectiveDictionaryPairLearning
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
println("matFileName: $matFileName.")

tic()
data = matread(joinpath(dirname(@__FILE__), matFileName))
DictMat, EncoderMat, TrData, TrLabel = data["DictMat"], data["EncoderMat"], data["TrData"], data["TrLabel"]
DictSize, tau, lambda, gamma = data["DictSize"], data["tau"], data["lambda"], data["gamma"]
println("Data loaded in $(toq()) s")

tic()
DEMO = true
TestDictMat, TestEncoderMat = TrainDPL(TrData, TrLabel, DictSize, tau, lambda, gamma, DEMO)
println("TrainDPL passed in $(toq()) s")

for i = 1:length(DictSize)
    @test_approx_eq(DictMat[i], TestDictMat[i])
end
@test_approx_eq(EncoderMat, TestEncoderMat)

testMat = [i+j for i in 1.0:5, j in 1.0:5]
resultMat = [
  0.210819  0.258199  0.290191  0.313112  0.330289
  0.316228  0.344265  0.362738  0.375735  0.385337
  0.421637  0.430331  0.435286  0.438357  0.440386
  0.527046  0.516398  0.507833  0.500979  0.495434
  0.632456  0.602464  0.580381  0.563602  0.550482
]
@test_approx_eq(resultMat, normcol_lessequal(testMat))

accuracy = dpldemo();
@test accuracy > 0.95

println("Finished unit tests!")
