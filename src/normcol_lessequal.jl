function normcol_lessequal(matin)
# solve the proximal problem 
# matout = argmin||matout-matin||_F^2, s.t. matout(:,i)<=1
matin ./ repmat(max(1, sqrt(sum(matin .^ 2, 1) + eps())), size(matin, 1), 1);
end