#include "mex.h"
#include "matfunctions.h"
#include "math.h"
/* */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* The C function */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void perfomer(mwSize m,
              mwSize ngauss,
              const double *Matrix,
              const double *MatrixStable,
              double *RegParameter)
{
//-------------------------------------------------------------------------
// Temporaries
//-------------------------------------------------------------------------
double *Imatrix      =  (double*)malloc(sizeof(double)*m*m);
double *Matrix_      =  (double*)malloc(sizeof(double)*m*m);
double *Temp_        =  (double*)malloc(sizeof(double)*m*m);
double *MatrixReg    =  (double*)malloc(sizeof(double)*m*m);
//-------------------------------------------------------------------------    
// Initialise the regularised matrix    
//-------------------------------------------------------------------------    
for (mwSize i=0; i<m*m; ++i){             
    MatrixReg[i]   =  0.;
}

for (mwSize i=0; i<m*m; ++i){
    Imatrix[i] = 0.;
}
for (mwSize i=0; i<m; ++i){
    Imatrix[i+i*m] = 1.;
}
//-------------------------------------------------------------------------
// Bisection for regularisation parameter alpha                          //
//-------------------------------------------------------------------------
double alpha_min, alpha_max, alpha, stability;
for (mwSize igauss=0; igauss<ngauss; ++igauss){
    
    AbsVector(&Matrix[igauss*m*m], m*m, Temp_);       
    alpha_max  =  sequential_maximum_vector(Temp_, m*m);
    alpha_max  =  alpha_max*1.2l;
    alpha_min  =  0.;
    //---------------------------------------------------------------------
    // Determine upper bound                                             //
    //---------------------------------------------------------------------
    stability     =  Sylvester2(&Matrix[igauss*m*m],&MatrixStable[igauss*m*m],m);  
    if (stability>0.9){
       for (mwSize i=0; i<m*m; ++i){
           MatrixReg[i]  =  Matrix[i + igauss*m*m];
       }
    }
    else    {
        alpha_min  =  0.;
        AbsVector(&Matrix[igauss*m*m], m*m, Temp_);       
        alpha_max  =  sequential_maximum_vector(Temp_, m*m);
        alpha_max  =  1.2*alpha_max;
       //------------------------------------------------------------------
       // Determine upper bound                                          //
       //------------------------------------------------------------------        
       for (mwSize i=0; i<m*m; ++i){
             Matrix_[i]  =  Matrix[i + igauss*m*m] + alpha_max*Imatrix[i];
         }
         stability     =  Sylvester2(Matrix_,&MatrixStable[igauss*m*m],m);  
         if (stability>0.9){
             BisectionStability2(m, alpha_max, &Matrix[igauss*m*m], &MatrixStable[igauss*m*m], &MatrixReg[0]);
          }
           else {
                  alpha_max    =  alpha_max*10;
              while (stability<0.1){
                  alpha_max    =  alpha_max*10;
                  for (mwSize i=0; i<m*m; ++i){
                      Matrix_[i]  =  Matrix[i + igauss*m*m] + alpha_max*Imatrix[i];
                  }
                  stability     =  Sylvester2(Matrix_, &MatrixStable[igauss*m*m], m);  
              }
             for (mwSize i=0; i<m*m; ++i){
                 BisectionStability2(m, alpha_max, &Matrix[igauss*m*m], &MatrixStable[igauss*m*m], &MatrixReg[0]);
             }
         }
    }
    //---------------------------------------------------------------------
    // Regularisation parameter                                          //
    //---------------------------------------------------------------------
    RegParameter[igauss]  =  MatrixReg[0] - Matrix[igauss*m*m]; 
}
//--------------------------
// free temporaries
//--------------------------
free(Imatrix);               
free(Matrix_);
free(Temp_);
free(MatrixReg);
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
    size_t m, ngauss;
    double *m_, *ngauss_;
    double *Matrix;   
    double *MatrixStable;
    /*-------------------------------------------------------------------*/
    /* outputs of the C function (computational routine)*/
    /*-------------------------------------------------------------------*/
    double *RegParameter;    
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    m_                 =  mxGetPr(prhs[0]);
    m                  =  (size_t)m_[0];    
    ngauss_            =  mxGetPr(prhs[1]);
    ngauss             =  (size_t)ngauss_[0];    
    Matrix             =  mxGetPr(prhs[2]);   
    MatrixStable       =  mxGetPr(prhs[3]);
    /*-------------------------------------------------------------------*/
    /* Get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    plhs[0]            =  mxCreateDoubleMatrix((mwSize)ngauss, (mwSize)1, mxREAL);
    RegParameter       =  mxGetPr(plhs[0]);        
    /*-------------------------------------------------------------------*/
    /* Call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)m, (mwSize)ngauss, Matrix, MatrixStable, RegParameter);
}


