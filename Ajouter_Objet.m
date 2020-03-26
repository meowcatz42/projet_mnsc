%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% Ajout d'un objet %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% Stefano DAL PONT % puis % Philippe PECOL %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% Ajouter_Objet (x,y,rayon,densite,v_x,v_y,v_r,code,tau)

    %%- x et y position du centre de masse de l'objet
    %%- rayon et densité de l'objet
    %%- v_x et v_y et v_r les vitesses initiales selon x et y du centre de l'objet
    %%- code permet de faire appartenir l'objet à un groupe
    %%- plus "tau" est grand, plus l'objet met du temps pour faire
    %%tendre sa vitesse réelle vers celle souhaitée;

function Ajouter_Objet (x,y,theta,rayon,densite,v_x,v_y,v_r,cod,to,colr)
  % Variables globales
    global Nb_objets   % Nombre d'objets constituant le système
    global q           % Vecteur de taille 2*N des positions des centres de gravités des objets
    global Rayon       % Vecteur de taille N des rayons des objets
    global V           % Vecteur de taille 2*N des vitesses des objets
    global Masse       % Vecteur de taille N des masses des objets
    global Code
    global couleur
    global tau
  % Ajout des coordonnées du centre de gravité de l'objet
    q(3*Nb_objets+1,1) = x;
    q(3*Nb_objets+2,1) = y;
    q(3*Nb_objets+3,1) = theta;
  % Ajout du rayon du l'objet
    Rayon(Nb_objets+1,1) = rayon;
  % Ajout des vitesse du centre de gravité de l'objet
    V(3*Nb_objets+1,1) = v_x;
    V(3*Nb_objets+2,1) = v_y;
    V(3*Nb_objets+3,1) = v_r;
  % Ajout de la masse de l'objet
    Masse(Nb_objets+1) =densite*pi*rayon*rayon;
    
  % Code de l'objet si l'on veut qu'il fasse parti d'un groupe
    Code(Nb_objets+1) = cod;
     %tau(Nb_objets+1) = to;
         %couleur(Nb_objets+1) =colr;
  % Temps de relaxation 
  
  % Nombre d'objets dans la nouvelle configuration
    Nb_objets = Nb_objets + 1;
   
end