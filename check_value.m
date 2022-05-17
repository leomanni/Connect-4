function [ret] = check_value(grid, value)

ret = 0;

[M,N] = size(grid);
for i=1:M
    for j=1:N
        if grid(i,j) == value
            ret = ret+1;
        end
    end
end
end