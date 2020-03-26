%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Affichage des résultats %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%
  %clf;
  global IM
  figure(1)
  
%   axis([0 8 0 6]);
%   hold on
%imagesc(0:731,0:541,Img_gray)
%imagesc(MX2(1,1:366),MY2(1:270,1),Img_gray(1:270,1:366))
imagesc(MX2(1,:),MY2(:,1),Img_gray)
%imagesc(IM)
%imagesc(Img_gray);
colormap gray % hot hsv
  %Y=size(M,2);
  %X=543:-1:1;
 % X=sort(X,'descend');
  %M=M';
  %plot(Y,X);
     % choix de la fenêtre d'affichage
  
  %imshow('A (5).png')
  %imagesc(IM);

  %axis([1 size(IM,2)  1 size(IM,1)]); % choix de la fenêtre d'affichage
  
  title({['Mouvement de ', num2str(Nb_objets), 'Piéton(s)'];[('T = '),num2str(h*n)]}); % à modifier si nécessaire
  hold on
 % grid on
% % grid minor
           

 % Direction_souhaitee;
    for i=1:Nb_objets
       Dessiner_Objet(i);
% %         if (Code(i)==1)
           plot(cc(3*i-2,:),cc(3*i-1,:),'r');
% %             
% %         else
% %            plot(cc(3*i-2,:),cc(3*i-1,:),'r');
% %         end
      
    end
     
% %       if n==0
% %            text(0,4.2,['m=', num2str(int8(Masse(1))),'kg'],'FontSize',12,'color','b');
% %            text(7,4.2,['m=', num2str(int8(Masse(2))),'kg'],'FontSize',12,'color','r');
% %       xa=[0.35,0.44];
% %       xb=[0.56,0.56];
% %       annotation('textarrow',xa,xb,'color','b')
% %       text(2.5,1.9,['u^-=', num2str(V(1)),'m/s'],'FontSize',10,'color','b');
% %       xa=[0.65,0.6];
% %       xb=[0.515,0.515];
% %       annotation('textarrow',xa,xb,'color','r')
  
     %  grid on
    % n=nf
% % %        if (rem(n,10)==0)||(n==1)
% % %         if ismember(n,1:9)
% % %             name = sprintf('aim0000%i.bmp',n);
% % %         elseif ismember(n,10:99)
% % %             name = sprintf('aim000%i.bmp',n);
% % %         elseif ismember(n,100:999)
% % %             name = sprintf('aim00%i.bmp',n);
% % %         elseif ismember(n,1000:9999)
% % %             name = sprintf('aim0%i.bmp',n);
% % %         elseif ismember(n,10000:99999)
% % %             name = sprintf('aim%i.bmp',n);
% % %         end
% % %         eval(['print -dbmp images/' name ]);
% % %     end
 %ùopen(Animation)
  %Image = getframe;
  % nf=nf+1;
   %FIG(nf)=Image;
  %writeVideo(Animation,Image);
%     
    