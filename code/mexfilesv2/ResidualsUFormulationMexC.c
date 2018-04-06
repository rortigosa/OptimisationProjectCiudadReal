#include "mex.h"
#include "matfunctions.h"

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
        const double *Piola,
        const double *IntWeight,
        double *Rx)
{
    /*-------------------------------------------------------------------*/
    /*Temporaries within the C function*/
    /*-------------------------------------------------------------------*/
    double *PDNX      = (double*)malloc(sizeof(double)*(dim));
    /*-------------------------------------------------------------------*/
    /*Initialise stiffness matrices*/
    /*-------------------------------------------------------------------*/
    mwSize j;
    for (j=0; j<dim*n_node_elem; j++){
        Rx[j]  =  0.;       
    }
    mwSize igauss, anode;
    /*-------------------------------------------------------------------*/
    /*Loop over Gauss points                                             */
    /*-------------------------------------------------------------------*/
    for (igauss=0; igauss<ngauss; igauss++){
        /*---------------------------------------------------------------*/
        /* Residual for x                                                */
        /*---------------------------------------------------------------*/
        for (anode=0; anode<n_node_elem; anode++){
            /*PNX*/
            matmul(dim,dim,(mwSize)1,&Piola[dim*dim*igauss],&DNX[dim*n_node_elem*igauss + dim*anode],PDNX);
            for (mwSize idim=0; idim<dim; idim++){
                Rx[anode*dim + idim]  +=  PDNX[idim]*IntWeight[igauss];    
            }
        }    
    }
    free(PDNX);
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
    double *Piola;  
    double *IntWeight; 
    /*-------------------------------------------------------------------*/
    /* outputs */
    /*-------------------------------------------------------------------*/
    double *Rx;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dims_DNX           =  mxGetDimensions(prhs[0]);
    dim                =  (size_t)dims_DNX[0];    
    n_node_elem        =  (size_t)dims_DNX[1];    
    ngauss             =  (size_t)dims_DNX[2];    
    DNX                =  mxGetPr(prhs[0]);
    Piola              =  mxGetPr(prhs[1]);
    IntWeight          =  mxGetPr(prhs[2]);
    /*-------------------------------------------------------------------*/
    /* get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    plhs[0]            =  mxCreateDoubleMatrix((mwSize)n_node_elem*dim, (mwSize)1, mxREAL);
    Rx                 =  mxGetPr(plhs[0]);
    /*-------------------------------------------------------------------*/
    /* call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dim,(mwSize)ngauss,(mwSize)n_node_elem,DNX,Piola,IntWeight,Rx);
}


