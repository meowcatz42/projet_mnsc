%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% Dessiner un objet %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% DESSINER_OBJET (POSITION)
% La procédure DESSINER_OBJET dessine l'objet numéro POSITION sur la
% fenêtre graphique courante .

function Dessiner_Objet (Position)
% Variables globales
  global q           % Vecteur de taille 2*N des positions des centres de gravités des objets
  global Rayon       % Vecteur de taille N des rayons des objets
  global Code        % Vecteur de taille N informant du groupe auquel appartient les objets
  global V_new
  global D_S
  
  teta=q(3*Position);
  
  VTheta1 =linspace(0,teta);
  XCercle1 = q(3*Position-2) + Rayon(Position) * cos(VTheta1);
  XCercle1=[XCercle1, q(3*Position-2),XCercle1(1)];
  YCercle1 = q(3*Position-1) + Rayon(Position) * sin(VTheta1);
  YCercle1=[YCercle1, q(3*Position-1),YCercle1(1)];
  
  VTheta2 =linspace(teta,2*pi);
  XCercle2 = q(3*Position-2) + Rayon(Position) * cos(VTheta2);
  XCercle2=[XCercle2, q(3*Position-2),XCercle2(1)];
  YCercle2 = q(3*Position-1) + Rayon(Position) * sin(VTheta2);
  YCercle2=[YCercle2, q(3*Position-1),YCercle2(1)];
  
  if (Code(Position)==1)
    fill(XCercle1, YCercle1,'g','edgecolor','g','linewidth',2);
      fill(XCercle2, YCercle2,'b','edgecolor','b','linewidth',2);
    plot([q(2*Position-1),q(2*Position-1)+(2/3)*Rayon(Position)*D_S(3*Position-1)],[q(2*Position),q(2*Position)+(2/3)*Rayon(Position)*D_S(3*Position)],'b');
  
  elseif (Code(Position)==2)
   fill(XCercle1, YCercle1,'g','edgecolor','g','linewidth',2);
   fill(XCercle2, YCercle2,'g','edgecolor','g','linewidth',2);
   plot([q(2*Position-1),q(2*Position-1)+(2/3)*Rayon(Position)*D_S(2*Position-1)],[q(2*Position),q(2*Position)+(2/3)*Rayon(Position)*D_S(2*Position)],'r');
   elseif (Code(Position)==3)
   fill(XCercle1, YCercle1,'g','edgecolor','g','linewidth',2);
   fill(XCercle2, YCercle2,'g','edgecolor','g','linewidth',2);
   plot([q(2*Position-1),q(2*Position-1)+(2/3)*Rayon(Position)*D_S(2*Position-1)],[q(2*Position),q(2*Position)+(2/3)*Rayon(Position)*D_S(2*Position)],'g') 
  end
 %text(q(3*Position-2),q(3*Position-1),['\theta=', num2str((q(3*Position)))],'FontSize',12,'color','w');
  
  %[0.87 0.49 0]
  
  
  