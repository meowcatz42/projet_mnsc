
A=Dist;
A(find(A==inf))=12;
s=surf(MX2,MY2,A)
%colorbar
shading interp 
%imagesc(Dist)
light               % create a light
lighting gouraud    % preferred method for lighting curved surfaces
material dull    % set material to be dull, no specular highlights