# =========================================================================
#   Shuhang Gu, Lei Zhang, Wangmeng Zuo and Xiangchu Feng,
#   "Projective Dictionary Pair Learning for Pattern Classification," In NIPS 2014.
#
#
#       Written by Shuhang Gu @ COMP HK-PolyU
#       Email: shuhanggu@gmail.com
#       Oct, 2014.
#
#       Transplanted to Julia by Xiaofeng Qu @ COMP HK-PolyU
#       Email: xiaofeng.qu.hk@ieee.org
#       Site: http://www.quxiaofeng.me
#       March, 2015.
#
#
# =========================================================================


# =========================================================================
#
#  Demo:
#
#    Pkg.add("ProjectiveDictionaryPairLearning")
#    using ProjectiveDictionaryPairLearning
#    dpldemo()
#
#
# =========================================================================

module ProjectiveDictionaryPairLearning

using MAT # to load and save data

include("TrainDPL.jl")
include("ClassificationDPL.jl")
include("normcol_equal.jl")

export dpldemo, TrainDPL, ClassificationDPL, updateA!, updateD!, updateP!, initialization, normcol_lessequal, normcol_equal

function dpldemo()
    # Load training and testing data
    matFileName = "YaleB_Jiang.mat"
    data = matread(joinpath(dirname(@__FILE__), matFileName))
    TrData, TrLabel = data["TrData"], data["TrLabel"]
    TtData, TtLabel = data["TtData"], data["TtLabel"]

    # Column normalization
    TrData = normcol_equal(TrData)
    TtData = normcol_equal(TtData)

    TrLabel = round(Int64, TrLabel)
    TtLabel = round(Int64, TtLabel)

    # Parameter setting
    DictSize = 30
    τ = 0.05
    λ = 0.003
    γ = 0.0001

    # DPL training
    DEMO = true
    tic()
    DictMat, EncoderMat = TrainDPL(TrData, TrLabel, DictSize, τ, λ, γ, DEMO)
    TrTime = toq()

    # DPL testing
    tic()
    PredictLabel, Error = ClassificationDPL(TtData, DictMat, EncoderMat, DictSize)
    TtTime = toq()

    # Show accuracy and time
    Accuracy = sum(TtLabel'.==PredictLabel)/size(TtLabel,2)
    @printf("\nThe running time for DPL training is : %.02f s ", TrTime)
    @printf("\nThe running time for DPL testing is : %.02f s ", TtTime)
    @printf("\nRecognition rate for DPL is : %.03f%% \n", Accuracy * 100.0)

    Accuracy
    end
end
