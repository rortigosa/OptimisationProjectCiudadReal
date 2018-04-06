#include "mex.h"
#include "matfunctions.h"

/* */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* The C function */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void perfomer(mwSize dim,
        mwSize ngauss,
        mwSize n_node_elem,
        const double *DNX,
        const double *Elasticity,
        const double *IntWeight,
        double *Kxx)
{
    /*-------------------------------------------------------------------*/
    /*Initialise stiffness matrices*/
    /*-------------------------------------------------------------------*/
    mwSize j;
    for (j=0; j<dim*n_node_elem*dim*n_node_elem; j++){
        Kxx[j]  =  0.;       
    }
    mwSize igauss, anode, bnode;
    /*-------------------------------------------------------------------*/
    /* The function for 2D*/
    /*-------------------------------------------------------------------*/
    if (dim==2){
        double DNXa0, DNXa1, DNXb0, DNXb1;
        double H0, H1, H2, H3, H4, H5, H6, H7, H8, H9, H10, H11, H12, H13, H14, H15;
        double K00, K10, K01, K11;
        for (igauss=0; igauss<ngauss; igauss++){
            mwSize id  =  dim*dim*dim*dim*igauss;
            /*The Hessian*/
            H0    =  Elasticity[id];
            H1    =  Elasticity[id + 1];
            H2    =  Elasticity[id + 2];
            H3    =  Elasticity[id + 3];
            H4    =  Elasticity[id + 4];
            H5    =  Elasticity[id + 5];
            H6    =  Elasticity[id + 6];
            H7    =  Elasticity[id + 7];
            H8    =  Elasticity[id + 8];
            H9    =  Elasticity[id + 9];
            H10   =  Elasticity[id + 10];
            H11   =  Elasticity[id + 11];
            H12   =  Elasticity[id + 12];
            H13   =  Elasticity[id + 13];
            H14   =  Elasticity[id + 14];
            H15   =  Elasticity[id + 15];            
            /*-----------------------------------------------------------*/
            /* Kxx                                                       */
            /*-----------------------------------------------------------*/
            for (anode=0; anode<n_node_elem; anode++){
                /*DNXb*/
                DNXa0  =  DNX[dim*n_node_elem*igauss + dim*anode];
                DNXa1  =  DNX[dim*n_node_elem*igauss + dim*anode + 1];
                 for (bnode=0; bnode<n_node_elem; bnode++){
                     /*DNXa*/
                     DNXb0  =  DNX[dim*n_node_elem*igauss + dim*bnode];
                     DNXb1  =  DNX[dim*n_node_elem*igauss + dim*bnode + 1];
                    /*Elements of the stiffness*/                    
                    K00     =  DNXb0*(DNXa0*H0 + DNXa1*H2) + DNXb1*(DNXa0*H8 + DNXa1*H10);
                    K10     =  DNXb0*(DNXa0*H1 + DNXa1*H3) + DNXb1*(DNXa0*H9 + DNXa1*H11);

                    K01     =  DNXb0*(DNXa0*H4 + DNXa1*H6) + DNXb1*(DNXa0*H12 + DNXa1*H14);
                    K11     =  DNXb0*(DNXa0*H5 + DNXa1*H7) + DNXb1*(DNXa0*H13 + DNXa1*H15);                                        
                    /*Stiffness*/
                    Kxx[dim*n_node_elem*dim*bnode + dim*anode]            +=  K00*IntWeight[igauss];
                    Kxx[dim*n_node_elem*dim*bnode + dim*anode + 1]        +=  K10*IntWeight[igauss];
                    Kxx[dim*n_node_elem*dim*bnode + dim*anode + dim*n_node_elem]        +=  K01*IntWeight[igauss];
                    Kxx[dim*n_node_elem*dim*bnode + dim*anode + dim*n_node_elem + 1]    +=  K11*IntWeight[igauss];                    
                 }            
            }
        }
    }
    /*-------------------------------------------------------------------*/
    /* The function for 3D*/
    /*-------------------------------------------------------------------*/
    else if (dim==3){
        double DNXa0, DNXa1, DNXa2, DNXb0, DNXb1, DNXb2, Npa;
        double H0, H1, H2, H3, H4, H5, H6, H7, H8, H9, H10, H11, H12, H13, H14, H15;
        double H16, H17, H18, H19, H20, H21, H22, H23, H24, H25, H26, H27, H28;  
        double H29, H30, H31, H32, H33, H34, H35, H36, H37, H38, H39, H40, H41;
        double H42, H43, H44, H45, H46, H47, H48, H49, H50, H51, H52, H53, H54;
        double H55, H56, H57, H58, H59, H60, H61, H62, H63, H64, H65, H66, H67;
        double H68, H69, H70, H71, H72, H73, H74, H75, H76, H77, H78, H79, H80;
        double K00, K10, K20, K01, K11, K21, K02, K12, K22;
        for (igauss=0; igauss<ngauss; igauss++){
            mwSize id  =  dim*dim*dim*dim*igauss;
            /*The Hessian*/
            H0    =  Elasticity[id];
            H1    =  Elasticity[id + 1];
            H2    =  Elasticity[id + 2];
            H3    =  Elasticity[id + 3];
            H4    =  Elasticity[id + 4];
            H5    =  Elasticity[id + 5];
            H6    =  Elasticity[id + 6];
            H7    =  Elasticity[id + 7];
            H8    =  Elasticity[id + 8];
            H9    =  Elasticity[id + 9];
            H10   =  Elasticity[id + 10];
            H11   =  Elasticity[id + 11];
            H12   =  Elasticity[id + 12];
            H13   =  Elasticity[id + 13];
            H14   =  Elasticity[id + 14];
            H15   =  Elasticity[id + 15];            
            H16   =  Elasticity[id + 16];            
            H17   =  Elasticity[id + 17];            
            H18   =  Elasticity[id + 18];            
            H19   =  Elasticity[id + 19];            
            H20   =  Elasticity[id + 20];            
            H21   =  Elasticity[id + 21];            
            H22   =  Elasticity[id + 22];            
            H23   =  Elasticity[id + 23];            
            H24   =  Elasticity[id + 24];            
            H25   =  Elasticity[id + 25];            
            H26   =  Elasticity[id + 26];            
            H27   =  Elasticity[id + 27];            
            H28   =  Elasticity[id + 28];            
            H29   =  Elasticity[id + 29];            
            H30   =  Elasticity[id + 30];            
            H31   =  Elasticity[id + 31];            
            H32   =  Elasticity[id + 32];            
            H33   =  Elasticity[id + 33];            
            H34   =  Elasticity[id + 34];            
            H35   =  Elasticity[id + 35];            
            H36   =  Elasticity[id + 36];            
            H37   =  Elasticity[id + 37];            
            H38   =  Elasticity[id + 38];            
            H39   =  Elasticity[id + 39];            
            H40   =  Elasticity[id + 40];            
            H41   =  Elasticity[id + 41];            
            H42   =  Elasticity[id + 42];            
            H43   =  Elasticity[id + 43];            
            H44   =  Elasticity[id + 44];            
            H45   =  Elasticity[id + 45];            
            H46   =  Elasticity[id + 46];            
            H47   =  Elasticity[id + 47];            
            H48   =  Elasticity[id + 48];            
            H49   =  Elasticity[id + 49];            
            H50   =  Elasticity[id + 50];            
            H51   =  Elasticity[id + 51];            
            H52   =  Elasticity[id + 52];            
            H53   =  Elasticity[id + 53];            
            H54   =  Elasticity[id + 54];            
            H55   =  Elasticity[id + 55];            
            H56   =  Elasticity[id + 56];            
            H57   =  Elasticity[id + 57];            
            H58   =  Elasticity[id + 58];            
            H59   =  Elasticity[id + 59];            
            H60   =  Elasticity[id + 60];            
            H61   =  Elasticity[id + 61];            
            H62   =  Elasticity[id + 62];            
            H63   =  Elasticity[id + 63];            
            H64   =  Elasticity[id + 64];            
            H65   =  Elasticity[id + 65];            
            H66   =  Elasticity[id + 66];            
            H67   =  Elasticity[id + 67];            
            H68   =  Elasticity[id + 68];            
            H69   =  Elasticity[id + 69];            
            H70   =  Elasticity[id + 70];            
            H71   =  Elasticity[id + 71];            
            H72   =  Elasticity[id + 72];            
            H73   =  Elasticity[id + 73];            
            H74   =  Elasticity[id + 74];            
            H75   =  Elasticity[id + 75];            
            H76   =  Elasticity[id + 76];            
            H77   =  Elasticity[id + 77];            
            H78   =  Elasticity[id + 78];            
            H79   =  Elasticity[id + 79];            
            H80   =  Elasticity[id + 80];            
            /*-----------------------------------------------------------*/
            /* Kxx                                                       */
            /*-----------------------------------------------------------*/
            for (anode=0; anode<n_node_elem; anode++){
                /*DNXb*/
                DNXa0  =  DNX[dim*n_node_elem*igauss + dim*anode];
                DNXa1  =  DNX[dim*n_node_elem*igauss + dim*anode + 1];
                DNXa2  =  DNX[dim*n_node_elem*igauss + dim*anode + 2];
                 for (bnode=0; bnode<n_node_elem; bnode++){
                     /*DNXa*/
                     DNXb0  =  DNX[dim*n_node_elem*igauss + dim*bnode];
                     DNXb1  =  DNX[dim*n_node_elem*igauss + dim*bnode + 1];
                     DNXb2  =  DNX[dim*n_node_elem*igauss + dim*bnode + 2];
                    /*Elements of the stiffness*/                    
                    K00     =  DNXb0*(DNXa0*H0  + DNXa1*H3 + DNXa2*H6)   + DNXb1*(DNXa0*H27 + DNXa1*H30 + DNXa2*H33) + DNXb2*(DNXa0*H54 + DNXa1*H57 + DNXa2*H60);
                    K10     =  DNXb0*(DNXa0*H1  + DNXa1*H4 + DNXa2*H7)   + DNXb1*(DNXa0*H28 + DNXa1*H31 + DNXa2*H34) + DNXb2*(DNXa0*H55 + DNXa1*H58 + DNXa2*H61);
                    K20     =  DNXb0*(DNXa0*H2  + DNXa1*H5 + DNXa2*H8)   + DNXb1*(DNXa0*H29 + DNXa1*H32 + DNXa2*H35) + DNXb2*(DNXa0*H56 + DNXa1*H59 + DNXa2*H62);

                    K01     =  DNXb0*(DNXa0*H9  + DNXa1*H12 + DNXa2*H15) + DNXb1*(DNXa0*H36 + DNXa1*H39 + DNXa2*H42) + DNXb2*(DNXa0*H63 + DNXa1*H66 + DNXa2*H69);
                    K11     =  DNXb0*(DNXa0*H10 + DNXa1*H13 + DNXa2*H16) + DNXb1*(DNXa0*H37 + DNXa1*H40 + DNXa2*H43) + DNXb2*(DNXa0*H64 + DNXa1*H67 + DNXa2*H70);                                        
                    K21     =  DNXb0*(DNXa0*H11 + DNXa1*H14 + DNXa2*H17) + DNXb1*(DNXa0*H38 + DNXa1*H41 + DNXa2*H44) + DNXb2*(DNXa0*H65 + DNXa1*H68 + DNXa2*H71);

                    K02     =  DNXb0*(DNXa0*H18 + DNXa1*H21 + DNXa2*H24) + DNXb1*(DNXa0*H45 + DNXa1*H48 + DNXa2*H51) + DNXb2*(DNXa0*H72 + DNXa1*H75 + DNXa2*H78);
                    K12     =  DNXb0*(DNXa0*H19 + DNXa1*H22 + DNXa2*H25) + DNXb1*(DNXa0*H46 + DNXa1*H49 + DNXa2*H52) + DNXb2*(DNXa0*H73 + DNXa1*H76 + DNXa2*H79);
                    K22     =  DNXb0*(DNXa0*H20 + DNXa1*H23 + DNXa2*H26) + DNXb1*(DNXa0*H47 + DNXa1*H50 + DNXa2*H53) + DNXb2*(DNXa0*H74 + DNXa1*H77 + DNXa2*H80);
                    /*Stiffness*/
                    Kxx[dim*n_node_elem*dim*bnode + dim*anode]            +=  K00*IntWeight[igauss];
                    Kxx[dim*n_node_elem*dim*bnode + dim*anode + 1]        +=  K10*IntWeight[igauss];
                    Kxx[dim*n_node_elem*dim*bnode + dim*anode + 2]        +=  K20*IntWeight[igauss];                    
                    Kxx[dim*n_node_elem*dim*bnode + dim*anode + dim*n_node_elem]        +=  K01*IntWeight[igauss];
                    Kxx[dim*n_node_elem*dim*bnode + dim*anode + dim*n_node_elem + 1]    +=  K11*IntWeight[igauss];                    
                    Kxx[dim*n_node_elem*dim*bnode + dim*anode + dim*n_node_elem + 2]    +=  K21*IntWeight[igauss];                    
                    Kxx[dim*n_node_elem*dim*bnode + dim*anode + 2*dim*n_node_elem]      +=  K02*IntWeight[igauss];
                    Kxx[dim*n_node_elem*dim*bnode + dim*anode + 2*dim*n_node_elem + 1]  +=  K12*IntWeight[igauss];                    
                    Kxx[dim*n_node_elem*dim*bnode + dim*anode + 2*dim*n_node_elem + 2]  +=  K22*IntWeight[igauss];                    
                 }            
            }
        }
    }
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
    /*Inputs and declaration*/
    /*-------------------------------------------------------------------*/
    size_t dim, ngauss, n_node_elem;
    const mwSize  *dims_DNX; 
    double *DNX;  
    double *Elasticity;  
    double *IntWeight; 
    /*-------------------------------------------------------------------*/
    /* outputs */
    /*-------------------------------------------------------------------*/
    double *Kxx;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dims_DNX           =  mxGetDimensions(prhs[0]);
    dim                =  (size_t)dims_DNX[0];    
    n_node_elem        =  (size_t)dims_DNX[1];    
    ngauss             =  (size_t)dims_DNX[2];    
    DNX                =  mxGetPr(prhs[0]);
    Elasticity         =  mxGetPr(prhs[1]);
    IntWeight          =  mxGetPr(prhs[2]);
    /*-------------------------------------------------------------------*/
    /* get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    plhs[0]            =  mxCreateDoubleMatrix((mwSize)n_node_elem*dim, (mwSize)n_node_elem*dim, mxREAL);
    Kxx                =  mxGetPr(plhs[0]);
    /*-------------------------------------------------------------------*/
    /* call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dim,(mwSize)ngauss,(mwSize)n_node_elem,DNX, Elasticity, IntWeight,Kxx);
}


