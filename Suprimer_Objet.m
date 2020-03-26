
function Suprimer_Objet (i)
  % Variables globales
    global Nb_objets   % Nombre d'objets constituant le système
    global q           % Vecteur de taille 2*N des positions des centres de gravités des objets
    global Rayon       % Vecteur de taille N des rayons des objets
   
    global V_ant% Vecteur de taille 2*N des vitesses des objets
    global V_new
    global M
    global M_inv    % Vecteur de taille N des masses des objets
    global tau
    global allure
    global Code
    global couleur
 
 
  for j=i:Nb_objets-1
    q(3*j-2:3*j,1)=q(3*(j+1)-2:3*(j+1),1);
    Rayon(j,1) =Rayon(j+1,1);
%    couleur(j)=couleur(j+1);
    Code(j)=Code(j+1);
    M(j,j)= M(j+1,j+1);
    M_inv(j,j)= M_inv(j+1,j+1);
    %tau(j)=tau(j+1);
    allure(j)=allure(j+1);
    V_ant(3*j-2:3*j,1)=V_ant(3*(j+1)-2:3*(j+1),1);
    V_new(3*j-2:3*j,1)=V_new(3*(j+1)-2:3*(j+1),1);
  end
  
   Nb_objets = Nb_objets - 1;
   