/*
 * ResidualsMatricesULEC.c
 *
 * Code generation for function 'ResidualsMatricesULEC'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "ResidualsMatricesULEC.h"
#include "mpower.h"
#include "ResidualsMatricesULEC_emxutil.h"
#include "ResidualsMatricesULEC_data.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 9, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRSInfo b_emlrtRSI = { 11, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRSInfo c_emlrtRSI = { 12, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRSInfo d_emlrtRSI = { 13, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRSInfo e_emlrtRSI = { 14, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRSInfo f_emlrtRSI = { 15, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRSInfo g_emlrtRSI = { 16, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRSInfo h_emlrtRSI = { 17, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRSInfo i_emlrtRSI = { 18, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRSInfo j_emlrtRSI = { 19, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRSInfo k_emlrtRSI = { 20, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRSInfo l_emlrtRSI = { 21, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRSInfo m_emlrtRSI = { 22, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRSInfo n_emlrtRSI = { 36, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRSInfo o_emlrtRSI = { 38, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRSInfo p_emlrtRSI = { 43, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRSInfo q_emlrtRSI = { 44, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRSInfo r_emlrtRSI = { 45, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRSInfo s_emlrtRSI = { 46, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRSInfo t_emlrtRSI = { 47, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRSInfo u_emlrtRSI = { 48, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRSInfo v_emlrtRSI = { 49, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRSInfo w_emlrtRSI = { 54, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRTEInfo emlrtRTEI = { 7, 27, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRTEInfo b_emlrtRTEI = { 13, 1, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRTEInfo c_emlrtRTEI = { 15, 1, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtRTEInfo d_emlrtRTEI = { 17, 1, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtBCInfo emlrtBCI = { 1, 4, 28, 43, "vect_kin.BF",
  "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  0 };

static emlrtRTEInfo e_emlrtRTEI = { 27, 1, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m"
};

static emlrtDCInfo emlrtDCI = { 25, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  1 };

static emlrtDCInfo b_emlrtDCI = { 25, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  4 };

static emlrtDCInfo c_emlrtDCI = { 24, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  1 };

static emlrtDCInfo d_emlrtDCI = { 24, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  4 };

static emlrtDCInfo e_emlrtDCI = { 22, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  4 };

static emlrtDCInfo f_emlrtDCI = { 21, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  4 };

static emlrtDCInfo g_emlrtDCI = { 20, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  4 };

static emlrtDCInfo h_emlrtDCI = { 19, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  4 };

static emlrtDCInfo i_emlrtDCI = { 18, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  4 };

static emlrtDCInfo j_emlrtDCI = { 17, 49, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  4 };

static emlrtDCInfo k_emlrtDCI = { 17, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  1 };

static emlrtDCInfo l_emlrtDCI = { 17, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  4 };

static emlrtDCInfo m_emlrtDCI = { 16, 39, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  1 };

static emlrtDCInfo n_emlrtDCI = { 16, 39, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  4 };

static emlrtDCInfo o_emlrtDCI = { 16, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  4 };

static emlrtDCInfo p_emlrtDCI = { 15, 49, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  4 };

static emlrtDCInfo q_emlrtDCI = { 15, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  1 };

static emlrtDCInfo r_emlrtDCI = { 15, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  4 };

static emlrtDCInfo s_emlrtDCI = { 14, 39, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  1 };

static emlrtDCInfo t_emlrtDCI = { 14, 39, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  4 };

static emlrtDCInfo u_emlrtDCI = { 14, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  4 };

static emlrtDCInfo v_emlrtDCI = { 13, 49, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  4 };

static emlrtDCInfo w_emlrtDCI = { 13, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  1 };

static emlrtDCInfo x_emlrtDCI = { 13, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  4 };

static emlrtDCInfo y_emlrtDCI = { 12, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  4 };

static emlrtDCInfo ab_emlrtDCI = { 11, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  4 };

static emlrtDCInfo bb_emlrtDCI = { 10, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  1 };

static emlrtDCInfo cb_emlrtDCI = { 10, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  4 };

static emlrtDCInfo db_emlrtDCI = { 9, 39, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  1 };

static emlrtDCInfo eb_emlrtDCI = { 9, 39, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  4 };

static emlrtDCInfo fb_emlrtDCI = { 9, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  1 };

static emlrtDCInfo gb_emlrtDCI = { 9, 33, "ResidualsMatricesULEC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\ResidualsMatricesULEC.m",
  4 };

/* Function Definitions */
void ResidualsMatricesULEC(const emlrtStack *sp, struct0_T *asmb, const
  struct1_T *DU, const struct2_T *D2U, const struct3_T *vect_kin, const
  struct4_T *kinematics, const real_T IntWeight[4], real_T dim, real_T
  n_node_elem, real_T ngauss, const real_T u[8])
{
  real_T alpha1;
  int32_T igauss;
  emxArray_real_T *BFxT;
  emxArray_real_T *BHxT;
  emxArray_real_T *BJxT;
  emxArray_real_T *b_vect_kin;
  emxArray_real_T *y;
  emxArray_real_T *b_kinematics;
  emxArray_real_T *b_y;
  emxArray_real_T *c_y;
  int32_T k;
  int32_T i17;
  real_T a_data[64];
  real_T b_data[64];
  real_T y_data[64];
  real_T beta1;
  char_T TRANSB;
  char_T TRANSA;
  ptrdiff_t m_t;
  ptrdiff_t n_t;
  ptrdiff_t k_t;
  ptrdiff_t lda_t;
  ptrdiff_t ldb_t;
  ptrdiff_t ldc_t;
  real_T x_data[4];
  real_T b_y_data[4];
  real_T b_a_data[4];
  real_T b_b_data[32];
  real_T c_y_data[8];
  real_T a[16];
  real_T C_data[32];
  int32_T loop_ub;
  real_T c_a_data[32];
  real_T d_y_data[64];
  real_T e_y_data[64];
  real_T KFJ_data[64];
  real_T f_y_data[64];
  real_T KHJ_data[64];
  int32_T KJJ_size_idx_0;
  real_T KJJ_data[64];
  int32_T b_loop_ub;
  int32_T i18;
  real_T b_C_data[64];
  real_T c_C_data[64];
  real_T g_y_data[64];
  real_T d_a_data[64];
  real_T b[8];
  real_T h_y_data[8];
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);

  /* -------------------------------------------------------------------------- */
  /* -------------------------------------------------------------------------- */
  /*  Residuals and Stiffness matrices */
  /* -------------------------------------------------------------------------- */
  /* -------------------------------------------------------------------------- */
  st.site = &emlrtRSI;
  alpha1 = mpower(dim);
  if (!(alpha1 > 0.0)) {
    emlrtNonNegativeCheckR2012b(alpha1, &gb_emlrtDCI, sp);
  }

  if (alpha1 != (int32_T)muDoubleScalarFloor(alpha1)) {
    emlrtIntegerCheckR2012b(alpha1, &fb_emlrtDCI, sp);
  }

  alpha1 = dim * n_node_elem;
  if (!(alpha1 > 0.0)) {
    emlrtNonNegativeCheckR2012b(alpha1, &eb_emlrtDCI, sp);
  }

  if (alpha1 != (int32_T)muDoubleScalarFloor(alpha1)) {
    emlrtIntegerCheckR2012b(alpha1, &db_emlrtDCI, sp);
  }

  if (!(dim > 0.0)) {
    emlrtNonNegativeCheckR2012b(dim, &cb_emlrtDCI, sp);
  }

  alpha1 = dim;
  if (alpha1 != (int32_T)muDoubleScalarFloor(alpha1)) {
    emlrtIntegerCheckR2012b(alpha1, &bb_emlrtDCI, sp);
  }

  st.site = &b_emlrtRSI;
  alpha1 = mpower(dim);
  if (!(alpha1 > 0.0)) {
    emlrtNonNegativeCheckR2012b(alpha1, &ab_emlrtDCI, sp);
  }

  st.site = &c_emlrtRSI;
  alpha1 = mpower(dim);
  if (!(alpha1 > 0.0)) {
    emlrtNonNegativeCheckR2012b(alpha1, &y_emlrtDCI, sp);
  }

  alpha1 = dim * n_node_elem;
  if (!(alpha1 > 0.0)) {
    emlrtNonNegativeCheckR2012b(alpha1, &x_emlrtDCI, sp);
  }

  if (alpha1 != (int32_T)muDoubleScalarFloor(alpha1)) {
    emlrtIntegerCheckR2012b(alpha1, &w_emlrtDCI, sp);
  }

  st.site = &d_emlrtRSI;
  alpha1 = mpower(dim);
  if (!(alpha1 > 0.0)) {
    emlrtNonNegativeCheckR2012b(alpha1, &v_emlrtDCI, sp);
  }

  st.site = &e_emlrtRSI;
  alpha1 = mpower(dim);
  if (!(alpha1 > 0.0)) {
    emlrtNonNegativeCheckR2012b(alpha1, &u_emlrtDCI, sp);
  }

  alpha1 = dim * n_node_elem;
  if (!(alpha1 > 0.0)) {
    emlrtNonNegativeCheckR2012b(alpha1, &t_emlrtDCI, sp);
  }

  if (alpha1 != (int32_T)muDoubleScalarFloor(alpha1)) {
    emlrtIntegerCheckR2012b(alpha1, &s_emlrtDCI, sp);
  }

  alpha1 = dim * n_node_elem;
  if (!(alpha1 > 0.0)) {
    emlrtNonNegativeCheckR2012b(alpha1, &r_emlrtDCI, sp);
  }

  if (alpha1 != (int32_T)muDoubleScalarFloor(alpha1)) {
    emlrtIntegerCheckR2012b(alpha1, &q_emlrtDCI, sp);
  }

  st.site = &f_emlrtRSI;
  alpha1 = mpower(dim);
  if (!(alpha1 > 0.0)) {
    emlrtNonNegativeCheckR2012b(alpha1, &p_emlrtDCI, sp);
  }

  st.site = &g_emlrtRSI;
  alpha1 = mpower(dim);
  if (!(alpha1 > 0.0)) {
    emlrtNonNegativeCheckR2012b(alpha1, &o_emlrtDCI, sp);
  }

  alpha1 = dim * n_node_elem;
  if (!(alpha1 > 0.0)) {
    emlrtNonNegativeCheckR2012b(alpha1, &n_emlrtDCI, sp);
  }

  if (alpha1 != (int32_T)muDoubleScalarFloor(alpha1)) {
    emlrtIntegerCheckR2012b(alpha1, &m_emlrtDCI, sp);
  }

  alpha1 = dim * n_node_elem;
  if (!(alpha1 > 0.0)) {
    emlrtNonNegativeCheckR2012b(alpha1, &l_emlrtDCI, sp);
  }

  if (alpha1 != (int32_T)muDoubleScalarFloor(alpha1)) {
    emlrtIntegerCheckR2012b(alpha1, &k_emlrtDCI, sp);
  }

  st.site = &h_emlrtRSI;
  alpha1 = mpower(dim);
  if (!(alpha1 > 0.0)) {
    emlrtNonNegativeCheckR2012b(alpha1, &j_emlrtDCI, sp);
  }

  st.site = &i_emlrtRSI;
  alpha1 = mpower(dim);
  if (!(alpha1 > 0.0)) {
    emlrtNonNegativeCheckR2012b(alpha1, &i_emlrtDCI, sp);
  }

  st.site = &j_emlrtRSI;
  alpha1 = mpower(dim);
  if (!(alpha1 > 0.0)) {
    emlrtNonNegativeCheckR2012b(alpha1, &h_emlrtDCI, sp);
  }

  st.site = &k_emlrtRSI;
  alpha1 = mpower(dim);
  if (!(alpha1 > 0.0)) {
    emlrtNonNegativeCheckR2012b(alpha1, &g_emlrtDCI, sp);
  }

  st.site = &l_emlrtRSI;
  alpha1 = mpower(dim);
  if (!(alpha1 > 0.0)) {
    emlrtNonNegativeCheckR2012b(alpha1, &f_emlrtDCI, sp);
  }

  st.site = &m_emlrtRSI;
  alpha1 = mpower(dim);
  if (!(alpha1 > 0.0)) {
    emlrtNonNegativeCheckR2012b(alpha1, &e_emlrtDCI, sp);
  }

  alpha1 = dim * n_node_elem;
  if (!(alpha1 > 0.0)) {
    emlrtNonNegativeCheckR2012b(alpha1, &d_emlrtDCI, sp);
  }

  if (alpha1 != (int32_T)muDoubleScalarFloor(alpha1)) {
    emlrtIntegerCheckR2012b(alpha1, &c_emlrtDCI, sp);
  }

  alpha1 = dim * n_node_elem;
  if (!(alpha1 > 0.0)) {
    emlrtNonNegativeCheckR2012b(alpha1, &b_emlrtDCI, sp);
  }

  if (alpha1 != (int32_T)muDoubleScalarFloor(alpha1)) {
    emlrtIntegerCheckR2012b(alpha1, &emlrtDCI, sp);
  }

  emlrtForLoopVectorCheckR2012b(1.0, 1.0, ngauss, mxDOUBLE_CLASS, (int32_T)
    ngauss, &e_emlrtRTEI, sp);
  igauss = 0;
  emxInit_real_T(sp, &BFxT, 2, &b_emlrtRTEI, true);
  emxInit_real_T(sp, &BHxT, 2, &c_emlrtRTEI, true);
  emxInit_real_T(sp, &BJxT, 2, &d_emlrtRTEI, true);
  emxInit_real_T(sp, &b_vect_kin, 2, &emlrtRTEI, true);
  emxInit_real_T(sp, &y, 2, &emlrtRTEI, true);
  emxInit_real_T(sp, &b_kinematics, 2, &emlrtRTEI, true);
  emxInit_real_T(sp, &b_y, 2, &emlrtRTEI, true);
  emxInit_real_T(sp, &c_y, 2, &emlrtRTEI, true);
  while (igauss <= (int32_T)ngauss - 1) {
    k = igauss + 1;
    if (!((k >= 1) && (k <= 4))) {
      emlrtDynamicBoundsCheckR2012b(k, 1, 4, &emlrtBCI, sp);
    }

    /* ---------------------------------------------------------------------- */
    /*  Transpose of matrices */
    /* ---------------------------------------------------------------------- */
    k = b_vect_kin->size[0] * b_vect_kin->size[1];
    b_vect_kin->size[0] = 8;
    b_vect_kin->size[1] = 4;
    emxEnsureCapacity(sp, (emxArray__common *)b_vect_kin, k, (int32_T)sizeof
                      (real_T), &emlrtRTEI);
    for (k = 0; k < 4; k++) {
      for (i17 = 0; i17 < 8; i17++) {
        b_vect_kin->data[i17 + b_vect_kin->size[0] * k] = vect_kin->BF[(k + (i17
          << 2)) + (igauss << 5)];
      }
    }

    k = BFxT->size[0] * BFxT->size[1];
    BFxT->size[0] = 8;
    BFxT->size[1] = 4;
    emxEnsureCapacity(sp, (emxArray__common *)BFxT, k, (int32_T)sizeof(real_T),
                      &emlrtRTEI);
    for (k = 0; k < 4; k++) {
      for (i17 = 0; i17 < 8; i17++) {
        BFxT->data[i17 + BFxT->size[0] * k] = b_vect_kin->data[i17 + (k << 3)];
      }
    }

    st.site = &n_emlrtRSI;
    for (k = 0; k < 4; k++) {
      for (i17 = 0; i17 < 4; i17++) {
        a_data[i17 + (k << 2)] = vect_kin->QF[(i17 + (k << 2)) + (igauss << 4)];
      }
    }

    for (k = 0; k < 8; k++) {
      for (i17 = 0; i17 < 4; i17++) {
        b_data[i17 + (k << 2)] = vect_kin->BF[(i17 + (k << 2)) + (igauss << 5)];
      }
    }

    for (k = 0; k < 8; k++) {
      for (i17 = 0; i17 < 4; i17++) {
        y_data[i17 + (k << 2)] = 0.0;
      }
    }

    alpha1 = 1.0;
    beta1 = 0.0;
    TRANSB = 'N';
    TRANSA = 'N';
    m_t = (ptrdiff_t)4;
    n_t = (ptrdiff_t)8;
    k_t = (ptrdiff_t)4;
    lda_t = (ptrdiff_t)4;
    ldb_t = (ptrdiff_t)4;
    ldc_t = (ptrdiff_t)4;
    dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &alpha1, &a_data[0], &lda_t,
          &b_data[0], &ldb_t, &beta1, &y_data[0], &ldc_t);
    k = y->size[0] * y->size[1];
    y->size[0] = 8;
    y->size[1] = 4;
    emxEnsureCapacity(sp, (emxArray__common *)y, k, (int32_T)sizeof(real_T),
                      &emlrtRTEI);
    for (k = 0; k < 4; k++) {
      for (i17 = 0; i17 < 8; i17++) {
        y->data[i17 + y->size[0] * k] = y_data[k + (i17 << 2)];
      }
    }

    k = BHxT->size[0] * BHxT->size[1];
    BHxT->size[0] = 8;
    BHxT->size[1] = 4;
    emxEnsureCapacity(sp, (emxArray__common *)BHxT, k, (int32_T)sizeof(real_T),
                      &emlrtRTEI);
    for (k = 0; k < 4; k++) {
      for (i17 = 0; i17 < 8; i17++) {
        BHxT->data[i17 + BHxT->size[0] * k] = y->data[i17 + (k << 3)];
      }
    }

    st.site = &o_emlrtRSI;
    k = b_kinematics->size[0] * b_kinematics->size[1];
    b_kinematics->size[0] = 2;
    b_kinematics->size[1] = 2;
    emxEnsureCapacity(&st, (emxArray__common *)b_kinematics, k, (int32_T)sizeof
                      (real_T), &emlrtRTEI);
    for (k = 0; k < 2; k++) {
      for (i17 = 0; i17 < 2; i17++) {
        b_kinematics->data[i17 + b_kinematics->size[0] * k] = kinematics->H[(k +
          (i17 << 1)) + (igauss << 2)];
      }
    }

    for (k = 0; k < 2; k++) {
      for (i17 = 0; i17 < 2; i17++) {
        x_data[i17 + (k << 1)] = b_kinematics->data[i17 + (k << 1)];
      }
    }

    for (k = 0; k < 4; k++) {
      b_y_data[k] = x_data[k];
    }

    st.site = &o_emlrtRSI;
    for (k = 0; k < 4; k++) {
      b_a_data[k] = b_y_data[k];
    }

    for (k = 0; k < 8; k++) {
      for (i17 = 0; i17 < 4; i17++) {
        b_b_data[i17 + (k << 2)] = vect_kin->BF[(i17 + (k << 2)) + (igauss << 5)];
      }
    }

    alpha1 = 1.0;
    beta1 = 0.0;
    TRANSB = 'N';
    TRANSA = 'N';
    memset(&c_y_data[0], 0, sizeof(real_T) << 3);
    m_t = (ptrdiff_t)1;
    n_t = (ptrdiff_t)8;
    k_t = (ptrdiff_t)4;
    lda_t = (ptrdiff_t)1;
    ldb_t = (ptrdiff_t)4;
    ldc_t = (ptrdiff_t)1;
    dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &alpha1, &b_a_data[0], &lda_t,
          &b_b_data[0], &ldb_t, &beta1, &c_y_data[0], &ldc_t);
    k = b_y->size[0] * b_y->size[1];
    b_y->size[0] = 8;
    b_y->size[1] = 1;
    emxEnsureCapacity(sp, (emxArray__common *)b_y, k, (int32_T)sizeof(real_T),
                      &emlrtRTEI);
    for (k = 0; k < 8; k++) {
      b_y->data[k] = c_y_data[k];
    }

    k = BJxT->size[0] * BJxT->size[1];
    BJxT->size[0] = 8;
    BJxT->size[1] = 1;
    emxEnsureCapacity(sp, (emxArray__common *)BJxT, k, (int32_T)sizeof(real_T),
                      &emlrtRTEI);
    for (k = 0; k < 1; k++) {
      for (i17 = 0; i17 < 8; i17++) {
        BJxT->data[i17] = b_y->data[i17];
      }
    }

    /* ---------------------------------------------------------------------- */
    /*  Stiffness matrices for Kxx */
    /* ---------------------------------------------------------------------- */
    st.site = &p_emlrtRSI;
    for (k = 0; k < 4; k++) {
      for (i17 = 0; i17 < 4; i17++) {
        a[i17 + (k << 2)] = D2U->D2UDFDF[(i17 + (k << 2)) + (igauss << 4)];
      }
    }

    for (k = 0; k < 8; k++) {
      for (i17 = 0; i17 < 4; i17++) {
        b_b_data[i17 + (k << 2)] = vect_kin->BF[(i17 + (k << 2)) + (igauss << 5)];
      }
    }

    alpha1 = 1.0;
    beta1 = 0.0;
    TRANSB = 'N';
    TRANSA = 'N';
    memset(&C_data[0], 0, sizeof(real_T) << 5);
    m_t = (ptrdiff_t)4;
    n_t = (ptrdiff_t)8;
    k_t = (ptrdiff_t)4;
    lda_t = (ptrdiff_t)4;
    ldb_t = (ptrdiff_t)4;
    ldc_t = (ptrdiff_t)4;
    dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &alpha1, &a[0], &lda_t, &b_b_data
          [0], &ldb_t, &beta1, &C_data[0], &ldc_t);
    st.site = &p_emlrtRSI;
    loop_ub = BFxT->size[0] * BFxT->size[1];
    for (k = 0; k < loop_ub; k++) {
      c_a_data[k] = BFxT->data[k];
    }

    for (k = 0; k < 8; k++) {
      memset(&d_y_data[k << 3], 0, sizeof(real_T) << 3);
    }

    alpha1 = 1.0;
    beta1 = 0.0;
    TRANSB = 'N';
    TRANSA = 'N';
    m_t = (ptrdiff_t)8;
    n_t = (ptrdiff_t)8;
    k_t = (ptrdiff_t)4;
    lda_t = (ptrdiff_t)8;
    ldb_t = (ptrdiff_t)4;
    ldc_t = (ptrdiff_t)8;
    dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &alpha1, &c_a_data[0], &lda_t,
          &C_data[0], &ldb_t, &beta1, &d_y_data[0], &ldc_t);
    st.site = &q_emlrtRSI;
    for (k = 0; k < 4; k++) {
      for (i17 = 0; i17 < 4; i17++) {
        a[i17 + (k << 2)] = D2U->D2UDFDH[(i17 + (k << 2)) + (igauss << 4)];
      }
    }

    for (k = 0; k < 32; k++) {
      b_b_data[k] = y_data[k];
    }

    alpha1 = 1.0;
    beta1 = 0.0;
    TRANSB = 'N';
    TRANSA = 'N';
    memset(&C_data[0], 0, sizeof(real_T) << 5);
    m_t = (ptrdiff_t)4;
    n_t = (ptrdiff_t)8;
    k_t = (ptrdiff_t)4;
    lda_t = (ptrdiff_t)4;
    ldb_t = (ptrdiff_t)4;
    ldc_t = (ptrdiff_t)4;
    dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &alpha1, &a[0], &lda_t, &b_b_data
          [0], &ldb_t, &beta1, &C_data[0], &ldc_t);
    st.site = &q_emlrtRSI;
    loop_ub = BFxT->size[0] * BFxT->size[1];
    for (k = 0; k < loop_ub; k++) {
      c_a_data[k] = BFxT->data[k];
    }

    for (k = 0; k < 8; k++) {
      memset(&e_y_data[k << 3], 0, sizeof(real_T) << 3);
    }

    alpha1 = 1.0;
    beta1 = 0.0;
    TRANSB = 'N';
    TRANSA = 'N';
    m_t = (ptrdiff_t)8;
    n_t = (ptrdiff_t)8;
    k_t = (ptrdiff_t)4;
    lda_t = (ptrdiff_t)8;
    ldb_t = (ptrdiff_t)4;
    ldc_t = (ptrdiff_t)8;
    dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &alpha1, &c_a_data[0], &lda_t,
          &C_data[0], &ldb_t, &beta1, &e_y_data[0], &ldc_t);
    for (k = 0; k < 4; k++) {
      for (i17 = 0; i17 < 8; i17++) {
        b_b_data[k + (i17 << 2)] = D2U->D2UDFDJ[k + (igauss << 2)] *
          c_y_data[i17];
      }
    }

    st.site = &r_emlrtRSI;
    loop_ub = BFxT->size[0] * BFxT->size[1];
    for (k = 0; k < loop_ub; k++) {
      c_a_data[k] = BFxT->data[k];
    }

    for (k = 0; k < 8; k++) {
      memset(&KFJ_data[k << 3], 0, sizeof(real_T) << 3);
    }

    alpha1 = 1.0;
    beta1 = 0.0;
    TRANSB = 'N';
    TRANSA = 'N';
    m_t = (ptrdiff_t)8;
    n_t = (ptrdiff_t)8;
    k_t = (ptrdiff_t)4;
    lda_t = (ptrdiff_t)8;
    ldb_t = (ptrdiff_t)4;
    ldc_t = (ptrdiff_t)8;
    dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &alpha1, &c_a_data[0], &lda_t,
          &b_b_data[0], &ldb_t, &beta1, &KFJ_data[0], &ldc_t);
    st.site = &s_emlrtRSI;
    for (k = 0; k < 4; k++) {
      for (i17 = 0; i17 < 4; i17++) {
        a[i17 + (k << 2)] = D2U->D2UDHDH[(i17 + (k << 2)) + (igauss << 4)];
      }
    }

    for (k = 0; k < 32; k++) {
      b_b_data[k] = y_data[k];
    }

    alpha1 = 1.0;
    beta1 = 0.0;
    TRANSB = 'N';
    TRANSA = 'N';
    memset(&C_data[0], 0, sizeof(real_T) << 5);
    m_t = (ptrdiff_t)4;
    n_t = (ptrdiff_t)8;
    k_t = (ptrdiff_t)4;
    lda_t = (ptrdiff_t)4;
    ldb_t = (ptrdiff_t)4;
    ldc_t = (ptrdiff_t)4;
    dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &alpha1, &a[0], &lda_t, &b_b_data
          [0], &ldb_t, &beta1, &C_data[0], &ldc_t);
    st.site = &s_emlrtRSI;
    loop_ub = BHxT->size[0] * BHxT->size[1];
    for (k = 0; k < loop_ub; k++) {
      c_a_data[k] = BHxT->data[k];
    }

    for (k = 0; k < 8; k++) {
      memset(&f_y_data[k << 3], 0, sizeof(real_T) << 3);
    }

    alpha1 = 1.0;
    beta1 = 0.0;
    TRANSB = 'N';
    TRANSA = 'N';
    m_t = (ptrdiff_t)8;
    n_t = (ptrdiff_t)8;
    k_t = (ptrdiff_t)4;
    lda_t = (ptrdiff_t)8;
    ldb_t = (ptrdiff_t)4;
    ldc_t = (ptrdiff_t)8;
    dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &alpha1, &c_a_data[0], &lda_t,
          &C_data[0], &ldb_t, &beta1, &f_y_data[0], &ldc_t);
    for (k = 0; k < 4; k++) {
      for (i17 = 0; i17 < 8; i17++) {
        b_b_data[k + (i17 << 2)] = D2U->D2UDHDJ[k + (igauss << 2)] *
          c_y_data[i17];
      }
    }

    st.site = &t_emlrtRSI;
    loop_ub = BHxT->size[0] * BHxT->size[1];
    for (k = 0; k < loop_ub; k++) {
      c_a_data[k] = BHxT->data[k];
    }

    for (k = 0; k < 8; k++) {
      memset(&KHJ_data[k << 3], 0, sizeof(real_T) << 3);
    }

    alpha1 = 1.0;
    beta1 = 0.0;
    TRANSB = 'N';
    TRANSA = 'N';
    m_t = (ptrdiff_t)8;
    n_t = (ptrdiff_t)8;
    k_t = (ptrdiff_t)4;
    lda_t = (ptrdiff_t)8;
    ldb_t = (ptrdiff_t)4;
    ldc_t = (ptrdiff_t)8;
    dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &alpha1, &c_a_data[0], &lda_t,
          &b_b_data[0], &ldb_t, &beta1, &KHJ_data[0], &ldc_t);
    for (k = 0; k < 8; k++) {
      b_data[k] = D2U->D2UDJDJ[igauss] * c_y_data[k];
    }

    st.site = &u_emlrtRSI;
    KJJ_size_idx_0 = BJxT->size[0];
    loop_ub = BJxT->size[0];
    for (k = 0; k < loop_ub; k++) {
      for (i17 = 0; i17 < 8; i17++) {
        KJJ_data[k + KJJ_size_idx_0 * i17] = 0.0;
        b_loop_ub = BJxT->size[1];
        for (i18 = 0; i18 < b_loop_ub; i18++) {
          KJJ_data[k + KJJ_size_idx_0 * i17] += BJxT->data[k + BJxT->size[0] *
            i18] * b_data[i18 + i17];
        }
      }
    }

    st.site = &v_emlrtRSI;
    loop_ub = BFxT->size[0] * BFxT->size[1];
    for (k = 0; k < loop_ub; k++) {
      a_data[k] = BFxT->data[k];
    }

    for (k = 0; k < 4; k++) {
      for (i17 = 0; i17 < 4; i17++) {
        b_data[i17 + (k << 2)] = vect_kin->QSigmaH[(i17 + (k << 2)) + (igauss <<
          4)];
      }
    }

    for (k = 0; k < 4; k++) {
      for (i17 = 0; i17 < 8; i17++) {
        b_C_data[i17 + (k << 3)] = 0.0;
      }
    }

    alpha1 = 1.0;
    beta1 = 0.0;
    TRANSB = 'N';
    TRANSA = 'N';
    m_t = (ptrdiff_t)8;
    n_t = (ptrdiff_t)4;
    k_t = (ptrdiff_t)4;
    lda_t = (ptrdiff_t)8;
    ldb_t = (ptrdiff_t)4;
    ldc_t = (ptrdiff_t)8;
    dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &alpha1, &a_data[0], &lda_t,
          &b_data[0], &ldb_t, &beta1, &b_C_data[0], &ldc_t);
    st.site = &v_emlrtRSI;
    for (k = 0; k < 8; k++) {
      for (i17 = 0; i17 < 4; i17++) {
        b_data[i17 + (k << 2)] = vect_kin->BF[(i17 + (k << 2)) + (igauss << 5)];
      }
    }

    for (k = 0; k < 8; k++) {
      for (i17 = 0; i17 < 8; i17++) {
        c_C_data[i17 + (k << 3)] = 0.0;
      }
    }

    alpha1 = 1.0;
    beta1 = 0.0;
    TRANSB = 'N';
    TRANSA = 'N';
    m_t = (ptrdiff_t)8;
    n_t = (ptrdiff_t)8;
    k_t = (ptrdiff_t)4;
    lda_t = (ptrdiff_t)8;
    ldb_t = (ptrdiff_t)4;
    ldc_t = (ptrdiff_t)8;
    dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &alpha1, &b_C_data[0], &lda_t,
          &b_data[0], &ldb_t, &beta1, &c_C_data[0], &ldc_t);
    st.site = &v_emlrtRSI;
    loop_ub = BFxT->size[0] * BFxT->size[1];
    for (k = 0; k < loop_ub; k++) {
      a_data[k] = BFxT->data[k];
    }

    for (k = 0; k < 8; k++) {
      for (i17 = 0; i17 < 8; i17++) {
        g_y_data[i17 + (k << 3)] = 0.0;
      }
    }

    alpha1 = 1.0;
    beta1 = 0.0;
    TRANSB = 'N';
    TRANSA = 'N';
    m_t = (ptrdiff_t)8;
    n_t = (ptrdiff_t)8;
    k_t = (ptrdiff_t)4;
    lda_t = (ptrdiff_t)8;
    ldb_t = (ptrdiff_t)4;
    ldc_t = (ptrdiff_t)8;
    dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &alpha1, &a_data[0], &lda_t,
          &y_data[0], &ldb_t, &beta1, &g_y_data[0], &ldc_t);
    for (k = 0; k < 64; k++) {
      a_data[k] = DU->DUDJ[igauss] * g_y_data[k];
    }

    k = BFxT->size[0] * BFxT->size[1];
    BFxT->size[0] = 8;
    BFxT->size[1] = 8;
    emxEnsureCapacity(sp, (emxArray__common *)BFxT, k, (int32_T)sizeof(real_T),
                      &emlrtRTEI);
    for (k = 0; k < 64; k++) {
      BFxT->data[k] = c_C_data[k] + a_data[k];
    }

    k = c_y->size[0] * c_y->size[1];
    c_y->size[0] = 8;
    c_y->size[1] = 8;
    emxEnsureCapacity(sp, (emxArray__common *)c_y, k, (int32_T)sizeof(real_T),
                      &emlrtRTEI);
    for (k = 0; k < 8; k++) {
      for (i17 = 0; i17 < 8; i17++) {
        c_y->data[i17 + c_y->size[0] * k] = e_y_data[k + (i17 << 3)];
      }
    }

    k = BHxT->size[0] * BHxT->size[1];
    BHxT->size[0] = 8;
    BHxT->size[1] = 8;
    emxEnsureCapacity(sp, (emxArray__common *)BHxT, k, (int32_T)sizeof(real_T),
                      &emlrtRTEI);
    for (k = 0; k < 8; k++) {
      for (i17 = 0; i17 < 8; i17++) {
        BHxT->data[i17 + BHxT->size[0] * k] = (((((d_y_data[i17 + (k << 3)] +
          f_y_data[i17 + (k << 3)]) + KJJ_data[i17 + KJJ_size_idx_0 * k]) +
          (e_y_data[i17 + (k << 3)] + c_y->data[i17 + (k << 3)])) +
          (KFJ_data[i17 + (k << 3)] + KFJ_data[k + (i17 << 3)])) + (KHJ_data[i17
          + (k << 3)] + KHJ_data[k + (i17 << 3)])) + BFxT->data[i17 + BFxT->
          size[0] * k];
      }
    }

    /* ---------------------------------------------------------------------- */
    /*  Residual and stiffness matrices for non-linear elasticity regions */
    /* ---------------------------------------------------------------------- */
    st.site = &w_emlrtRSI;
    loop_ub = BHxT->size[0] * BHxT->size[1];
    for (k = 0; k < loop_ub; k++) {
      d_a_data[k] = BHxT->data[k];
    }

    for (k = 0; k < 8; k++) {
      b[k] = u[k];
      h_y_data[k] = 0.0;
    }

    alpha1 = 1.0;
    beta1 = 0.0;
    TRANSB = 'N';
    TRANSA = 'N';
    m_t = (ptrdiff_t)8;
    n_t = (ptrdiff_t)1;
    k_t = (ptrdiff_t)8;
    lda_t = (ptrdiff_t)8;
    ldb_t = (ptrdiff_t)8;
    ldc_t = (ptrdiff_t)8;
    dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &alpha1, &d_a_data[0], &lda_t, &b
          [0], &ldb_t, &beta1, &h_y_data[0], &ldc_t);
    for (k = 0; k < 8; k++) {
      asmb->Tx[k] += h_y_data[k] * IntWeight[igauss];
    }

    for (k = 0; k < 64; k++) {
      asmb->Kxx[k] += BHxT->data[k] * IntWeight[igauss];
    }

    igauss++;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_real_T(&c_y);
  emxFree_real_T(&b_y);
  emxFree_real_T(&b_kinematics);
  emxFree_real_T(&y);
  emxFree_real_T(&b_vect_kin);
  emxFree_real_T(&BJxT);
  emxFree_real_T(&BHxT);
  emxFree_real_T(&BFxT);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (ResidualsMatricesULEC.c) */
