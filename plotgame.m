% Funzione per la plot del Connect-4

function  plotgame(grid)
grid=flipud(grid); % flippo up-down per questioni di grafica
% figure('Units','normalized','Position',[.2 .2 .6 .6], ...
%     'Name','     * CONNECT - 4 *','Color','w');
% axes('Units','normalized','Position',[.1 0 .8 .8], ...
%     'Color','b','LineWidth',1,'Box','on');
% set(gca, 'XTick',[],'YTick',[],'XLim',[0,140],'YLim',[0,130]);
hold on;
for row = 1:6
    for col = 1:7
        if(grid(row,col)==1)
            grid(row,col) = plot( col*20,row*20, 'wo','MarkerSize',30,...
                'LineWidth',.5,'MarkerFaceColor','y', ...
                'MarkerEdgeColor', [0 0 0]);
        elseif (grid(row,col) ==2)
            grid(row,col) = plot( col*20,row*20, 'wo','MarkerSize',30,...
                'LineWidth',.5,'MarkerFaceColor','r', ...
                'MarkerEdgeColor', [0 0 0]);
        else
            grid(row,col) = plot( col*20,row*20, 'wo','MarkerSize',30,...
                'LineWidth',.5,'MarkerFaceColor','w', ...
                'MarkerEdgeColor', [0 0 0]);
        end
    

    end
end
end