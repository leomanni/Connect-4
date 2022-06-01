%SARSA C4

clc
close all
clear variables

rows = 5;
columns = 6;
grid = zeros(rows, columns);
actions = 1:columns;

alpha = 0.5;
epsilon = 0.2;
gamma = 1;
num_episodes = 100;

Q = randi(8,[1,columns]);   %8 da modificare?
is_terminal = false;
visited_grids = zeros(1,1);

visited_grids(1) = grid2id(grid);

for i = 1 : num_episodes
 
    % initialize S = 1 (indicizzazione)
    S = 1;
    R = 0;

    while ~is_terminal
        % scelta A epsilon greedy, guardando a Q(S',A)
        A = eps_greedy(Q(S,:),epsilon);
        grid = action(A,grid,1);
        % azione avversario
        grid = random_action(grid,2);

        % simulate step 
            % osservo R, S'
            id_grid = grid2id(grid);
            winner = wincondition(grid);

            % check_vittoria
            if winner == 1
                R = 100;
                is_terminal = true;
            else
                grid = random_action(grid,2);
            end

            id_grid = grid2id(grid);
            winner = wincondition(grid);

            % check sconfitta
            if winner == 2
                R = -100;
                is_terminal = true;      
            end

            if find(id_grid == visited_grids,1) == 0 
                visited_grids = [visited_grids ; id_grid];
                S_1 = length(visited_grids);
                Q = [Q; zeros(1,columns)];
            else
                S_1 = find(id_grid == visited_grids,1);
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
                is_terminal = true;
            end
    end


end

