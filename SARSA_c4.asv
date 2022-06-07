% SARSA C4

clc
close all
clear variables

rows = 6;
columns = 7;
grid = zeros(rows, columns);
actions = 1:columns;

alpha = 0.9;
%epsilon = 0.6; % Ambiente STATICO -> epsilon DECRESCENTE
epsilon = 0.1;
gamma = 1;
num_episodes = 100000;
% n episodi giocati con grafica
n = 0;

Q = randi(8,[1,columns]);   %8 da modificare?

is_terminal = false;
visited_grids = zeros(1,2);

visited_grids(1,1) = grid2id(grid);

vittorie = 0;
vittorie_step = 0;
step = 5000; % ogni step visualizzo la % di vittoria
array_vict_tot = [];
array_vict_step = [];

win_reward = 100;
lose_reward = -100;
out_of_grid_reward = -100*rows*columns;

%%
load data.mat

%%
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
        U_valid_temp_1 = free_id(check_valid);

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

        A = eps_greedy(Q(S,:),epsilon,grid);

        % potrebbe non verificarsi mai:
        % epsilon_greedy sceglie solo da U ammissibili

        ret_check = check_valid(A);
        if ret_check == 0
            R = out_of_grid_reward;
            % Il valore Q(S',A') è posto a 0
            Q(S,A) = Q(S,A) + alpha*(R - Q(S,A));

            is_terminal = true;
        end

        grid = action(A,grid,1);
        picture(grid,e,n);

        % azione avversario


        % simulate step
        % osservo R, S'
        id_grid = grid2id(grid);
        winner = wincondition(grid);

        % check_vittoria
        if winner == 1
            R = win_reward;

            epsilon = epsilon - 1/1e6;
            if epsilon <= 0.1
                epsilon = 0.1;
            end
            %             alpha = alpha - 1/3e6;
            %             if alpha <= 0.1
            %                 alpha = 0.1;
            %             end

            vittorie = vittorie + 1;
            vittorie_step = vittorie_step + 1;
            is_terminal = true;
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
            %             alpha = alpha - 1/3e6;
            %             if alpha <= 0.1
            %                 alpha = 0.1;
            %             end

            is_terminal = true;
        end
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

%%
save data.mat Q visited_grids array_vict_tot array_vict_step

%% GAME



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

    % muove l'agente

    check_valid = vect_action(grid);
    U_valid_temp_1 = free_id(check_valid);

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

    A = eps_greedy(Q(S,:),0,grid);

    ret_check = check_valid(A);
    if ret_check == 0
        R = -100*rows*columns;
        msgbox("Non superare la griglia! Hai provato mossa " + A);
        disp("Episodio terminato")
        % Il valore Q(S',A') è posto a 0
        Q(S,A) = Q(S,A) + alpha*(R - Q(S,A));

        is_terminal = true;
        break;
    end

    grid = action(A,grid,1);
    picture(grid,e,n);

    % check vittoria agente
    winner = wincondition(grid);
    if winner == 1
        R = 100;
        is_terminal = true;
    else
        % muove giocatore
        valid = false;

        % ripete finché non inserisce azione valida
        while ~valid
            answer=inputdlg('Seleziona mossa valida:','Input',[1 35]);
            a = str2double(answer{1});

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
    % S = S'
    S = S_1;
    % A = A'
    A = A_1;
    % check S is_terminal
    if check_value(grid,0) == 0
        Q(S,:)=0;
        is_terminal = true;
    end

end




