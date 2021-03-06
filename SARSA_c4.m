%% REINFORCEMENT LEARNING DEL GIOCO CONNECT-4 TRAMITE ALGORITMO SARSA
% Progetto per il corso di Laurea Magistrale in Ingegneria dell'Automazione
% Materia: Ottimizzazione dei Sistemi di Controllo 1
% Autori: Manni Leonardo, Rossi Edoardo

clc
close all
clear variables

rows = 6;
columns = 7;
grid = zeros(rows, columns);
actions = 1:columns;

% PARAMETRI SARSA
alpha = 0.9;
%epsilon = 0.6; % Ambiente STATICO -> epsilon DECRESCENTE
epsilon = 0.1; % Utilizzare ad apprendimento avanzanto
gamma = 1;
Q = randi(8,[1,columns]);  % Q iniziale random
num_episodes = 1000000;

n=0; % n° episodi giocati con grafica durante l'apprendimento
is_terminal = false;
visited_grids = zeros(1,2); % corrispondenza degli AS visitati
visited_grids(1,1) = grid2id(grid);

% PARAMETRI PRESTAZIONI
vittorie = 0;
vittorie_step = 0;
step = 5000; % ogni step visualizzo la % di vittoria
array_vict_tot = [];
array_vict_step = [];

%REWARDS
win_reward = 100;
lose_reward = -100;
out_of_grid_reward = -100*rows*columns;

%% LOAD DELL'APPRENDIMENTO EFETTUATO

load data.mat

