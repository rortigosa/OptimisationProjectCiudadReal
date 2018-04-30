
function DKMatLab  =  DerivativeStiffnessMatLab(dim,n_node_elem,ngauss,DNX,EigenVector,SixthOrderTensor,IntWeight)

DKMatLab  =  zeros(dim,n_node_elem);
for igauss=1:ngauss
    for cnode=1:n_node_elem
        for anode=1:n_node_elem
            for bnode=1:n_node_elem
                for i=1:dim
                    for I=1:dim
                        for j=1:dim
                            for J=1:dim
                                for p=1:dim
                                    for P=1:dim
                                        DKMatLab(p,cnode)  =  DKMatLab(p,cnode) + SixthOrderTensor(i,I,j,J,p,P,igauss)*EigenVector(i,anode)*DNX(I,anode,igauss)*...
                                                                      EigenVector(j,bnode)*DNX(J,bnode,igauss)*DNX(P,cnode,igauss)*IntWeight(igauss);                
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
DKMatLab  =  DKMatLab(:);
 

