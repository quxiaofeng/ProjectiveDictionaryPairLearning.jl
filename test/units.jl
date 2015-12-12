using ProjectiveDictionaryPairLearning
using MAT, Base.Test

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

# for i = 1:length(DictSize)
#     @test_approx_eq(DictMat[i], TestDictMat[i])
# end
# @test_approx_eq(EncoderMat, TestEncoderMat)

testMat = [i+j for i in 1.0:5, j in 1.0:5]
resultMat = [
 0.21081851067789195 0.25819888974716115 0.29019050004400465 0.31311214554257477 0.3302891295379082
 0.31622776601683794 0.34426518632954817 0.36273812505500586 0.3757345746510897 0.3853373177942262
 0.4216370213557839 0.43033148291193524 0.435285750066007 0.4383570037596047 0.4403855060505443
 0.5270462766947299 0.5163977794943223 0.5078333750770082 0.5009794328681196 0.4954336943068623
 0.6324555320336759 0.6024640760767093 0.5803810000880093 0.5636018619766345 0.5504818825631803
]
@test_approx_eq(resultMat, normcol_lessequal(testMat))

accuracy = dpldemo();
@test accuracy > 0.95

println("Finished unit tests!")
