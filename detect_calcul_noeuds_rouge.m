%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Détecte et calcule les Dist(i,j) des nouveaux noeuds "rouge" %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Philippe PECOL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Pile_test=[];
teta=0;

% Noeuds entourant le dernier noeud devenu "noir"
    if i+1<size(IM,1)
        Pile_test=[Pile_test;i+1,j];  % selon y
    else
        Pile_test=[Pile_test;NaN,NaN];
    end
    if 1<i-1
        Pile_test=[Pile_test;i-1,j];  % selon y
    else
        Pile_test=[Pile_test;NaN,NaN];
    end
    if j+1<size(IM,2)
        Pile_test=[Pile_test;i,j+1];  % selon x
    else
        Pile_test=[Pile_test;NaN,NaN];
    end
    if 1<j-1
        Pile_test=[Pile_test;i,j-1,]; % selon x
    else
        Pile_test=[Pile_test;NaN,NaN];
    end


for k=1:4
    
    if isnan(Pile_test(k,1))==0
        
        i=Pile_test(k,1);
        j=Pile_test(k,2);
        
        if TAB(i,j)~=1
            %%%%On calcule la distance au point (i,j)
            if i+1<size(IM,1)
                t2=Dist(i+1,j);
            else
                t2=Inf;
            end
            if 1<i-1
               t1=Dist(i-1,j);
            else
               t1=Inf;
            end
            if j+1<size(IM,2)
                t4=Dist(i,j+1);
            else
                t4=Inf;
            end
            if 1<j-1
                t3=Dist(i,j-1);
            else
                t3=Inf;
            end
            
%         end

            v1=min(t1,t2);
            v2=min(t3,t4);

            if (max(v1,v2)-min(v1,v2))<=ph

                teta =(v1+v2)/2+0.5*sqrt(2*ph^2-(v2-v1)^2);

            elseif (max(v1,v2)-min(v1,v2))>=ph

                teta =min(v1,v2)+ph;

            end


            if TAB(i,j)==0

                Pile=[Pile;i,j,teta];
                TAB(i,j)=-1;
                Dist(i,j)=teta;

            elseif TAB(i,j)==-1

                if teta<Dist(i,j)  
                    Dist(i,j)=teta;
                    AA=find(Pile(:,1)==i);
                    BB=find(Pile(:,2)==j);

                    for l1=1:length(AA)
                        for l2=1:length(BB)
                            if isempty(find(AA(l1)==BB(l2)))==0
                            CC=AA(l1);
                            end
                        end
                    end
                    Pile(CC,3)=Dist(i,j);
                end

            end
        end % if TAB(i,j)~=1
        
    end %if Pile_test(k,1)~=Nan
    
end % for k=1:4





























































