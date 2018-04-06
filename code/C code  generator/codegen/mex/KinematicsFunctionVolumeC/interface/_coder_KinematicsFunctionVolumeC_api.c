/*
 * _coder_KinematicsFunctionVolumeC_api.c
 *
 * Code generation for function '_coder_KinematicsFunctionVolumeC_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "KinematicsFunctionVolumeC.h"
#include "_coder_KinematicsFunctionVolumeC_api.h"
#include "KinematicsFunctionVolumeC_data.h"
#include "lapacke.h"

/* Function Declarations */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct0_T *y);
static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y_data[], int32_T y_size[3]);
static const mxArray *c_emlrt_marshallOut(const struct0_T *u);
static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y_data[], int32_T y_size[1]);
static const mxArray *d_emlrt_marshallOut(const real_T u_data[], const int32_T
  u_size[3]);
static real_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *dim, const
  char_T *identifier);
static void emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *init_kinematics, const char_T *identifier, struct0_T *y);
static real_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *x_elem,
  const char_T *identifier, real_T **y_data, int32_T y_size[2]);
static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T **y_data, int32_T y_size[2]);
static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *DNX, const
  char_T *identifier, real_T **y_data, int32_T y_size[3]);
static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T **y_data, int32_T y_size[3]);
static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret_data[], int32_T ret_size[3]);
static void l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret_data[], int32_T ret_size[1]);
static real_T m_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);
static void n_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T **ret_data, int32_T ret_size[2]);
static void o_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T **ret_data, int32_T ret_size[3]);

/* Function Definitions */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct0_T *y)
{
  emlrtMsgIdentifier thisId;
  static const int32_T dims = 0;
  static const char * fieldNames[3] = { "F", "H", "J" };

  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b(sp, parentId, u, 3, fieldNames, 0U, &dims);
  thisId.fIdentifier = "F";
  c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "F")), &thisId,
                     y->F.data, y->F.size);
  thisId.fIdentifier = "H";
  c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "H")), &thisId,
                     y->H.data, y->H.size);
  thisId.fIdentifier = "J";
  d_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "J")), &thisId,
                     y->J.data, y->J.size);
  emlrtDestroyArray(&u);
}

static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y_data[], int32_T y_size[3])
{
  k_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

static const mxArray *c_emlrt_marshallOut(const struct0_T *u)
{
  const mxArray *y;
  int32_T u_size[1];
  int32_T loop_ub;
  int32_T i0;
  real_T u_data[8];
  const mxArray *b_y;
  const mxArray *m2;
  real_T *pData;
  y = NULL;
  emlrtAssign(&y, emlrtCreateStructMatrix(1, 1, 0, NULL));
  emlrtAddField(y, d_emlrt_marshallOut(u->F.data, u->F.size), "F", 0);
  emlrtAddField(y, d_emlrt_marshallOut(u->H.data, u->H.size), "H", 0);
  u_size[0] = u->J.size[0];
  loop_ub = u->J.size[0];
  for (i0 = 0; i0 < loop_ub; i0++) {
    u_data[i0] = u->J.data[i0];
  }

  b_y = NULL;
  m2 = emlrtCreateNumericArray(1, u_size, mxDOUBLE_CLASS, mxREAL);
  pData = (real_T *)mxGetPr(m2);
  i0 = 0;
  for (loop_ub = 0; loop_ub < u_size[0]; loop_ub++) {
    pData[i0] = u_data[loop_ub];
    i0++;
  }

  emlrtAssign(&b_y, m2);
  emlrtAddField(y, b_y, "J", 0);
  return y;
}

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y_data[], int32_T y_size[1])
{
  l_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

static const mxArray *d_emlrt_marshallOut(const real_T u_data[], const int32_T
  u_size[3])
{
  const mxArray *y;
  const mxArray *m3;
  real_T *pData;
  int32_T i1;
  int32_T i;
  int32_T b_i;
  int32_T c_i;
  y = NULL;
  m3 = emlrtCreateNumericArray(3, u_size, mxDOUBLE_CLASS, mxREAL);
  pData = (real_T *)mxGetPr(m3);
  i1 = 0;
  for (i = 0; i < u_size[2]; i++) {
    for (b_i = 0; b_i < u_size[1]; b_i++) {
      for (c_i = 0; c_i < u_size[0]; c_i++) {
        pData[i1] = u_data[(c_i + u_size[0] * b_i) + u_size[0] * u_size[1] * i];
        i1++;
      }
    }
  }

  emlrtAssign(&y, m3);
  return y;
}

static real_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *dim, const
  char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = f_emlrt_marshallIn(sp, emlrtAlias(dim), &thisId);
  emlrtDestroyArray(&dim);
  return y;
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *init_kinematics, const char_T *identifier, struct0_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(init_kinematics), &thisId, y);
  emlrtDestroyArray(&init_kinematics);
}

