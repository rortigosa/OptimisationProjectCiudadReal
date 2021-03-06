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
        const double *Elasticity,
        double *stability,
        double *minimum_gauss,
        double *absolute_minimum)
{
    /*-------------------------------------------------------------------*/
    /*Temporaries within the C function*/
    /*-------------------------------------------------------------------*/
//    double *stability_vector  = (double*)malloc(sizeof(double)*(ngauss));
    double *minimum_vector    = (double*)malloc(sizeof(double)*(dim*dim));
    /*-------------------------------------------------------------------*/
    /*The C function*/
    /*-------------------------------------------------------------------*/
    mwSize igauss, total_dim;
    total_dim  =  (dim*dim)*(dim*dim);
    if (dim==2){
        double A00, A01, A02, A03, A10, A11, A12, A13, A20, A21, A22, A23, A30, A31, A32, A33;
        double minor1, minor2, minor3, minor4;
        double min1, min2, min3;
        for (igauss=0; igauss<ngauss; ++igauss) {
            /*  Components of the Hessian */
            A00  =  Elasticity[0  + total_dim*igauss];            
            A10  =  Elasticity[1  + total_dim*igauss];            
            A20  =  Elasticity[2  + total_dim*igauss];            
            A30  =  Elasticity[3  + total_dim*igauss];            
            A01  =  Elasticity[4  + total_dim*igauss];            
            A11  =  Elasticity[5  + total_dim*igauss];            
            A21  =  Elasticity[6  + total_dim*igauss];            
            A31  =  Elasticity[7  + total_dim*igauss];            
            A02  =  Elasticity[8  + total_dim*igauss];            
            A12  =  Elasticity[9  + total_dim*igauss];            
            A22  =  Elasticity[10 + total_dim*igauss];            
            A32  =  Elasticity[11 + total_dim*igauss];            
            A03  =  Elasticity[12 + total_dim*igauss];            
            A13  =  Elasticity[13 + total_dim*igauss];            
            A23  =  Elasticity[14 + total_dim*igauss];            
            A33  =  Elasticity[15 + total_dim*igauss];            
            /* First minor */
            minimum_vector[0]  =  A00;
            /* Second minor */
            minimum_vector[1]  =  A00*A11 - A01*A10;
            /* Third minor */
            minimum_vector[2]  =  A00*A11*A22 - A00*A12*A21 - A01*A10*A22 + 
                                  A01*A12*A20 + A02*A10*A21 - A02*A11*A20;
            /* Fourth minor */
            minimum_vector[3]  =  A00*A11*A22*A33 - A00*A11*A23*A32 - 
                                  A00*A12*A21*A33 + A00*A12*A23*A31 + 
                                  A00*A13*A21*A32 - A00*A13*A22*A31 - 
                                  A01*A10*A22*A33 + A01*A10*A23*A32 + 
                                  A01*A12*A20*A33 - A01*A12*A23*A30 - 
                                  A01*A13*A20*A32 + A01*A13*A22*A30 + 
                                  A02*A10*A21*A33 - A02*A10*A23*A31 - 
                                  A02*A11*A20*A33 + A02*A11*A23*A30 + 
                                  A02*A13*A20*A31 - A02*A13*A21*A30 - 
                                  A03*A10*A21*A32 + A03*A10*A22*A31 + 
                                  A03*A11*A20*A32 - A03*A11*A22*A30 - 
                                  A03*A12*A20*A31 + A03*A12*A21*A30;            
            /*-----------------------------------------------------------*/
            /*Select the least of the minors */
            /*-----------------------------------------------------------*/
            minimum_gauss[igauss]  =  sequential_minimum_vector(minimum_vector,dim*dim);
            //minimum_gauss[igauss]  =  minimum_vector[3];
            //stability_vector[igauss]  =  minimum_vector[0];
        }
    }
    else if (dim==3){
       /*Not implemented yet*/
    }  
    /*-------------------------------------------------------------------*/
    /* Select the least of the least minor at all Gauss points           /*
    /*-------------------------------------------------------------------*/
    absolute_minimum[0]   =  sequential_minimum_vector(minimum_gauss,ngauss);    
    //absolute_minimum[0]   =  minimum_gauss[2];    
    stability[0]       =  1.0;
    if (absolute_minimum[0]<=0){
       stability[0]    =  0.0;
    }
    /*-------------------------------------------------------------------*/
    /* Free temporaries*/
    /*-------------------------------------------------------------------*/
//    free(stability_vector);
    free(minimum_vector);
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
    size_t dim, ngauss;
    //const mwSize  *dim_, *ngauss_;      /* input scalar */
    double *dim_, *ngauss_;
    double *Elasticity;    
    /*-------------------------------------------------------------------*/
    /* outputs of the C function (computational routine)*/
    /*-------------------------------------------------------------------*/
    double *stability;
    double *minimum_gauss;
    double *absolute_minimum;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dim_               =  mxGetPr(prhs[0]);
    dim                =  (size_t)dim_[0];    
    ngauss_            =  mxGetPr(prhs[1]);
    ngauss             =  (size_t)ngauss_[0];
    Elasticity         =  mxGetPr(prhs[2]);   
    /*-------------------------------------------------------------------*/
    /* Get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    plhs[0]            =  mxCreateDoubleMatrix((mwSize)1,(mwSize)1, mxREAL);
    plhs[1]            =  mxCreateDoubleMatrix((mwSize)ngauss,(mwSize)1, mxREAL);
    plhs[2]            =  mxCreateDoubleMatrix((mwSize)1,(mwSize)1, mxREAL);
    stability          =  mxGetPr(plhs[0]);
    minimum_gauss      =  mxGetPr(plhs[1]);
    absolute_minimum   =  mxGetPr(plhs[2]);
    /*-------------------------------------------------------------------*/
    /* Call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dim,(mwSize)ngauss, Elasticity, stability, minimum_gauss, absolute_minimum);
}


