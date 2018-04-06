/*
 * _coder_func_1_api.c
 *
 * Code generation for function '_coder_func_1_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "func_1.h"
#include "_coder_func_1_api.h"
#include "func_1_data.h"

/* Function Declarations */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[450000];
static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *a, const
  char_T *identifier);
static real_T d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static real_T (*e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *d, const
  char_T *identifier))[150000];
static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *A, const
  char_T *identifier))[450000];
static void emlrt_marshallOut(const real_T u[450000], const mxArray *y);
static real_T (*f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[150000];
static real_T (*g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[450000];
static real_T h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);
static real_T (*i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[150000];

/* Function Definitions */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[450000]
{
  real_T (*y)[450000];
  y = g_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *a, const
  char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = d_emlrt_marshallIn(sp, emlrtAlias(a), &thisId);
  emlrtDestroyArray(&a);
  return y;
}

static real_T d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = h_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T (*e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *d, const
  char_T *identifier))[150000]
{
  real_T (*y)[150000];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = f_emlrt_marshallIn(sp, emlrtAlias(d), &thisId);
  emlrtDestroyArray(&d);
  return y;
}
  static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *A, const
  char_T *identifier))[450000]
{
  real_T (*y)[450000];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(A), &thisId);
  emlrtDestroyArray(&A);
  return y;
}

static void emlrt_marshallOut(const real_T u[450000], const mxArray *y)
{
  static const int32_T iv0[3] = { 3, 3, 50000 };

  mxSetData((mxArray *)y, (void *)&u[0]);
  emlrtSetDimensions((mxArray *)y, iv0, 3);
}

static real_T (*f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[150000]
{
  real_T (*y)[150000];
  y = i_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T (*g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[450000]
{
  real_T (*ret)[450000];
  static const int32_T dims[3] = { 3, 3, 50000 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 3U, dims);
  ret = (real_T (*)[450000])mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
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

static real_T (*i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[150000]
{
  real_T (*ret)[150000];
  static const int32_T dims[2] = { 3, 50000 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims);
  ret = (real_T (*)[150000])mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  void func_1_api(const mxArray *prhs[7], const mxArray *plhs[2])
{
  real_T (*A)[450000];
  real_T (*B)[450000];
  real_T a;
  real_T (*b)[450000];
  real_T (*c)[450000];
  real_T (*d)[150000];
  real_T e;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  prhs[0] = emlrtProtectR2012b(prhs[0], 0, true, -1);
  prhs[1] = emlrtProtectR2012b(prhs[1], 1, true, -1);

  /* Marshall function inputs */
  A = emlrt_marshallIn(&st, emlrtAlias(prhs[0]), "A");
  B = emlrt_marshallIn(&st, emlrtAlias(prhs[1]), "B");
  a = c_emlrt_marshallIn(&st, emlrtAliasP(prhs[2]), "a");
  b = emlrt_marshallIn(&st, emlrtAlias(prhs[3]), "b");
  c = emlrt_marshallIn(&st, emlrtAlias(prhs[4]), "c");
  d = e_emlrt_marshallIn(&st, emlrtAlias(prhs[5]), "d");
  e = c_emlrt_marshallIn(&st, emlrtAliasP(prhs[6]), "e");

  /* Invoke the target function */
  func_1(&st, *A, *B, a, *b, *c, *d, e);

  /* Marshall function outputs */
  emlrt_marshallOut(*A, prhs[0]);
  plhs[0] = prhs[0];
  emlrt_marshallOut(*B, prhs[1]);
  plhs[1] = prhs[1];
}

/* End of code generation (_coder_func_1_api.c) */
