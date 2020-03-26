%fast marching test via image
%apload image & read it 
%M=imread('A (5).png');
% global Xmin
% global Xmax
% global Ymin
% global Ymax
% global IM
clear all;
Img_rgb=imread('TestSortie.png');
Img_gray=rgb2gray(Img_rgb);
IM=Img_gray;
% imagesc(IM)
% colormap gray
% return;
%return;
%no geometry discretization it already done  
Dist=inf(size(IM));
TAB=zeros(size(IM));
ph=0.01;
Xmin=0;
Xmax=size(IM,2)*ph;
Ymin=0;
Ymax=size(IM,1)*ph;
niter_tab=size(Dist,1)*size(Dist,2);
%initialisation of exit, and obstacles
Pile=[];
for i=1:size(IM,1)
    for j=1:size(IM,2)
        if IM(i,j)==0 %obstacles
            Dist(i,j)=inf;
            TAB(i,j)=1;
            niter_tab=niter_tab-1;
        elseif IM(i,j)==91 %exit
            Dist(i,j)=0;
            TAB(i,j)=-1;
            Pile=[Pile;i,j,0];
        end
        
    end
end
%%%
%%%
MX2=Xmin*ones(round((Ymax-Ymin)/ph),1);
for k=2:round((Xmax-Xmin)/ph)
    MX2=[MX2,MX2(:,k-1)+ph];
end
%imagesc(0:731,0:541,Img_gray)
%imagesc(MX2(1,:),MY2(:,1),Img_gray)
MY2=Ymin*ones(1,round((Xmax-Xmin)/ph));
for k=2:round((Ymax-Ymin)/ph)
    MY2=[MY2;MY2(k-1,:)+ph];
end

% Boucle principale
comp_bucle=0;

while niter_tab>1 && size(Pile,1)>0  %niter_tab>2%(isempty(find(TAB==0))==0)||(isempty(find(TAB==-1))==0)%

    comp_bucle=comp_bucle+1;
    detect_calcul_noeuds_rouge;
    
    Pile=sortrows(Pile,3);% Recherche le noeud rouge avec Dist(i,j) le plus petit, il sera sur la ligne 1 de B qui a été trié
    
        i=Pile(1,1) ;                   % Nouvelle indice de i
        j=Pile(1,2);                    % Nouvelle indice de j
      
        TAB(i,j)=1;                     % le nouveau passe en "noir"
        Pile=Pile(2:end,:);
        %%% Compteur
        if mod(comp_bucle,1000)==1
            fprintf(['\ncomp_rest=',num2str(niter_tab)]);
        end
        niter_tab=niter_tab-1;
end
% Desired directions  (Matrices)
[FX,FY] = gradient(Dist);

 FXN=zeros(size(FX));
 FYN=zeros(size(FY));
 % 
for k=1:size(FX,1)*size(FX,2)
    if isnan(FX(k))==0 && isnan(FY(k))==0
    if (abs(FX(k))~=inf)&&(abs(FY(k))~=inf)
        if((FX(k)~=0)||FY(k)~=0)
        Norme=sqrt(FX(k)^2+FY(k)^2);
        FXN(k)=FX(k)/Norme;
        FYN(k)=FY(k)/Norme;
        end
    end
    
       
    end
end
FXN1=FXN;
FYN1=FYN;
Dist2=Dist;
save Dist2; save FXN1; save FYN1; save MX2; save MY2;
figure(1);
imagesc(Dist)
%quiver(-FXN,-FYN);
axis equal
