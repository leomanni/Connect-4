% Check degli indici disponibili nel vettore delle azione della funzione
% vect_action
function free_id = free_id(vect)
    free_id = [];
    for i=1 : length(vect)
        if(vect(i)==1)
            free_id = [free_id,i];
        end
    end
end