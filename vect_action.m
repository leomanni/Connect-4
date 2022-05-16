%Costruisco il vettore delle mosse disponibili

function vect_action = vect_action(grid)
vect_action =zeros(1,size(grid,2));
top_grid = grid(1,:);
for i= 1:size(grid,2)
    if top_grid(i) == 0
        vect_action(i) = 1;
    end
end
end