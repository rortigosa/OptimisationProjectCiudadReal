function set_latex_font(siz)
set(gca,'Fontsize',siz)    
    set(gca,'FontName','Times New Roman')
    set(get(gca,'Xlabel'),'Interpreter','latex')
    set(get(gca,'Xlabel'),'FontSize',siz)
    set(get(gca,'Ylabel'),'Interpreter','latex')
    set(get(gca,'Ylabel'),'FontSize',siz)
    set(get(gca,'Title'),'Interpreter','latex')
    set(get(gca,'Title'),'FontSize',siz)
    a=get(gcf,'Children');
    %set(a(1),'Interpreter','latex')
    for i = 1:numel(a) 
        try 
            set(a(i),'Interpreter','latex');
        catch
%            disp('oops');
        end; 
    end
