# solve the proximal problem
# matout = argmin||matout-matin||_F^2, s.t. matout(:,i)<=1
function normcol_lessequal(matin::Matrix{Float64})
    broadcast(/, matin, max(1.0, sqrt(sum(abs2(matin), 1))))
end
