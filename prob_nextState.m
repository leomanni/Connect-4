
function prob = prob_nextState(grid)

n_zero = check_value(grid,0);
if n_zero ~= 0
    prob = 1/n_zero;
else
    prob = 0;
end

end