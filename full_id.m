% Check degli indici pieni nel vettore delle azione della funzione
% vect_action
function full_id = full_id(vect)
    full_id = [];
    for i=1 : length(vect)
        if(vect(i)==0)
            full_id = [full_id,i];
        end
    end
end