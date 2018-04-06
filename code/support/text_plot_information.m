%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function adds text to a plot. Given the coordinates where the
% information wants to be put and the variable that needs to be associated
% to, it puts that information in the plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function text_plot_information(X_coor,information,FontSize)

switch max(size(X_coor))
    case 2
         X       =  X_coor(1);
         Y       =  X_coor(2);
         text(X,Y,['\bullet' num2str(information)],'Fontsize',FontSize)   
    case 3
         X       =  X_coor(1);
         Y       =  X_coor(2);
         Z       =  X_coor(3);
         text(X,Y,Z,['\bullet' num2str(information)],'Fontsize',FontSize)         
end
        
    
