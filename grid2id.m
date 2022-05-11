%Coverto da matrice a indice che rappresenta la configurazione

function id = grid2id(grid)
    id = 0;
    ROWS = size(grid,1);
    COLUMNS = size(grid,2);
    vect=reshape(transpose(grid),1,(ROWS*COLUMNS)); %da matrix a vect 1x(ROWS*COLUMNS) -> per riga
    
    esp=1;
    for i=(ROWS*COLUMNS):-1:1
        id = id + vect(i)*3^(esp-1);
        esp = esp + 1;
    end

 end