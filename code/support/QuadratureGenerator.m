clc
clear all

dim                            =  [1;2;3];
degree_quadrature              =  [1;2;3;4;5;6;7;8];
degree_polynomial              =  [1;2;3;4];
str                            =  [];
% %--------------------------------------------------------------------------
% % Quadrature rule generator for quads/hexa elements
% %--------------------------------------------------------------------------
% for idim=1:size(dim,1)
%     for iquad=1:size(degree_quadrature,1)
%         newstr                 =  GaussQuadrature(str,degree_quadrature(iquad),dim(idim));
%         Chi                    =  newstr.quadrature.Chi;
%         W_v                    =  newstr.quadrature.W_v; 
%         switch idim
%             case 1
%                  filename      =  ['Line_QuadRule_' num2str(iquad) '.mat'];
%             case 2
%                  filename      =  ['Quad_QuadRule_' num2str(iquad) '.mat'];
%             case 3
%                  filename      =  ['Hexa_QuadRule_' num2str(iquad) '.mat'];
%         end
%         save(filename,'Chi','W_v')
%     end
% end
% %--------------------------------------------------------------------------
% % Quadrature rule generator for triangular/tetrahedral elements
% %--------------------------------------------------------------------------
%for idim=2:size(dim,1)
%     for iquad=1:size(degree_quadrature,1)
%         [xout,wout]                 =  gaussianquad(dim(idim),degree_quadrature(iquad));
%         Chi                         =  xout;
%         W_v                         =  wout; 
%         switch idim
%             case 2
%                  filename           =  ['Tri_QuadRule_' num2str(iquad) '.mat'];
%             case 3
%                  filename           =  ['Tet_QuadRule_' num2str(iquad) '.mat'];
%         end
%         save(filename,'Chi','W_v')
%     end
% end
%--------------------------------------------------------------------------
% Shape functions and derivatives generator for quads/hexas
%--------------------------------------------------------------------------
% for idim=1:size(dim,1)
%     for ipol=1:size(degree_polynomial,1)
%         for iquad=1:size(degree_quadrature,1)
%             switch idim
%                 case 1
%                      QuadFile        =  ['Line_QuadRule_' num2str(iquad) '.mat'];
%                      load(QuadFile)
%                      quadrature.Chi  =  Chi;
%                      [N,DN_chi]      =  ShapeFunctionComputation(1,degree_polynomial(ipol),dim(idim),quadrature);            
%                      filename        =  ['Line_QuadRule_' num2str(iquad) '_Q' num2str(ipol) '.mat'];
%                 case 2
%                      QuadFile        =  ['Quad_QuadRule_' num2str(iquad) '.mat'];
%                      load(QuadFile)
%                      quadrature.Chi  =  Chi;
%                      [N,DN_chi]      =  ShapeFunctionComputation(1,degree_polynomial(ipol),dim(idim),quadrature);            
%                      filename        =  ['Quad_QuadRule_' num2str(iquad) '_Q' num2str(ipol) '.mat'];
%                 case 3
%                      QuadFile        =  ['Hexa_QuadRule_' num2str(iquad) '.mat'];
%                      load(QuadFile)
%                      quadrature.Chi  =  Chi;
%                      [N,DN_chi]      =  ShapeFunctionComputation(1,degree_polynomial(ipol),dim(idim),quadrature);            
%                      filename        =  ['Hexa_QuadRule_' num2str(iquad) '_Q' num2str(ipol) '.mat'];
%             end
%             save(filename,'N','DN_chi')
%         end
%     end
% end
%--------------------------------------------------------------------------
% Shape functions and derivatives generator for triangles/tets
%--------------------------------------------------------------------------
for idim=2:size(dim,1)
    for ipol=1:size(degree_polynomial,1)
        for iquad=1:size(degree_quadrature,1)
            switch idim
                case 2
                     QuadFile        =  ['Tri_QuadRule_' num2str(iquad) '.mat'];
                     load(QuadFile)
                     quadrature.Chi  =  Chi;
                     [N,DN_chi]      =  ShapeFunctionComputation(0,degree_polynomial(ipol),dim(idim),quadrature);            
                     filename        =  ['Tri_QuadRule_' num2str(iquad) '_Q' num2str(ipol) '.mat'];
                case 3
                     QuadFile        =  ['Tet_QuadRule_' num2str(iquad) '.mat'];
                     load(QuadFile)
                     quadrature.Chi  =  Chi;
                     [N,DN_chi]      =  ShapeFunctionComputation(0,degree_polynomial(ipol),dim(idim),quadrature);            
                     filename        =  ['Tet_QuadRule_' num2str(iquad) '_Q' num2str(ipol) '.mat'];
            end
            save(filename,'N','DN_chi')
        end
    end
end



%
% 
