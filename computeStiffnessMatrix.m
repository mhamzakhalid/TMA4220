function stiffMatrix = computeStiffnessMatrix(v1, v2, v3)
    min = [2 -1 -1; -1 1 0; 1 0 1];
    [~, jacInverse] = getAffineMapping(v1, v2, v3, v3, true);
    [~, jac] = getAffineMapping(v1, v2, v3, v3, false);
    Phi = [-ones(2,1),eye(2)];
    stiffMatrix = zeros(3,3);
    for i = 1:3
        for j = 1:3
            stiffMatrix(i,j) = dot(jacInverse'*Phi(:,i), ...
                jacInverse'*Phi(:,j)) * det(jac)/2;
        end
    end
    
end