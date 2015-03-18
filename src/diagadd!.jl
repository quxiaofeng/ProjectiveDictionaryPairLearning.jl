function diagadd!(A, c)
    # A <- A + c*I
    Dim = minimum(size(A))
    for i=1:Dim
        @inbounds A[i,i] += c
    end
end