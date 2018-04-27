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
    Tensor<double,ndim,ndim> HT       =  transpose(H);
    Tensor<double,ndim,ndim> HTH      =  matmul(H,HT); 
    Tensor<double,ndim,1> HE0         =  matmul(HT,E0); 
    Tensor<double,ndim,1> HTE0        =  matmul(H,E0);
    Tensor<double,ndim,1> HTHE0       =  matmul(H,HE0);
    Tensor<double,ndim,ndim> HE0_HE0  =  dyadic(HE0,HE0);
    Tensor<double,ndim,ndim> HE0_E0   =  dyadic(E0,HE0);
    Tensor<double,ndim,ndim> E0_E0    =  dyadic(E0,E0);
    double HE0_HE0_invariant          =  trace(HE0_HE0);
    /*-------------------------------------------------------------------*/
    // COMPUTE FIRST DERIVATIVES OF THE MODEL    
    /*-------------------------------------------------------------------*/
     Tensor<double,ndim,ndim> WF  =  mu1*F;
     Tensor<double,ndim,ndim> WH  =  mu2*H - (epsilon/J)*HE0_E0;
     double WJ =  -(mu1 + 2.*mu2)/J + lambda*(J - 1.) + epsilon/(2.*J*J)*HE0_HE0_invariant;    
     Tensor<double,ndim>  WE0  =  -(epsilon/J)*HTHE0;
    /*-------------------------------------------------------------------*/
    // COMPUTE FIRST PIOLA AND THE ELECTRIC DISPLACEMENT
    /*-------------------------------------------------------------------*/         
    Tensor<double,ndim,ndim> WHT  =  transpose(WH); 
    Tensor<double,ndim,ndim> PiolaH  =  trace(WH)*Imatrix - WHT;
    Tensor<double,ndim,ndim> P    =  WF + PiolaH + WJ*H;    
    Tensor<double,ndim,1>    D0   =  -WE0;
    /*-------------------------------------------------------------------*/    
    // AUXILIARY VARIABLES NEEDED
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim,ndim,ndim> I_I      =  outer(Imatrix,Imatrix);               //delta_iI*delta_jJ 
    Tensor<double,ndim,ndim,ndim,ndim> I4D      =  permutation<Index<1,3,2,4>>(I_I);     //delta_ij*delta_IJ    
    Tensor<double,ndim,ndim,ndim,ndim> I4DT     =  permutation<Index<2,3,1,4>>(I_I);     //delta_iJ*delta_jI   
    Tensor<double,ndim,ndim,ndim,ndim> D2H      =  I_I - I4DT;  
    Tensor<double,ndim,ndim,ndim,ndim> I_E0E0   =  outer(E0_E0,Imatrix);                 //delta_iI*(E0xE0)_jJ
    Tensor<double,ndim,ndim,ndim,ndim> I4_E0E0  =  permutation<Index<1,3,2,4>>(I_E0E0);  // (E0xE0)_ij*delta_IJ 
    Tensor<double,ndim,ndim,ndim> HE0_iJI       =  outer(H,E0);
    HE0_iJI  =  permutation<Index<1,3,2>>(HE0_iJI);
    Tensor<double,ndim,ndim,ndim> HE0_iIJ       =  outer(HE0,Imatrix);
    /*-------------------------------------------------------------------*/    
    // ELASTICITY TENSOR
    /*-------------------------------------------------------------------*/            
    Tensor<double,ndim,ndim,ndim,ndim> WFF  =  mu1*I4D;
    Tensor<double,ndim,ndim,ndim,ndim> WHH  =  mu2*I4D - (epsilon/J)*I4_E0E0;
    Tensor<double,ndim,ndim>  WHJ  =  epsilon/(J*J)*HE0_E0;
    double WJJ =  (mu1 + 2.*mu2)/(J*J) + lambda - epsilon/(J*J*J)*HE0_HE0_invariant;    
    
    Tensor<double,ndim,ndim,ndim,ndim> DH_WHH_DH = einsum<Index<1,2,3,4>,Index<3,4,5,6>,Index<5,6,7,8>>(D2H,WHH,D2H);
    Tensor<double,ndim,ndim,ndim,ndim> H_H  =  outer(H,H);        
    Tensor<double,ndim,ndim,ndim,ndim> C_Geom  =  WJ*(I_I - I4DT); 
    Tensor<double,ndim,ndim>  DH_WHJ = einsum<Index<1,2,3,4>,Index<3,4>>(D2H,WHJ);
    Tensor<double,ndim,ndim,ndim,ndim> Elasticity4D  =  WFF + DH_WHH_DH + WJJ*H_H + C_Geom + outer(H,DH_WHJ) + outer(DH_WHJ,H);

    Tensor<double,ndim*ndim,ndim*ndim> Elasticity  =  reshape<ndim*ndim,ndim*ndim>(Elasticity4D);
    /*-------------------------------------------------------------------*/    
    // PIEZOELECTRIC TENSOR
    /*-------------------------------------------------------------------*/            
    Tensor<double,ndim,ndim,ndim>  WHE0  =  -epsilon/J*(HE0_iJI);
    Tensor<double,ndim,1> WJE0  =  (epsilon/(J*J))*HTHE0;
    Tensor<double,ndim,ndim,ndim>  WHE0_DH = einsum<Index<1,2,3,4>,Index<1,2,5>>(D2H,WHE0);    
    Tensor<double,ndim,ndim,ndim>  H_WJE0  = outer(WJE0,H);

    Tensor<double,ndim,ndim,ndim>  PiezoTensor3D  =  WHE0_DH + H_WJE0;
    Tensor<double,ndim*ndim,ndim> PiezoTensor  =  reshape<ndim*ndim,ndim>(PiezoTensor3D);    
    /*-------------------------------------------------------------------*/    
    // DIELECTRIC TENSOR
    /*-------------------------------------------------------------------*/            
    Tensor<double,ndim,ndim> WE0E0  =  -(epsilon/J)*HTH;
    Tensor<double,ndim,ndim> DielTensor  =  -WE0E0;
    /*-------------------------------------------------------------------*/    
    // Copy back from Fastor to C*
    /*-------------------------------------------------------------------*/    
    copy_fastor(P_m,P);    
    copy_fastor(D0_m,D0);
    copy_fastor(Elasticity_m,Elasticity);
    copy_fastor(PiezoTensor_m,PiezoTensor);
    copy_fastor(DielTensor_m,DielTensor);
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
//     copy_matlab(E0,E0_m);
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
    double *Piola;
    double *D0;
    double *Elasticity;
    double *PiezoTensor;
    double *DielTensor;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/        
    dims_F               =  mxGetDimensions(prhs[4]);
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
    mwSize PiezoDims[3]  =  {dim*dim,dim,ngauss};
    mwSize DielDims[3]   =  {dim,dim,ngauss};
    plhs[0]              =  mxCreateNumericArray(3, PDims, mxDOUBLE_CLASS, mxREAL);   
    plhs[1]              =  mxCreateDoubleMatrix((mwSize)dim, (mwSize)ngauss, mxREAL);             
    plhs[2]              =  mxCreateNumericArray(3, ElastDims, mxDOUBLE_CLASS, mxREAL);   
    plhs[3]              =  mxCreateNumericArray(3, PiezoDims, mxDOUBLE_CLASS, mxREAL);   
    plhs[4]              =  mxCreateNumericArray(3, DielDims, mxDOUBLE_CLASS, mxREAL);   
    Piola                =  mxGetPr(plhs[0]);
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
           MooneyRivlin<2>(mu1,mu2,lambda,epsilon,&F[dim*dim*igauss],&H[dim*dim*igauss],J[igauss],&E0[dim*igauss],&Piola[dim*dim*igauss],&D0[dim*igauss],&Elasticity[dim*dim*dim*dim*igauss],&PiezoTensor[dim*dim*dim*igauss],&DielTensor[dim*dim*igauss]);
       }
    }
    else if (dim==3){
       for (igauss=0; igauss<ngauss; ++igauss){
           MooneyRivlin<3>(mu1,mu2,lambda,epsilon,&F[dim*dim*igauss],&H[dim*dim*igauss],J[igauss],&E0[dim*igauss],&Piola[dim*dim*igauss],&D0[dim*igauss],&Elasticity[dim*dim*dim*dim*igauss],&PiezoTensor[dim*dim*dim*igauss],&DielTensor[dim*dim*igauss]);
       }    
    }
}


