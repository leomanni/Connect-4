function picture(grid,i,n)

if mod(i,n) == 0

    hold on
    
    plotgame(grid);
    pause(0.7)
    if (wincondition(grid)==1)
        disp("GIALLO VINCE")
    elseif (wincondition(grid)==2)
        disp("ROSSO VINCE, COMPLIMENTI!")
    end
end


end