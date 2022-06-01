% SARSA C4

clc
close all
clear variables

rows = 6;
columns = 7;
grid = zeros(rows, columns);
actions = 1:columns;

alpha = 0.5;
epsilon = 0.5;
gamma = 1;
num_episodes = 1000;
% n episodi giocati con grafica
n = 0;

Q = randi(8,[1,columns]);   %8 da modificare?

is_terminal = false;
visited_grids = zeros(1,2);

visited_grids(1,1) = grid2id(grid);

vittorie = 0;

% load data.mat

tic
for i = 1 : num_episodes



    % initialize S = 1 (indicizzazione)
    S = 1;
    visited_grids(S,2) = visited_grids(S,2) + 1;
    R = 0;
    is_terminal = false;
    grid = id2grid(visited_grids(S,1));
    picture(grid,i,n);

    while ~is_terminal
        % scelta A epsilon greedy, guardando a Q(S',A)
        A = eps_greedy(Q(S,:),epsilon);


        check_valid = vect_action(grid);
        ret_check = check_valid(A);
        if ret_check == 0
            R = -100*rows*columns;
            % Il valore Q(S',A') è posto a 0
            Q(S,A) = Q(S,A) + alpha*(R - Q(S,A));

            is_terminal = true;
        end

        grid = action(A,grid,1);
        picture(grid,i,n);

        % azione avversario


        % simulate step
        % osservo R, S'
        id_grid = grid2id(grid);
        winner = wincondition(grid);

        % check_vittoria
        if winner == 1
            R = 100;

            epsilon = epsilon - 0.00001;
            if epsilon <= 0.01
                epsilon = 0.01;
            end

            vittorie = vittorie + 1;
            is_terminal = true;
        else
            grid = random_action(grid,2);
            picture(grid,i,n);
        end

        id_grid = grid2id(grid);
        winner = wincondition(grid);

        % check sconfitta
        if winner == 2
            R = -100;

            epsilon = epsilon - 0.00001;
            if epsilon <= 0.01
                epsilon = 0.01;
            end

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
        A_1 = eps_greedy(Q(S_1,:),epsilon);

        % aggiorno Q(S,A) = Q(S,A) + alpha(R+gamma*Q(S',A') - Q(S,A))

        Q(S,A) = Q(S,A) + alpha*(R+gamma*Q(S_1,A_1) - Q(S,A));
        % S = S'
        S = S_1;
        % A = A'
        A = A_1;
        % check S is_terminal
        if check_value(grid,0) == 0

            epsilon = epsilon - 0.00001;
            if epsilon <= 0.01
                epsilon = 0.01;
            end

            is_terminal = true;
        end
    end

    % percentuale vittorie
    if (mod(i,100) == 0)
        media_v = vittorie/i;
        disp("% vittorie = " + media_v);
    end

end
toc

save data.mat Q visited_grids

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
i = 1;
picture(grid,i,n);

while ~is_terminal

    % muove l'agente
    A = eps_greedy(Q(S,:),0);

    check_valid = vect_action(grid);
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
    picture(grid,i,n);

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
            prompt = "Seleziona mossa valida: ";
            a = input(prompt);
            valid = true;
        end
        grid = action(a,grid,2);
        picture(grid,i,n);
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
    A_1 = eps_greedy(Q(S_1,:),0);

    % aggiorno Q(S,A) = Q(S,A) + alpha(R+gamma*Q(S',A') - Q(S,A))

    Q(S,A) = Q(S,A) + alpha*(R+gamma*Q(S_1,A_1) - Q(S,A));
    % S = S'
    S = S_1;
    % A = A'
    A = A_1;
    % check S is_terminal
    if check_value(grid,0) == 0
        is_terminal = true;
    end

end




