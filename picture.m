function picture(grid,i,n)

if mod(i,n) == 0

    hold on
    
    plotgame(grid);
    pause(1)
    if (wincondition(grid)==1)
        disp("GIALLO VINCE")
    elseif (wincondition(grid)==2)
        disp("GIALLO PERDE")
    end
end


end