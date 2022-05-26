
function prob = prob_nextState(grid)

n_actions = length(free_id(vect_action(grid)));
if n_actions ~= 0
    prob = 1/n_actions;
else
    prob = 0;
end

end