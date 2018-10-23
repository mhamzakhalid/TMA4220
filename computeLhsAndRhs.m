function [lhs, rhs] = computeLhsAndRhs(elements, vertices)
    numVertices = size(vertices,2);
    numElements = size(elements,2);
    A = zeros(numVertices,numVertices);
    K = zeros(numVertices,numVertices);
    rhs = zeros(numVertices,1);
    miniStiffMatrix = [2 -1 -1; -1 1 0; 1 0 1];
    miniMassMatrix = computeMiniMassMatrix();
    for v = 1:numElements
        v0 = vertices(:, elements(1,v));
        v1 = vertices(:, elements(2,v));
        v2 = vertices(:, elements(3,v));
        [~, jacobian] = getAffineMapping(v0, v1, v2, [0;0], true);
        %Stiffness matrix:
        K(elements(:,v),elements(:,v)) = K(elements(:,v),elements(:,v)) ...
            + 1/(2*det(jacobian)) * miniStiffMatrix;
        %Mass matrix:
        A(elements(:,v),elements(:,v)) = A(elements(:,v),elements(:,v)) ...
            + det(jacobian) * miniMassMatrix;
        %Right hand side:
        rhs(elements(:,v),1) = rhs(elements(:,v),1) + ...
            estimateRhs(v0,v1,v2);
    end
    lhs = (A + K);
end