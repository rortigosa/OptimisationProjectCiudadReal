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
        mwSize n_node_elem_x,
        mwSize n_node_elem_phi,
        const double *DNXx,
        const double *DNXphi,
        const double *Elasticity,
        const double *PiezoTensor,
        const double *DielTensor,
        const double *IntWeight,
        double *Kxx,
        double *Kxphi,
        double *Kphix,
        double *Kphiphi)
{
    /*-------------------------------------------------------------------*/
    /*Initialise stiffness matrices*/
    /*-------------------------------------------------------------------*/
    mwSize j;
    for (j=0; j<dim*n_node_elem_x*dim*n_node_elem_x; j++){
        Kxx[j]  =  0.;       
    }
    for (j=0; j<dim*n_node_elem_x*n_node_elem_phi; j++){
        Kxphi[j]  =  0.;       
        Kphix[j]  =  0.;       
    }
    for (j=0; j<n_node_elem_phi*n_node_elem_phi; j++){
        Kphiphi[j]  =  0.;       
    }
    mwSize igauss, anode, bnode;
    /*-------------------------------------------------------------------*/
    /* The function for 2D*/
    /*-------------------------------------------------------------------*/
    if (dim==2){
        double DNXa0, DNXa1, DNXb0, DNXb1;
        double H0, H1, H2, H3, H4, H5, H6, H7, H8, H9, H10, H11, H12, H13, H14, H15;
        double Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7;
        double A0, A1, A2, A3;
        double K00, K10, K01, K11;
        for (igauss=0; igauss<ngauss; igauss++){
            mwSize id  =  dim*dim*dim*dim*igauss;
            /*The Elasticity tensor*/
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
            /*The Piezoelectric tensor*/
            Q0    =  PiezoTensor[id];
            Q1    =  PiezoTensor[id + 1];
            Q2    =  PiezoTensor[id + 2];
            Q3    =  PiezoTensor[id + 3];
            Q4    =  PiezoTensor[id + 4];
            Q5    =  PiezoTensor[id + 5];
            Q6    =  PiezoTensor[id + 6];
            Q7    =  PiezoTensor[id + 7];
            /*The Dielectric tensor*/
            A0    =  DielTensor[id];
            A1    =  DielTensor[id + 1];
            A2    =  DielTensor[id + 2];
            A3    =  DielTensor[id + 3];
            /*-----------------------------------------------------------*/
            /* Kxx                                                       */
            /*-----------------------------------------------------------*/
            for (anode=0; anode<n_node_elem_x; anode++){
                /*DNXa*/
                DNXa0  =  DNXx[dim*n_node_elem_x*igauss + dim*anode];
                DNXa1  =  DNXx[dim*n_node_elem_x*igauss + dim*anode + 1];
                 for (bnode=0; bnode<n_node_elem_x; bnode++){
                     /*DNXb*/
                     DNXb0  =  DNXx[dim*n_node_elem_x*igauss + dim*bnode];
                     DNXb1  =  DNXx[dim*n_node_elem_x*igauss + dim*bnode + 1];
                     /*Elements of the stiffness*/                    
                     K00    =  DNXb0*(DNXa0*H0 + DNXa1*H2) + DNXb1*(DNXa0*H8 + DNXa1*H10);
                     K10    =  DNXb0*(DNXa0*H1 + DNXa1*H3) + DNXb1*(DNXa0*H9 + DNXa1*H11);

                     K01    =  DNXb0*(DNXa0*H4 + DNXa1*H6) + DNXb1*(DNXa0*H12 + DNXa1*H14);
                     K11    =  DNXb0*(DNXa0*H5 + DNXa1*H7) + DNXb1*(DNXa0*H13 + DNXa1*H15);                                        
                     /*Stiffness*/
                     Kxx[dim*n_node_elem_x*dim*bnode + dim*anode]            +=  K00*IntWeight[igauss];
                     Kxx[dim*n_node_elem_x*dim*bnode + dim*anode + 1]        +=  K10*IntWeight[igauss];
                     Kxx[dim*n_node_elem_x*dim*bnode + dim*anode + dim*n_node_elem_x]      +=  K01*IntWeight[igauss];
                     Kxx[dim*n_node_elem_x*dim*bnode + dim*anode + dim*n_node_elem_x + 1]  +=  K11*IntWeight[igauss];                    
                 }            
            }
            /*-----------------------------------------------------------*/
            /* Kxphi                                                     */
            /*-----------------------------------------------------------*/
            for (anode=0; anode<n_node_elem_x; anode++){
                /*DNXa*/
                DNXa0  =  DNXx[dim*n_node_elem_x*igauss + dim*anode];
                DNXa1  =  DNXx[dim*n_node_elem_x*igauss + dim*anode + 1];
                 for (bnode=0; bnode<n_node_elem_phi; bnode++){
                     /*DNXb*/
                     DNXb0  =  DNXphi[dim*n_node_elem_phi*igauss + dim*bnode];
                     DNXb1  =  DNXphi[dim*n_node_elem_phi*igauss + dim*bnode + 1];
                     /*Elements of the stiffness*/                    
                     K00    =  DNXb0*(DNXa0*Q0 + DNXa1*Q2) + DNXb1*(DNXa0*Q4 + DNXa1*Q6);
                     K10    =  DNXb0*(DNXa0*Q1 + DNXa1*Q3) + DNXb1*(DNXa0*Q5 + DNXa1*Q7);
                     /*Stiffness*/
                     Kxphi[dim*n_node_elem_x*bnode + dim*anode]      +=  K00*IntWeight[igauss];
                     Kxphi[dim*n_node_elem_x*bnode + dim*anode + 1]  +=  K10*IntWeight[igauss];
                 }            
            }
            /*-----------------------------------------------------------*/
            /* Kphiphi                                                   */
            /*-----------------------------------------------------------*/
            for (anode=0; anode<n_node_elem_phi; anode++){
                /*DNXa*/
                DNXa0  =  DNXphi[dim*n_node_elem_phi*igauss + dim*anode];
                DNXa1  =  DNXphi[dim*n_node_elem_phi*igauss + dim*anode + 1];
                 for (bnode=0; bnode<n_node_elem_phi; bnode++){
                     /*DNXb*/
                     DNXb0  =  DNXphi[dim*n_node_elem_phi*igauss + dim*bnode];
                     DNXb1  =  DNXphi[dim*n_node_elem_phi*igauss + dim*bnode + 1];
                     /*Elements of the stiffness*/                    
                     K00    =  DNXb0*(A0*DNXa0 + A1*DNXa1) + DNXb1*(A2*DNXa0 + A3*DNXa1);                     
                     /*Stiffness*/
                     Kphiphi[n_node_elem_phi*bnode + anode]   +=  K00*IntWeight[igauss];
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
        double Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15;
        double Q16, Q17, Q18, Q19, Q20, Q21, Q22, Q23, Q24, Q25, Q26;
        double A0, A1, A2, A3, A4, A5, A6, A7, A8;
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
            /*The Piezoelectric tensor*/
            Q0    =  PiezoTensor[id];
            Q1    =  PiezoTensor[id + 1];
            Q2    =  PiezoTensor[id + 2];
            Q3    =  PiezoTensor[id + 3];
            Q4    =  PiezoTensor[id + 4];
            Q5    =  PiezoTensor[id + 5];
            Q6    =  PiezoTensor[id + 6];
            Q7    =  PiezoTensor[id + 7];
            Q8    =  PiezoTensor[id + 8];
            Q9    =  PiezoTensor[id + 9];
            Q10   =  PiezoTensor[id + 10];
            Q11   =  PiezoTensor[id + 11];
            Q12   =  PiezoTensor[id + 12];
            Q13   =  PiezoTensor[id + 13];
            Q14   =  PiezoTensor[id + 14];
            Q15   =  PiezoTensor[id + 15];            
            Q16   =  PiezoTensor[id + 16];            
            Q17   =  PiezoTensor[id + 17];            
            Q18   =  PiezoTensor[id + 18];            
            Q19   =  PiezoTensor[id + 19];            
            Q20   =  PiezoTensor[id + 20];            
            Q21   =  PiezoTensor[id + 21];            
            Q22   =  PiezoTensor[id + 22];            
            Q23   =  PiezoTensor[id + 23];            
            Q24   =  PiezoTensor[id + 24];            
            Q25   =  PiezoTensor[id + 25];            
            Q26   =  PiezoTensor[id + 26];            
            /*The Dielectric tensor*/
            A0    =  DielTensor[id];
            A1    =  DielTensor[id + 1];
            A2    =  DielTensor[id + 2];
            A3    =  DielTensor[id + 3];
            A4    =  DielTensor[id + 4];
            A5    =  DielTensor[id + 5];
            A6    =  DielTensor[id + 6];
            A7    =  DielTensor[id + 7];
            A8    =  DielTensor[id + 8];
            /*-----------------------------------------------------------*/
            /* Kxx                                                       */
            /*-----------------------------------------------------------*/
            for (anode=0; anode<n_node_elem_x; anode++){
                /*DNXa*/
                DNXa0  =  DNXx[dim*n_node_elem_x*igauss + dim*anode];
                DNXa1  =  DNXx[dim*n_node_elem_x*igauss + dim*anode + 1];
                DNXa2  =  DNXx[dim*n_node_elem_x*igauss + dim*anode + 2];
                 for (bnode=0; bnode<n_node_elem_x; bnode++){
                     /*DNXb*/
                     DNXb0  =  DNXx[dim*n_node_elem_x*igauss + dim*bnode];
                     DNXb1  =  DNXx[dim*n_node_elem_x*igauss + dim*bnode + 1];
                     DNXb2  =  DNXx[dim*n_node_elem_x*igauss + dim*bnode + 2];
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
                    Kxx[dim*n_node_elem_x*dim*bnode + dim*anode]            +=  K00*IntWeight[igauss];
                    Kxx[dim*n_node_elem_x*dim*bnode + dim*anode + 1]        +=  K10*IntWeight[igauss];
                    Kxx[dim*n_node_elem_x*dim*bnode + dim*anode + 2]        +=  K20*IntWeight[igauss];                    
                    Kxx[dim*n_node_elem_x*dim*bnode + dim*anode + dim*n_node_elem_x]        +=  K01*IntWeight[igauss];
                    Kxx[dim*n_node_elem_x*dim*bnode + dim*anode + dim*n_node_elem_x + 1]    +=  K11*IntWeight[igauss];                    
                    Kxx[dim*n_node_elem_x*dim*bnode + dim*anode + dim*n_node_elem_x + 2]    +=  K21*IntWeight[igauss];                    
                    Kxx[dim*n_node_elem_x*dim*bnode + dim*anode + 2*dim*n_node_elem_x]      +=  K02*IntWeight[igauss];
                    Kxx[dim*n_node_elem_x*dim*bnode + dim*anode + 2*dim*n_node_elem_x + 1]  +=  K12*IntWeight[igauss];                    
                    Kxx[dim*n_node_elem_x*dim*bnode + dim*anode + 2*dim*n_node_elem_x + 2]  +=  K22*IntWeight[igauss];                    
                 }            
            }
            /*-----------------------------------------------------------*/
            /* Kxphi                                                     */
            /*-----------------------------------------------------------*/
            for (anode=0; anode<n_node_elem_x; anode++){
                /*DNXa*/
                DNXa0  =  DNXx[dim*n_node_elem_x*igauss + dim*anode];
                DNXa1  =  DNXx[dim*n_node_elem_x*igauss + dim*anode + 1];
                DNXa2  =  DNXx[dim*n_node_elem_x*igauss + dim*anode + 2];
                 for (bnode=0; bnode<n_node_elem_phi; bnode++){
                     /*DNXb*/
                     DNXb0  =  DNXphi[dim*n_node_elem_phi*igauss + dim*bnode];
                     DNXb1  =  DNXphi[dim*n_node_elem_phi*igauss + dim*bnode + 1];
                     DNXb2  =  DNXphi[dim*n_node_elem_phi*igauss + dim*bnode + 2];
                    /*Elements of the stiffness*/                    
                    K00     =  DNXb0*(DNXa0*Q0 + DNXa1*Q3 + DNXa2*Q6) + DNXb1*(DNXa0*Q9 + DNXa1*Q12 + DNXa2*Q15)  + DNXb2*(DNXa0*Q18 + DNXa1*Q21 + DNXa2*Q24);
                    K10     =  DNXb0*(DNXa0*Q1 + DNXa1*Q4 + DNXa2*Q7) + DNXb1*(DNXa0*Q10 + DNXa1*Q13 + DNXa2*Q16) + DNXb2*(DNXa0*Q19 + DNXa1*Q22 + DNXa2*Q25);
                    K20     =  DNXb0*(DNXa0*Q2 + DNXa1*Q5 + DNXa2*Q8) + DNXb1*(DNXa0*Q11 + DNXa1*Q14 + DNXa2*Q17) + DNXb2*(DNXa0*Q20 + DNXa1*Q23 + DNXa2*Q26);
                    /*Stiffness*/
                    Kxphi[dim*n_node_elem_x*bnode + dim*anode]      +=  K00*IntWeight[igauss];
                    Kxphi[dim*n_node_elem_x*bnode + dim*anode + 1]  +=  K10*IntWeight[igauss];
                    Kxphi[dim*n_node_elem_x*bnode + dim*anode + 2]  +=  K20*IntWeight[igauss];                    
                 }            
            }
            /*-----------------------------------------------------------*/
            /* Kphiphi                                                     */
            /*-----------------------------------------------------------*/
            for (anode=0; anode<n_node_elem_phi; anode++){
                /*DNXa*/
                DNXa0  =  DNXx[dim*n_node_elem_phi*igauss + dim*anode];
                DNXa1  =  DNXx[dim*n_node_elem_phi*igauss + dim*anode + 1];
                DNXa2  =  DNXx[dim*n_node_elem_phi*igauss + dim*anode + 2];
                 for (bnode=0; bnode<n_node_elem_phi; bnode++){
                     /*DNXb*/
                     DNXb0  =  DNXphi[dim*n_node_elem_phi*igauss + dim*bnode];
                     DNXb1  =  DNXphi[dim*n_node_elem_phi*igauss + dim*bnode + 1];
                     DNXb2  =  DNXphi[dim*n_node_elem_phi*igauss + dim*bnode + 2];
                    /*Elements of the stiffness*/                    
                    K00     =  DNXb0*(A0*DNXa0* + A1*DNXa1 + A2*DNXa2) + DNXb1*(A3*DNXa0 + A4*DNXa1 + A5*DNXa2) + DNXb2*(A6*DNXa0 + A7*DNXa1 + A8*DNXa2);
                    /*Stiffness*/
                    Kphiphi[n_node_elem_phi*bnode + anode]      +=  K00*IntWeight[igauss];
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
    size_t dim, ngauss, n_node_elem_x, n_node_elem_phi;
    const mwSize  *dims_DNX; 
    double *DNXx;  
    double *DNXphi;  
    double *Elasticity;  
    double *PiezoTensor;
    double *DielTensor;
    double *IntWeight; 
    /*-------------------------------------------------------------------*/
    /* outputs */
    /*-------------------------------------------------------------------*/
    double *Kxx;
    double *Kxphi;
    double *Kphix;
    double *Kphiphi;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dims_DNXx          =  mxGetDimensions(prhs[0]);
    dims_DNXphi        =  mxGetDimensions(prhs[1]);
    dim                =  (size_t)dims_DNXx[0];    
    n_node_elem_x      =  (size_t)dims_DNXx[1];    
    n_node_elem_phi    =  (size_t)dims_DNXphi[1];    
    ngauss             =  (size_t)dims_DNX[2];    
    DNXx               =  mxGetPr(prhs[0]);
    DNXphi             =  mxGetPr(prhs[1]);
    Elasticity         =  mxGetPr(prhs[2]);
    PiezoTensor        =  mxGetPr(prhs[3]);
    DielTensor         =  mxGetPr(prhs[4]);
    IntWeight          =  mxGetPr(prhs[5]);
    /*-------------------------------------------------------------------*/
    /* get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    plhs[0]            =  mxCreateDoubleMatrix((mwSize)n_node_elem_x*dim, (mwSize)n_node_elem_x*dim, mxREAL);
    plhs[1]            =  mxCreateDoubleMatrix((mwSize)n_node_elem_x*dim, (mwSize)n_node_elem_phi,   mxREAL);
    plhs[2]            =  mxCreateDoubleMatrix((mwSize)n_node_elem_phi,   (mwSize)n_node_elem_x*dim, mxREAL);
    plhs[3]            =  mxCreateDoubleMatrix((mwSize)n_node_elem_phi    (mwSize)n_node_elem_phi,   mxREAL);
    Kxx                =  mxGetPr(plhs[0]);
    Kxphi              =  mxGetPr(plhs[1]);
    Kphix              =  mxGetPr(plhs[2]);
    Kphiphi            =  mxGetPr(plhs[3]);
    /*-------------------------------------------------------------------*/
    /* call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dim,(mwSize)ngauss,(mwSize)n_node_elem_x, (mwSize)n_node_elem_phi, DNXx, DNXphi, Elasticity, PiezoTensor, DielTensor, IntWeight, Kxx, Kxphi, Kphix, Kphiphi);
}


