
function [Nb_contacts] = Detection_Chocs_Objets ()

global Nb_objets Pext k q Rayon K_N_obj K_T_obj choc C_N C_NN C_T V_new V_ant h  M_inv
    choc=zeros(Nb_objets,1);
    %contacts possibles... (somme distance centres de gravité < somme rayons)
    C_N=[];
    C_NN=[];
    C_T=[];
    k=1;
    c_o=0;
    q_save=q; 
   
    %q=q+h*V_new;
    %q=q+h*(V_ant+(V_ant+h*Pext.*diag(M_inv)))/2;
     q=q+h*(V_ant+(V_ant+h*Pext))/2; 
    for i=1:Nb_objets
        for j=i+1:Nb_objets
            Distance = norm(q(3*i-2:3*i-1,1)-q(3*j-2:3*j-1,1),2) - (Rayon(i)+Rayon(j));
            if (Distance <=0)     
                D=[];
                % objets considérés:
                  i1=i;
                  i2=j;   
                % On précise le point de contact
                  A_objets = q(3*i1-2:3*i1-1)' + Rayon(i1)*(q(3*i2-2:3*i2-1)-q(3*i1-2:3*i1-1))'/norm(q(3*i2-2:3*i2-1)-q(3*i1-2:3*i1-1),2);
                % On précise la normale au point de contact
                  normale = (q(3*i1-2:3*i1-1,1)-q(3*i2-2:3*i2-1,1))/(norm(q(3*i1-2:3*i1-1,1)-q(3*i2-2:3*i2-1,1),2));
                  normale = normale';
                % On précise la tangente au point de contact
                  tangente = [normale(2),-normale(1)];
             
                G1A = Rayon(i1)*(q(3*i2-2:3*i2-1)-q(3*i1-2:3*i1-1))'/norm(q(3*i2-2:3*i2-1)-q(3*i1-2:3*i1-1),2); %[a;b]
                G2A = Rayon(i2)*(q(3*i1-2:3*i1-1)-q(3*i2-2:3*i2-1))'/norm(q(3*i1-2:3*i1-1)-q(3*i2-2:3*i2-1),2); %[c;d]

                rho = [-G1A(2),G1A(1);-G2A(2),G2A(1)]; % [alpha1x,alpha1y ; alpha2x,alpha2y] = [-b,a ; -d,c]
               
                % Construction de D...
                D(1,3*Nb_objets)=0;   
                D(1,3*(i1-1)+1)=1;   
                D(1,3*(i2-1)+1)=-1;
                D(1,3*i1)=0;%rho(1,1);
                D(1,3*i2)=0;%-rho(2,1);
                D(2,3*(i1-1)+2)=1;
                D(2,3*(i2-1)+2)=-1;
                D(2,3*i1)=0;%rho(1,2);
                D(2,3*i2)=0;%-rho(2,2);
                

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % on construit les matrices C_N et C_T (projection de D sur la normale/tangente)
                C_N(k,:)=normale*D(1:2,:);
                 C_NN(k,:)=sqrt(K_N_obj)*normale*D(1:2,:);
                C_T(k,:)=sqrt(K_T_obj)*tangente*D(1:2,:);

                % on verifie le contact...si la vitesse de contact (normale)
                % est positive, pas besoin d'exercer une percussion interne!
                if C_N(k,:)*V_new<=0
                    choc(i1)=1;
                    choc(i2)=1;
                    c_o=c_o+1;
                    k=k+1;
                end
               
        end
        end
    end
    
% Calcul de Nb_contacts
    Nb_contacts=c_o;
                
% Réinitialisation de q                
        q=q_save;               