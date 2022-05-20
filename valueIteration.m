clear variables
close all
clc

load data.mat
%%
gamma = 0.9;

S = size(P1,1); % array dimensione AS
A = size(R,2); %azioni

value = randi(A,S,1); % inizializzo  random la funzione valore (array Sx1 con randi(A))

prevpolicy = rand(S,1); % policy random



tic
while true
    [value, policy] = policyOptim(P1,P2,P3,P4,P5,P6, R, gamma, value);
    %disp(norm(policy - prevpolicy))
    if norm(policy - prevpolicy) == 0
        break;
    else
        prevpolicy = policy;
    end
end
toc


% tic
% while true
%     [value, policy] = policyOptim(P, R, gamma, value);
%     %disp(norm(policy - prevpolicy))
%     if norm(policy - prevpolicy) == 0
%         break;
%     else
%         prevpolicy = policy;
%     end
% end
% toc


%% GAME

grid= zeros(5,6);
plotgame(grid);
while (checkzero(grid~=0) || wincondition(grid)==0)
    id = grid2id(grid);
    grid = action(policy(AS == id),grid,1);
    %stampa
    hold on;
    pause(1);
    plotgame(grid);

    % partita terminata
    if (wincondition(grid)~=0)
        break;
    % partita continua    
    else
        %scelta azione player
        choose = input("Sceliere azione: ");
        grid =action(choose,grid,2);
        pause(1);
        plotgame(grid);
        id = grid2id(grid);
    end
end

if (wincondition(grid)==1)
    disp("HAI PERSO!")
elseif (wincondition(grid)==2)
    disp("HAI VINTO!")
else
    disp("PAREGGIO!")

end