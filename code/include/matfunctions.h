#pragma once /*Avoids redefinition of matfunctions in the translation unit*/

/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes the minimum of a vector*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
double sequential_minimum_vector(const double *vector, mwSize dim)
{
    double out, aux;
    mwSize i;
    out  =  vector[0];
    for (i=1; i<dim; i++) {
        if (vector[i]<=out){
           out  =  vector[i];
        }
    }
    return out;
}

/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes the minimum of a vector*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
double sequential_maximum_vector(const double *vector, mwSize dim)
{
    double out, aux;
    mwSize i;
    out  =  vector[0];
    for (i=1; i<dim; i++) {
        if (vector[i]>=out){
           out  =  vector[i];
        }
    }
    return out;
}

/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes the absolute value of a double array*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void AbsVector(const double *vector, mwSize dim, double *out)
{
    mwSize i;
    for (i=0; i<dim; i++) {
        if (vector[i]<0){
           out[i]  =  -vector[i];
        }
        else {
            out[i] =  vector[i];
        }            
    }
}

/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes the absolute value of a double scalar*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
double AbsDouble(double scalar)
{
    double out;
    if (scalar<0){
       out  =  -scalar;     
    }
    else {
       out  =  scalar;   
    }
    return out;
}

/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes the transpose of an mxn matrix matrix*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void transpose(const double *a, double *out, mwSize m, mwSize n) 
{
    mwSize i, j;
    /* multiply each element y by x */
    for (j=0; j<m; j++) {
        for (i=0; i<n; i++) {
            out[j*n+i] = a[i*m+j];
        }
    }
}
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes the scalar product of two flat entities of 
 * the same size*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
double scalar_product(const double *a, const double *b, mwSize m)
{
    double out;
    out = 0.;
    mwSize i;
    for (i=0; i<m; i++) {
        out += a[i]*b[i];
    }
    return out;
}
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes the scalar product of two flat entities of 
 * the same size*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
double trace(const double *a, mwSize m)
{
    double out;
    out = 0.;
    mwSize i;
    for (i=0; i<m; i++) {
        out += a[i + m*i];
    }
    return out;
}
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes element-wise product of vectors*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void elewise_product(const double *a, const double *b, double *out, mwSize m)
{
    mwSize i;
    for (i=0; i<m; i++) {
        out[i] = a[i]*b[i];
    }
}
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes the cross product between two vectors in 3D*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void vector_cross_product(const double *a, const double *b, double *out)
{
  out[0]  =  a[1]*b[2] - a[2]*b[1];
  out[1]  =  a[2]*b[0] - a[0]*b[2];
  out[2]  =  a[0]*b[1] - a[1]*b[0];
}
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes the Euclidean norm of vectors*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
double vector_euclidean_norm(mwSize dim, const double *a)
{
  double out;
  if (dim==2){
      out  =  a[0]*a[0] + a[1]*a[1];
  }
  else if (dim==3){
      out  =  a[0]*a[0] + a[1]*a[1] + a[2]*a[2];
  }
  return out;
}
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* Given the square root of the Euclidean norm of a vector and the vector, 
 * this function computes the unitary vector*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void unitary_vector(mwSize dim, double norm, const double *a, double *out)
{
  if (dim==2){
     out[0]  =  a[0]/norm;
     out[1]  =  a[1]/norm;
  }
  else if (dim==3){
     out[0]  =  a[0]/norm;
     out[1]  =  a[1]/norm;
     out[2]  =  a[2]/norm;      
  }
}
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes the outer product of two vectors*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
 void vector_outer_product(mwSize M, const double *a, const double *b, double *out) {     
    for (mwSize j=0; j<M*M; ++j){
        out[j]  =  0.;   
    }     
    for (mwSize j=0; j<M; ++j) {
        for (mwSize i=0; i<M; ++i){
            out[i + j*M]  =  a[i]*b[j];            
        }
    }
}
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes the outer product of two vectors*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
 void identity_matrix(mwSize M, double *out) {
    for (mwSize i=0; i<M*M; ++i){
        out[i] = 0.;   
    }
    for (mwSize i=0; i<M; ++i) {
        out[i + i*M]  =  1.;            
    }
}
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes the product a scalar and a matrix*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
 void MatScalarmul(mwSize M, double a, const double *A, double *out) {
    for (mwSize i=0; i<M; ++i) {
        out[i] =  a*A[i];
    }
}
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes the product of two matrices*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
 void matmul(mwSize M, mwSize K, mwSize N, const double *a, const double *b, double *out) {
    for (mwSize i=0; i<M*N; ++i) {
       out[i] = 0.;
    }
    for (mwSize i=0; i<M; ++i) {
        for (mwSize j=0; j<K; ++j) {
            for (mwSize k=0; k<N; ++k) {
                out[k*M+i] += a[j*M+i]*b[k*K+j];
            }
        }
    }
} 
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes the product of a matrix and a vector*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void  MatVectorMul(mwSize m, const double *Matrix, const double *Vector, double *VectorOut){
    for (mwSize i=0; i<m; i++){
        VectorOut[i]  =  0.;
    }
    for (mwSize i=0; i<m; i++){
         for (mwSize j=0; j<m; j++){
             VectorOut[i]  +=  Matrix[i + j*m]*Vector[j];
         }
    }
}
 
 
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes the sum of two matrices*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void matsum(mwSize M, mwSize N, const double *a, const double *b, double *out) {
    for (mwSize i=0; i<M*N; ++i) {
       out[i] = a[i] + b[i];
    }
}
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes the substraction of two matrices*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void matsubs(mwSize M, mwSize N, const double *a, const double *b, double *out) {
    for (mwSize i=0; i<M*N; ++i) {
       out[i] = a[i] - b[i];
    }
}

