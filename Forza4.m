% FORZA 4
clear all
close all
clc




rows = 5;
columns = 6;

grid = zeros(rows, columns);
actions = 1:columns;
AS= [0];


tic
simulazioni = 1e3;

i=1;
while i<=simulazioni
    grid = zeros(rows, columns); %parto da grid vuota (Già in AS)

    while checkzero(grid)~=0  % INIZIO PARTITA RANDOM
        %a=randi(size(actions,2)); % mossa random
        grid = random_action(grid,1);   % mossa PLAYER 1 random (Non è un AS)
        grid = random_action(grid,2);   % mossa PLAYER 2 random (E' UN AS)
        id_AS = grid2id(grid);  %converto in id
        if (ismember(id_AS, AS) == 0)
            AS = [AS;id_AS];    % id non presente, quindi aggiungo
        end
        checkzero(grid);
    end
    i = i+1;
end

AS=sort(AS);
toc

save data.mat AS

%%
num_AS=length(AS);


% MATRICE P di trasizione

P = zeros(num_AS+1, num_AS+1 , length(actions));

for s = 1:num_AS    % ciclo su tuttu gli AS generati
    
    for a = 1:length(actions)   % ciclo su ogni azione
        
        grid = id2grid(AS(s));
        grid = action(a,grid,1);  % gioco la mossa Player 1
        free_actions = free_id(vect_action(grid));  % vettore delle mosse libere
        probAS = prob_nextState(grid);  % probabilità di evolvere in un nuovo stato
        
        for i=1:length(free_actions)            
            grid_temp = grid;
            grid_temp = action(free_actions(i),grid_temp,2);    % Player 2 gioca mossa tra le possibili
            id = grid2id(grid_temp);
            index_id = find(AS == id);  % per avere stessa corrispondenza tra AS e P
            P(s,index_id,a) = probAS;   % popolo la matice P
        end
        
    end
    
end





%% matrice R

R = zeros(num_AS+1, length(actions));

victory_reward = 1;
draw_reward = -1;
lose_reward = -1;
fail_reward = -1000;

for s = 1:num_AS    % ciclo su tuttu gli AS generati
    
    for a = 1:length(actions)    % ciclo su ogni azione
        
        grid = id2grid(AS(s));
        
        
        % converti IL CONTENUTO di grid in vettore di azioni libere tra 1:6
        vect=vect_action(grid);
        
        
        % check sulla posizione in cui vorrei giocare
        prev = grid_temp(1,a);
                
        
        % se sfora la colonna
        if (vect(a) == 0)
            R(s,a) = fail_reward;
            
            % se libero
        elseif vect(a) == 1
            grid = action(a,grid,1);
            
            ret = checkwin(grid);
            
            
            if ret == 1
                % se vince
                
                R(s,a) = victory_reward;
                
            elseif ret == -1
                
                % se pareggia
                
                R(s,a) = draw_reward;
                
            else
                % se il gioco continua e l'avversario gioca
                % if ret == 0
                
                free_index = free_id(vect);
                fi_size = length(free_index);
                p_lose = 1/fi_size;
                rsa_array =zeros(fi_size,1);
                
                
                for i = 1:fi_size
                    
                    temp_grid = action(free_index(i),grid,2);
                    % emp ret dipende dall'implementazione di checkwni/lose
                    temp_ret = checklose(temp_grid);
                    
                    if temp_ret == -2
                        rsa = lose_reward;
                        
                    else
                        rsa = 0;
                    end
                    rsa_array(i) = rsa;
                    
                end
                % il reward sarà la media
                
                R(s,a) = mean(rsa_array);
                
                
            end
        end
    end
end




%% METODI


%Conto il numero di 0 in griglia
function zero= checkzero(grid)
zero = 0;
for i=1:size(grid,1)
    for j=1:size(grid,2)
        if grid(i,j) == 0
            zero = zero+1;
        end
    end
end
end

%Conto il numero di 1 in griglia
function one= checkone(grid)
one = 0;
for i=1:size(grid,1)
    for j=1:size(grid,2)
        if grid(i,j) == 1
            one = one+1;
        end
    end
end
end

%Conto il numero di 2 in griglia
function two= checktwo(grid)
two = 0;
for i=1:size(grid,1)
    for j=1:size(grid,2)
        if grid(i,j) == 2
            two = two+1;
        end
    end
end
end

