%close;
%clear all;
%clc;
format long; 
     VARIABLES_GLOBALES;
     load('FXN1');
     load('FYN1');
     load('FXN1');
     load('FYN1');
     initialisation;
     Nb_contacts=0;
     cc=[];
     %initialisationZoneT;
     n=0;
     V_ant=V;
      m=3.76;%moyenne 
      ec=0.35;%ecart 
      Nb_evacue=0;
%       allure=ec*randn(Nb_objets,1)+m;
      allure=3*ones(Nb_objets,1);
      %X1=[Sortie(1),Sortie(2)]';
      %X2=[Sortie(3),Sortie(4)]';
      date1=clock;
 Animation = VideoWriter('Evacuation_salle.avi');
   open(Animation) 
        while (n<N_iter && Nb_objets>0)
            
           cc=[cc,q]; 
             n=n+1;
              f_m=zeros(3*Nb_objets,1);
              f_c=zeros(3*Nb_objets,1);
               D_S=zeros(3*Nb_objets,1);
               Direction_souhaitee;
               % force d'acceleration 
               kk=120;
        for i=1:Nb_objets
       f_m(3*i-2:3*i-1)=(D_S(3*i-2:3*i-1,1)* 1.5-V_ant(3*i-2:3*i-1,1))/0.1;
      
        %Force do contact 
             
        for j=i+1:Nb_objets
            Distance = norm(q(3*i-2:3*i-1,1)-q(3*j-2:3*j-1,1),2) - (Rayon(i)+Rayon(j));
            if (Distance <=0)     
                f_c(3*i-2:3*i-1)=f_c(3*i-2:3*i-1)+kk*Distance;
                f_c(3*j-2:3*j-1)=f_c(3*j-2:3*j-1)+kk*Distance;
            end
        end
             end
        
                % objets considérés:
        
         ind=1:Nb_objets;
            V_new=V_ant+h*(f_m+M_inv*f_c);
            V_new(3*ind,1)=0;
            %Detection de contact
            
