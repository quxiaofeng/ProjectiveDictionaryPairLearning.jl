include(joinpath(dirname(@__FILE__), "updateA!.jl")

# return inv(τ*A*A' + λ*B*B' + γ*I)
function getinv(τ, λ, γ, A, B)
    C = A*A'
    D = B*B'
    Dim = size(C, 1)

    for j=1:Dim, i=1:Dim
        if i==j
            @inbounds C[i,j] = τ*C[i,j] + λ*D[i,j] + γ
        else
            @inbounds C[i,j] = τ*C[i,j] + λ*D[i,j]
        end
    end

    inv(C)
end

function initialization(Data, Label, DictSize, τ, λ, γ)
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
    ClassNum = maximum(Label)
    Dim = size(Data, 1)

    DataMat = Array(Any, ClassNum)
    DictMat = Array(Any, ClassNum)
    P = Array(Any, ClassNum)
    DataInvMat = Array(Any, ClassNum)
    CoefMat = Array(Any, ClassNum)

    for i=1:ClassNum
        @inbounds TempData = Data[:, find(Label .== i)]
        @inbounds DataMat[i] = TempData

        srand(i)
        TempRand = randn(Dim, DictSize)
        normalize!(TempRand, 2, 1)
        @inbounds DictMat[i] = TempRand

        srand(2i)
        TempRand = randn(Dim, DictSize)
        normalize!(TempRand, 2, 1)
        @inbounds P[i] = TempRand'

        @inbounds TempDataC = Data[:, find(Label .!=i)]
        @inbounds DataInvMat[i] = getinv(τ, λ, γ, TempData, TempDataC)
    end

    updateA!(CoefMat, DictMat, DataMat, P, τ, DictSize)

    DataMat, DictMat, P, DataInvMat, CoefMat, ClassNum, Dim
end
