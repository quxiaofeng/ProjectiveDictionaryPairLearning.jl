include("normcol_lessequal.jl")
include("diagadd.jl")

function add_sub!(A, B, C)
	# A <- A + B - C
    Dim = size(A)
    for j=1:Dim[2], i=1:Dim[1]
        @inbounds A[i,j] += B[i,j] - C[i,j]
    end
end


function updateD!(DictMat, CoefMat, DataMat)
	# Update D by Eq. (12)
    for i=1:length(DictMat)
        @inbounds TempCoef = CoefMat[i]
        @inbounds TempData = DataMat[i]
        ρ = 1.
        rate_ρ = 1.2
        @inbounds TempS = DictMat[i]
        TempT = zeros(TempS)
        @inbounds preD = DictMat[i]
        Iter = 1
        ERROR = 1.
        while ERROR > 1e-8 && Iter < 100
		
            A = TempData*TempCoef'
            fma!(A, TempS-TempT, ρ) # A <- A + ρ(TempS - TempT)
            B = TempCoef*TempCoef'
            diagadd!(B, ρ)
            TempD = A/B
			
            TempS = normcol_lessequal(TempD+TempT)
            add_sub!(TempT, TempD, TempS) # TemP <- TemP + (TempD-TempS)
            ρ *= rate_ρ
            ERROR = meansq(preD-TempD)
            preD = TempD
            Iter += 1
        end
        @inbounds DictMat[i] = preD
    end
end
