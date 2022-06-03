function a = eps_greedy(Q, epsilon,grid)

% mossa random
if rand < epsilon
    %"random"
    vect_free = free_id(vect_action(grid)); %vettore delle mosse disponibili


    if length(vect_free)>1
    	a = randsample(vect_free,1); %se il vettore diventa uno scalare (nel caso rimane solo una mossa disbonibile) si trasforma in un randi
    else
        if isempty(vect_free)
            a=1; %serve per gestire il bug
        else
        % QUANDO LA GRID è FULL CRUSHA
        a = vect_free; %scelgo l'unica mossa disponibile
        end
    end
    
% mossa epsilon-greedy
else
    vect_full = full_id(vect_action(grid));

    % faccio in modo che le mosse non possibili non vengano prese
    if length(vect_full) > 0
        Q(1,vect_full) = -1000;
    end
    
    % mossa che massimizza il reward
    if length(find(Q == max(Q))) > 1
        a = randsample(find(Q == max(Q)),1);
    else
        a = find(Q == max(Q), 1, 'first');
    end
end

