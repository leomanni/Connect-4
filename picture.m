function picture(grid,i,n)

if mod(i,n) == 0

    hold on
    
    plotgame(grid);
    pause(0.7)
    if (wincondition(grid)==1)
        msgbox("GIALLO VINCE");
    elseif (wincondition(grid)==2)
       msgbox("ROSSO VINCE, COMPLIMENTI!");
    end
end


end