/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes the co-factor of 2D and 3D matrices*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
 void cofactor(const double *a, double *out, mwSize m)
{
    if (m==2){
        out[0]  =  a[3];
        out[1]  =  -a[2];
        out[2]  =  -a[1];
        out[3]  =  a[0];
    }
    else if (m==3){
        out[0]  =  0.5*(a[4]*a[8] - a[7]*a[5] - a[5]*a[7] + a[8]*a[4]);
        out[1]  =  0.5*(a[5]*a[6] - a[8]*a[3] - a[3]*a[8] + a[6]*a[5]);
        out[2]  =  0.5*(a[3]*a[7] - a[6]*a[4] - a[4]*a[6] + a[7]*a[3]);
        out[3]  =  0.5*(a[7]*a[2] - a[1]*a[8] - a[8]*a[1] + a[2]*a[7]);
        out[4]  =  0.5*(a[8]*a[0] - a[2]*a[6] - a[6]*a[2] + a[0]*a[8]);
        out[5]  =  0.5*(a[6]*a[1] - a[0]*a[7] - a[7]*a[0] + a[1]*a[6]);
        out[6]  =  0.5*(a[1]*a[5] - a[4]*a[2] - a[2]*a[4] + a[5]*a[1]);
        out[7]  =  0.5*(a[2]*a[3] - a[5]*a[0] - a[0]*a[5] + a[3]*a[2]);
        out[8]  =  0.5*(a[0]*a[4] - a[3]*a[1] - a[1]*a[3] + a[4]*a[0]);
    }
}
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes stress contribution SigmaHxF */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void piolaHFunction(const double *SigmaH, const double *F, double *out, mwSize m)
{
    if (m==2){
        out[0]  =   SigmaH[3];
        out[1]  =  -SigmaH[2];
        out[2]  =  -SigmaH[1];
        out[3]  =   SigmaH[0];
    }
    else if (m==3){
        out[0]  =  (SigmaH[4]*F[8] - SigmaH[7]*F[5] - SigmaH[5]*F[7] + SigmaH[8]*F[4]);
        out[1]  =  (SigmaH[5]*F[6] - SigmaH[8]*F[3] - SigmaH[3]*F[8] + SigmaH[6]*F[5]);
        out[2]  =  (SigmaH[3]*F[7] - SigmaH[6]*F[4] - SigmaH[4]*F[6] + SigmaH[7]*F[3]);
        out[3]  =  (SigmaH[7]*F[2] - SigmaH[1]*F[8] - SigmaH[8]*F[1] + SigmaH[2]*F[7]);
        out[4]  =  (SigmaH[8]*F[0] - SigmaH[2]*F[6] - SigmaH[6]*F[2] + SigmaH[0]*F[8]);
        out[5]  =  (SigmaH[6]*F[1] - SigmaH[0]*F[7] - SigmaH[7]*F[0] + SigmaH[1]*F[6]);
        out[6]  =  (SigmaH[1]*F[5] - SigmaH[4]*F[2] - SigmaH[2]*F[4] + SigmaH[5]*F[1]);
        out[7]  =  (SigmaH[2]*F[3] - SigmaH[5]*F[0] - SigmaH[0]*F[5] + SigmaH[3]*F[2]);
        out[8]  =  (SigmaH[0]*F[4] - SigmaH[3]*F[1] - SigmaH[1]*F[3] + SigmaH[4]*F[0]);
    }
}