%% APPRENDIMENTO
tic
for e = 1 : num_episodes

    % initialize S = 1 (indicizzazione)
    S = 1;
    visited_grids(S,2) = visited_grids(S,2) + 1;
    R = 0;
    is_terminal = false;
    grid = id2grid(visited_grids(S,1));
    picture(grid,e,n);

    while ~is_terminal
        % scelta A epsilon greedy, guardando a Q(S',A)
        check_valid = vect_action(grid);
        U_valid_temp_1 = free_id(check_valid); % array delle mosse valide
        
        % check di S' di ogni mossa valida dell'agente
        for i = 1:length(U_valid_temp_1)
            grid_temp = grid;
            grid_temp = action(U_valid_temp_1(i),grid_temp,1);
            U_valid_temp_2 = free_id(vect_action(grid_temp));
            
            % mossa i fa vincere l'agente
            if wincondition(grid_temp)== 1
                Q(S,i) = win_reward;
            break;
            end

            % check di S' di ogni mossa valida dell'avversario
            for j = 1:length(U_valid_temp_2)
                grid_temp_oppo = grid_temp;
                grid_temp_oppo = action(U_valid_temp_2(j),grid_temp_oppo,2);
                winner_temp = wincondition(grid_temp_oppo);
                
                % mossa i agente + mossa j avversario -> avversario vince
                if winner_temp == 2
                    Q(S,i) = lose_reward;
                end

            end

        end
        
        % epsilon_greedy sceglie solo da U ammissibili
        A = eps_greedy(Q(S,:),epsilon,grid);
        grid = action(A,grid,1);
        picture(grid,e,n);

        % simulate step
        % osservo R, S'
        id_grid = grid2id(grid);
        winner = wincondition(grid);

        % check_vittoria
        if winner == 1
            R = win_reward;

            % espilon decrescente
            epsilon = epsilon - 1/1e6;
            if epsilon <= 0.1
                epsilon = 0.1;
            end
            
            vittorie = vittorie + 1;
            vittorie_step = vittorie_step + 1;
            is_terminal = true;
            
        % gioco continua, tocca all'avversario (random)
        else
            grid = random_action(grid,2);
            picture(grid,i,n);
        end

        id_grid = grid2id(grid);
        winner = wincondition(grid);

        % check sconfitta
        if winner == 2
            R = lose_reward;
            
            epsilon = epsilon - 1/1e6;
            if epsilon <= 0.1
                epsilon = 0.1;
            end
            
            is_terminal = true;
        end
        
        % se AS è nuovo lo aggiungo
        ret = find(id_grid == visited_grids(:,1),1);
        if  length(ret) == 0
            visited_grids = [visited_grids ; [id_grid,1]];
            Q = [Q; zeros(1,columns)];
            S_1 = size(visited_grids,1);
            
        else
            S_1 = ret;
            visited_grids(S,2) = visited_grids(S,2) + 1;
        end



        % scelta A' epsilon greedy
        A_1 = eps_greedy(Q(S_1,:),epsilon,grid);
        vect_free = free_id(vect_action(grid));

        % aggiorno Q(S,A) = Q(S,A) + alpha(R+gamma*Q(S',A') - Q(S,A))

        Q(S,A) = Q(S,A) + alpha*(R+gamma*Q(S_1,A_1) - Q(S,A));
        S = S_1;
        A = A_1;

        % check S is_terminal
        if check_value(grid,0) == 0
            epsilon = epsilon - 1/1e6;
            if epsilon <= 0.1
                epsilon = 0.1;
            end

            Q(S,:)=0; % imposto il valore dello stato terminale a 0
            is_terminal = true;
        end
        
    end

    % percentuale vittorie
    if (mod(e,step) == 0)
        media_tot = (vittorie/e)*100;
        array_vict_tot = [array_vict_tot, media_tot];
        disp("% vittorie totale = " + media_tot);

        media_step = (vittorie_step/step)*100;
        array_vict_step = [array_vict_step, media_step];
        %disp("% vittorie step = " + media_step);
        vittorie_step = 0;
    end

end
toc

%% SALVATAGGIO APPRENDIMENTO EFFETTUATO

save data.mat Q visited_grids array_vict_tot array_vict_step

%% GAME (con grafica)

figure('Units','normalized','Position',[.2 .2 .6 .6], ...
    'Name','     * CONNECT - 4 *','Color','w');
axes('Units','normalized','Position',[.1 0 .8 .8], ...
    'Color','b','LineWidth',1,'Box','on');
set(gca, 'XTick',[],'YTick',[],'XLim',[0,160],'YLim',[0,150]);

S = 1;
R = 0;
is_terminal = false;
grid = id2grid(visited_grids(S,1));
n = 1;
e = 1;
picture(grid,e,n);

while ~is_terminal

    check_valid = vect_action(grid);
    U_valid_temp_1 = free_id(check_valid);

    % check sullo stato S'
    for i = 1:length(U_valid_temp_1)
        grid_temp = grid;
        grid_temp = action(U_valid_temp_1(i),grid_temp,1);
        U_valid_temp_2 = free_id(vect_action(grid_temp));
        
        if wincondition(grid_temp)== 1
            Q(S,i) = win_reward;
            break;
        end
        
        for j = 1:length(U_valid_temp_2)
            grid_temp_oppo = grid_temp;
            grid_temp_oppo = action(U_valid_temp_2(j),grid_temp_oppo,2);
            winner_temp = wincondition(grid_temp_oppo);
            
            if winner_temp == 2
                Q(S,i) = lose_reward;
            end

        end

    end
    
    % muove l'agente
    A = eps_greedy(Q(S,:),0,grid);
    grid = action(A,grid,1);
    picture(grid,e,n);

    % check vittoria agente
    winner = wincondition(grid);
    if winner == 1
        R = 100;
        is_terminal = true;
     
    % gioco continua   
    else
        valid = false;

        % gioca avversario
        while ~valid
            answer=inputdlg('Seleziona mossa valida:','Input',[1 35]);
            a = str2double(answer{1});
            
            % eccede colonna
            if isempty(find(a==free_id(vect_action(grid)), 1))==1
                msgbox("Non superare la griglia! Hai provato mossa " + A);
                msgbox("Episodio terminato");
                winner=1;
                is_terminal = true;
                break;   
            end
                
            valid = true;
        end
        
        grid = action(a,grid,2);
        picture(grid,e,n);
    end

    id_grid = grid2id(grid);
    winner = wincondition(grid);

    % check sconfitta
    if winner == 2
        R = -100;
        is_terminal = true;
    end

    % aggiornamento degli stati conosciuti
    ret = find(id_grid == visited_grids(:,1),1);
    if  length(ret) == 0
        visited_grids = [visited_grids ; [id_grid,1]];
        Q = [Q; zeros(1,columns)];
        S_1 = size(visited_grids,1);
    else
        S_1 = ret;
        visited_grids(S,2) = visited_grids(S,2) + 1;
    end


    % scelta A' epsilon greedy
    A_1 = eps_greedy(Q(S_1,:),0,grid);

    % aggiorno Q(S,A) = Q(S,A) + alpha(R+gamma*Q(S',A') - Q(S,A))
    Q(S,A) = Q(S,A) + alpha*(R+gamma*Q(S_1,A_1) - Q(S,A));
    S = S_1;
    A = A_1;
    
    % check S is_terminal
    if check_value(grid,0) == 0
        Q(S,:)=0;
        is_terminal = true;
    end

end




