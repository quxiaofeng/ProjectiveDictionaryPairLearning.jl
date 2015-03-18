using NumericExtensions

include("Initialization.jl")
include("UpdateP!.jl")
include("UpdateD!.jl")
include("UpdateA!.jl")

function TrainDPL(Data, Label, DictSize, τ, λ, γ)
    # This is the DPL training function

    # Initialize D and P, compute the inverse matrix used in Eq. (10), update A for one time
    DataMat, D, P, DataInvMat, A = Initialization(Data, Label, DictSize, τ, λ, γ)

    # Alternatively update P, D and A
    for i = 1:20
        UpdateP!(P, A, DataInvMat, DataMat, τ)
        UpdateD!(D, A, DataMat)
        UpdateA!(A, D, DataMat, P, τ, DictSize)
    end

    EncoderMat = zeros(size(P[1], 1) * size(P, 1), size(P[1], 2))
    # Reorganize the P matrix to make the classification fast
    for i = 1:size(P, 1)
        @inbounds EncoderMat[(i - 1)*DictSize+1 : i*DictSize, :] = P[i]
    end

    D, EncoderMat
end