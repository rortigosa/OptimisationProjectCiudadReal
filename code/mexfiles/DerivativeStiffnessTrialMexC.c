#include "mex.h"
#include "matfunctions.h"
#include "TensorAlgebra.h"


/* */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* The C function */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void perfomer(mwSize dim,
        mwSize ngauss,
        mwSize n_node_elem,
        const double *DNX,
        const double *EigenVector,
        const double *SixthOrderTensor,
        const double *IntWeight,
        double *DK)
{
    /*-------------------------------------------------------------------*/
    /*Temporaries*/
    /*-------------------------------------------------------------------*/
    double *Tensor4      = (double*)malloc(sizeof(double)*(dim*dim*dim*dim));
    double *Tensor2      = (double*)malloc(sizeof(double)*(dim*dim));
    double *TensorDNXc   = (double*)malloc(sizeof(double)*(dim));
    /*-------------------------------------------------------------------*/
    /*Initialise residual*/
    /*-------------------------------------------------------------------*/
    mwSize j;
    for (j=0; j<dim*n_node_elem; j++){
        DK[j]  =  0.;       
    }
    mwSize igauss, anode, bnode, cnode;
    /*-------------------------------------------------------------------*/
    /* The function for 2D*/
    /*-------------------------------------------------------------------*/
    if (dim==2){
        for (igauss=0; igauss<ngauss; igauss++){
            /*-----------------------------------------------------------*/
            /* DK                                                        */            
            /*-----------------------------------------------------------*/
            for (cnode=0; cnode<n_node_elem; cnode++){
                for (anode=0; anode<n_node_elem; anode++){
                    for (bnode=0; bnode<n_node_elem; bnode++){
                        /*-----------------------------------------------*/
                        /*Compute fourth order tensor: phia*DNa*phib*DNb */
                        /*-----------------------------------------------*/
                        outer_1_1_1_1_(dim,&EigenVector[dim*anode],&DNX[dim*n_node_elem*igauss + dim*anode],&EigenVector[dim*bnode],&DNX[dim*n_node_elem*igauss + dim*bnode],Tensor4);
                        contraction_4_6_(dim,Tensor4,&SixthOrderTensor[dim*dim*dim*dim*dim*dim*igauss],Tensor2);                        
                        matmul(dim,dim,(mwSize)1,Tensor2,&DNX[dim*n_node_elem*igauss + dim*cnode],TensorDNXc);
                        /*-----------------------------------------------*/
                        /*Elements of the vector                         */                    
                        /*-----------------------------------------------*/
                        DK[dim*cnode + 0]  +=  TensorDNXc[0]*IntWeight[igauss];
                        DK[dim*cnode + 1]  +=  TensorDNXc[1]*IntWeight[igauss];
                    }
                }            
            }
        }
    }
    /*-------------------------------------------------------------------*/
    /* The function for 3D*/
    /*-------------------------------------------------------------------*/
    else if (dim==3){
        for (igauss=0; igauss<ngauss; igauss++){
            /*-----------------------------------------------------------*/
            /* DK                                                        */            
            /*-----------------------------------------------------------*/
            for (cnode=0; cnode<n_node_elem; cnode++){
                for (anode=0; anode<n_node_elem; anode++){
                    for (bnode=0; bnode<n_node_elem; bnode++){
                        /*-----------------------------------------------*/
                        /*Compute fourth order tensor: phia*DNa*phib*DNb */
                        /*-----------------------------------------------*/
                        //outer_1_1_1_1_(dim,&EigenVector[dim*anode],&DNX[dim*n_node_elem*igauss + dim*anode],&EigenVector[dim*bnode],&DNX[dim*n_node_elem*igauss + dim*bnode],Tensor4);
                        //contraction_4_6_(dim,Tensor4,&SixthOrderTensor[dim*dim*dim*dim*dim*dim*dim*igauss],Tensor2);                        
                        //matmul(dim,dim,(mwSize)1,Tensor2,&DNX[dim*n_node_elem*igauss + dim*cnode],TensorDNXc);
                        /*-----------------------------------------------*/
                        /*Elements of the vector                         */                    
                        /*-----------------------------------------------*/
                        //DK[dim*cnode + 0]  +=  TensorDNXc[0]*IntWeight[igauss];
                        //DK[dim*cnode + 1]  +=  TensorDNXc[1]*IntWeight[igauss];
                        //DK[dim*cnode + 2]  +=  TensorDNXc[2]*IntWeight[igauss];
                        DK[dim*cnode + 0]  +=  IntWeight[igauss];
                        DK[dim*cnode + 1]  +=  IntWeight[igauss];
                        DK[dim*cnode + 2]  +=  IntWeight[igauss];
                    }
                }            
            }
        }
    }
    /*-------------------------------------------------------------------*/
    /*Free temporaries                                                   */
    /*-------------------------------------------------------------------*/
    free(Tensor4);
    free(Tensor2);
    free(TensorDNXc);
}
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* The gateway function */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
    /*-------------------------------------------------------------------*/
    /*Inputs and declaration*/
    /*-------------------------------------------------------------------*/
    size_t dim, ngauss, n_node_elem;
    const mwSize  *dims_DNX; 
    double *DNX;  
    double *EigenVector;
    double *SixthOrderTensor;  
    double *IntWeight; 
    /*-------------------------------------------------------------------*/
    /* outputs */
    /*-------------------------------------------------------------------*/
    double *DK;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dims_DNX           =  mxGetDimensions(prhs[0]);
    dim                =  (size_t)dims_DNX[0];    
    n_node_elem        =  (size_t)dims_DNX[1];    
    ngauss             =  (size_t)dims_DNX[2];    
    DNX                =  mxGetPr(prhs[0]);
    EigenVector        =  mxGetPr(prhs[1]);
    SixthOrderTensor   =  mxGetPr(prhs[2]);
    IntWeight          =  mxGetPr(prhs[3]);
    /*-------------------------------------------------------------------*/
    /* get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    plhs[0]            =  mxCreateDoubleMatrix((mwSize)n_node_elem*dim, (mwSize)1, mxREAL);
    DK                 =  mxGetPr(plhs[0]);
    /*-------------------------------------------------------------------*/
    /* call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dim,(mwSize)ngauss,(mwSize)n_node_elem, DNX, EigenVector, SixthOrderTensor, IntWeight, DK);
}


