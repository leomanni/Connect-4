% Mossa RANDOM

function grid = random_action(grid,value) %passo grid, valore giocatore 
    ROWS = size(grid,1);
    %COLUMNS = size(grid,2);
    %vect_action(grid)
    vect = free_id(vect_action(grid));
    if length(vect)>1
        a = randsample(vect,1); %se il vettore diventa uno scalare (nel caso rimane solo una mossa disbonibile) si trasforma in un randi
    else
        a = vect; %scelgo l'unica mossa disponibile
    end
        %if(vect(a) == 1) % mossa fattibile
    for i=ROWS:-1:1
        if grid(i,a)==0
            grid(i,a) = value;
            break
        end
    end
end