static real_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = m_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *x_elem,
  const char_T *identifier, real_T **y_data, int32_T y_size[2])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  h_emlrt_marshallIn(sp, emlrtAlias(x_elem), &thisId, y_data, y_size);
  emlrtDestroyArray(&x_elem);
}

static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T **y_data, int32_T y_size[2])
{
  n_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *DNX, const
  char_T *identifier, real_T **y_data, int32_T y_size[3])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  j_emlrt_marshallIn(sp, emlrtAlias(DNX), &thisId, y_data, y_size);
  emlrtDestroyArray(&DNX);
}

static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T **y_data, int32_T y_size[3])
{
  o_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret_data[], int32_T ret_size[3])
{
  int32_T iv0[3];
  boolean_T bv0[3] = { true, true, true };

  static const int32_T dims[3] = { 3, 3, 8 };

  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 3U, dims, &bv0[0],
    iv0);
  ret_size[0] = iv0[0];
  ret_size[1] = iv0[1];
  ret_size[2] = iv0[2];
  emlrtImportArrayR2015b(sp, src, (void *)ret_data, 8, false);
  emlrtDestroyArray(&src);
}

static void l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret_data[], int32_T ret_size[1])
{
  int32_T iv1[1];
  boolean_T bv1[1] = { true };

  static const int32_T dims[1] = { 8 };

  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 1U, dims, &bv1[0],
    iv1);
  ret_size[0] = iv1[0];
  emlrtImportArrayR2015b(sp, src, (void *)ret_data, 8, false);
  emlrtDestroyArray(&src);
}

static real_T m_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 0U, &dims);
  ret = *(real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void n_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T **ret_data, int32_T ret_size[2])
{
  int32_T iv2[2];
  boolean_T bv2[2] = { true, true };

  static const int32_T dims[2] = { 3, 8 };

  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims, &bv2[0],
    iv2);
  ret_size[0] = iv2[0];
  ret_size[1] = iv2[1];
  *ret_data = (real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
}

static void o_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T **ret_data, int32_T ret_size[3])
{
  int32_T iv3[3];
  boolean_T bv3[3] = { true, true, true };

  static const int32_T dims[3] = { 3, 8, 8 };

  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 3U, dims, &bv3[0],
    iv3);
  ret_size[0] = iv3[0];
  ret_size[1] = iv3[1];
  ret_size[2] = iv3[2];
  *ret_data = (real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
}

void KinematicsFunctionVolumeC_api(const mxArray * const prhs[4], const mxArray *
  plhs[1])
{
  struct0_T init_kinematics;
  real_T dim;
  int32_T x_elem_size[2];
  real_T (*x_elem_data)[24];
  int32_T DNX_size[3];
  real_T (*DNX_data)[192];
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;

  /* Marshall function inputs */
  emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "init_kinematics",
                   &init_kinematics);
  dim = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[1]), "dim");
  g_emlrt_marshallIn(&st, emlrtAlias(prhs[2]), "x_elem", (real_T **)&x_elem_data,
                     x_elem_size);
  i_emlrt_marshallIn(&st, emlrtAlias(prhs[3]), "DNX", (real_T **)&DNX_data,
                     DNX_size);

  /* Invoke the target function */
  KinematicsFunctionVolumeC(&st, &init_kinematics, dim, *x_elem_data,
    x_elem_size, *DNX_data, DNX_size);

  /* Marshall function outputs */
  plhs[0] = c_emlrt_marshallOut(&init_kinematics);
}

/* End of code generation (_coder_KinematicsFunctionVolumeC_api.c) */
