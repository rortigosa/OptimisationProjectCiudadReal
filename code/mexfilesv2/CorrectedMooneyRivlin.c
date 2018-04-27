#include "mex.h"
#include "matfunctions.h"
#include "TensorAlgebra.h"
#include "math.h"
/* */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* The C function */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void perfomer(mwSize dim,
        mwSize ngauss,
        double Jc,
        double mu1,
        double mu2,
        double lambda,
        const double *F,
        const double *H,
        const double *J,
        const double *Piola,
        const double *Hessian,
        double *Piola_c,
        double *Hessian_c)
{
    /*-------------------------------------------------------------------*/
    /*The C function*/
    /*-------------------------------------------------------------------*/
    double *I_iIjJ           = (double*)malloc(sizeof(double)*(dim*dim*dim*dim));    
    double *I_iJjI           = (double*)malloc(sizeof(double)*(dim*dim*dim*dim));    
    double *Tensor1          = (double*)malloc(sizeof(double)*(dim*dim*dim*dim));
    double *Tensor2          = (double*)malloc(sizeof(double)*(dim*dim*dim*dim));
    double *Hessian1         = (double*)malloc(sizeof(double)*(dim*dim*dim*dim));
    double *Hessian2         = (double*)malloc(sizeof(double)*(dim*dim*dim*dim));

    double WJ_, WJJ_;
    double WJ, WJJ, WJc, WJJc;
    for (mwSize igauss=0; igauss<ngauss; igauss++) {
        /*---------------------------------------------------------------*/
        /* Corrected terms*/
        /*---------------------------------------------------------------*/
        WJ      =  - (mu1 + 2.*mu2)/J[igauss];
        WJJ     =    (mu1 + 2.*mu2)/(J[igauss]*J[igauss]);           
        if (J[igauss]>=Jc){
           WJ_   =  WJ;
           WJJ_  =  WJJ;           
        }
        else {
           double a1, a2, a3, fc, fpc, fppc;
           fc    =  - (mu1 + 2.*mu2)*log(Jc);
           fpc   =  - (mu1 + 2.*mu2)/Jc;
           fppc  =    (mu1 + 2.*mu2)/pow(Jc,2);
           a1    =  fppc/2.;
           a2    =  fpc - 2.*a1*Jc;
           a3    =  fc - a1*pow(Jc,2) - a2*Jc;               
           WJ_   =  2*a1*J[igauss] + a2;  
           WJJ_  =  2*a1;  
        }            
        /*---------------------------------------------------------------*/
        /* Corrected Piola*/
        /*---------------------------------------------------------------*/
        WJc      =  WJ_  -  WJ;
        WJJc     =  WJJ_ -  WJJ;
        for (mwSize idim=0; idim<dim*dim; idim++){
           Piola_c[idim + dim*dim*igauss]  =  Piola[idim + dim*dim*igauss]  + WJc*H[idim + dim*dim*igauss];       
        }
        /*---------------------------------------------------------------*/
        /* Corrected Hessian*/
        /*---------------------------------------------------------------*/
        Outer_22_(dim, &H[igauss*dim*dim], &H[igauss*dim*dim], Tensor1);
        MatScalarmul((size_t)dim*dim*dim*dim, WJJc, Tensor1, Tensor2);        
        matsum((size_t)dim*dim, (size_t)dim*dim, &Hessian[igauss*dim*dim*dim*dim], Tensor2, Hessian1);
        /*---------------------------------------------------------------*/
        /* Corrected (geometric) Hessian*/
        /*---------------------------------------------------------------*/
        if (dim==2){
           FourthOrderIdentity_iIjJ(dim,I_iIjJ);
           FourthOrderIdentity_iJjI(dim,I_iJjI);
           matsubs((size_t)dim*dim, (size_t)dim*dim, I_iIjJ, I_iJjI, Tensor2);
        }
        else if (dim==3){
           Cross_IdentityMatrix_42_(dim, &F[dim*dim*igauss],Tensor2);
        }
        MatScalarmul((size_t)dim*dim*dim*dim, WJc, Tensor2, Hessian2);
        /*---------------------------------------------------------------*/
        /* Add material and geometrical contributions*/
        /*---------------------------------------------------------------*/
        matsum((size_t)dim*dim, (size_t)dim*dim, Hessian1, Hessian2, &Hessian_c[igauss*dim*dim*dim*dim]);
    }    
    free(I_iIjJ);    
    free(I_iJjI);    
    free(Tensor1);    
    free(Tensor2);    
    free(Hessian1);    
    free(Hessian2);    
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
    const mwSize  *dims_F;     
    double *Jc_;
    double Jc;
    double *mu1_, *mu2_, *lambda_;
    double mu1, mu2, lambda;
    double *F;    
    double *H;    
    double *J;    
    double *Piola;
    double *Hessian;
    /*-------------------------------------------------------------------*/
    /* outputs of the C function (computational routine)*/
    /*-------------------------------------------------------------------*/
    double *Piola_c;
    double *Hessian_c;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dims_F             =  mxGetDimensions(prhs[4]);
    dim                =  (size_t)dims_F[0];    
    ngauss             =  (size_t)dims_F[2];    
    Jc_                =  mxGetPr(prhs[0]);
    Jc                 =  Jc_[0];
    mu1_               =  mxGetPr(prhs[1]);
    mu2_               =  mxGetPr(prhs[2]);
    lambda_            =  mxGetPr(prhs[3]);
    mu1                =  mu1_[0];
    mu2                =  mu2_[0];
    lambda             =  lambda_[0];
    F                  =  mxGetPr(prhs[4]);   
    H                  =  mxGetPr(prhs[5]);
    J                  =  mxGetPr(prhs[6]);
    Piola              =  mxGetPr(prhs[7]);   
    Hessian            =  mxGetPr(prhs[8]);   
    /*-------------------------------------------------------------------*/
    /* Get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    mwSize PDims[3]    =  {dim,dim,ngauss};            
    mwSize HDims[3]    =  {dim*dim,dim*dim,ngauss};            
    plhs[0]            =  mxCreateNumericArray(3,PDims, mxDOUBLE_CLASS, mxREAL);    /*F*/      
    plhs[1]            =  mxCreateNumericArray(3,HDims, mxDOUBLE_CLASS, mxREAL);    /*F*/  

    Piola_c            =  mxGetPr(plhs[0]);
    Hessian_c          =  mxGetPr(plhs[1]);
    /*-------------------------------------------------------------------*/
    /* Call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dim,(mwSize)ngauss, Jc, mu1, mu2, lambda, F, H, J, Piola, Hessian, Piola_c, Hessian_c);
}


