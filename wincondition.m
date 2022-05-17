% Check sulle possibili configurazioni di Vittoria/Sconfitta

function winner = wincondition(grid)
SEQ = 4;
win = 0;
winner = 0;
ROWS = size(grid,1);
COLUMNS = size(grid,2);

% Check orizzontale
if win==0
    for i=1:ROWS
        for j=1:(COLUMNS-SEQ+1)
            if (grid(i,j)~=0 && grid(i,j)==grid(i,j+1) && grid(i,j)==grid(i,j+2) && grid(i,j)==grid(i,j+3))
                win = 1;
                winner = grid(i,j);
            end
        end
    end
end

% Check verticale
if win==0
    for j=1:COLUMNS
        for i=1:(ROWS-SEQ+1)
            if (grid(i,j)~=0 && grid(i,j)==grid(i+1,j) && grid(i,j)==grid(i+2,j) && grid(i,j)==grid(i+3,j))
                win = 1;
                winner = grid(i,j);
            end
        end
    end
end

% Check diagonale \
if win==0
    for i=1:(ROWS-SEQ+1)
        j=1;
        while j<=(COLUMNS-SEQ+1)
             if (grid(i,j)~=0 && grid(i,j)==grid(i+1,j+1) && grid(i,j)==grid(i+2,j+2) && grid(i,j)==grid(i+3,j+3))
                win = 1;
                winner = grid(i,j);
             end
             j=j+1;
        end
    end
end

% Check diagonale /
if win==0
    for i=ROWS:-1:SEQ %vede RIGA 5,4
        j = 1;
        while j<=(COLUMNS-SEQ+1) % vede COLONNA 1,2,3
            if (grid(i,j)~=0 && grid(i,j)==grid(i-1,j+1) && grid(i,j)==grid(i-2,j+2) && grid(i,j)==grid(i-3,j+3))
                win = 1;
                winner = grid(i,j);
            end
            j=j+1;
        end
    end
end


end
