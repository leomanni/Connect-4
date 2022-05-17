%Funzioni per verificare se si verifica una vittoria da parte del PC

% Vittoria (PC)
 function win = checkwin(grid)
 
 win = 0;
 
 %CHECK ORIZZONTALE
 for i=1:size(grid,1)
     if (  grid(i,1)==1 && grid(i,2)==1 && grid(i,3)==1 && grid(i,4)==1 ...
        || grid(i,2)==1 && grid(i,3)==1 && grid(i,4)==1 && grid(i,5)==1 ...
        || grid(i,3)==1 && grid(i,4)==1 && grid(i,5)==1 && grid(i,6)==1 ) %...
        %|| grid(i,4)==1 && grid(i,5)==1 && grid(i,6)==1 && grid(i,7)==1 )
            win = 1;
            return
     end  
 end
 
 %CHECK VERTICALE
 for j=1:size(grid,2)
     if (  grid(1,j)==1 && grid(2,j)==1 && grid(3,j)==1 && grid(4,j)==1 ...
        || grid(2,j)==1 && grid(3,j)==1 && grid(4,j)==1 && grid(5,j)==1 ) %...
        %|| grid(3,j)==1 && grid(4,j)==1 && grid(5,j)==1 && grid(6,j)==1 )
            win = 1;
           return
     end
 end
 
 %CHECK OBBLIGUO \ 5x6
 if (grid(1,1)==1 && grid(2,2)==1 && grid(3,3)==1 && grid(4,4)==1 ...
    || grid(1,2)==1 && grid(2,3)==1 && grid(3,4)==1 && grid(4,5)==1 ...
    || grid(1,3)==1 && grid(2,4)==1 && grid(3,5)==1 && grid(4,6)==1 ...
    %|| grid(1,4)==1 && grid(2,5)==1 && grid(3,6)==1 && grid(4,7)==1 ...
    || grid(2,1)==1 && grid(3,2)==1 && grid(4,3)==1 && grid(5,4)==1 ...
    %|| grid(3,1)==1 && grid(4,2)==1 && grid(5,3)==1 && grid(6,4)==1 ...
    %|| grid(3,2)==1 && grid(4,3)==1 && grid(5,4)==1 && grid(6,5)==1 ...
    %|| grid(3,3)==1 && grid(4,4)==1 && grid(5,5)==1 && grid(6,6)==1 ...
    %|| grid(3,4)==1 && grid(4,5)==1 && grid(5,6)==1 && grid(6,7)==1 ...
    || grid(2,2)==1 && grid(3,3)==1 && grid(4,4)==1 && grid(5,5)==1 ...
    || grid(2,3)==1 && grid(3,4)==1 && grid(4,5)==1 && grid(5,6)==1 )...
    %|| grid(2,4)==1 && grid(3,5)==1 && grid(4,6)==1 && grid(5,7)==1 )
        win = 1;
        return
 end
 
 %CHECK OBBLIGUO /
 if ( %grid(6,1)==1 && grid(5,2)==1 && grid(4,3)==1 && grid(3,4)==1 ...
    %|| grid(6,2)==1 && grid(5,3)==1 && grid(4,4)==1 && grid(3,5)==1 ...
    %|| grid(6,3)==1 && grid(5,4)==1 && grid(4,5)==1 && grid(3,6)==1 ...
    %|| grid(6,4)==1 && grid(5,5)==1 && grid(4,6)==1 && grid(3,7)==1 ...
    || grid(5,1)==1 && grid(4,2)==1 && grid(3,3)==1 && grid(2,4)==1 ...
    || grid(4,1)==1 && grid(3,2)==1 && grid(2,3)==1 && grid(1,4)==1 ...
    || grid(4,2)==1 && grid(3,3)==1 && grid(2,4)==1 && grid(1,5)==1 ...
    || grid(4,3)==1 && grid(3,4)==1 && grid(2,5)==1 && grid(1,6)==1 ...
    %|| grid(4,4)==1 && grid(3,5)==1 && grid(2,6)==1 && grid(1,7)==1 ...
    %|| grid(5,4)==1 && grid(4,5)==1 && grid(3,6)==1 && grid(6,7)==1 ...
    || grid(5,2)==1 && grid(4,3)==1 && grid(3,4)==1 && grid(2,5)==1 ...
    || grid(5,3)==1 && grid(4,4)==1 && grid(3,5)==1 && grid(2,6)==1 )
        win = 1;
        return
 end
 end
 