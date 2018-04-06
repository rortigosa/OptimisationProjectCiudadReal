#pragma once /*Avoids redefinition of matfunctions in the translation unit*/

/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* Geometric term in nonlinear elasticity associated with J term        
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void GeometricJTerm(mwSize dim, double *WJ, const double *F, double *C) /*a is a mxm matrix*/
{
    for (mwSize i=0; i<dim*dim*dim*dim; i++){
       C[i]  =  0.;   
    }
    if (dim==2){
       C[0]  =  0.;
       C[3]  =  1.;
       C[6]  =  -1.;
       C[9] =  -1.;
       C[12] =  1;.
       C[15] =  0.;               
    }
    else if (dim==3){
             Tensor[5] =   F8;
             Tensor[6] =   -F7;
             Tensor[8] =   -F5;             
             Tensor[9] =   F4;
             Tensor[13] =  -F8;
             Tensor[15] =  F6;
             Tensor[16] =  F5;
             Tensor[18] =  -F3;
             Tensor[22] =  F7;
             Tensor[23] =  -F6;
             Tensor[25] =  -F4;
             Tensor[26] =  F3;
             Tensor[29] =  -F8;
             Tensor[30] =  F7;
             Tensor[35] =  F2;
             Tensor[36] =  -F1;
             Tensor[37] =  F8;
             Tensor[39] =  -F6;
             Tensor[43] =  -F2;
             Tensor[45] =  F0;
             Tensor[46] =  -F7;
             Tensor[47] =  F6;
             Tensor[52] =  F1;
             Tensor[53] =  -F0;
             Tensor[56] =  F5;
             Tensor[57] =  -F4;
             Tensor[59] =  -F2;
             Tensor[60] =  F1;
             Tensor[64] =  -F5;
             Tensor[66] =  F3;
             Tensor[67] =  F2;
             Tensor[69] =  -F0;
             Tensor[73] =  F4;
             Tensor[74] =  -F3;
             Tensor[76] =  -F1;
             Tensor[77] =  F0;
             
             
        

  
  
 
  
 
 
  
 
  
  
 
  
 
 
  
 
  
  
 
  
 
 
          
        
    }
}
