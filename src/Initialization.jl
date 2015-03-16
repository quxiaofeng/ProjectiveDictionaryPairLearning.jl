include("UpdateA.jl")

function Initialization(Data, Label, DictSize, tau, lambda, gamma)
# In this initialization function, we do the following things:
# 1. Random initialization of dictionary pair D and P for each class
# 2. Compute the class-specific inverse matrix used in Eq. (10)
# 3. Compute matrix class-specific code matrix A by Eq. (8)
#    with the random initialized D and P
#
# The randn seeds are set to make sure the results in our paper are
# reproducible. The randn seed setting can be removed, our algorithm is
# not sensitive to the initialization of D and P. In most cases, different
# initialization will lead to the same recognition accuracy on a wide range
# of testing databases.

ClassNum   = maximum(Label);
Dim        = size(Data, 1);
I_Mat      = eye(Dim, Dim);

DataMat    = Any[];
DictMat    = Any[];
P_Mat      = Any[];
DataInvMat = Any[];

for i = 1:ClassNum
    TempData      = Data[:, find(Label .== i)];
    push!(DataMat, TempData);
    srand(int(i));
    push!(DictMat, normcol_equal(randn(Dim, DictSize)));
    srand(int(2 * i));
    push!(P_Mat, normcol_equal(randn(Dim, DictSize))');

    TempDataC     = Data[:, find(Label .!= i)];
    push!(DataInvMat, inv(tau * TempData * TempData' + lambda * TempDataC * TempDataC' + gamma * I_Mat));
end

CoefMat = UpdateA(DictMat, DataMat, P_Mat, tau, DictSize);

DataMat, DictMat, P_Mat, DataInvMat, CoefMat
end