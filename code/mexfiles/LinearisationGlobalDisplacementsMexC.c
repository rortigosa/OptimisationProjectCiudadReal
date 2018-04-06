#include "mex.h"
#include "matfunctions.h"
#include "math.h"
/* */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* The C function */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void perfomer(mwSize dim,
        mwSize ngauss,
        mwSize n_node_elem,
        const double *NShape,
        const double *uGauss,
        const double *IntWeight,
        double *DI)
{
    /*-------------------------------------------------------------------*/
    /*Initialise stiffness matrices*/
    /*-------------------------------------------------------------------*/
    mwSize j;
    for (j=0; j<dim*n_node_elem; j++){
        DI[j]  =  0.;       
    }
    mwSize igauss, anode;
    /*-------------------------------------------------------------------*/
    /*Loop over Gauss points                                             */
    /*-------------------------------------------------------------------*/
    double uu, inv_uu_norm;
    for (igauss=0; igauss<ngauss; igauss++){
        uu             =  scalar_product(&uGauss[igauss*dim],&uGauss[igauss*dim],dim);
        inv_uu_norm    =  1./sqrt(uu);
        for (anode=0; anode<n_node_elem; anode++){
            /*PNX*/
            for (mwSize idim=0; idim<dim; idim++){
                DI[anode*dim + idim]  +=  (inv_uu_norm)*uGauss[igauss*dim + idim]*NShape[n_node_elem*igauss]*IntWeight[igauss];    
            }
        }    
    }
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
    const mwSize  *dims_N; 
    const mwSize  *dims_u; 
    double *NShape;  
    double *uGauss;  
    double *IntWeight; 
    /*-------------------------------------------------------------------*/
    /* outputs */
    /*-------------------------------------------------------------------*/
    double *DI;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dims_N             =  mxGetDimensions(prhs[0]);
    dims_u             =  mxGetDimensions(prhs[1]);    
    ngauss             =  (size_t)dims_N[1];    
    dim                =  (size_t)dims_u[0];    
    n_node_elem        =  (size_t)dims_u[1];    
    NShape             =  mxGetPr(prhs[0]);
    uGauss             =  mxGetPr(prhs[1]);
    IntWeight          =  mxGetPr(prhs[2]);
    /*-------------------------------------------------------------------*/
    /* get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    plhs[0]            =  mxCreateDoubleMatrix((mwSize)n_node_elem*dim, (mwSize)1, mxREAL);
    DI                 =  mxGetPr(plhs[0]);
    /*-------------------------------------------------------------------*/
    /* call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dim,(mwSize)ngauss,(mwSize)n_node_elem,NShape,uGauss,IntWeight,DI);
}


