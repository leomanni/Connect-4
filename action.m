% Mossa PLAYER value 

function grid = action(a,grid,value) %passo azione, grid, valore giocatore 
    ROWS = size(grid,1);
   %COLUMNS = size(grid,2);
    if grid(1,a)~=0 % controllo se la colonna è full
        %mossa non fattibile
        fprintf('ERRORE: selezionare altra mossa! ')
    else %posso impilare pedine
        for i=ROWS:-1:1
             if grid(i,a)==0
                 grid(i,a)= value;
                 break
             else

             end
        end
    end
 end