#if !defined(_WIN32)
#define dgemm dgemm_
#endif

#include "mex.h"
#include "matfunctions.h"
#include "blas.h"

/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* This function computes the stiffness matrix for
* a displacement-based formulation                                       */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void StiffnessMatrixUFormulation(mwSize dim,
        mwSize n_gauss,
        mwSize n_node_elem,
        const double *BF,
        const double *BH,
        const double *BJ,
        const double *GeomSigmaH,
        const double *WFF,
        const double *WFH,
        const double *WFJ,
        const double *WHH,
        const double *WHJ,
        const double *WJJ,
        const double *SigmaJ,
        const double *IntWeight,
        double *K)
{
    size_t dim1          =  dim*dim;
    size_t dim2          =  dim*n_node_elem;
    mwSize capacityBF    =  dim2*dim1;
    mwSize capacity      =  dim2*dim2;
    mwSize capacityBJ    =  dim2;
    /*-------------------------------------------------------------------*/
    /*Initialise temporary variables*/
    /*-------------------------------------------------------------------*/
    double *BFT          =  (double*)malloc(sizeof(double)*(capacityBF));
    double *BHT          =  (double*)malloc(sizeof(double)*(capacityBF));
    double *BJT          =  (double*)malloc(sizeof(double)*(capacityBJ));

    double *BFT_WFF      =  (double*)malloc(sizeof(double)*(capacityBF));
    double *BFT_WFH      =  (double*)malloc(sizeof(double)*(capacityBF));
    double *BFT_WFJ      =  (double*)malloc(sizeof(double)*(capacityBJ));
    double *BHT_WHH      =  (double*)malloc(sizeof(double)*(capacityBF));
    double *BHT_WHJ      =  (double*)malloc(sizeof(double)*(capacityBJ));
    double *BJT_BJ       =  (double*)malloc(sizeof(double)*(capacity));
    double *BFT_SH       =  (double*)malloc(sizeof(double)*(capacityBF));
    double *BFT_BH       =  (double*)malloc(sizeof(double)*(capacityBF));
    
    double *BFT_WFF_BF   =  (double*)malloc(sizeof(double)*(capacity));
    double *BFT_WFH_BH   =  (double*)malloc(sizeof(double)*(capacity));
    double *BFT_WFJ_BJ   =  (double*)malloc(sizeof(double)*(capacity));
    double *BHT_WHH_BH   =  (double*)malloc(sizeof(double)*(capacity));
    double *BHT_WHJ_BJ   =  (double*)malloc(sizeof(double)*(capacity));
    double *BJT_WJJ_BJ   =  (double*)malloc(sizeof(double)*(capacity));
    double *BFT_SH_BF    =  (double*)malloc(sizeof(double)*(capacity));
    double *BFT_BH_SJ    =  (double*)malloc(sizeof(double)*(capacity));
    
    double *Kcons        =  (double*)malloc(sizeof(double)*(capacity));
    double *Kgeom        =  (double*)malloc(sizeof(double)*(capacity));
    /*-------------------------------------------------------------------*/
    /*Initialise matrix K*/
    /*-------------------------------------------------------------------*/
    mwSize j;
    for (j=0; j<capacity; ++j){
        K[j]     =  0.;
        Kcons[j] =  0.;
        Kgeom[j] =  0.;
    }    
    /*-------------------------------------------------------------------*/
    /*Compute K matrix*/    
    /*-------------------------------------------------------------------*/
    char *chn    =  "N";
    char *cht    =  "T";
    size_t m1    =  dim1;    /*number of rows of A*/
    size_t n1    =  dim1;    /*number of columns of B*/
    size_t k1    =  dim2;    /*number of columns of A*/

    size_t m2    =  dim2;    /*number of rows of A*/
    size_t n2    =  dim2;    /*number of columns of B*/
    size_t k2    =  dim1;    /*number of columns of A*/ 

    size_t m3    =  dim1;    /*number of rows of A*/   
    size_t n3    =  dim1;    /*number of columns of B*/
    size_t k3    =  dim2;    /*number of columns of A*/ 

    mwSize one   =  1;
    size_t m4    =  dim2;    /*number of rows of A*/
    size_t n4    =  one;     /*number of columns of B*/
    size_t k4    =  dim2;    /*number of columns of A*/ 

    size_t m5    =  dim1;    /*number of rows of A*/
    size_t n5    =  dim2;    /*number of columns of B*/
    size_t k5    =  one;     /*number of columns of A*/ 

    size_t m6    =  dim2;    /*number of rows of A*/ 
    size_t n6    =  dim2;    /*number of columns of B*/
    size_t k6    =  one;     /*number of columns of A*/
    /*-------------------------------------------------------------------*/    
    /* scalar values to use in dgemm */
    /*-------------------------------------------------------------------*/
    double one   =  1.0, zero = 0.0;
    /*-------------------------------------------------------------------*/
    /* Loop over gauss points                                            */
    /*-------------------------------------------------------------------*/
    mwSize igauss;
    for (igauss=0; igauss<n_gauss; ++igauss) {
        /*  FF term  */
        dgemm(cht, chn, &k1, &n1, &m1, &one, &BF[dim*n_node_elem*dim*dim*igauss], &m1, &WFF[dim*dim*dim*dim*igauss], &m1, &zero, BFT_WFF, &k1);        
        dgemm(chn, chn, &m2, &n2, &k2, &one, BFT_WFF, &m2, &BF[dim*n_node_elem*dim*dim*gauss], &k2, &zero, BFT_WFF_BF, &m2);                
        /*  FH term  */
        dgemm(cht, chn, &k1, &n1, &m1, &one, &BF[dim*n_node_elem*dim*dim*igauss], &m1, &WFH[dim*dim*dim*dim*igauss], &m1, &zero, BFT_WFH, &k1);        
        dgemm(chn, chn, &m2, &n2, &k2, &one, BFT_WFH, &m2, &BH[dim*n_node_elem*dim*dim*igauss], &k2, &zero, BFT_WFH_BH, &m2);                
        /*  FJ term  */
        dgemm(cht, chn, &k3, &n3, &m3, &one, &BF[dim*n_node_elem*dim*dim*igauss], &m3, &WFJ[dim*dim*igauss], &m3, &zero, BFT_WFJ, &k3);        
        dgemm(chn, chn, &m4, &n4, &k4, &one, BFT_WFJ, &m4, &BJ[dim*n_node_elem*igauss], &k4, &zero, BFT_WFJ_BJ, &m4);                
        /*  HH term  */
        dgemm(cht, chn, &k1, &n1, &m1, &one, &BH[dim*n_node_elem*dim*dim*igauss], &m1, &WHH[dim*dim*dim*dim*igauss], &m1, &zero, BHT_WHH, &k1);        
        dgemm(chn, chn, &m2, &n2, &k2, &one, BHT_WHH, &m2, &BH[dim*n_node_elem*dim*dim*igauss], &k2, &zero, BHT_WHH_BH, &m2);                
        /*  HJ term  */
        dgemm(cht, chn, &k3, &n3, &m3, &one, &BH[dim*n_node_elem*dim*dim*igauss], &m3, &WHJ[dim*dim*igauss], &m3, &zero, BHT_WHJ, &k3);        
        dgemm(chn, chn, &m4, &n4, &k4, &one, BHT_WHJ, &m4, &BJ[dim*n_node_elem*igauss], &k4, &zero, BHT_WFJ_BJ, &m4);                
        /*  JJ term  */
        dgemm(cht, chn, &k6, &n6, &m6, &one, &BJ[dim2*igauss], &m1, &BJ[dim2*igauss], &m6, &zero, BJT_BJJ, &k6);        
        BJT_WJJ_BJ         =  WJJ[i]*BJT_BJ;
        /*  Geometrical term SigmaH  */
        dgemm(cht, chn, &k1, &n1, &m1, &one, &BF[dim*n_node_elem*dim*dim*igauss], &m1, &GeomSigmaH[dim*dim*dim*dim*igauss], &m1, &zero, BFT_SH, &k1);        
        dgemm(chn, chn, &m2, &n2, &k2, &one, BFT_SH, &m2, &BF[dim*n_node_elem*dim*dim*igauss], &k2, &zero, BFT_SH_BF, &m2);                
        /*  Geometrical term  SigmaJ*/
        dgemm(cht, chn, &k1, &n1, &m1, &one, &BF[dim*n_node_elem*dim*dim*igauss], &m1, &BH[dim*dim*dim*dim*igauss], &m1, &zero, BFT_BH, &k1);        
        BFT_BH_SJ          =  SigmaJ[igauss]*BFT_BH;        
        /*  Constitutive matrix*/       
        for (j=0; j<capacity; ++j){
            Kcons[j]       =  0.5*(BFT_WFF_BF[j] + BFT_WFH_BH[j] + BFT_WFJ_BJ[j] + BHT_WHH_BH[j] + BHT_WHJ_BJ[j] + BJT_WJJ_BJ[j]));
            Kgeom[j]       =  BFT_SH_BF[j] + BFT_BH_SJ[j];
        }        
    }
    /*-------------------------------------------------------------------*/
    /* Symmetrise the constitutive stiffness matrix                      */
    /*-------------------------------------------------------------------*/
    mwSize i, j;
    /* multiply each element y by x */
    for (j=0; j<dim2; j++) {
        for (i=0; i<dim2; i++) {
            Kcons[j*n+i]  +=  Kcons[i*m+j];
            K[j]           =  Kcons[j] + Kgeom[j];
        }
    }        
    /*-------------------------------------------------------------------*/
    /*Free temporaries*/     
    /*-------------------------------------------------------------------*/
    free(BFT);
    free(BHT);
    free(BJT);
    
    free(BFT_WFF);
    free(BFT_WFH);
    free(BFT_WFJ);
    free(BHT_WHH);
    free(BHT_WHJ);
    free(BJT_BJ);
    free(BFT_SH);
    free(BFT_BH);
    
    free(BFT_WFF_BF);
    free(BFT_WFH_BH);
    free(BFT_WFJ_BJ);
    free(BHT_WHH_BH);
    free(BHT_WHJ_BJ);
    free(BJT_WJJ_BJ);    
    free(BFT_SH_BF);
    free(BFT_BH_SJ);
    
    free(Kcons);
    free(Kgeom);
}


