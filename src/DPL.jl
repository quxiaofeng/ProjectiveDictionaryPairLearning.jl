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
# =========================================================================

# =========================================================================
#  Usage:
#
#       dpldemo();
#
#
#
#
#
#
#
#
# =========================================================================

module DPL

using MAT # to load and save data
using NumericExtensions

include("TrainDPL.jl")
include("ClassificationDPL.jl")

export dpldemo, TrainDPL, ClassificationDPL

function dpldemo()
    # Load training and testing data
    data = matread("YaleB_Jiang.mat");
    TrData, TrLabel = data["TrData"], data["TrLabel"]
    TtData, TtLabel = data["TtData"], data["TtLabel"]
    # Column normalization
    normalize!(TrData, 2, 1)
    normalize!(TtData, 2, 1)

    TrLabel = int(TrLabel)
    TtLabel = int(TtLabel)

    # Parameter setting
    DictSize = 30
    τ = 0.05
    λ = 0.003
    γ = 0.0001

    # DPL trainig
    tic()
    DictMat, EncoderMat = TrainDPL(TrData, TrLabel, DictSize, τ, λ, γ)
    TrTime = toq()

    # DPL testing
    tic()
    PredictLabel, Error = ClassificationDPL(TtData, DictMat, EncoderMat, DictSize)
    TtTime = toq()

    # Show accuracy and time
    Accuracy = sum(TtLabel'.==PredictLabel)/size(TtLabel,2)
    @printf("\nThe running time for DPL training is : %.02f s ", TrTime)
    @printf("\nThe running time for DPL testing is : %.02f s ", TtTime)
    @printf("\nRecognition rate for DPL is : %.03f%% \n", Accuracy)
end

end