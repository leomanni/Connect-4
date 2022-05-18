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