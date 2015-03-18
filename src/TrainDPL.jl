include("Initialization.jl")
include("UpdateP.jl")
include("UpdateD.jl")
include("UpdateA.jl")


function TrainDPL(Data, Label, DictSize, τ, λ, γ)
    # This is the DPL training function

	# Initialize D and P, compute the inverse matrix used in Eq. (10), update A for one time 
	DataMat, DictMat, P, DataInvMat, CoefMat, ClassNum, Dim = Initialization(Data, Label, DictSize, τ, λ, γ)
    
	# Alternatively update P, D and A
    for i=1:20
        updateP!(P, CoefMat, DataInvMat, DataMat, τ)
        updateD!(DictMat, CoefMat, DataMat)
        updateA!(CoefMat, DictMat, DataMat, P, τ, DictSize)
    end
    
    EncoderMat = zeros(DictSize*ClassNum, Dim)
    
	# Reorganize the P matrix to make the classification fast
    for i=1:ClassNum
        @inbounds EncoderMat[(i-1)*DictSize+1:i*DictSize, :] = P[i]
    end
    
    DictMat, EncoderMat
end
