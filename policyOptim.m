function [newValue, policy] = policyOptim(P1,P2,P3,P4,P5,P6, R, gamma, value)

S = size(P1,1);
A= size(R,2);

newValue = zeros(S,1);
policy = zeros(S,1);

for s = 1:S
    q = zeros(A,1);
    for a = 1:A

        switch A

            case 1
                trans = P1(s,:); % mi dice la prob che vado in ciascuno degli stati s' sapendo che sono partito da s e ho preso l'azione a
            case 2
                trans = P2(s,:);   % vettore riga
            case 3
                trans = P3(s,:);
            case 4
                trans = P4(s,:);
            case 5
                trans = P5(s,:);
            case 6
                trans = P6(s,:);
        end
        q(a) = R(s,a) + gamma*trans*value; %trans vett RIGA, value vett COLL, quindi facendo cosi mi calcolo la sommatoria
    end
    newValue(s) = max(q); % scelgo per ciascuno stato la q max
    policy(s) = find(q == max(q), 1);
end