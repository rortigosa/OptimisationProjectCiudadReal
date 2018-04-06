/*
 * xgetrf.c
 *
 * Code generation for function 'xgetrf'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "KinematicsFunctionVolumeC.h"
#include "xgetrf.h"
#include "error.h"
#include "lapacke.h"

/* Type Definitions */
#include <stdlib.h>

/* Variable Definitions */
static emlrtRSInfo h_emlrtRSI = { 25, "xgetrf",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\+lapack\\xgetrf.m"
};

static emlrtRSInfo i_emlrtRSI = { 53, "xgetrf",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\+lapack\\xgetrf.m"
};

static emlrtRSInfo j_emlrtRSI = { 86, "xgetrf",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\+lapack\\xgetrf.m"
};

static emlrtRSInfo k_emlrtRSI = { 18, "repmat",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\elmat\\repmat.m"
};

static emlrtRSInfo l_emlrtRSI = { 42, "infocheck",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\+lapack\\infocheck.m"
};

static emlrtRSInfo m_emlrtRSI = { 45, "infocheck",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\eml\\+coder\\+internal\\+lapack\\infocheck.m"
};

static emlrtMCInfo emlrtMCI = { 37, 5, "repmat",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\elmat\\repmat.m"
};

static emlrtRSInfo n_emlrtRSI = { 37, "repmat",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\elmat\\repmat.m"
};

/* Function Declarations */
static void c_error(const emlrtStack *sp, const mxArray *b, emlrtMCInfo
                    *location);

/* Function Definitions */
static void c_error(const emlrtStack *sp, const mxArray *b, emlrtMCInfo
                    *location)
{
  const mxArray *pArray;
  pArray = b;
  emlrtCallMATLABR2012b(sp, 0, NULL, 1, &pArray, "error", true, location);
}

void xgetrf(const emlrtStack *sp, int32_T m, int32_T n, real_T A_data[], int32_T
            A_size[2], int32_T lda, int32_T ipiv_data[], int32_T ipiv_size[2])
{
  int32_T k;
  int32_T varargin_1;
  static const char_T cv0[15] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 'p', 'm',
    'a', 'x', 's', 'i', 'z', 'e' };

  char_T u[15];
  const mxArray *y;
  static const int32_T iv7[2] = { 1, 15 };

  const mxArray *m4;
  ptrdiff_t ipiv_t_data[3];
  ptrdiff_t info_t;
  boolean_T p;
  int32_T loop_ub;
  int32_T b_loop_ub;
  int32_T i4;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &h_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  if ((A_size[0] == 0) || (A_size[1] == 0)) {
    ipiv_size[0] = 1;
    ipiv_size[1] = 0;
  } else {
    k = muIntScalarMin_sint32(m, n);
    if (k < 1) {
      varargin_1 = 1;
    } else {
      varargin_1 = k;
    }

    b_st.site = &i_emlrtRSI;
    c_st.site = &k_emlrtRSI;
    if ((int8_T)varargin_1 == varargin_1) {
    } else {
      for (k = 0; k < 15; k++) {
        u[k] = cv0[k];
      }

      y = NULL;
      m4 = emlrtCreateCharArray(2, iv7);
      emlrtInitCharArrayR2013a(&b_st, 15, m4, &u[0]);
      emlrtAssign(&y, m4);
      c_st.site = &n_emlrtRSI;
      c_error(&c_st, y, &emlrtMCI);
    }

    info_t = LAPACKE_dgetrf_work(102, (ptrdiff_t)m, (ptrdiff_t)n, &A_data[0],
      (ptrdiff_t)lda, &ipiv_t_data[0]);
    k = (int32_T)info_t;
    ipiv_size[0] = 1;
    ipiv_size[1] = (int8_T)varargin_1;
    b_st.site = &j_emlrtRSI;
    if (k < 0) {
      if (k == -1010) {
        c_st.site = &l_emlrtRSI;
        error(&c_st);
      } else {
        c_st.site = &m_emlrtRSI;
        b_error(&c_st, k);
      }

      p = true;
    } else {
      p = false;
    }

    if (p) {
      loop_ub = A_size[1];
      for (k = 0; k < loop_ub; k++) {
        b_loop_ub = A_size[0];
        for (i4 = 0; i4 < b_loop_ub; i4++) {
          A_data[i4 + A_size[0] * k] = rtNaN;
        }
      }

      for (k = 0; k < (int8_T)varargin_1; k++) {
        ipiv_data[k] = k + 1;
      }
    } else {
      for (k = 0; k < (int8_T)varargin_1; k++) {
        ipiv_data[k] = (int32_T)ipiv_t_data[k];
      }
    }
  }
}

/* End of code generation (xgetrf.c) */
