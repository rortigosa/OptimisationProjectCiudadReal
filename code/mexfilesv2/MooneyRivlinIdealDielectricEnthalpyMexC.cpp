#include "mex.h"
#include "FastorHelper.h"

/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* The C function */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
template<size_t ndim>
void MooneyRivlin(double mu1,
        double mu2,
        double lambda,
        double epsilon,
        const double *F_m,
        const double *H_m,
        double J_m,
        double *E0_m,
        double *P_m,
        double *D0_m,
        double *Elasticity_m,
        double *PiezoTensor_m,
        double *DielTensor_m);
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/*C FUNCTION FOR 2D PROBLEMS*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
template<>
void MooneyRivlin<2>(double mu1,
        double mu2,
        double lambda,
        double epsilon,
        const double *F_m,
        const double *H_m,
        double J_m,
        double *E0_m,
        double *P_m,
        double *D0_m,
        double *Elasticity_m,
        double *PiezoTensor_m,
        double *DielTensor_m)
{
    /*-------------------------------------------------------------------*/
    /*Dimension of the problem*/
    /*-------------------------------------------------------------------*/
    const mwSize  ndim  =  2;
    /*-------------------------------------------------------------------*/
    /*Copy from C to Fastor*/
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim> F;
    Tensor<double,ndim,ndim> H;
    Tensor<double,ndim,1> E0;
    copy_matlab(F,F_m);
    copy_matlab(H,H_m);
    copy_matlab(E0,E0_m);
    double J = J_m;
    /*-------------------------------------------------------------------*/    
    // IDENTITY SECOND ORDER TENSOR
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim> Imatrix; Imatrix.eye();
    /*-------------------------------------------------------------------*/
    // AUXILIARY TENSORS
    /*-------------------------------------------------------------------*/
//     Tensor<double,ndim,ndim> HT      =  transpose(H);
//     Tensor<double,ndim,ndim> HTH     =  matmul(H,HT); // Always transpose of what it's intended
//     Tensor<double,ndim,1> HTHE0      =  matmul(HTH,E0); //Not sure about this
//     Tensor<double,ndim,1> HE0        =  matmul(H,E0);
//     Tensor<double,ndim,1> HTE0       =  matmul(HT,E0);
//     Tensor<double,ndim,ndim> E0_HE0  =  dyadic(E0,HE0); // PROBABLY THE OPPOSITE
//     Tensor<double,ndim,ndim> HE0_HE0 =  dyadic(HE0,HE0);
//     Tensor<double,ndim,ndim> E0_E0   =  dyadic(E0,E0);
//     double E0_HE0_invariant          =  trace(E0_HE0);    
//     double HE0_HE0_invariant         =  trace(HE0_HE0);
//     double E0_E0_invariant           =  trace(E0_E0);
    /*-------------------------------------------------------------------*/
    // COMPUTE FIRST DERIVATIVES OF THE MODEL    
    /*-------------------------------------------------------------------*/
//     Tensor<double,ndim,ndim> WF  =  (mu1 + mu2)*F - epsilon/J*(E0_HE0_invariant*Imatrix - E0_HE0);
//     double WJ =  -(mu1 + 2.*mu2)/J + lambda*(J - 1.) + mu2*J + epsilon/(2.*(J*J)*HE0_HE0_invariant;    
    /*-------------------------------------------------------------------*/
    // COMPUTE FIRST PIOLA AND THE ELECTRIC DISPLACEMENT
    /*-------------------------------------------------------------------*/    
//     Tensor<double,ndim,ndim> P    =  WF + WJ*H;    
//     Tensor<double,ndim,1>    D0   =  epsilon*J*HTHE0;
    /*-------------------------------------------------------------------*/    
    // AUXILIARY VARIABLES NEEDED
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim,ndim,ndim> I_I      =  outer(Imatrix,Imatrix);               //delta_iI*delta_jJ 
    Tensor<double,ndim,ndim,ndim,ndim> I4D      =  permutation<Index<1,3,2,4>>(I_I);     //delta_ij*delta_IJ    
    Tensor<double,ndim,ndim,ndim,ndim> I4DT     =  permutation<Index<2,3,1,4>>(I_I);     //delta_iJ*delta_jI   
//     Tensor<double,ndim,ndim,ndim,ndim> I_E0E0   =  outer(E0_E0,Imatrix);                 //delta_iI*(E0xE0)_jJ
//     Tensor<double,ndim,ndim,ndim,ndim> E0E0_I   =  outer(Imatrix,E0_E0);                 //(E0xE0)_iI*delta_jJ
//     Tensor<double,ndim,ndim,ndim,ndim> E0E0_I4  =  permutation<Index<1,3,2,4>>(E0E0_I);  // (E0xE0)_ij*delta_IJ 
    /*-------------------------------------------------------------------*/    
    // ELASTICITY TENSOR
    /*-------------------------------------------------------------------*/            
