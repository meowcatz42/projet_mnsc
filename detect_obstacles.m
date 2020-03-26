

function [Obstacles]=detect_obstacles(IM)
Obstacles=[];
for ii=1:size(IM,1)
     for j=1:size(IM,2)
         if IM(ii,j)==0
         Obstacles=[Obstacles;ii,j];
         end
     end
end
end