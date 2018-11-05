function [elements, vertices] = computeMesh(Kx, Ky)
    hx = 1 / Kx;
    hy = 1 / Ky;
    numElements = 2 * Kx * Ky;
    numVertices = (1+Kx) * (1+Ky);
    elements = zeros(3, numElements); % each column contains the indices to the vertices to the corresponding triangle
    vertices = zeros(2, numVertices); % each column contains the coordinates to each vertice.
    elementIndex = 1;
    for j = 1:Ky
        for i = 1:Kx
            % create vertices indices
            v0 = (j-1) * (Kx+1) + i;
            v1 = v0 + 1;
            v2 = v0 + Kx + 1;
            v3 = v2 + 1;
            % create two new elements K_i
            elements(:,elementIndex) = [v0; v3; v2]; 
            elements(:,elementIndex + 1) = [v0; v1; v3];
            elementIndex = elementIndex + 2;
            % create vertices
            x0 = (i-1) * hx;
            y0 = (j-1) * hy;
            vertices(:,v0) = [x0; y0];
            vertices(:,v1) = [x0 + hx; y0];
            vertices(:,v2) = [x0; y0 + hy];
            vertices(:,v3) = [x0 + hx; y0 + hy];
        end
    end
end