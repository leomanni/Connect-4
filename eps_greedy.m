function a = eps_greedy(Q, epsilon)

if rand < epsilon
    a = randi(length(Q),6);
else
    a = find(Q == max(Q), 6, 'first');
end