% % % % %             Nb_contacts = Detection_Chocs_Obstacles();
% % % % %             %Nb_contacts_obstacles_Cercle = Detection_Chocs_Obstacles_Cercle ();
% % % % %             %Nb_contacts_obstacles_Rectangle = Detection_Chocs_Obstacles_Rectangle ();
% % % % %             %Nb_contacts=Nb_contacts_Barre+Nb_contacts_objets+Nb_contacts_obstacles_Rectangle+Nb_contacts_obstacles_Cercle;
% % % % %             
% % % % %             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % %             % Détermination des objets en collision
% % % % %             
% % % % %             non_choc=find(choc==0);
% % % % %             test=isempty(non_choc);
% % % % %             if test==1
% % % % %                 non_choc=[];
% % % % %                 choc=find(choc==1);
% % % % %                 choc=[(3*choc-2)';(3*choc-1)';3*choc'];
% % % % %                 choc=reshape(choc,size(choc,1)*size(choc,2),1);
% % % % %             else
% % % % %                 choc=find(choc==1);
% % % % %                 choc=[(3*choc-2)';(3*choc-1)';3*choc'];
% % % % %                 choc=reshape(choc,size(choc,1)*size(choc,2),1);
% % % % %                 non_choc=[(3*non_choc-2)' ; (3*non_choc-1)' ; 3*non_choc'];
% % % % %                 non_choc=reshape(non_choc,size(non_choc,1)*size(non_choc,2),1);
% % % % %             end   
% % % % %             
% % % % %             
% % % % %             %%%%%%%%%%%%%%%%%%%%%%%
% % % % %            if (Nb_contacts > 0)
% % % % %        %% On utilise la méthode d'Uzawa seulement où il y a des chocs
% % % % %                     
% % % % %                     Uc = V_ant(choc);
% % % % %                    
% % % % %                     P_ext = Pext(choc);
% % % % %                     C_N = C_N(:,choc);
% % % % %                      C_NN = C_NN(:,choc);
% % % % %                     C_T = C_T(:,choc);
% % % % %                     MM=M(choc,choc);
% % % % %                     MM_inv=M_inv(choc,choc);
% % % % %             
% % % % % % % % %                    %%%%%%%%% % UZAWA%%%%%%%%%%%%
% % % % % % % % %                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % % % % %                     MU = zeros(size(C_N,1),1);
% % % % % % % % %                     epsilon=1e-13;
% % % % % % % % %                     testa=10*epsilon;
% % % % % % % % %                     niter=0;
% % % % % % % % %                   %  r = 1/(norm(C_N,2)*norm(C_N,2));%r=2/size(C_N,1);
% % % % % % % % %                      r=1e10;
% % % % % % % % %                     while (testa>epsilon)
% % % % % % % % %                         niter=niter+1;
% % % % % % % % % % %                         A = MM+(1/2)*K_N*(C_N)'*C_N+(1/2)*K_T*(C_T)'*C_T;
% % % % % % % % % % %                         B = MM*Uc+h*P_ext-(1/2)*K_N*(C_N)'*C_N*Uc-(1/2)*K_T*(C_T)'*C_T*Uc+(C_N)'*MU;
% % % % % % % % %                         A = MM+(1/2)*(C_NN)'*C_NN+(1/2)*(C_T)'*C_T;
% % % % % % % % %                         B = MM*Uc+h*P_ext-(1/2)*(C_NN)'*C_NN*Uc-(1/2)*(C_T)'*C_T*Uc+(C_N)'*MU;
% % % % % % % % %                        
% % % % % % % % %                       
% % % % % % % % %                         [L,UU] = lu(A);
% % % % % % % % %                         dum = L\B;
% % % % % % % % %                         Y = UU\dum;
% % % % % % % % %                         mu_2=max(MU+r*(-C_N*Y),0);
% % % % % % % % %                         test=dot(mu_2-MU,(-C_N*Y));  % voir CIARLET pour la théorie
% % % % % % % % %                         MU=mu_2;
% % % % % % % % %                         if niter>=2
% % % % % % % % %                             if test>testa  %petit test de convergence..si on converge pas, on divise r par 2!
% % % % % % % % %                                 r=r/2;
% % % % % % % % %                             end
% % % % % % % % %                         end
% % % % % % % % %                         testa=test;
% % % % % % % % %                     end
% % % % % % % % %                     V_new(choc)=Y;
% % % % % % %     [L,U]=lu(C_N*MM_inv*C_N');
% % % % % % %   ll=L\(C_N*Uc);
% % % % % % %   uu=U\ll;
% % % % % % %  % Y=Uc-MM_inv*(C_N'*uu);
% % % % % % %   Y=V_ant(choc)-MM_inv*(C_N'*uu);
% % % % %      z=zeros(size(C_N,1),1);
% % % % % A = MM+(1/2)*(C_NN)'*C_NN+(1/2)*(C_T)'*C_T;
% % % % % B = MM*Uc+h*P_ext-(1/2)*(C_NN)'*C_NN*Uc-(1/2)*(C_T)'*C_T*Uc;
% % % % % Y=quadprog(A,-B,-C_N,z);
% % % % %  V_new(choc)=Y;
% % % % % %%%%%%%%%%%
% % % % % % % G=null(-C_N);
% % % % % % % % w=G'*MM*G;
% % % % % % % % [l,u]=lu(w);
% % % % % % % % yy=l\(G'*MM*Uc);
% % % % % % % % x=u\yy;
% % % % % % % % Y=G*x;
% % % % % % % %      V_new(choc)=Y;
% % % % %  
% % % % % 
% % % % %   
% % % % %             end
% % % % % 
% % % % %             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % %             % Mise à jour de la position des piétons    

            q = q +(V_ant+V_new)*h/2;
            %q = q +5*D_S*h;
            V_ant=V_new;
            supr=0;
            z=5*ph;
        for s=1:Nb_objets
     if (q(3*s-2,1)>=Xmax-z || q(3*s-2,1)<=Xmin+z || q(3*s-1,1)<=Ymin+z ||q(3*s-1,1)>=Ymax-z)
         temps_evacuation(s+Nb_evacue)=n*h;
        Suprimer_Objet(s);
         supr=1;
         s=s-1;
         Nb_evacue=Nb_evacue+1;
     end
       end
          if supr==1
      q=q(1:3*Nb_objets);
       cc=cc(1:3*Nb_objets,:);
     Rayon =Rayon(1:Nb_objets);
     %couleur=couleur(1:Nb_objets);
     Code=Code(1:Nb_objets);
     M= M(1:3*Nb_objets,1:3*Nb_objets);
     M_inv= M_inv(1:3*Nb_objets,1:3*Nb_objets);
     %tau=tau(1:Nb_objets);
     allure=allure(1:Nb_objets);
     V_ant=V_ant(1:3*Nb_objets);
     V_new=V_new(1:3*Nb_objets);
     
         end
                    
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Affichage des résultats
            if ((n==1)||(mod(n*h,20*h)==0)) % modifier "A2" dans "mod(A1,A2)" pour afficher les résultats toutes les "A2" secondes
                Affichage_resultats;
             %   grid on
             n
                %%outputString = sprintf('frame %d .fig', n);
               %% saveas(gcf,outputString);
%                 fig = gcf;
%                 writeVideo(Animation,fig);
                frame = getframe(1);
                im = frame2im(frame);
                writeVideo(Animation,im);
                [imind,cm] = rgb2ind(im,256);
                outfile = 'Animation.gif';
% %                 % On the first loop, create the file. In subsequent loops, append.
                if n==1
                    imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',inf);
                else
                    imwrite(imind,cm,outfile,'gif','DelayTime',0,'writemode','append');
                end

                pause(h);
            end
           
           
% % % % %             AA3=q(3)*360/2/pi
%          
  

 

        end % Fin de la boucle principale
        moy_temps_evac=sum(temps_evacuation)/size(temps_evacuation,1);
    
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % La vidéo de la simulation est terminée

     close(Animation);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Affichage du temps de calcul de la simulation
        date2=clock;
        Resultat=date2-date1;
        fprintf(['\nTemps de simulation : ', num2str(Resultat)]);
        fprintf(' \n****** Fin de la simulation ****** \n');


