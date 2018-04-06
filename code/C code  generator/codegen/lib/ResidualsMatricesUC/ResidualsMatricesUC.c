/*
 * File: ResidualsMatricesUC.c
 *
 * MATLAB Coder version            : 3.0
 * C/C++ source code generated on  : 16-Nov-2017 12:07:55
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "ResidualsMatricesUC.h"
#include "ResidualsMatricesUC_emxutil.h"

/* Function Definitions */

/*
 * Arguments    : struct0_T *asmb
 *                const struct1_T *derivatives
 *                const double Piola_vect[16]
 *                const struct4_T *vect_kin
 *                const struct5_T *kinematics
 *                const double IntWeight[4]
 *                double dim
 *                double n_node_elem
 *                double ngauss
 * Return Type  : void
 */
void ResidualsMatricesUC(struct0_T *asmb, const struct1_T *derivatives, const
  double Piola_vect[16], const struct4_T *vect_kin, const struct5_T *kinematics,
  const double IntWeight[4], double dim, double n_node_elem, double ngauss)
{
  int igauss;
  emxArray_real_T *BFxT;
  emxArray_real_T *BHxT;
  emxArray_real_T *BJxT;
  emxArray_real_T *b_vect_kin;
  emxArray_real_T *y;
  emxArray_real_T *b_kinematics;
  emxArray_real_T *b_y;
  emxArray_real_T *c_vect_kin;
  emxArray_real_T *c_y;
  int i0;
  int i1;
  double y_data[64];
  int cr;
  int ic;
  int br;
  int ar;
  int ib;
  double b_y_data[64];
  int ia;
  double vect_kin_data[64];
  double x_data[4];
  double a_data[4];
  double c_y_data[8];
  double b_vect_kin_data[32];
  double d_y_data[32];
  double e_y_data[64];
  double f_y_data[64];
  double KFJ_data[64];
  double g_y_data[64];
  double KHJ_data[64];
  double h_y_data[64];
  int KJJ_size_idx_0;
  double KJJ_data[64];
  double i_y_data[64];
  double C_data[64];
  double j_y_data[64];
  double b_a_data[32];
  double k_y_data[8];
  (void)dim;
  (void)n_node_elem;

  /* -------------------------------------------------------------------------- */
  /* -------------------------------------------------------------------------- */
  /*  Residuals and Stiffness matrices */
  /* -------------------------------------------------------------------------- */
  /* -------------------------------------------------------------------------- */
  igauss = 0;
  emxInit_real_T(&BFxT, 2);
  emxInit_real_T(&BHxT, 2);
  emxInit_real_T(&BJxT, 2);
  emxInit_real_T(&b_vect_kin, 2);
  emxInit_real_T(&y, 2);
  emxInit_real_T(&b_kinematics, 2);
  emxInit_real_T(&b_y, 2);
  emxInit_real_T(&c_vect_kin, 2);
  emxInit_real_T(&c_y, 2);
  while (igauss <= (int)ngauss - 1) {
    /* ---------------------------------------------------------------------- */
    /*  Transpose of matrices */
    /* ---------------------------------------------------------------------- */
    i0 = b_vect_kin->size[0] * b_vect_kin->size[1];
    b_vect_kin->size[0] = 8;
    b_vect_kin->size[1] = 4;
    emxEnsureCapacity((emxArray__common *)b_vect_kin, i0, (int)sizeof(double));
    for (i0 = 0; i0 < 4; i0++) {
      for (i1 = 0; i1 < 8; i1++) {
        b_vect_kin->data[i1 + b_vect_kin->size[0] * i0] = vect_kin->BF[(i0 + (i1
          << 2)) + (igauss << 5)];
      }
    }

    i0 = BFxT->size[0] * BFxT->size[1];
    BFxT->size[0] = 8;
    BFxT->size[1] = 4;
    emxEnsureCapacity((emxArray__common *)BFxT, i0, (int)sizeof(double));
    for (i0 = 0; i0 < 4; i0++) {
      for (i1 = 0; i1 < 8; i1++) {
        BFxT->data[i1 + BFxT->size[0] * i0] = b_vect_kin->data[i1 + (i0 << 3)];
      }
    }

    for (i0 = 0; i0 < 8; i0++) {
      for (i1 = 0; i1 < 4; i1++) {
        y_data[i1 + (i0 << 2)] = 0.0;
      }
    }

    for (cr = 1; cr - 1 <= 28; cr += 4) {
      for (ic = cr; ic <= cr + 3; ic++) {
        y_data[ic - 1] = 0.0;
      }
    }

    br = 0;
    for (cr = 0; cr <= 28; cr += 4) {
      ar = 0;
      for (ib = br; ib + 1 <= br + 4; ib++) {
        for (i0 = 0; i0 < 8; i0++) {
          for (i1 = 0; i1 < 4; i1++) {
            b_y_data[i1 + (i0 << 2)] = vect_kin->BF[(i1 + (i0 << 2)) + (igauss <<
              5)];
          }
        }

        if (b_y_data[ib] != 0.0) {
          ia = ar;
          for (ic = cr; ic + 1 <= cr + 4; ic++) {
            ia++;
            for (i0 = 0; i0 < 8; i0++) {
              for (i1 = 0; i1 < 4; i1++) {
                b_y_data[i1 + (i0 << 2)] = vect_kin->BF[(i1 + (i0 << 2)) +
                  (igauss << 5)];
              }
            }

            for (i0 = 0; i0 < 4; i0++) {
              for (i1 = 0; i1 < 4; i1++) {
                vect_kin_data[i1 + (i0 << 2)] = vect_kin->QF[(i1 + (i0 << 2)) +
                  (igauss << 4)];
              }
            }

            y_data[ic] += b_y_data[ib] * vect_kin_data[ia - 1];
          }
        }

        ar += 4;
      }

      br += 4;
    }

    i0 = y->size[0] * y->size[1];
    y->size[0] = 8;
    y->size[1] = 4;
    emxEnsureCapacity((emxArray__common *)y, i0, (int)sizeof(double));
    for (i0 = 0; i0 < 4; i0++) {
      for (i1 = 0; i1 < 8; i1++) {
        y->data[i1 + y->size[0] * i0] = y_data[i0 + (i1 << 2)];
      }
    }

    i0 = BHxT->size[0] * BHxT->size[1];
    BHxT->size[0] = 8;
    BHxT->size[1] = 4;
    emxEnsureCapacity((emxArray__common *)BHxT, i0, (int)sizeof(double));
    for (i0 = 0; i0 < 4; i0++) {
      for (i1 = 0; i1 < 8; i1++) {
        BHxT->data[i1 + BHxT->size[0] * i0] = y->data[i1 + (i0 << 3)];
      }
    }

    i0 = b_kinematics->size[0] * b_kinematics->size[1];
    b_kinematics->size[0] = 2;
    b_kinematics->size[1] = 2;
    emxEnsureCapacity((emxArray__common *)b_kinematics, i0, (int)sizeof(double));
    for (i0 = 0; i0 < 2; i0++) {
      for (i1 = 0; i1 < 2; i1++) {
        b_kinematics->data[i1 + b_kinematics->size[0] * i0] = kinematics->H[(i0
          + (i1 << 1)) + (igauss << 2)];
      }
    }

    for (i0 = 0; i0 < 2; i0++) {
      for (i1 = 0; i1 < 2; i1++) {
        x_data[i1 + (i0 << 1)] = b_kinematics->data[i1 + (i0 << 1)];
      }
    }

    for (cr = 0; cr < 4; cr++) {
      a_data[cr] = x_data[cr];
    }

    memset(&c_y_data[0], 0, sizeof(double) << 3);
    for (cr = 0; cr < 8; cr++) {
      for (ic = cr; ic + 1 <= cr + 1; ic++) {
        c_y_data[ic] = 0.0;
      }
    }

    br = 0;
    for (cr = 0; cr < 8; cr++) {
      ar = 0;
      for (ib = br; ib + 1 <= br + 4; ib++) {
        for (i0 = 0; i0 < 8; i0++) {
          for (i1 = 0; i1 < 4; i1++) {
            b_vect_kin_data[i1 + (i0 << 2)] = vect_kin->BF[(i1 + (i0 << 2)) +
              (igauss << 5)];
          }
        }

        if (b_vect_kin_data[ib] != 0.0) {
          ia = ar;
          for (ic = cr; ic + 1 <= cr + 1; ic++) {
            ia++;
            for (i0 = 0; i0 < 8; i0++) {
              for (i1 = 0; i1 < 4; i1++) {
                b_vect_kin_data[i1 + (i0 << 2)] = vect_kin->BF[(i1 + (i0 << 2))
                  + (igauss << 5)];
              }
            }

            c_y_data[ic] += b_vect_kin_data[ib] * a_data[ia - 1];
          }
        }

        ar++;
      }

      br += 4;
    }

    i0 = b_y->size[0] * b_y->size[1];
    b_y->size[0] = 8;
    b_y->size[1] = 1;
    emxEnsureCapacity((emxArray__common *)b_y, i0, (int)sizeof(double));
    for (i0 = 0; i0 < 8; i0++) {
      b_y->data[i0] = c_y_data[i0];
    }

    i0 = BJxT->size[0] * BJxT->size[1];
    BJxT->size[0] = 8;
    BJxT->size[1] = 1;
    emxEnsureCapacity((emxArray__common *)BJxT, i0, (int)sizeof(double));
    for (i0 = 0; i0 < 1; i0++) {
      for (i1 = 0; i1 < 8; i1++) {
        BJxT->data[i1] = b_y->data[i1];
      }
    }

    /* ---------------------------------------------------------------------- */
    /*  Stiffness matrices for Kxx */
    /* ---------------------------------------------------------------------- */
    memset(&d_y_data[0], 0, sizeof(double) << 5);
    for (cr = 0; cr <= 28; cr += 4) {
      for (ic = cr; ic + 1 <= cr + 4; ic++) {
        d_y_data[ic] = 0.0;
      }
    }

    br = 0;
    for (cr = 0; cr <= 28; cr += 4) {
      ar = 0;
      for (ib = br; ib + 1 <= br + 4; ib++) {
        for (i0 = 0; i0 < 8; i0++) {
          for (i1 = 0; i1 < 4; i1++) {
            b_vect_kin_data[i1 + (i0 << 2)] = vect_kin->BF[(i1 + (i0 << 2)) +
              (igauss << 5)];
          }
        }

        if (b_vect_kin_data[ib] != 0.0) {
          ia = ar;
          for (ic = cr; ic + 1 <= cr + 4; ic++) {
            ia++;
            for (i0 = 0; i0 < 8; i0++) {
              for (i1 = 0; i1 < 4; i1++) {
                b_vect_kin_data[i1 + (i0 << 2)] = vect_kin->BF[(i1 + (i0 << 2))
                  + (igauss << 5)];
              }
            }

            d_y_data[ic] += b_vect_kin_data[ib] * derivatives->D2U.D2UDFDF[((ia
              - 1) % 4 + ((ia - 1) / 4 << 2)) + (igauss << 4)];
          }
        }

        ar += 4;
      }

      br += 4;
    }

    for (i0 = 0; i0 < 8; i0++) {
      memset(&e_y_data[i0 << 3], 0, sizeof(double) << 3);
    }

    for (cr = 0; cr <= 56; cr += 8) {
      for (ic = cr; ic + 1 <= cr + 8; ic++) {
        e_y_data[ic] = 0.0;
      }
    }

    br = 0;
    for (cr = 0; cr <= 56; cr += 8) {
      ar = 0;
      for (ib = br; ib + 1 <= br + 4; ib++) {
        if (d_y_data[ib] != 0.0) {
          ia = ar;
          for (ic = cr; ic + 1 <= cr + 8; ic++) {
            ia++;
            e_y_data[ic] += d_y_data[ib] * BFxT->data[ia - 1];
          }
        }

        ar += 8;
      }

      br += 4;
    }

    memset(&d_y_data[0], 0, sizeof(double) << 5);
    for (cr = 0; cr <= 28; cr += 4) {
      for (ic = cr; ic + 1 <= cr + 4; ic++) {
        d_y_data[ic] = 0.0;
      }
    }

    br = 0;
    for (cr = 0; cr <= 28; cr += 4) {
      ar = 0;
      for (ib = br; ib + 1 <= br + 4; ib++) {
        if (y_data[ib] != 0.0) {
          ia = ar;
          for (ic = cr; ic + 1 <= cr + 4; ic++) {
            ia++;
            d_y_data[ic] += y_data[ib] * derivatives->D2U.D2UDFDH[((ia - 1) % 4
              + ((ia - 1) / 4 << 2)) + (igauss << 4)];
          }
        }

        ar += 4;
      }

      br += 4;
    }

    for (i0 = 0; i0 < 8; i0++) {
      memset(&f_y_data[i0 << 3], 0, sizeof(double) << 3);
    }

    for (cr = 0; cr <= 56; cr += 8) {
      for (ic = cr; ic + 1 <= cr + 8; ic++) {
        f_y_data[ic] = 0.0;
      }
    }

    br = 0;
    for (cr = 0; cr <= 56; cr += 8) {
      ar = 0;
      for (ib = br; ib + 1 <= br + 4; ib++) {
        if (d_y_data[ib] != 0.0) {
          ia = ar;
          for (ic = cr; ic + 1 <= cr + 8; ic++) {
            ia++;
            f_y_data[ic] += d_y_data[ib] * BFxT->data[ia - 1];
          }
        }

        ar += 8;
      }

      br += 4;
    }

    for (i0 = 0; i0 < 4; i0++) {
      for (i1 = 0; i1 < 8; i1++) {
        d_y_data[i0 + (i1 << 2)] = derivatives->D2U.D2UDFDJ[i0 + (igauss << 2)] *
          c_y_data[i1];
      }
    }

    for (i0 = 0; i0 < 8; i0++) {
      memset(&KFJ_data[i0 << 3], 0, sizeof(double) << 3);
    }

    for (cr = 0; cr <= 56; cr += 8) {
      for (ic = cr; ic + 1 <= cr + 8; ic++) {
        KFJ_data[ic] = 0.0;
      }
    }

    br = 0;
    for (cr = 0; cr <= 56; cr += 8) {
      ar = 0;
      for (ib = br; ib + 1 <= br + 4; ib++) {
        if (d_y_data[ib] != 0.0) {
          ia = ar;
          for (ic = cr; ic + 1 <= cr + 8; ic++) {
            ia++;
            KFJ_data[ic] += d_y_data[ib] * BFxT->data[ia - 1];
          }
        }

        ar += 8;
      }

      br += 4;
    }

    memset(&d_y_data[0], 0, sizeof(double) << 5);
    for (cr = 0; cr <= 28; cr += 4) {
      for (ic = cr; ic + 1 <= cr + 4; ic++) {
        d_y_data[ic] = 0.0;
      }
    }

    br = 0;
    for (cr = 0; cr <= 28; cr += 4) {
      ar = 0;
      for (ib = br; ib + 1 <= br + 4; ib++) {
        if (y_data[ib] != 0.0) {
          ia = ar;
          for (ic = cr; ic + 1 <= cr + 4; ic++) {
            ia++;
            d_y_data[ic] += y_data[ib] * derivatives->D2U.D2UDHDH[((ia - 1) % 4
              + ((ia - 1) / 4 << 2)) + (igauss << 4)];
          }
        }

        ar += 4;
      }

      br += 4;
    }

    for (i0 = 0; i0 < 8; i0++) {
      memset(&g_y_data[i0 << 3], 0, sizeof(double) << 3);
    }

    for (cr = 0; cr <= 56; cr += 8) {
      for (ic = cr; ic + 1 <= cr + 8; ic++) {
        g_y_data[ic] = 0.0;
      }
    }

    br = 0;
    for (cr = 0; cr <= 56; cr += 8) {
      ar = 0;
      for (ib = br; ib + 1 <= br + 4; ib++) {
        if (d_y_data[ib] != 0.0) {
          ia = ar;
          for (ic = cr; ic + 1 <= cr + 8; ic++) {
            ia++;
            g_y_data[ic] += d_y_data[ib] * BHxT->data[ia - 1];
          }
        }

        ar += 8;
      }

      br += 4;
    }

    for (i0 = 0; i0 < 4; i0++) {
      for (i1 = 0; i1 < 8; i1++) {
        d_y_data[i0 + (i1 << 2)] = derivatives->D2U.D2UDHDJ[i0 + (igauss << 2)] *
          c_y_data[i1];
      }
    }

    for (i0 = 0; i0 < 8; i0++) {
      memset(&KHJ_data[i0 << 3], 0, sizeof(double) << 3);
    }

    for (cr = 0; cr <= 56; cr += 8) {
      for (ic = cr; ic + 1 <= cr + 8; ic++) {
        KHJ_data[ic] = 0.0;
      }
    }

    br = 0;
    for (cr = 0; cr <= 56; cr += 8) {
      ar = 0;
      for (ib = br; ib + 1 <= br + 4; ib++) {
        if (d_y_data[ib] != 0.0) {
          ia = ar;
          for (ic = cr; ic + 1 <= cr + 8; ic++) {
            ia++;
            KHJ_data[ic] += d_y_data[ib] * BHxT->data[ia - 1];
          }
        }

        ar += 8;
      }

      br += 4;
    }

    for (i0 = 0; i0 < 8; i0++) {
      h_y_data[i0] = derivatives->D2U.D2UDJDJ[igauss] * c_y_data[i0];
    }

    KJJ_size_idx_0 = BJxT->size[0];
    cr = BJxT->size[0];
    for (i0 = 0; i0 < cr; i0++) {
      for (i1 = 0; i1 < 8; i1++) {
        KJJ_data[i0 + KJJ_size_idx_0 * i1] = 0.0;
        br = BJxT->size[1];
        for (ic = 0; ic < br; ic++) {
          KJJ_data[i0 + KJJ_size_idx_0 * i1] += BJxT->data[i0 + BJxT->size[0] *
            ic] * h_y_data[ic + i1];
        }
      }
    }

    for (i0 = 0; i0 < 4; i0++) {
      for (i1 = 0; i1 < 8; i1++) {
        i_y_data[i1 + (i0 << 3)] = 0.0;
      }
    }

    for (cr = 1; cr - 1 <= 24; cr += 8) {
      for (ic = cr; ic <= cr + 7; ic++) {
        i_y_data[ic - 1] = 0.0;
      }
    }

    br = 0;
    for (cr = 0; cr <= 24; cr += 8) {
      ar = 0;
      for (ib = br; ib + 1 <= br + 4; ib++) {
        for (i0 = 0; i0 < 4; i0++) {
          for (i1 = 0; i1 < 4; i1++) {
            b_y_data[i1 + (i0 << 2)] = vect_kin->QSigmaH[(i1 + (i0 << 2)) +
              (igauss << 4)];
          }
        }

        if (b_y_data[ib] != 0.0) {
          ia = ar;
          for (ic = cr; ic + 1 <= cr + 8; ic++) {
            ia++;
            for (i0 = 0; i0 < 4; i0++) {
              for (i1 = 0; i1 < 4; i1++) {
                b_y_data[i1 + (i0 << 2)] = vect_kin->QSigmaH[(i1 + (i0 << 2)) +
                  (igauss << 4)];
              }
            }

            i_y_data[ic] += b_y_data[ib] * BFxT->data[ia - 1];
          }
        }

        ar += 8;
      }

      br += 4;
    }

    for (i0 = 0; i0 < 8; i0++) {
      for (i1 = 0; i1 < 8; i1++) {
        C_data[i1 + (i0 << 3)] = 0.0;
      }
    }

    for (cr = 1; cr - 1 <= 56; cr += 8) {
      for (ic = cr; ic <= cr + 7; ic++) {
        C_data[ic - 1] = 0.0;
      }
    }

    br = 0;
    for (cr = 0; cr <= 56; cr += 8) {
      ar = 0;
      for (ib = br; ib + 1 <= br + 4; ib++) {
        for (i0 = 0; i0 < 8; i0++) {
          for (i1 = 0; i1 < 4; i1++) {
            b_y_data[i1 + (i0 << 2)] = vect_kin->BF[(i1 + (i0 << 2)) + (igauss <<
              5)];
          }
        }

        if (b_y_data[ib] != 0.0) {
          ia = ar;
          for (ic = cr; ic + 1 <= cr + 8; ic++) {
            ia++;
            for (i0 = 0; i0 < 8; i0++) {
              for (i1 = 0; i1 < 4; i1++) {
                b_y_data[i1 + (i0 << 2)] = vect_kin->BF[(i1 + (i0 << 2)) +
                  (igauss << 5)];
              }
            }

            C_data[ic] += b_y_data[ib] * i_y_data[ia - 1];
          }
        }

        ar += 8;
      }

      br += 4;
    }

    for (i0 = 0; i0 < 8; i0++) {
      for (i1 = 0; i1 < 8; i1++) {
        j_y_data[i1 + (i0 << 3)] = 0.0;
      }
    }

    for (cr = 1; cr - 1 <= 56; cr += 8) {
      for (ic = cr; ic <= cr + 7; ic++) {
        j_y_data[ic - 1] = 0.0;
      }
    }

    br = 0;
    for (cr = 0; cr <= 56; cr += 8) {
      ar = 0;
      for (ib = br; ib + 1 <= br + 4; ib++) {
        if (y_data[ib] != 0.0) {
          ia = ar;
          for (ic = cr; ic + 1 <= cr + 8; ic++) {
            ia++;
            j_y_data[ic] += y_data[ib] * BFxT->data[ia - 1];
          }
        }

        ar += 8;
      }

      br += 4;
    }

    /* ---------------------------------------------------------------------- */
    /*  Residual and stiffness matrices for non-linear elasticity regions */
    /* ---------------------------------------------------------------------- */
    i0 = c_vect_kin->size[0] * c_vect_kin->size[1];
    c_vect_kin->size[0] = 8;
    c_vect_kin->size[1] = 4;
    emxEnsureCapacity((emxArray__common *)c_vect_kin, i0, (int)sizeof(double));
    for (i0 = 0; i0 < 4; i0++) {
      for (i1 = 0; i1 < 8; i1++) {
        c_vect_kin->data[i1 + c_vect_kin->size[0] * i0] = vect_kin->BF[(i0 + (i1
          << 2)) + (igauss << 5)];
      }
    }

    for (i0 = 0; i0 < 4; i0++) {
      for (i1 = 0; i1 < 8; i1++) {
        b_a_data[i1 + (i0 << 3)] = c_vect_kin->data[i1 + (i0 << 3)];
      }
    }

    memset(&k_y_data[0], 0, sizeof(double) << 3);
    for (ic = 1; ic < 9; ic++) {
      k_y_data[ic - 1] = 0.0;
    }

    ar = 0;
    for (ib = 0; ib + 1 < 5; ib++) {
      if (Piola_vect[ib + (igauss << 2)] != 0.0) {
        ia = ar;
        for (ic = 0; ic + 1 < 9; ic++) {
          ia++;
          k_y_data[ic] += Piola_vect[ib + (igauss << 2)] * b_a_data[ia - 1];
        }
      }

      ar += 8;
    }

    for (i0 = 0; i0 < 8; i0++) {
      asmb->Tx[i0] += k_y_data[i0] * IntWeight[igauss];
    }

    i0 = c_y->size[0] * c_y->size[1];
    c_y->size[0] = 8;
    c_y->size[1] = 8;
    emxEnsureCapacity((emxArray__common *)c_y, i0, (int)sizeof(double));
    for (i0 = 0; i0 < 8; i0++) {
      for (i1 = 0; i1 < 8; i1++) {
        c_y->data[i1 + c_y->size[0] * i0] = f_y_data[i0 + (i1 << 3)];
      }
    }

    for (i0 = 0; i0 < 8; i0++) {
      for (i1 = 0; i1 < 8; i1++) {
        b_y_data[i1 + (i0 << 3)] = ((((((e_y_data[i1 + (i0 << 3)] + g_y_data[i1
          + (i0 << 3)]) + KJJ_data[i1 + KJJ_size_idx_0 * i0]) + (f_y_data[i1 +
          (i0 << 3)] + c_y->data[i1 + (i0 << 3)])) + (KFJ_data[i1 + (i0 << 3)] +
          KFJ_data[i0 + (i1 << 3)])) + (KHJ_data[i1 + (i0 << 3)] + KHJ_data[i0 +
          (i1 << 3)])) + (C_data[i1 + (i0 << 3)] + derivatives->DU.DUDJ[igauss] *
                          j_y_data[i1 + (i0 << 3)])) * IntWeight[igauss];
      }
    }

    for (i0 = 0; i0 < 8; i0++) {
      for (i1 = 0; i1 < 8; i1++) {
        asmb->Kxx[i1 + (i0 << 3)] += b_y_data[i1 + (i0 << 3)];
      }
    }

    igauss++;
  }

  emxFree_real_T(&c_y);
  emxFree_real_T(&c_vect_kin);
  emxFree_real_T(&b_y);
  emxFree_real_T(&b_kinematics);
  emxFree_real_T(&y);
  emxFree_real_T(&b_vect_kin);
  emxFree_real_T(&BJxT);
  emxFree_real_T(&BHxT);
  emxFree_real_T(&BFxT);
}

/*
 * File trailer for ResidualsMatricesUC.c
 *
 * [EOF]
 */