/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes the inverse of a matrix */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
 void inverse(const double *src, double *dst, mwSize m)
{
    double det;
    if (m==2) {
        dst[0]  =   src[3];
        dst[1]  =  -src[1];
        dst[2]  =  -src[2];
        dst[3]  =   src[0];
        /*---------------------------------------------------------------*/
        /* Compute determinant: */
        /*---------------------------------------------------------------*/
        det = 1./(src[0] * dst[0] + src[2] * dst[1]);
        dst[0] = dst[0]*det;
        dst[1] = dst[1]*det;
        dst[2] = dst[2]*det;
        dst[3] = dst[3]*det;
    }
    else if (m==3){
        double det;
        double src0 = src[0];
        double src1 = src[1];
        double src2 = src[2];
        double src3 = src[3];
        double src4 = src[4];
        double src5 = src[5];
        double src6 = src[6];
        double src7 = src[7];
        double src8 = src[8];
        /*---------------------------------------------------------------*/
        /* Compute adjoint: */
        /*---------------------------------------------------------------*/
        dst[0] = + src4 * src8 - src5 * src7;
        dst[1] = - src1 * src8 + src2 * src7;
        dst[2] = + src1 * src5 - src2 * src4;
        dst[3] = - src3 * src8 + src5 * src6;
        dst[4] = + src0 * src8 - src2 * src6;
        dst[5] = - src0 * src5 + src2 * src3;
        dst[6] = + src3 * src7 - src4 * src6;
        dst[7] = - src0 * src7 + src1 * src6;
        dst[8] = + src0 * src4 - src1 * src3;
        /*---------------------------------------------------------------*/
        /* Compute determinant: */
        /*---------------------------------------------------------------*/
        det = 1.0/(src0 * dst[0] + src1 * dst[3] + src2 * dst[6]);
        dst[0] *= det;
        dst[1] *= det;
        dst[2] *= det;
        dst[3] *= det;
        dst[4] *= det;
        dst[5] *= det;
        dst[6] *= det;
        dst[7] *= det;
        dst[8] *= det;
    }
}
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes the determinant of a square matrix */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
 double determinant(const double *src, mwSize m)
{
    double *dst = (double*)malloc(sizeof(double)*m*m);
    double det;
    if (m==2) {
        dst[0]  =   src[3];
        dst[1]  =  -src[1];
        dst[2]  =  -src[2];
        dst[3]  =   src[0];
        /*---------------------------------------------------------------*/
        /* Compute determinant: */
        /*---------------------------------------------------------------*/
        det = src[0] * dst[0] + src[2] * dst[1];
    }
    else if (m==3){
        double src0 = src[0];
        double src1 = src[1];
        double src2 = src[2];
        double src3 = src[3];
        double src4 = src[4];
        double src5 = src[5];
        double src6 = src[6];
        double src7 = src[7];
        double src8 = src[8];
        /*---------------------------------------------------------------*/
        /* Compute adjoint: */
        /*---------------------------------------------------------------*/
        dst[0] = + src4 * src8 - src5 * src7;
        dst[1] = - src1 * src8 + src2 * src7;
        dst[2] = + src1 * src5 - src2 * src4;
        dst[3] = - src3 * src8 + src5 * src6;
        dst[4] = + src0 * src8 - src2 * src6;
        dst[5] = - src0 * src5 + src2 * src3;
        dst[6] = + src3 * src7 - src4 * src6;
        dst[7] = - src0 * src7 + src1 * src6;
        dst[8] = + src0 * src4 - src1 * src3;
        /*---------------------------------------------------------------*/
        /* Compute determinant: */
        /*---------------------------------------------------------------*/
        det = src0 * dst[0] + src1 * dst[3] + src2 * dst[6];
    }
    free(dst);
    return det;
}
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes Qmatrix for BH=Q*BF */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void Qmatrix(const double *a, double *out, mwSize m)
{
    if (m==2){
       out[3]      =   1.0;
       out[6]      =  -1.0;
       out[9]      =  -1.0;
       out[12]     =   1.0;
    }
    else if (m==3){
       out[4]      =   a[8];
       out[5]      =  -a[5];
       out[7]      =  -a[7];
       out[8]      =   a[4];       
       out[3+9]    =  -a[8];
       out[5+9]    =   a[2];
       out[6+9]    =   a[7];
       out[8+9]    =  -a[1];       
       out[3+9*2]  =  a[5];
       out[4+9*2]  =  -a[2];
       out[6+9*2]  =  -a[4];
       out[7+9*2]  =  a[1];       
       out[1+9*3]  =  -a[8];
       out[2+9*3]  =  a[5];
       out[7+9*3]  =  a[6];
       out[8+9*3]  =  -a[3];       
       out[0+9*4]  =  a[8];
       out[2+9*4]  =  -a[2];
       out[6+9*4]  =  -a[6];
       out[8+9*4]  =  a[0];       
       out[0+9*5]  =  -a[5];
       out[1+9*5]  =  a[2];
       out[6+9*5]  =  a[3];
       out[7+9*5]  =  -a[0];       
       out[1+9*6]  =  a[7];
       out[2+9*6]  =  -a[4];
       out[4+9*6]  =  -a[6];
       out[5+9*6]  =  a[3];       
       out[0+9*7]  =  -a[7];
       out[2+9*7]  =  a[1];
       out[3+9*7]  =  a[6];
       out[5+9*7]  =  -a[0];       
       out[0+9*8]  =  a[4];
       out[1+9*8]  =  -a[1];
       out[3+9*8]  =  -a[3];
       out[4+9*8]  =  a[0];
    }
}

