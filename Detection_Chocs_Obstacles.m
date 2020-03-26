function [Nb_contacts] = Detection_Chocs_Obstacles()

global Nb_objets k  K_N_obs K_T_obs   q Rayon choc C_N C_NN C_T V_new Pext M_inv h V_ant Obstacles
    
% initialisation
   % k=size(C_N,1)+1;                                  
    Contact_obstacles = [];
    %IM=imread('A (5).png');
    C_N=[];
    C_NN=[];
    C_T=[];
    k=1;
 
    
% Prévision de la position à la fin de l'intervalle de temps considéré
    q_save=q; %sauvegarde les positions du début de l'intervalle de temps
   % q=q+h*(V_ant+(V_ant+h*Pext.*diag(M_inv)))/2;    
    q=q+h*(V_ant+(V_ant+h*Pext))/2; 
% Détection des contacts possibles  
    for i=1:Nb_objets
        for l=1:size(Obstacles,1)
         Distance = norm(q(3*i-2:3*i-1,1)-Obstacles(l,:)',2)- Rayon(i);
            if (Distance <=0)
                D=[];
                % yacontact=[yacontact;i,l];
% %             end
% %         end
% %     end                  
         
% Lorsque des contacts sont détectés: détermination de C_N, C_T  
   %% for p=1:size(yacontact,1)
            
                % objet et obstacle considérés:
                obj=i;%yacontact(p,1);
                obs=l;%yacontact(p,2);     
                
                % On précise le point de contact
                  A_obstacles =  q(3*obj-2:3*obj-1) + Rayon(obj)*(Obstacles(obs,1:2)'-q(3*obj-2:3*obj-1))/norm(Obstacles(obs,1:2)'-q(3*obj-2:3*obj-1),2);
                % On précise la normale au point de contact
                  Normale_obstacles =(q(3*obj-2:3*obj-1)-Obstacles(obs,1:2)')/(norm(q(3*obj-2:3*obj-1)-Obstacles(obs,1:2)',2));
                  Normale_obstacles=Normale_obstacles';
                  %Normale_obstacles
                % On précise la tangente au point de contact
                  Tangente_obstacles = [Normale_obstacles(2),-Normale_obstacles(1)];
                  
% % % % %                   rho = A_obstacles_Cercle'-q(3*obj-2:3*obj-1,1)';
% % % % %                   
% % % % %                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % %                 % Construction de D...    
% % % % %                 
% % % % %                 
% % % % % % %                 A MODIFIER !!!!!!!!!!!!!!!!!!
% % % % %                 D(k,3*Nb_objets)=0; %
% % % % %                 D(k,3*(obj-1)+1)=1;
% % % % %                 D(k,3*obj)=-rho(1,2);
% % % % %                 D(k+1,3*(obj-1)+2)=1;
% % % % %                 D(k+1,3*obj)=rho(1,1);
% % % % %                 k=k+2;

                G1A = A_obstacles - q(3*obj-2:3*obj-1); %[a;b]
                rho =[0,0];%[-G1A(2),G1A(1)]; % [alpha1x,alpha1y] = [-b,a]
                  
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % Construction de D...    
                D(1,3*Nb_objets)=0; %
                D(1,3*(obj-1)+1)=1;
                D(1,3*obj)=rho(1,1);
                D(2,3*(obj-1)+2)=1;
                D(2,3*obj)=rho(1,2);
                size(D(1:2,:))
                
                % on construit les matrices C_N et C_T (projection de D sur la normale/tangente)
                C_N(k,:)=Normale_obstacles*D(1:2,:);
                C_NN(k,:)=sqrt(K_N_obs)* Normale_obstacles*D(1:2,:);
                C_T(k,:)=sqrt(K_T_obs)*Tangente_obstacles*D(1:2,:);
            
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % on verifie le contact...si la vitesse de contact (normale)
                % est positive, pas besoin d'exercer une percussion interne!       
                if C_N(k,:)*V_new<=0
                     Contact_obstacles = [Contact_obstacles;obj,obs];                           
                    choc(obj)=1;
                    k=k+1;
                end 
    end
        end
    end
    Nb_contacts=size(Contact_obstacles,1);

% Réinitialisation de q
      q=q_save;      
                              