D1=Dist;
%D1(find(D1~=inf))=5;

[N,M]=gradient(D1);
H=sqrt(N.^2+M.^2);
figure
imagesc(H)

z=find(H>1.50);


H(z)=1000;
figure;
imagesc(H)