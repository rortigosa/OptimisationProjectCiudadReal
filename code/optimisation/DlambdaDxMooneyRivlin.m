
function Residual       =  DlambdaDxMooneyRivlin(Optimisation,Solution,Quadrature,Mesh,FEM,Geometry,MatInfo,Assembly,formulation)

%rho                    =  Optimisation.density;
%rho_p                  =  rho.^Optimisation.penalty;
g                       =  ones(Mesh.volume.n_elem  ,1);

x                       =  Solution.x.Eulerian_x;
X                       =  Solution.x.Lagrangian_X;
connectivity            =  Mesh.volume.x.connectivity;
DNX                     =  FEM.volume.bilinear.x.DN_X;
IntWeight               =  Quadrature.volume.bilinear.IntWeight;
ngauss                  =  size(IntWeight,1);
dim                     =  Geometry.dim;
Identity                =  eye(dim);

mu1                     =  MatInfo.mu1; 
mu2                     =  MatInfo.mu2; 
kappa                   =  MatInfo.lambda; 

[~,Tdata]               =  SparseStiffnessPreallocationv2(Geometry,Mesh,formulation);
%--------------------------------------------------------------------------
% Loop over elements
%--------------------------------------------------------------------------
for ielem=1:Mesh.volume.n_elem  
    %----------------------------------------------------------------------
    % kinematics
    %----------------------------------------------------------------------
    x_elem              =  x(:,connectivity(:,ielem));
    X_elem              =  X(:,connectivity(:,ielem));
    [F,H,J]             =  KinematicsFunctionFinalMexC(x_elem,X_elem,DNX);
    %----------------------------------------------------------------------
    % Compute Piola and the Elasticity tensor for the nonlinear model
    %----------------------------------------------------------------------
    [~,Elasticity]     =  MooneyRivlinMexC(mu1,mu2,kappa,F,H,J);    
    H                  =  CofactorGauss(dim,ngauss,F);
    %----------------------------------------------------------------------
    % Compute
    %----------------------------------------------------------------------
    Tensor               =  zeros(dim,dim,ngauss);
    for igauss=1:ngauss
        %------------------------------------------------------------------
        %  Compute the eigenvalues and eigenvectors of the consistent
        %  elasticity tensor
        %------------------------------------------------------------------
        [V,D]          =  eig(Elasticity(:,:,igauss));
        eigenvalues    =  diag(D);
        I              =  find(eigenvalues<0);
        eigenvalues    =  eigenvalues(eigenvalues<0);
        eigenvectors   =  V(:,I);
        n_eigenvalues  =  size(eigenvectors,2);
        DfDC           =  zeros(dim^2,dim^2);
        %------------------------------------------------------------------
        % Derivative of the function f(eigenvalue) with respect to the
        % elasticity tensor C
        %------------------------------------------------------------------
        for ieig=1:n_eigenvalues
            %DfDeigenvalue =  eigenvalues(ieig);
            DfDeigenvalue  =  -1;
            %DeigenvalueDC  =  eigenvalues(ieig)*(eigenvectors(:,ieig)*eigenvectors(:,ieig)');
            DeigenvalueDC  =  (eigenvectors(:,ieig)*eigenvectors(:,ieig)');
            %DfDC          =  DfDC + DfDeigenvalue*(eigenvectors(:,ieig)*eigenvectors(:,ieig)');
            DfDC           =  DfDC + DfDeigenvalue*DeigenvalueDC;
        end
        %------------------------------------------------------------------
        % Mooney-Rivlin material
        %------------------------------------------------------------------
        WJJ           =  mu2  + (mu1 + 2*mu2)/J(igauss)^2 + kappa;
        WJJJ          =  -2*(mu1 + 2*mu2)/J(igauss)^3;
        %------------------------------------------------------------------
        % Intermediate tensors
        %------------------------------------------------------------------
        H_             =  H(:,:,igauss);
        H_DfDC_H       =  H_(:)'*(DfDC*H_(:));
        DfDC_II        =  DfDC(:)'*reshape(FourthOrderIdentityTensorOuter(dim) - FourthOrderIdentityTranspose(dim),[],1);
        I_DfDC_H       =  Identity(:)'*(DfDC*H_(:));
        H_DfDC_I       =  H_(:)'*(DfDC*Identity(:));
        DfDC_H         =  DfDC*H_(:);
        H_DfDC         =  H_(:)'*DfDC;
        
        DfDC_H         =  (reshape(DfDC_H,dim,dim))';
        H_DfDC         =  (reshape(H_DfDC,dim,dim))';
        DfDC_H         =  DfDC_H(:);
        H_DfDC         =  H_DfDC(:);
        
        B                   =  Identity*(I_DfDC_H + H_DfDC_I) - reshape(DfDC_H + H_DfDC,dim,dim);
        Tensor(:,:,igauss)  =  (WJJJ*H_DfDC_H)*H_ + WJJ*(B + DfDC_II*H_);
    end
    %----------------------------------------------------------------------    
    % Integrate the derivative of the eigenvalue with respect to x
    %----------------------------------------------------------------------    
    Tdata(:,ielem)  =  g(ielem)*ResidualsUFormulationMexC(DNX,Tensor,IntWeight);
end     
%--------------------------------------------------------------------------
% Sparse assembly of the residual.              
%--------------------------------------------------------------------------
Residual            =  sparse(Assembly.sparse.Tindexi,Assembly.sparse.Tindexj,Tdata,Solution.n_dofs,1);


