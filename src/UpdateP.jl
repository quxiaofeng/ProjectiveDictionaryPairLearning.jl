function UpdateP(Coef, DataInvMat, P_Mat, DataMat, tau)
# Update P by Eq. (10)

P_Mat = Any[];
ClassNum = length(Coef);
for i = 1:ClassNum
     push!(P_Mat, (tau * Coef[i] * DataMat[i]') * DataInvMat[i]);
end

P_Mat
end

