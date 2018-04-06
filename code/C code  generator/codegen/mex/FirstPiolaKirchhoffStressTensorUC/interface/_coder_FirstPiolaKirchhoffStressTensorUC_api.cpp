/*
 * _coder_FirstPiolaKirchhoffStressTensorUC_api.cpp
 *
 * Code generation for function '_coder_FirstPiolaKirchhoffStressTensorUC_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "FirstPiolaKirchhoffStressTensorUC.h"
#include "_coder_FirstPiolaKirchhoffStressTensorUC_api.h"
#include "FirstPiolaKirchhoffStressTensorUC_data.h"

/* Function Declarations */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T **y_data, int32_T y_size[3]);
static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *ngauss,
  const char_T *identifier);
static void c_emlrt_marshallOut(const real_T u_data[], const int32_T u_size[3],
  const mxArray *y);
static real_T d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *DUDJ, const
  char_T *identifier, real_T **y_data, int32_T y_size[1]);
static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *Piola, const
  char_T *identifier, real_T **y_data, int32_T y_size[3]);
static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T **y_data, int32_T y_size[1]);
static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T **ret_data, int32_T ret_size[3]);
static real_T h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);
static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T **ret_data, int32_T ret_size[1]);

/* Function Definitions */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T **y_data, int32_T y_size[3])
{
  g_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *ngauss,
  const char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = d_emlrt_marshallIn(sp, emlrtAlias(ngauss), &thisId);
  emlrtDestroyArray(&ngauss);
  return y;
}

static void c_emlrt_marshallOut(const real_T u_data[], const int32_T u_size[3],
  const mxArray *y)
{
  mxSetData((mxArray *)y, (void *)u_data);
  emlrtSetDimensions((mxArray *)y, *(int32_T (*)[3])&u_size[0], 3);
}

static real_T d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = h_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *DUDJ, const
  char_T *identifier, real_T **y_data, int32_T y_size[1])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  f_emlrt_marshallIn(sp, emlrtAlias(DUDJ), &thisId, y_data, y_size);
  emlrtDestroyArray(&DUDJ);
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *Piola, const
  char_T *identifier, real_T **y_data, int32_T y_size[3])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(Piola), &thisId, y_data, y_size);
  emlrtDestroyArray(&Piola);
}

static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T **y_data, int32_T y_size[1])
{
  i_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T **ret_data, int32_T ret_size[3])
{
  int32_T iv0[3];
  boolean_T bv0[3] = { true, true, true };

  static const int32_T dims[3] = { 3, 3, 8 };

  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 3U, dims, &bv0[0],
    iv0);
  ret_size[0] = iv0[0];
  ret_size[1] = iv0[1];
  ret_size[2] = iv0[2];
  *ret_data = (real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
}

static real_T h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 0U, &dims);
  ret = *(real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T **ret_data, int32_T ret_size[1])
{
  int32_T iv1[1];
  boolean_T bv1[1] = { true };

  static const int32_T dims[1] = { 8 };

  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 1U, dims, &bv1[0],
    iv1);
  ret_size[0] = iv1[0];
  *ret_data = (real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
}

void FirstPiolaKirchhoffStressTensorUC_api(const mxArray *prhs[8], const mxArray
  *plhs[1])
{
  int32_T Piola_size[3];
  real_T (*Piola_data)[72];
  real_T ngauss;
  real_T dim;
  int32_T F_size[3];
  real_T (*F_data)[72];
  int32_T H_size[3];
  real_T (*H_data)[72];
  int32_T DUDF_size[3];
  real_T (*DUDF_data)[72];
  int32_T DUDH_size[3];
  real_T (*DUDH_data)[72];
  int32_T DUDJ_size[1];
  real_T (*DUDJ_data)[8];
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;
  prhs[0] = emlrtProtectR2012b(prhs[0], 0, true, 72);

  /* Marshall function inputs */
  emlrt_marshallIn(&st, emlrtAlias(prhs[0]), "Piola", (real_T **)&Piola_data,
                   Piola_size);
  ngauss = c_emlrt_marshallIn(&st, emlrtAliasP(prhs[1]), "ngauss");
  dim = c_emlrt_marshallIn(&st, emlrtAliasP(prhs[2]), "dim");
  emlrt_marshallIn(&st, emlrtAlias(prhs[3]), "F", (real_T **)&F_data, F_size);
  emlrt_marshallIn(&st, emlrtAlias(prhs[4]), "H", (real_T **)&H_data, H_size);
  emlrt_marshallIn(&st, emlrtAlias(prhs[5]), "DUDF", (real_T **)&DUDF_data,
                   DUDF_size);
  emlrt_marshallIn(&st, emlrtAlias(prhs[6]), "DUDH", (real_T **)&DUDH_data,
                   DUDH_size);
  e_emlrt_marshallIn(&st, emlrtAlias(prhs[7]), "DUDJ", (real_T **)&DUDJ_data,
                     DUDJ_size);

  /* Invoke the target function */
  FirstPiolaKirchhoffStressTensorUC(&st, *Piola_data, Piola_size, ngauss, dim,
    *F_data, F_size, *H_data, H_size, *DUDF_data, DUDF_size, *DUDH_data,
    DUDH_size, *DUDJ_data, DUDJ_size);

  /* Marshall function outputs */
  c_emlrt_marshallOut(*Piola_data, Piola_size, prhs[0]);
  plhs[0] = prhs[0];
}

/* End of code generation (_coder_FirstPiolaKirchhoffStressTensorUC_api.cpp) */
