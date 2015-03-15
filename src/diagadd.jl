# A <- A + c*I
function diagadd!(A, c)
    Dim = minimum(size(A))
    for i=1:Dim
        @inbounds A[i,i] += c
    end
end
