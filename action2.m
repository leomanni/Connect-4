% Mossa PLAYER 2

 function grid = action2(a,grid) %passo l'azione e la grid
    ROWS = size(grid,1);
    COLUMNS = size(grid,2);
    if grid(1,a)~=0 % controllo se la colonna è full
        %mossa non fattibile
        fprintf('ERRORE: selezionare altra mossa! ')
    else %posso impilare pedine
        for i=ROWS:-1:1
             if grid(i,a)==0
                 grid(i,a)= 2;
                 break
             else

             end
        end
    end
 end