//     Tensor<double,ndim,ndim,ndim,ndim> WFF  =  (mu1 + mu2)*I4D - epsilon/J*(E0_E0_invariant*I4 - I_E0E0 - E0E0_I + E0E0_I4);
//     double WJJ =  (mu1 + 2.*mu2)/(J*J) + lambda + mu2 - epsilon/(J*J*J)*HE0_HE0_invariant;    
//     Tensor<double,ndim,ndim>  WFJ = epsilon/(J*J)*(E0_HE0_invariant*Imatrix - E0_HE0);
//     Tensor<double,ndim,ndim,ndim,ndim>  WFJ_H  =  outer(H,WFJ);
//     Tensor<double,ndim,ndim,ndim,ndim>  H_WJF  =  transpose(WFJ_H);
//         
//     Tensor<double,ndim,ndim,ndim,ndim> H_H  =  outer(H,H);        
//     Tensor<double,ndim,ndim,ndim,ndim> C_Geom  =  WJ*(I_I - I4DT); 
//    Tensor<double,ndim,ndim,ndim,ndim> Elasticity4D  =  einsum<Index<1,2,3,4>,Index<3,4,5,6>>(I_I,I_I);
    Tensor<double,ndim,ndim,ndim,ndim> Elasticity4D  =  I_I;
//    Tensor<double,ndim,ndim,ndim,ndim> Elasticity4D  =  I4D;        
//    Tensor<double,ndim,ndim,ndim,ndim> Elasticity4D  =  WFF + WJJ*H_H + WFJ_H + H_WJF + C_Geom;    
    Tensor<double,ndim*ndim,ndim*ndim> Elasticity  =  reshape<ndim*ndim,ndim*ndim>(Elasticity4D);
    /*-------------------------------------------------------------------*/    
    // PIEZOELECTRIC TENSOR
    /*-------------------------------------------------------------------*/            
//     Tensor<double,ndim,ndim,ndim>  I_HE0   =  outer(HE0,Imatrix);
//     Tensor<double,ndim,ndim,ndim>  I_HTE0  =  outer(HTE0,Imatrix); 
//     Tensor<double,ndim,ndim,ndim>  I4
//     Tensor<double,ndim,ndim,ndim> WFE0  =  
    
    /*-------------------------------------------------------------------*/    
    // Copy back from Fastor to C*
    /*-------------------------------------------------------------------*/    
//    copy_fastor(P_m,P);    
//    copy_fastor(D0_m,D0);
    copy_fastor(Elasticity_m,Elasticity);
 //   copy_fastor(PiezoTensor_m,PiezoTensor);
 //   copy_fastor(DielTensor_m,DielTensor);
}
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/*C FUNCTION FOR 3D PROBLEMS*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
template<>
void MooneyRivlin<3>(double mu1,
        double mu2,
        double lambda,
        double epsilon,
        const double *F_m,
        const double *H_m,
        double J_m,
        double *E0_m,
        double *P_m,
        double *D0_m,
        double *Elasticity_m,
        double *PiezoTensor_m,
        double *DielTensor_m)
{
    const mwSize  ndim  =  3;
    /*-------------------------------------------------------------------*/
    /*Copy from C to Fastor*/
    /*-------------------------------------------------------------------*/    
