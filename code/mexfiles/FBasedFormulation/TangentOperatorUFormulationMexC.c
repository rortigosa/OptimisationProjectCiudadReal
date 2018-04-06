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
        const double *H,
        const double *IntWeight,
        double *Kmatrix)
{
    /*-------------------------------------------------------------------*/
    /*DNX and Second Piola S*/
    /*-------------------------------------------------------------------*/
    mwSize j;
    for (j=0; j<dim*n_node_elem*dim*n_node_elem; j++){
        Kmatrix[j]  =  0.;       
    }
    mwSize igauss, anode, bnode;
    /*-------------------------------------------------------------------*/
    /* The function for 2D*/
    /*-------------------------------------------------------------------*/
    if (dim==2){
        double DNXa0, DNXa1, DNXb0, DNXb1;
        double H0, H1, H2, H3, H4, H5, H6, H7, H8, H9, H10, H11, H12, H13, H14, H15;
        double K00, K01, K10, K11;
        for (igauss=0; igauss<ngauss; igauss++){
            mwSize id  =  dim*dim*dim*dim*igauss;
            /*The Hessian*/
            H0    =  H[id];
            H1    =  H[id + 1];
            H2    =  H[id + 2];
            H3    =  H[id + 3];
            H4    =  H[id + 4];
            H5    =  H[id + 5];
            H6    =  H[id + 6];
            H7    =  H[id + 7];
            H8    =  H[id + 8];
            H9    =  H[id + 9];
            H10   =  H[id + 10];
            H11   =  H[id + 11];
            H12   =  H[id + 12];
            H13   =  H[id + 13];
            H14   =  H[id + 14];
            H15   =  H[id + 15];
            for (anode=0; anode<n_node_elem; anode++){
                /*DNXa*/
                DNXa0  =  DNX[dim*n_node_elem*igauss + dim*anode];
                DNXa1  =  DNX[dim*n_node_elem*igauss + dim*anode + 1];
                for (bnode=0; bnode<n_node_elem; bnode++){
                    /*DNXb*/
                    DNXb0      =  DNX[dim*n_node_elem*igauss + dim*bnode];
                    DNXb1      =  DNX[dim*n_node_elem*igauss + dim*bnode + 1];
                    /*Elements of the stiffness*/                    
                    K00        =  DNXb0*(DNXa0*H0 + DNXa1*H1) + DNXb1*(DNXa0*H4 + DNXa1*H5);
                    K10        =  DNXb0*(DNXa0*H2 + DNXa1*H3) + DNXb1*(DNXa0*H6 + DNXa1*H7);
                    K01        =  DNXb0*(DNXa0*H8 + DNXa1*H9) + DNXb1*(DNXa0*H12 + DNXa1*H13);
                    K11        =  DNXb0*(DNXa0*H10 + DNXa1*H11) + DNXb1*(DNXa0*H14 + DNXa1*H15);
                    /*Stiffness matrix*/
                    Kmatrix[dim*n_node_elem*dim*bnode + dim*anode]        +=  K00*IntWeight[igauss];
                    Kmatrix[dim*n_node_elem*dim*bnode + dim*anode + 1]    +=  K10*IntWeight[igauss];
                    Kmatrix[dim*n_node_elem*dim*bnode + dim*n_node_elem + dim*anode]      +=  K01*IntWeight[igauss];
                    Kmatrix[dim*n_node_elem*dim*bnode + dim*n_node_elem + dim*anode + 1]  +=  K11*IntWeight[igauss];
                }            
            }
        }
    }
    /*-------------------------------------------------------------------*/
    /* The function for 3D*/
    /*-------------------------------------------------------------------*/
    else if (dim==3){
        double DNXa0, DNXa1, DNXa2, DNXb0, DNXb1, DNXb2;
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
            H0    =  H[id];
            H1    =  H[id + 1];
            H2    =  H[id + 2];
            H3    =  H[id + 3];
            H4    =  H[id + 4];
            H5    =  H[id + 5];
            H6    =  H[id + 6];
            H7    =  H[id + 7];
            H8    =  H[id + 8];
            H9    =  H[id + 9];
            H10   =  H[id + 10];
            H11   =  H[id + 11];
            H12   =  H[id + 12];
            H13   =  H[id + 13];
            H14   =  H[id + 14];
            H15   =  H[id + 15];            
            H16   =  H[id + 16];            
            H17   =  H[id + 17];            
            H18   =  H[id + 18];            
            H19   =  H[id + 19];            
            H20   =  H[id + 20];            
            H21   =  H[id + 21];            
            H22   =  H[id + 22];            
            H23   =  H[id + 23];            
            H24   =  H[id + 24];            
            H25   =  H[id + 25];            
            H26   =  H[id + 26];            
            H27   =  H[id + 27];            
            H28   =  H[id + 28];            
            H29   =  H[id + 29];            
            H30   =  H[id + 30];            
            H31   =  H[id + 31];            
            H32   =  H[id + 32];            
            H33   =  H[id + 33];            
            H34   =  H[id + 34];            
            H35   =  H[id + 35];            
            H36   =  H[id + 36];            
            H37   =  H[id + 37];            
            H38   =  H[id + 38];            
            H39   =  H[id + 39];            
            H40   =  H[id + 30];            
            H41   =  H[id + 41];            
            H42   =  H[id + 42];            
            H43   =  H[id + 43];            
            H44   =  H[id + 44];            
            H45   =  H[id + 45];            
            H46   =  H[id + 46];            
            H47   =  H[id + 47];            
            H48   =  H[id + 48];            
            H49   =  H[id + 49];            
            H50   =  H[id + 50];            
            H51   =  H[id + 51];            
            H52   =  H[id + 52];            
            H53   =  H[id + 53];            
            H54   =  H[id + 54];            
            H55   =  H[id + 55];            
            H56   =  H[id + 56];            
            H57   =  H[id + 57];            
            H58   =  H[id + 58];            
            H59   =  H[id + 59];            
            H60   =  H[id + 60];            
            H61   =  H[id + 61];            
            H62   =  H[id + 62];            
            H63   =  H[id + 63];            
            H64   =  H[id + 64];            
            H65   =  H[id + 65];            
            H66   =  H[id + 66];            
            H67   =  H[id + 67];            
            H68   =  H[id + 68];            
            H69   =  H[id + 69];            
            H70   =  H[id + 70];            
            H71   =  H[id + 71];            
            H72   =  H[id + 72];            
            H73   =  H[id + 73];            
            H74   =  H[id + 74];            
            H75   =  H[id + 75];            
            H76   =  H[id + 76];            
            H77   =  H[id + 77];            
            H78   =  H[id + 78];            
            H79   =  H[id + 79];            
            H80   =  H[id + 80];            
            for (anode=0; anode<n_node_elem; anode++){
                /*DNXa*/
                DNXa0  =  DNX[dim*n_node_elem*igauss + dim*anode];
                DNXa1  =  DNX[dim*n_node_elem*igauss + dim*anode + 1];
                DNXa2  =  DNX[dim*n_node_elem*igauss + dim*anode + 2];
                 for (bnode=0; bnode<n_node_elem; bnode++){
                     /*DNXb*/
                     DNXb0  =  DNX[dim*n_node_elem*igauss + dim*bnode];
                     DNXb1  =  DNX[dim*n_node_elem*igauss + dim*bnode + 1];
                     DNXb2  =  DNX[dim*n_node_elem*igauss + dim*bnode + 2];
                    /*Elements of the stiffness*/                    
                    K00     =  DNXb0*(DNXa0*H0 + DNXa1*H1 + DNXa2*H2) + DNXb1*(DNXa0*H9 + DNXa1*H10 + DNXa2*H11) + DNXb2*(DNXa0*H18 + DNXa1*H19 + DNXa2*H20);
                    K10     =  DNXb0*(DNXa0*H3 + DNXa1*H4 + DNXa2*H5) + DNXb1*(DNXa0*H12 + DNXa1*H13 + DNXa2*H14) + DNXb2*(DNXa0*H21 + DNXa1*H22 + DNXa2*H23);
                    K20     =  DNXb0*(DNXa0*H6 + DNXa1*H7 + DNXa2*H8) + DNXb1*(DNXa0*H15 + DNXa1*H16 + DNXa2*H17) + DNXb2*(DNXa0*H24 + DNXa1*H25 + DNXa2*H26);
                    K01     =  DNXb0*(DNXa0*H27 + DNXa1*H28 + DNXa2*H29) + DNXb1*(DNXa0*H36 + DNXa1*H37 + DNXa2*H38) + DNXb2*(DNXa0*H45 + DNXa1*H46 + DNXa2*H47);
                    K11     =  DNXb0*(DNXa0*H30 + DNXa1*H31 + DNXa2*H32) + DNXb1*(DNXa0*H39 + DNXa1*H40 + DNXa2*H41) + DNXb2*(DNXa0*H48 + DNXa1*H49 + DNXa2*H50);
                    K21     =  DNXb0*(DNXa0*H33 + DNXa1*H34 + DNXa2*H35) + DNXb1*(DNXa0*H42 + DNXa1*H43 + DNXa2*H44) + DNXb2*(DNXa0*H51 + DNXa1*H52 + DNXa2*H53);
                    K02     =  DNXb0*(DNXa0*H54 + DNXa1*H55 + DNXa2*H56) + DNXb1*(DNXa0*H63 + DNXa1*H64 + DNXa2*H65) + DNXb2*(DNXa0*H72 + DNXa1*H73 + DNXa2*H74);
                    K12     =  DNXb0*(DNXa0*H57 + DNXa1*H58 + DNXa2*H59) + DNXb1*(DNXa0*H66 + DNXa1*H67 + DNXa2*H68) + DNXb2*(DNXa0*H75 + DNXa1*H76 + DNXa2*H77);
                    K22     =  DNXb0*(DNXa0*H60 + DNXa1*H61 + DNXa2*H62) + DNXb1*(DNXa0*H69 + DNXa1*H70 + DNXa2*H71) + DNXb2*(DNXa0*H78 + DNXa1*H79 + DNXa2*H80);
                    /*Stiffness*/
                    Kmatrix[dim*n_node_elem*dim*bnode + dim*anode]        +=  K00*IntWeight[igauss];
                    Kmatrix[dim*n_node_elem*dim*bnode + dim*anode + 1]    +=  K10*IntWeight[igauss];
                    Kmatrix[dim*n_node_elem*dim*bnode + dim*anode + 2]    +=  K20*IntWeight[igauss];                    
                    Kmatrix[dim*n_node_elem*dim*bnode + dim*n_node_elem + dim*anode]        +=  K01*IntWeight[igauss];
                    Kmatrix[dim*n_node_elem*dim*bnode + dim*n_node_elem + dim*anode + 1]    +=  K11*IntWeight[igauss];                    
                    Kmatrix[dim*n_node_elem*dim*bnode + dim*n_node_elem + dim*anode + 2]    +=  K21*IntWeight[igauss];                    
                    Kmatrix[dim*n_node_elem*dim*bnode + 2*dim*n_node_elem + dim*anode]      +=  K01*IntWeight[igauss];
                    Kmatrix[dim*n_node_elem*dim*bnode + 2*dim*n_node_elem + dim*anode + 1]  +=  K11*IntWeight[igauss];                    
                    Kmatrix[dim*n_node_elem*dim*bnode + 2*dim*n_node_elem + dim*anode + 2]  +=  K21*IntWeight[igauss];                    
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
    const mwSize  *dims_DNX; /* input scalar */
    double *DNX;        /* input matrix */
    double *H;          /* input matrix */
    double *IntWeight;  /* input matrix */
    /*-------------------------------------------------------------------*/
    /* outputs */
    /*-------------------------------------------------------------------*/
    double *Kmatrix;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dims_DNX           =  mxGetDimensions(prhs[0]);
    dim                =  (size_t)dims_DNX[0];    
    n_node_elem        =  (size_t)dims_DNX[1];    
    ngauss             =  (size_t)dims_DNX[2];    
    DNX                =  mxGetPr(prhs[0]);
    H                  =  mxGetPr(prhs[1]);
    IntWeight          =  mxGetPr(prhs[2]);
    /*-------------------------------------------------------------------*/
    /* get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    plhs[0]            =  mxCreateDoubleMatrix((mwSize)n_node_elem*dim, (mwSize)n_node_elem*dim, mxREAL);
    Kmatrix            =  mxGetPr(plhs[0]);
    /*-------------------------------------------------------------------*/
    /* call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dim,(mwSize)ngauss,(mwSize)n_node_elem,DNX,H,IntWeight,Kmatrix);
}