/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes triangular sup of a matrix*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void trisup(mwSize M, const double *a, double *out)
{     
     /*--------------------------
     /* Initialise the matrix
     /*--------------------------*/
    for (mwSize i=0; i<M*M; ++i) {
       out[i] = a[i];
    }
     /*--------------------------
     /* Triangular matrix
     /*--------------------------*/
    double pivot;
    for (mwSize k=1; k<M; ++k){
        for (mwSize i=k; i<M; ++i){
             pivot      =  out[(k-1)*M+i];            
             for (mwSize j=k-1; j<M; ++j){
                if (pivot>0.){
                   out[i+j*M] = (out[i+j*M]*out[(k-1)*M+k-1]/pivot - out[k-1 + j*M])*(pivot/out[(k-1)*M + k-1]);
                }
                if (pivot<0.){
                   out[i+j*M] = (out[i+j*M]*out[(k-1)*M+k-1]/pivot - out[k-1 + j*M])*(pivot/out[(k-1)*M + k-1]);
                }
                
            }
        }
    }
 }
 
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes the determinant of any nxn matrix
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
double determinant_multidim(const double *a, mwSize m)
{
    double det;
    double *a_tri = (double*)malloc(sizeof(double)*m*m);
    /*Triangular superior matrix*/
    trisup(m,a,a_tri);     
    det  =  1.0;
    /*Determinant*/
    for (mwSize i=0; i<m; ++i){
        det  =  det*a_tri[i+m*i];
    }
    free(a_tri);
    
    return det;
}

/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes the minors of a matrix
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void minors_func(mwSize m, const double *a, double *minors) /*a is a mxm matrix*/
{
    double det_;
    minors[0]  = a[0];
    for (mwSize i=1; i<m; ++i){
        /*-----------------------------------------------------------------
        /*Create the minor (matrix)*/
        /*---------------------------------------------------------------*/
        double *minor_matrix = (double*)malloc(sizeof(double)*(size_t)(i+1)*(size_t)(i+1));
        for (mwSize j=0; j<i+1; ++j){
            for (mwSize k=0; k<i+1; ++k){
                minor_matrix[k+j*(i+1)] =  a[k + j*m];      
            }
        }
        /*-----------------------------------------------------------------
        /*Create the determininant of the minor*/
        /*---------------------------------------------------------------*/
        det_       =  determinant_multidim(minor_matrix,(size_t)i+1);   
        minors[i]  =  det_;
        free(minor_matrix);
    }
}


/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* Sylvester criterion
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
double Sylvester(const double *Matrix, mwSize m)
{
    /*Compute the minors*/
    double *minors = (double*)malloc(sizeof(double)*m);
    minors_func(m,Matrix,minors);    
    /*Compute the minimum of the minors*/
    double min_minors;
    min_minors  =  sequential_minimum_vector(minors,m);        
    /*Stability*/
    double stability;
    stability       =  1.0;
    //stability       =  min_minors;
    if (min_minors<0.){
       stability    =  0.0;
    }    
    free(minors);
    return stability;
}

