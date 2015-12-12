include(joinpath(dirname(@__FILE__), "initialization.jl"))
include(joinpath(dirname(@__FILE__), "updateP!.jl"))
include(joinpath(dirname(@__FILE__), "updateD!.jl"))
include(joinpath(dirname(@__FILE__), "updateA!.jl"))

function TrainDPL(Data::Matrix{Float64}, Label::Matrix{Int64}, DictSize::Int64, τ::Float64, λ::Float64, γ::Float64, DEMO=false)
    # This is the DPL training function

    # Initialize D and P, compute the inverse matrix used in Eq. (10), update A for one time
    DataMat, D, P, DataInvMat, A = initialization(Data, Label, DictSize, τ, λ, γ, DEMO)

    # Alternatively update P, D and A
    for i = 1:20
        updateP!(P, A, DataInvMat, DataMat, τ)
        updateD!(D, A, DataMat)
        updateA!(A, D, DataMat, P, τ, DictSize)
        if DEMO
            println("Training ... iteration $i finished.")
        end
    end

    EncoderMat = zeros(size(P[1], 1) * size(P, 1), size(P[1], 2))
    # Reorganize the P matrix to make the classification fast
    for i = 1:size(P, 1)
        @inbounds EncoderMat[(i - 1)*DictSize+1 : i*DictSize, :] = P[i]
    end

    D, EncoderMat
end
