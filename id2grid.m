% %Da indice a grid

 function grid = id2grid(id)
    ROWS = 6;
    COLUMNS = 7;
    grid = zeros(ROWS,COLUMNS);
    vect = zeros(1,ROWS*COLUMNS);
    value = id; %vpa(id,30); %aumento sensibilità decimali
    
    i = 1;
    while value ~= 0
        r = mod(value,3); %resto dell'operazione mod
        value = (value - r)/3;
        vect(i) = r;
        i = i + 1;
    end
    v=size(vect,2);
    for i=1:ROWS
        for j=1:COLUMNS
            grid(i,j) = vect(v);
            v= v-1;
        end
    end
 end