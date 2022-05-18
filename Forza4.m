%% Connect-4
% Progetto OSC-1
% Manni Leonardo, Rossi Edoardo

clear
close all
clc

rows = 5;
columns = 6;
grid = zeros(rows, columns);
actions = 1:columns;

AS = [0]; % array in cui vengono allocati tutti gli After State generati


% Allocazione After-State
tic
simulazioni = 1000;
i=1;

while i<=simulazioni
    grid = zeros(rows, columns); %parto da grid vuota (Già in AS)

    % inizio partita random
    while (checkzero(grid)~=0) %|| wincondition(grid)==0)
        if(wincondition(grid)==0)
            grid = random_action(grid,1);   % mossa PLAYER 1 random (Non è un AS)
            grid = random_action(grid,2);   % mossa PLAYER 2 random (E' UN AS)
            id_AS = grid2id(grid);  % converto in id

            % se id non presente in AS lo aggiungo
            if (ismember(id_AS, AS) == 0)
                AS = [AS;id_AS];
            end

            checkzero(grid);
        else
            break
        end
        
    end

    i = i+1;
end

AS=sort(AS);

toc

save data.mat AS

%prove grafica

% grid=id2grid(AS(90));
% plotgame(grid)
% ax = gca;
% %pause(1)
% hold on
% grid=id2grid(AS(91));
% plotgame(grid)
% hold off

%% MATRICE P di trasizione

num_AS=length(AS);

P = zeros(num_AS+1, num_AS+1 , length(actions));

% ciclo su tutti gli AS generati
for s = 1:num_AS 

    % ciclo su ogni azione
    for a = 1:length(actions)   
        grid = id2grid(AS(s));
        grid = action(a,grid,1);  % gioco la mossa Player 1
        free_actions = free_id(vect_action(grid));  % vettore delle mosse libere
        probAS = prob_nextState(grid);  % probabilità di evolvere in un nuovo stato

        % ciclo su ogni azione possibile
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

% ciclo su tuttu gli AS generati
for s = 1:num_AS    

    % ciclo su ogni azione
    for a = 1:length(actions)    
        grid = id2grid(AS(s));
        vect=vect_action(grid); % converti il contenuto di grid in vettore di azioni libere tra 1:6
        prev = grid_temp(1,a); % check sulla posizione in cui vorrei giocare

        % se eccede la colonna
        if (vect(a) == 0)
            R(s,a) = fail_reward;
            
        % se libero
        elseif vect(a) == 1
            grid = action(a,grid,1);
            ret = wincondition(grid);

            % se vince
            if ret == 1
                R(s,a) = victory_reward;

            % se pareggia   
            elseif (ret == 0 && checkzero(grid)==0)
                R(s,a) = draw_reward;

            % se il gioco continua e l'avversario gioca    
            else
                free_index = free_id(vect); % check sulle mosse ancora disponibili
                fi_size = length(free_index); 
                p_lose = 1/fi_size; % probabilità di sconfitta
                rsa_array =zeros(fi_size,1); % array dei possibili rewards
                
                % cosa succede quando l'avversario effettua la prossima
                % mossa?
                for i = 1:fi_size
                    
                    temp_grid = action(free_index(i),grid,2); % costruisco un grid temporanea per valutare ogni situazione possibile
                    temp_ret = wincondition(temp_grid);
                    
                    % l'avversario vince
                    if temp_ret == 2
                        rsa = lose_reward;
                        
                    % il gioco continua   
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


% Si possono cancellare 

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

