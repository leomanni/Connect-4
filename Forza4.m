% FORZA 4
clear all
close all
clc




global ROWS   COLUMNS
ROWS = 4;
COLUMNS = 4;
win = 0;
lose = 0;
valid_id=[];
grid = zeros(ROWS, COLUMNS);
actions = 1:COLUMNS;
S = 3^(ROWS*COLUMNS);
valid_AS=[]; %contiene tutti gli id validi associati agli AFTER STATES

% k=[0,0,0,0,0,0,0;
%    0,0,0,0,0,0,0;
%    0,0,0,0,0,0,0;
%    0,0,0,0,0,0,0;
%    0,0,0,0,0,0,0;
%    0,0,0,0,0,0,0] ;   

% k=[0,0,0,0;
%    0,0,0,0;
%    0,0,0,0;
%    0,0,0,0]; 
% 
% k1= action1(3,k);
% k2=action2(3,k1)
% id=grid2id(k2)
% l= id2grid(id)

%%

%vettore di indica per riga
%k_res=fliplr((id2grid(id))); %matrice da conversione
%k_res=id2grid(id);

%% RIDUZIONE STATI
for id=0:S-1
    grid = id2grid(id);
    if (checkone(grid) == checktwo(grid))
        valid_AS=[valid_AS; id];
    end
end

num_AS=length(valid_AS);
 
%% SAVE

%save data.mat valid_AS_id
%%   
    


%cc= fliplr(id2grid(id(1))); %flippo il vettore
%kk= transpose(reshape(cc,6,7)) %da vettore a matrice
%id1=grid2id(kk);

grid;
vect_action(grid);

% while win==0 && lose ==0
% PC= input ('Inserisci mossa PC: ');
% P2= input ('Inserisci mossa P2: ');
% grid=action1(PC,grid);
% grid=action2(P2,grid);
 %win=checkwin(k);
 %lose= checklose(k);
% grid

%grid;
% k=[0,0,0,0,0,0,0;
%    0,0,2,1,1,1,0;
%    0,0,2,0,0,0,0;
%    0,0,2,0,0,0,0;
%    0,0,2,0,0,0,0;
%    0,0,0,0,0,0,0]
   
   
% w=checkwin(k)
% l=checklose(k)
 


















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
 function vect_action = vect_action(grid)
    vect_action =zeros(1,size(grid,2));
    top_grid = grid(1,:);
    for i= 1:size(grid,2)
        if top_grid(i) == 0
            vect_action(i) = 1;
        end
    end
 end
 
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