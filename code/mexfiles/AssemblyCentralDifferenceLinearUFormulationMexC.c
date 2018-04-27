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
        mwSize n_node_elem,
        mwSize n_nodes,
        mwSize n_elem,
        const double *void_factor,
        const double *rho_p,
        const double *connectivity,
        const double *x,
        const double *X,
        const double *Klinear,
        double *TInternal)
{
// void perfomer(mwSize dim,
//         mwSize n_node_elem,
//         mwSize n_nodes,
//         mwSize n_elem,
//         const double *void_factor,
//         const double *rho_p,
//         const double *connectivity,
//         const double *x,
//         const double *X,
//         const double *Klinear,
//         double *dofs)
// {
    /*-------------------------------------------------------------------*/
    /*Temporaries*/
    /*-------------------------------------------------------------------*/
    double *Rx           = (double*)malloc(sizeof(double)*(dim*n_node_elem));
    double *dofs         = (double*)malloc(sizeof(double)*(dim*n_node_elem));
    double *u_elem       = (double*)malloc(sizeof(double)*(dim*n_node_elem));
    /*-------------------------------------------------------------------*/
    /*Initialisation of the residual*/
    /*-------------------------------------------------------------------*/
    for (mwSize i=0; i<dim*n_nodes; i++){
        TInternal[i]  =  0.;
    }
    /*-------------------------------------------------------------------*/
    /*The C function*/
    /*-------------------------------------------------------------------*/
    mwSize ielem;
    mwSize node;         //
    double hom_factor;  //homogenisation factor
    for (ielem=0; ielem<n_elem; ++ielem) {
        /*---------------------------------------------------------------*/
        /*Get displacemen ts*/
        /*---------------------------------------------------------------*/
        for (mwSize inode=0; inode<n_node_elem; inode++){
            node  =  (mwSize)(connectivity[ielem*n_node_elem + inode]-1);
            for (mwSize idim=0; idim<dim; idim++){
                u_elem[idim + inode*dim]  =  x[idim + dim*node] - X[idim + dim*node];
                dofs[idim+inode*dim]   =  idim + dim*node;
            }
        }
//         /*---------------------------------------------------------------*/
//         /*Get residual*/
//         /*---------------------------------------------------------------*/
         matmul(dim*n_node_elem,dim*n_node_elem,(mwSize)1,Klinear,u_elem,Rx);
//         /*---------------------------------------------------------------*/
//         /*Assembled residual*/
//         /*---------------------------------------------------------------*/
        hom_factor    =  rho_p[ielem] + (1. - rho_p[ielem])*void_factor[0];
        for (mwSize idof=0; idof<dim*n_node_elem; idof++){
            //TInternal[(mwSize)dofs[idof]] += hom_factor*Rx[idof];     
            TInternal[(mwSize)dofs[idof]] += hom_factor*Rx[idof];     
        }
    }
    /*-------------------------------------------------------------------*/
    /* Free temporaries*/
    /*-------------------------------------------------------------------*/
    free(Rx);
    free(dofs);
    free(u_elem);
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
    /*Inputs of the C function*/
    /*-------------------------------------------------------------------*/
    size_t dim, n_node_elem, n_nodes, n_elem;
    double *dim_, *n_node_elem_, *n_nodes_, *n_elem_;
    double *void_factor;
    double *rho_p;
    double *connectivity;
    double *x;
    double *X;
    double *Klinear;    
    /*-------------------------------------------------------------------*/
    /* outputs of the C function (computational routine)*/
    /*-------------------------------------------------------------------*/
    double *TInternal;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dim_               =  mxGetPr(prhs[0]);
    n_node_elem_       =  mxGetPr(prhs[1]); 
    n_nodes_           =  mxGetPr(prhs[2]); 
    n_elem_            =  mxGetPr(prhs[3]); 
    void_factor        =  mxGetPr(prhs[4]);
    rho_p              =  mxGetPr(prhs[5]);
    connectivity       =  mxGetPr(prhs[6]);
    x                  =  mxGetPr(prhs[7]);
    X                  =  mxGetPr(prhs[8]);
    Klinear            =  mxGetPr(prhs[9]);
    
    dim                =  dim_[0];
    n_node_elem        =  n_node_elem_[0];
    n_nodes            =  n_nodes_[0];
    n_elem             =  n_elem_[0];
    /*-------------------------------------------------------------------*/
    /* Pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    plhs[0]            =  mxCreateDoubleMatrix((mwSize)n_nodes*dim,(mwSize)1, mxREAL);  
    TInternal          =  mxGetPr(plhs[0]);
    /*-------------------------------------------------------------------*/
    /* Call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dim,(mwSize)n_node_elem,(mwSize)n_nodes,(mwSize)n_elem, void_factor, rho_p, connectivity, x, X, Klinear, TInternal);
}

