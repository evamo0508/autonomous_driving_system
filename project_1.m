a=xlsread('test1.xlsx');

n=1;
for j=1:11
    a(j,1)=randi([0,80]);
    a(j,2)=randi([0,40]);
    a(j,3)=randi([0,80]);
    a(j,4)=randi([0,40]);
    f=readfis('project_redgreenlight.fis');
    a(j,5)=10*( evalfis([(a(j,1)+a(j,2))/3 (a(j,3)+a(j,4))/3],f) ) ;
    a(j,6) = a(j,5) * a(j,1) / ( a(j,1)+a(j,2) )
    a(j,7) = a(j,5) * a(j,2) / ( a(j,1)+a(j,2) )
    g=readfis('project_nomandriving.fis');
    
    for i=n:(n+floor(a(j,6))-1)
        if mod(j,2)==1
            a(i+1,9)=a(i,9)-0.6;
            if a(i+1,9)<0
                a(i+1,9)=0;
            end
        else
            a(i+1,9)=a(i,9)+0.6;
            if a(i+1,9)>60
                a(i+1,9)=60;
            end
        end
        a(i,13) = 60;
        a(i,20) = 60;
        
        %second car
        a(i,14)=evalfis([(a(i,12)./a(i,10)) a(i,11)/a(i,10)],g).*a(i,13)+a(i,10);
        a(i,15)=evalfis([(a(i,12)./a(i,10)) a(i,11)/a(i,10)],g);
        a(i+1,10)=a(i,14);
        a(i+1,11)=a(i+1,10)-a(i+1,9);
        a(i+1,12)=a(i,12)-a(i,11)*0.1;
        if a(i,12)<0.5
            a(i+1,10)=a(i+1,9);
        end
        if a(i,12)>a(i,10)
            a(i+1,10)=a(i,10)-(a(i+1,11)/8);
        end
        if a(i+1,10)<0
            a(i+1,10)=0;
        end
        
        %third car
        a(i,21)=evalfis([(a(i,19)./a(i,17)) a(i,18)/a(i,17)],g).*a(i,20)+a(i,17);
        a(i,15)=evalfis([(a(i,12)./a(i,10)) a(i,11)/a(i,10)],g);
        a(i+1,17)=a(i,21);
        a(i+1,18)=a(i+1,17)-a(i+1,10);
        a(i+1,19)=a(i,19)-a(i,18)*0.1;
        if a(i,19)<0.5
            a(i+1,17)=a(i+1,10);
        end
        if a(i,19)>a(i,17)
            a(i+1,17)=a(i,17)-(a(i+1,18)/8)
        end
        if  a(i+1,17)<0
            a(i+1,17)=0;
        end   
    end
    n=n+floor(a(j,6));
end
%a(1,12)=a(1,8)./a(1,6);
    
xlswrite('testoutput',a);