/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* Sylvester criterion
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
double Sylvester2(const double *Matrix, const double *MatrixStable, mwSize m)
{
    /*-----------------------------------*/
    /* Compute the zero reference        */
    /*-----------------------------------*/
    double zero_;
    double *Temp_ = (double*)malloc(sizeof(double)*m*m);
    AbsVector(&MatrixStable[0], (size_t)m*m, Temp_);       
    zero_   =  sequential_maximum_vector(Temp_, (size_t)m*m);    
    //zero_ =  AbsDouble(zero_*1e-6)*(-1);  // Not clear if it has to be positive or negative
    zero_   =  AbsDouble(zero_*1e-6)*(1);  // Not clear if it has to be positive or negative
    /*-----------------------------------*/
    /*Compute the minors                 */
    /*-----------------------------------*/
    double *minors = (double*)malloc(sizeof(double)*m);
    minors_func(m,Matrix,minors);    
    /*-----------------------------------*/
    /* Compute the minimum of the minors */
    /*-----------------------------------*/
    double min_minors;
    min_minors  =  sequential_minimum_vector(minors,m);        
    /*-----------------------------------*/
    /*Stability                          */
    /*-----------------------------------*/
    double stability;
    stability       =  1.0;
    if (min_minors<zero_){
       stability    =  0.0;
    }    
    /*-----------------------------------*/
    /* free temporaries                  */
    /*-----------------------------------*/
    free(minors);
    free(Temp_);
    /*-----------------------------------*/
    /* Return stability                  */
    /*-----------------------------------*/
    return stability;
}

/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* Bisection for regularisation of elasticity tensor
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void BisectionStability(mwSize m, double alpha_max, const double *Hessian, double *out)
{
  /*---------------------------*/
  /*Initialice identity matrix */
  /*---------------------------*/
  double *Imatrix = (double*)malloc(sizeof(double)*m*m);
  
  for (mwSize i=0; i<m*m; ++i){
      Imatrix[i] = 0.;
  }
  for (mwSize i=0; i<m; ++i){
      Imatrix[i+i*m] = 1.;
  }
    mwSize NIter;
    NIter = 6;
  for (mwSize i=0; i<m*m; ++i){
      out[i]  =  Hessian[i];   
  }
  /*---------------------------*/
  /*Bisection process          */
  /*---------------------------*/
  double alpha_min, alpha, stability;
  alpha_min  =  0.;
  for (mwSize iter=0; iter<NIter; iter++){
      alpha    =  (alpha_min + alpha_max)/2.;
      for (mwSize i=0; i<m*m; ++i){    
           out[i]  = Hessian[i] + alpha*Imatrix[i];
          }
      stability         =  Sylvester(out,m);  
      /*-----------------------*/
      /*Stable solution        */
      /*-----------------------*/
      if (stability>0.9){
         alpha_max =  alpha; 
      }
      /*-----------------------*/
      /*Non stable solution    */
      /*-----------------------*/
      else {
         alpha_min = alpha;
         alpha     =  alpha_max;
         for (mwSize i=0; i<m*m; ++i){    
             out[i]  = Hessian[i] + alpha*Imatrix[i];
         }
      }
  }
  free(Imatrix);
}
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* Bisection for regularisation of elasticity tensor
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void BisectionStability2(mwSize m, double alpha_max, const double *Hessian, const double *HessianStable, double *out)
{
  /*---------------------------*/
  /*Initialice identity matrix */
  /*---------------------------*/
  double *Imatrix = (double*)malloc(sizeof(double)*m*m);
  
  for (mwSize i=0; i<m*m; ++i){
      Imatrix[i] = 0.;
  }
  for (mwSize i=0; i<m; ++i){
      Imatrix[i+i*m] = 1.;
  }
    mwSize NIter;
    NIter = 10;
  for (mwSize i=0; i<m*m; ++i){
      out[i]  =  Hessian[i];   
  }
  /*---------------------------*/
  /*Bisection process          */
  /*---------------------------*/
  double alpha_min, alpha, stability;
  alpha_min  =  0.;
  for (mwSize iter=0; iter<NIter; iter++){
      alpha    =  (alpha_min + alpha_max)/2.;
      for (mwSize i=0; i<m*m; ++i){    
           out[i]  = Hessian[i] + alpha*Imatrix[i];
          }
      stability  =  Sylvester2(out,HessianStable, m);  
      /*-----------------------*/
      /*Stable solution        */
      /*-----------------------*/
      if (stability>0.9){
         alpha_max =  alpha; 
      }
      /*-----------------------*/
      /*Non stable solution    */
      /*-----------------------*/
      else {
         alpha_min = alpha;
         alpha     =  alpha_max;
         for (mwSize i=0; i<m*m; ++i){    
             out[i]  = Hessian[i] + alpha*Imatrix[i];
         }
      }
  }
  free(Imatrix);
}


