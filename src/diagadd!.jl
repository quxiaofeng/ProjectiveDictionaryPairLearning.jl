function diagadd!(A::Matrix{Float64}, c::Float64)
    # A <- A + c*I
    Dim = minimum(size(A))
    for i=1:Dim
        @inbounds A[i,i] += c
    end
end