include("Initialization.jl")
include("UpdateP.jl")
include("UpdateD.jl")
include("UpdateA.jl")

function TrainDPL(Data, Label, DictSize, tau, lambda, gamma)
# This is the DPL training function

# Initialize D and P, compute the inverse matrix used in Eq. (10), update A for one time 
DataMat, DictMat, P_Mat, DataInvMat, CoefMat = Initialization(Data, Label, DictSize, tau, lambda, gamma);

# Alternatively update P, D and A
for i = 1:20
    P_Mat   = UpdateP(CoefMat, DataInvMat, P_Mat, DataMat, tau);
    DictMat = UpdateD(CoefMat, DataMat, DictMat);
    CoefMat = UpdateA(DictMat, DataMat, P_Mat, tau, DictSize); 
end

EncoderMat = zeros(size(P_Mat[1], 1) * size(P_Mat, 1), size(P_Mat[1], 2));
# Reorganize the P matrix to make the classification fast
for i = 1:size(P_Mat, 1)
    EncoderMat[ ((i - 1) * size(P_Mat[1], 1) + 1) : (i * size(P_Mat[1], 1)), :] = P_Mat[i];
end

DictMat, EncoderMat
end