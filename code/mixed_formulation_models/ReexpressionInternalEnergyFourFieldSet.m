
function derivatives                         =  ReexpressionInternalEnergyFourFieldSet(dim,n_gauss,D0,derivatives,F,vectorisation)

D0_matrix                                    =  zeros(dim,dim^2);
QSigmad                                      =  zeros(dim,dim^2);
LHS_indices_D0                               =  vectorisation.vector2matrix_rowwise.LHS_indices;
RHS_indices_D0                               =  vectorisation.vector2matrix_rowwise.RHS_indices;
LHS_indices_Sigmad                           =  vectorisation.vector2matrix_colwise.LHS_indices;
RHS_indices_Sigmad                           =  vectorisation.vector2matrix_colwise.RHS_indices;

for igauss=1:n_gauss
    D0_matrix(LHS_indices_D0)                =  D0(RHS_indices_D0,igauss);
    QSigmad(LHS_indices_Sigmad)              =  derivatives.DU.DUDd(RHS_indices_Sigmad,igauss);    
    
    
    derivatives.D2Uhat.D2UDFDF(:,:,igauss)   =  derivatives.D2U.D2UDFDF(:,:,igauss)  + ...
                                                derivatives.D2U.D2UDFDd(:,:,igauss)*D0_matrix + D0_matrix'*derivatives.D2U.D2UDdDF(:,:,igauss)  + ...
                                                D0_matrix'*derivatives.D2U.D2UDdDd(:,:,igauss)*D0_matrix;
    derivatives.D2Uhat.D2UDFDH(:,:,igauss)   =  derivatives.D2U.D2UDFDH(:,:,igauss)  + D0_matrix'*derivatives.D2U.D2UDdDH(:,:,igauss);
    derivatives.D2Uhat.D2UDFDJ(:,:,igauss)   =  derivatives.D2U.D2UDFDJ(:,:,igauss)  + D0_matrix'*derivatives.D2U.D2UDdDJ(:,:,igauss);
    derivatives.D2Uhat.D2UDFDD0(:,:,igauss)  =  derivatives.D2U.D2UDFDD0(:,:,igauss) + ...
                                                derivatives.D2U.D2UDFDd(:,:,igauss)*F(:,:,igauss) + ...
                                                D0_matrix'*derivatives.D2U.D2UDdDD0(:,:,igauss) + ...
                                                D0_matrix'*derivatives.D2U.D2UDdDd(:,:,igauss)*F(:,:,igauss) + QSigmad';
    
    derivatives.D2Uhat.D2UDHDF(:,:,igauss)   =  derivatives.D2Uhat.D2UDFDH(:,:,igauss)';
    derivatives.D2Uhat.D2UDHDH(:,:,igauss)   =  derivatives.D2U.D2UDHDH(:,:,igauss);
    derivatives.D2Uhat.D2UDJDH(:,:,igauss)   =  derivatives.D2U.D2UDHDJ(:,:,igauss);
    derivatives.D2Uhat.D2UDHDD0(:,:,igauss)  =  derivatives.D2U.D2UDHDD0(:,:,igauss) + derivatives.D2U.D2UDHDd(:,:,igauss)*F(:,:,igauss);
    
    derivatives.D2Uhat.D2UDJDF(:,:,igauss)   =  derivatives.D2Uhat.D2UDFDJ(:,:,igauss)';
    derivatives.D2Uhat.D2UDJDH(:,:,igauss)   =  derivatives.D2Uhat.D2UDHDJ(:,:,igauss)';
    derivatives.D2Uhat.D2UDJDJ(igauss)       =  derivatives.D2U.D2UDJDJ(igauss);
    derivatives.D2Uhat.D2UDJDD0(:,:,igauss)  =  derivatives.D2U.D2UDJDD0(:,:,igauss) + derivatives.D2U.D2UDJDd(:,:,igauss)*F(:,:,igauss);
    
    derivatives.D2Uhat.D2UDD0DF(:,:,igauss)  =  derivatives.D2Uhat.D2UDFDD0(:,:,igauss)';
    derivatives.D2Uhat.D2UDD0DH(:,:,igauss)  =  derivatives.D2Uhat.D2UDHDD0(:,:,igauss)';
    derivatives.D2Uhat.D2UDD0DJ(:,:,igauss)  =  derivatives.D2Uhat.D2UDJDD0(:,:,igauss)';
    derivatives.D2Uhat.D2UDD0DD0(:,:,igauss) =  derivatives.D2U.D2UDD0DD0(:,:,igauss) + ...
                                                derivatives.D2U.D2UDD0Dd(:,:,igauss)*F(:,:,igauss) + ...
                                                F(:,:,igauss)'*derivatives.D2U.D2UDdDD0(:,:,igauss) + ...
                                                F(:,:,igauss)'*derivatives.D2U.D2UDdDd(:,:,igauss)*F(:,:,igauss);
end



