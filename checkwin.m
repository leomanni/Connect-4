%Funzioni per verificare se si verifica una vittoria da parte del PC

% Vittoria (PC)
 function win = checkwin(grid,value)
 
 win = 0;
 
 %CHECK ORIZZONTALE
 for i=1:size(grid,1)
     if (  grid(i,1)==value && grid(i,2)==value && grid(i,3)==value && grid(i,4)==value ...
        || grid(i,2)==value && grid(i,3)==value && grid(i,4)==value && grid(i,5)==value ...
        || grid(i,3)==value && grid(i,4)==value && grid(i,5)==value && grid(i,6)==value )
            win = 1;
            return
     end  
 end
 
 %CHECK VERTICALE
 for j=1:size(grid,2)
     if (  grid(1,j)==value && grid(2,j)==value && grid(3,j)==value && grid(4,j)==value ...
        || grid(2,j)==value && grid(3,j)==value && grid(4,j)==value && grid(5,j)==value ) 
            win = 1;
           return
     end
 end
 
 %CHECK OBBLIGUO \ 5x6
 if (grid(1,1)==value && grid(2,2)==value && grid(3,3)==value && grid(4,4)==value ...
    || grid(1,2)==value && grid(2,3)==value && grid(3,4)==value && grid(4,5)==value ...
    || grid(1,3)==value && grid(2,4)==value && grid(3,5)==value && grid(4,6)==value ...
    || grid(2,1)==value && grid(3,2)==value && grid(4,3)==value && grid(5,4)==value ...
    || grid(2,2)==value && grid(3,3)==value && grid(4,4)==value && grid(5,5)==value ...
    || grid(2,3)==value && grid(3,4)==value && grid(4,5)==value && grid(5,6)==value )
        win = 1;
        return
 end
 
 %CHECK OBBLIGUO /
 if ( grid(5,1)==value && grid(4,2)==value && grid(3,3)==value && grid(2,4)==value ...
    || grid(4,1)==value && grid(3,2)==value && grid(2,3)==value && grid(1,4)==value ...
    || grid(4,2)==value && grid(3,3)==value && grid(2,4)==value && grid(1,5)==value ...
    || grid(4,3)==value && grid(3,4)==value && grid(2,5)==value && grid(1,6)==value ...
    || grid(5,2)==value && grid(4,3)==value && grid(3,4)==value && grid(2,5)==value ...
    || grid(5,3)==value && grid(4,4)==value && grid(3,5)==value && grid(2,6)==value )
        win = 1;
        return
 end
 end
 