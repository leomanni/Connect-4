function a = eps_greedy(Q, epsilon)


if rand < epsilon
    a = randi(length(Q),1);
else
    a = find(Q == max(Q), 1, 'first');
end

