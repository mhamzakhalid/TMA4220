% maps from reference with inverse as "false", to reference with inverse as
% "true".
function [xMapped, jacobian] = getAffineMapping(v0, v1, v2, xNonMapped, inverse)
    if inverse
        jacInverse = getAffineMappingJacobianInverse(v0, v1, v2);
        jacobian = jacInverse;
        xMapped = jacInverse*(xNonMapped-v0);
    else
        jac = getAffineMappingJacobian(v0,v1,v2);
        jacobian = jac;
        xMapped = v0 + jac * xNonMapped;
    end
end

function jac = getAffineMappingJacobian(v0, v1, v2)
    jac = [v1(1) - v0(1), v2(1) - v0(1);...
           v1(2) - v0(2), v2(2) - v0(2)];
end

function jacInv = getAffineMappingJacobianInverse(v0, v1, v2)
    jac = getAffineMappingJacobian(v0, v1, v2);
    jacInv = [jac(2,2), -jac(1,2); -jac(2,1), jac(1,1)] / ...
        (jac(1,1) * jac(2,2) - jac(1,2) * jac(2,1)); 
end