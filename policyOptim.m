function [newValue, policy] = policyOptim(P, R, gamma, value)

S = size(P,1);
A= size(R,2);

newValue = zeros(S,1);
policy = zeros(S,1);

for s = 1:S
    q = zeros(A,1);
    for a = 1:A
        trans = P(s,:,a); % mi dice la prob che vado in ciascuno degli stati s' sapendo che sono partito da s e ho preso l'azione a
        q(a) = R(s,a) + gamma*trans*value; %trans vett RIGA, value vett COLL, quindi facendo cosi mi calcolo la sommatoria
    end 
    newValue(s) = max(q); % scelgo per ciascuno stato la q max   
    policy(s) = find(q == max(q), 1);
end