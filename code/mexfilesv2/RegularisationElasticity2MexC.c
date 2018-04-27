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
              double *MatrixReg)
{
//-------------------------------------------------------------------------    
// Initialise the regularised matrix    
//-------------------------------------------------------------------------    
for (mwSize i=0; i<m*m*ngauss; ++i){             
    MatrixReg[i]   =  0.;
}
//-------------------------------------------------------------------------
// Temporaries
//-------------------------------------------------------------------------
double *Matrix_ = (double*)malloc(sizeof(double)*m*m);
//-------------------------------------------------------------------------
// Bisection for regularisation parameter alpha
//-------------------------------------------------------------------------
double alpha_min, alpha_max, alpha, stability;
for (mwSize igauss=0; igauss<ngauss; ++igauss){
    
    alpha_max  =  0.1;
    alpha_min  =  0.;
    //---------------------------------------------------------------------
    // Determine upper bound
    //---------------------------------------------------------------------
    stability     =  Sylvester(Matrix,m);  
    if (stability>0.9){
       for (mwSize i=0; i<m*m; ++i){
           MatrixReg[i + igauss*m*m]  =  Matrix[i + igauss*m*m];
       }
    }
     else    {
        alpha_min  =  0.;
        alpha_max  =  0.1;
       //------------------------------------------------------------------
       // Determine upper bound
       //------------------------------------------------------------------
       for (mwSize i=0; i<m*m; ++i){
             Matrix_[i]  =  Matrix[i + igauss*m*m] + alpha_max*MatrixStable[i + igauss*m*m];
         }
         stability    =  Sylvester(Matrix_,m);
         if (stability>0.9){
             BisectionStability2(m, alpha_max, &Matrix[igauss*m*m], &MatrixStable[igauss*m*m], &MatrixReg[igauss*m*m]);
          }
           else {
                  alpha_max    =  alpha_max*10;
              while (stability<0.1){
                  alpha_max    =  alpha_max*10;
                  for (mwSize i=0; i<m*m; ++i){
                      Matrix_[i]  =  Matrix[i + igauss*m*m] + alpha_max*MatrixStable[i + igauss*m*m];
                  }
                  stability    =  Sylvester(Matrix_,m);
              }
             for (mwSize i=0; i<m*m; ++i){
                 BisectionStability2(m, alpha_max, &Matrix[igauss*m*m], &MatrixStable[igauss*m*m], &MatrixReg[igauss*m*m]);
             }
         }
  }
}
//--------------------------
// free temporaries
//--------------------------
free(Matrix_);
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
    double *MatrixReg;
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
    mwSize Dims[3]     =  {m,m,ngauss};            
    plhs[0]            =  mxCreateNumericArray(3,Dims, mxDOUBLE_CLASS, mxREAL);    
    MatrixReg          =  mxGetPr(plhs[0]);    
    /*-------------------------------------------------------------------*/
    /* Call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)m, (mwSize)ngauss, Matrix, MatrixStable, MatrixReg);
}