//     Tensor<double,ndim,ndim> F;
//     Tensor<double,ndim,ndim> H;
//     copy_matlab(F,F_m);
//     copy_matlab(H,H_m);
//     double J   =  J_m;
//     /*-------------------------------------------------------------------*/    
//     // IDENTITY SECOND ORDER TENSOR
//     /*-------------------------------------------------------------------*/    
//     Tensor<double,ndim,ndim> Imatrix; Imatrix.eye();
//     /*-------------------------------------------------------------------*/
//     // COMPUTE FIRST DERIVATIVES OF THE MODEL    
//     /*-------------------------------------------------------------------*/
//     Tensor<double,ndim,ndim> WF  =  mu1*F;
//     Tensor<double,ndim,ndim> WH  =  mu2*H;
//     double WJ =  -(mu1 + 2.*mu2)/J + lambda*(J - 1.);    
//     /*-------------------------------------------------------------------*/
//     // COMPUTE FIRST PIOLA STRESS TENSOR    
//     /*-------------------------------------------------------------------*/
//     Tensor<double,ndim,ndim> P   =  WF + cross(WH,F) + WJ*H;    
//     /*-------------------------------------------------------------------*/    
//     // Auxiliary tensors and variables needed
//     /*-------------------------------------------------------------------*/    
//     Tensor<double,ndim,ndim,ndim,ndim> I_I   =  outer(Imatrix,Imatrix);
//     Tensor<double,ndim,ndim,ndim,ndim> I4D   =  permutation<Index<1,3,2,4>>(I_I);    
//     
//     Tensor<double,ndim,ndim,ndim,ndim> WFF  =  mu1*I4D;
//     Tensor<double,ndim,ndim,ndim,ndim> WHH  =  mu2*I4D;
//     double WJJ =  (mu1 + 2.*mu2)/(J*J) + lambda;    
//     
//     Tensor<double,ndim,ndim,ndim,ndim> F_WHH_F  =  cross(cross(F,WHH),F);
//     Tensor<double,ndim,ndim,ndim,ndim> H_H  =  outer(H,H);        
//      
//     Tensor<double,ndim,ndim>  Geom  =  WH + WJ*F;
//     Tensor<double,ndim,ndim,ndim,ndim> C_Geom  =  cross(Geom,I4D); 
//      
//     Tensor<double,ndim,ndim,ndim,ndim> Elasticity4D  =  WFF + F_WHH_F + WJJ*H_H + C_Geom;    
//     Tensor<double,ndim*ndim,ndim*ndim> Elasticity  =  reshape<ndim*ndim,ndim*ndim>(Elasticity4D);
//     /*-------------------------------------------------------------------*/    
//     // Copy back from Fastor to C*
//     /*-------------------------------------------------------------------*/    
//     copy_fastor(P_m,P);    
//     copy_fastor(D0_m,D0);
//     copy_fastor(Elasticity_m,Elasticity);
//     copy_fastor(PiezoTensor_m,PiezoTensor);
//     copy_fastor(DielTensor_m,DielTensor);
}
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* The gateway function                                                  */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
    /*-------------------------------------------------------------------*/
    /*Inputs and declaration                                             */
    /*-------------------------------------------------------------------*/
    size_t dim, ngauss;    
    const mwSize  *dims_F;   
    double *mu1_, *mu2_, *lambda_, *epsilon_;
    double mu1, mu2, lambda, epsilon;
    double *F;               
    double *H;               
    double *J;               
    double *E0;
    /*-------------------------------------------------------------------*/
    /* outputs                                                           */
    /*-------------------------------------------------------------------*/
    double *P; 
    double *D0;
    double *Elasticity;
    double *PiezoTensor;
    double *DielTensor;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/        
    dims_F               =  mxGetDimensions(prhs[3]);
    dim                  =  (size_t)dims_F[0];    
    ngauss               =  (size_t)dims_F[2];    

    mu1_                 =  mxGetPr(prhs[0]);
    mu2_                 =  mxGetPr(prhs[1]);
    lambda_              =  mxGetPr(prhs[2]);
    epsilon_             =  mxGetPr(prhs[3]);
    mu1                  =  mu1_[0];
    mu2                  =  mu2_[0];
    lambda               =  lambda_[0];
    epsilon              =  epsilon_[0];
    F                    =  mxGetPr(prhs[4]);  
    H                    =  mxGetPr(prhs[5]);
    J                    =  mxGetPr(prhs[6]);
    E0                   =  mxGetPr(prhs[7]);
    /*-------------------------------------------------------------------*/
    /* get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    mwSize PDims[3]      =  {dim,dim,ngauss};            
    mwSize ElastDims[3]  =  {dim*dim,dim*dim,ngauss};
    plhs[0]              =  mxCreateNumericArray(3, PDims, mxDOUBLE_CLASS, mxREAL);   /*P*/
    plhs[1]              =  mxCreateNumericArray(3, ElastDims, mxDOUBLE_CLASS, mxREAL);   /*P*/
    P                    =  mxGetPr(plhs[0]);
    D0                   =  mxGetPr(plhs[1]);
    Elasticity           =  mxGetPr(plhs[2]);
    PiezoTensor          =  mxGetPr(plhs[3]);
    DielTensor           =  mxGetPr(plhs[4]);
    /*-------------------------------------------------------------------*/
    /* call the computational routine */
    /*-------------------------------------------------------------------*/
    mwSize igauss;
    if (dim==2){
       for (igauss=0; igauss<ngauss; ++igauss){
           MooneyRivlin<2>(mu1,mu2,lambda,epsilon,&F[dim*dim*igauss],&H[dim*dim*igauss],J[igauss],&E0[dim*igauss],&P[dim*dim*igauss],&D0[dim*igauss],&Elasticity[dim*dim*dim*dim*igauss],&PiezoTensor[dim*dim*dim*igauss],&DielTensor[dim*dim*igauss]);
       }
    }
    else if (dim==3){
       for (igauss=0; igauss<ngauss; ++igauss){
           MooneyRivlin<3>(mu1,mu2,lambda,epsilon,&F[dim*dim*igauss],&H[dim*dim*igauss],J[igauss],&E0[dim*igauss],&P[dim*dim*igauss],&D0[dim*igauss],&Elasticity[dim*dim*dim*dim*igauss],&PiezoTensor[dim*dim*dim*igauss],&DielTensor[dim*dim*igauss]);
       }    
    }
}


