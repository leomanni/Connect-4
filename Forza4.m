% FORZA 4
clear all
close all
clc




rows = 5;
columns = 6;

grid = zeros(rows, columns);
actions = 1:columns;
S = 0;
AS= [0];

%cleT=cat(3); %matrice 3D che contiente le corrispondenze grid indice(indice inserimento)
%%
tic
simulazioni = 10;

i=1;
while i<=simulazioni
    grid = zeros(rows, columns); %parto da grid vuota (Gi� in AS)

    while checkzero(grid)~=0 %INIZIO PARTITA RANDOM
        %a=randi(size(actions,2)); %mossa random
        grid = random_action(grid,1); % mossa PLAYER 1 random (Non � un AS)
        grid = random_action(grid,2); % mossa PLAYER 2 random (E' UN AS)
        id_AS = grid2id(grid); %converto in id
        if (ismember(id_AS, AS) == 0)
            AS = [AS;id_AS]; %id non presente, quindi aggiungo
        end
        checkzero(grid);
    end
    i = i+1;
end

AS=sort(AS);
toc
%%
save data.mat AS

%%
num_AS=length(AS);


% MATRICE P
P = zeros(num_AS+1, num_AS+1 , length(actions));

for s = 1:num_AS    % indice stato di partenza s
    
    for a = 1:length(actions)   % scelta dell'azione a
        
        grid = id2grid(AS(s));
        grid = action(grid,a,1);
        % questo perch� il find cicla per colonne
        empty_index = find(transpose(grid) == 0);
        probAS = prob_nextState(grid);
        
        for i=1:length(empty_index)
            grid_temp = grid;
            grid_temp = action(grid_temp,empty_index(i),2);
            id = grid2id(grid_temp);
            index_id = find(AS == id);
            P(s,index_id,a) = probAS;
        end
        
    end
    
end







%%
% AS= [AS;0];
% %grid = zeros(rows, columns);
% for i=1:size(actions,2)
%     grid = zeros(rows, columns) %parto da grid vuota (Gi� in AS)
%     j=1;
%     while checkzero(grid)~=0 
%         grid = action(j,grid,1) % mossa PLAYER 1 (Non � un AS)
%         act_disp = vect_action(grid); %Check sul numero di mosse disponibili dell'avversario
%         for a=1:size(act_disp,2) %ciclo tante volte quante sono le azioni disponibili
%             if(act_disp(a)==1)
%                 grid_AS = action(a,grid,2) %grid temporanea
%                 id_AS = grid2id(grid_AS); %converto in id
%                 if (ismember(id_AS, AS) == 0)
%                     AS = [AS;id_AS]; %id non presente, quindi aggiungo
%                 end
%             end
%         end
%         grid = grid_AS % salvo l'ultimo AS inserito nel vettore per continuare a generare grid
%         j = j+1;
%      end
% end
% 
% 







%% Allocazione stati
% 
% id = grid2id(grid);
% S_array = [S_array; id];
% i = 1;
% % for i = 1:7 (a monte)
% 
% while (i <=length(S_array))
%     grid_1 = id2grid(S_array(i));
% 
%     for j = 1:7
%         % controllo sulla possibilit� di giocare mossa j
%         grid_2 = action(j,grid_1,2);
%         id_temp = grid2id(grid_2);
%         if find(S_array = id) == 0
%             S_array = [S_array; id_temp]; %#ok<AGROW>
%         end
%     end
%     i = i+1;
% end
% 
% % for i=1:7
% %   se colonna libera, gioca mossa i
% %       aggiungi A_S i-esimo a S_array in coda SE NON ESISTE
% %           se aggiunto stato, aggiungi 0 (not visited) in coda a S_visited
% % dopo il for, metti lo stato corrente con S_visited = 1



















%% METODI

%numOccur = sum(arrayfun(@(x) x == 1,grid(i,:))); %conto il numero di 1 nell'array riga, se sono 4 allora controllo se sono consecutivi
%if numOccur >= 4  %se ci sono almeno 4 1 controllo senno skippo


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

%Calcolo la probabilit� di fare una mossa


%
%

%








%%%%%  FUNZIONA!!!!!
%Coverto da matrice a vettore di indici che rappresenta la configurazione
%per riga
%  function id = grid2id(grid)
%     id = zeros(6,1); %indice per ogni vettore riga
%     for i=1:6
%         esp=1;
%         for j=7:-1:1
%             id(i) = id(i) + grid(i,j)*3^(esp-1);
%             esp = esp + 1;
%         end
%     end
%  end


%%%%%  FUNZIONA!!!!!
%converto ogni indice nel vettore associato fino a riformare la griglia
%originaria
%  function grid = id2grid(id)
%     grid = zeros(6,7);
%     value =id;
%     for i=1:6
%         j=1;
%         while value(i) ~= 0
%             r = mod(value(i),3);
%             value(i) =(value(i) - r)/3;
%             grid(i,j) = r;
%             j = j + 1;
%         end
%     end
%     grid=fliplr(grid);
%
%  end