
  Nb_objets = 0;
  Nb_contact=0;
  %Nb_obstacles_Rectangle = 0;
  %Nb_obstacles_Cercle = 0;
  %Nb_obstacles_Barre =0;
  tau=0.5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
  K_T_obj =0;
  K_T_obs =0;
  K_N_obj=5;
  K_N_obs=5;
  K_Z_obj=0;
  K_Z_obs=0;
  k=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  T =20;
  h =1e-3;
  N_iter = T/h;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
 eps=0.1;
 %Ajouter_Obstacle_Rectangle (5.5,3,0.5,0.5);
 %Ajouter_Obstacle_Rectangle (1.45,1.45,eps,1.55);   
 %Ajouter_Obstacle_Rectangle (-0.2,4,4.4,eps); 
 %Ajouter_Obstacle_Rectangle (1,0,8,6.5);
 %Ajouter_Obstacle_Barre (1,0,9,0);
 %Ajouter_Obstacle_Barre (1,0,1,7);
 %Ajouter_Obstacle_Barre (1,7,9,7);
 %Ajouter_Obstacle_Barre (9,0,9,2.5);
 %Ajouter_Obstacle_Barre (9,4,9,7);
 %Ajouter_Obstacle_Barre (4.5,0,4.5,2.5);
 %Ajouter_Obstacle_Barre (6,0,6,2.5);
 %Ajouter_Obstacle_Barre (6,4,6,6.5);
%Ajouter_Obstacle_Barre(7,1,7,2.5);
%Ajouter_Obstacle_Barre(7,3.5,7,5);
%    IM=imread('A (5).png');     
%  Xmin=1;
%  Xmax=size(IM,1);
%  Ymin=1;
%  Ymax=size(IM,2);
%Sortie=[Xmax,2.5,Xmax,4];
 pas=4;
       aj=-pas;
      %k=0;
      %rr=0.4*pas;
 %for j=4:rr:4.8
           %aj=aj+pas;
 % for i=4:rr:5
        %se=randi(13);     
    %if j<=3
        %Ajouter_Objet (i,j,0,pas/8,100,2.34,0.26,0,1,0.1,se)
   %else
        %Ajouter_Objet (i,j,0,pas/8,500,0,0.5,0,2,0.1,se)
    %end
  %end
 %end
 %G=[];
 %G=find(IM==181);
 
%  for i=1:Xmax
%      for j=1:Ymax
%          if IM(i,j)==200
%            %jj=Ymax;
%            %jj=jj-j+1;
%            G=[G;i,j];
%          end
%      end
%  end
     %for i=300:4:320
         %se=randi(13);
         %for j=200:10:210
           %if IM(300,j)~=0
            % Ajouter_Objet (400,250,pi,5,100,6.7,3.2,0.1,1,0.1)
             for i=1:1:10
                 Ajouter_Objet(2 + 1/i, 1 + 1/i, pi, 0.03, 5000, 0, 0, 1, 2, 0.2);
             end
             %for i=1:1:5
                 %Ajouter_Objet(i, 1/i, pi, 0.03, 5000, 0, 0, 0, 2, 0.2);
             %end
             
             %Ajouter_Objet (3.65,0.4,pi,0.03,5000,0,0,0,1,0.2);
             %Ajouter_Objet (3.65,0.7,pi,0.03,5000,0,0,0,1,0.2);
             %Ajouter_Objet (1.6,3.65,pi,0.03,5000,0,0,0,2,0.2);
             %Ajouter_Objet (1.7,3.65,pi,0.03,5000,0,0,0,2,0.2);
             %Ajouter_Objet (2,1,pi,0.03,5000,0,0,0,2,0.2);
           %end
         %end
%      %end
%   H=find(IM==0);
%   X=MX2(IM(H));
%   Y=MY2(IM(H));
%Obstacles=detect_obstacles(IM);
  %Ajouter_Obstacle_Barre(6,2,6,4);
% Ajouter_Obstacle_Cercle (x,y,radius)
% Ajouter_Obstacle_Cercle (7,3,0.7)
% Ajouter_Obstacle_Rectangle (x,y,longueur,largeur)
 %Ajouter_Obstacle_Rectangle (5.5,2,0.1,2)
%%%%%% Ajouter_Objet (x,y,theta,rayon,densite,v_x,v_y,w,code,tau)
%%- x et y position du centre de masse de l'objet.
%%- rayon et densité de l'objet.
%%- v_x et v_y les vitesses initiales selon x et y du piéton
%%- code permet de faire appartenir le piéton à un groupe.
     
   
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %Ajouter_Plusieurs_Objets (3,1.5,4,3,4,normrnd(1.34,0.26),2,0.1)
 %Ajouter_Plusieurs_Objets (2,4.7,5.8,2.8,3.8,normrnd(1.34,0.26),2,0.1)
 
          %Ajouter_Objet (5,3,0,pas/4,100,8,0.26,0,2,0.1)

        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Matrice des masses
        M = zeros(3*Nb_objets,3*Nb_objets);
          M_inv = zeros(3*Nb_objets,3*Nb_objets);
        for i=1:Nb_objets
            M(3*i-1,3*i-1) = Masse(i);    
            M(3*i-2,3*i-2) = Masse(i); 
            M(3*i,3*i) = 0.5*Masse(i)*Rayon(i)^2;
            M_inv(3*i-1,3*i-1) =1/ Masse(i);    
            M_inv(3*i-2,3*i-2) = 1/Masse(i); 
            M_inv(3*i,3*i) =1/( 0.5*Masse(i)*Rayon(i)^2);
            
        end
        
       temps_evacuation=zeros(Nb_objets,1);
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Directions souhaitées initiales
       D_S=zeros(3*Nb_objets,1);


%%%%%%%%%Fast Marching%%%%


%MX=MX3;
%MY=MY3;
%FXN=FXN3;
%FYN=FYN3;
