/*
 * _coder_ResidualsMatricesUC_api.cpp
 *
 * Code generation for function '_coder_ResidualsMatricesUC_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "ResidualsMatricesUC.h"
#include "_coder_ResidualsMatricesUC_api.h"
#include "ResidualsMatricesUC_data.h"

/* Function Declarations */
static void ab_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[64]);
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct0_T *y);
static void bb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[16]);
static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[8]);
static const mxArray *c_emlrt_marshallOut(const struct0_T *u);
static void cb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[4]);
static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[64]);
static void db_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[16]);
static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *derivatives,
  const char_T *identifier, struct1_T *y);
static real_T (*eb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[16];
static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *asmb, const
  char_T *identifier, struct0_T *y);
static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct1_T *y);
static void fb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[128]);
static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct2_T *y);
static real_T (*gb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[4];
static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[64]);
static real_T hb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId);
static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[16]);
static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[4]);
static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct3_T *y);
static void l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[16]);
static real_T (*m_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *Piola_vect, const char_T *identifier))[16];
static real_T (*n_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[16];
static void o_emlrt_marshallIn(const emlrtStack *sp, const mxArray *vect_kin,
  const char_T *identifier, struct4_T *y);
static void p_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct4_T *y);
static void q_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[128]);
static void r_emlrt_marshallIn(const emlrtStack *sp, const mxArray *kinematics,
  const char_T *identifier, struct5_T *y);
static void s_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct5_T *y);
static real_T (*t_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *IntWeight, const char_T *identifier))[4];
static real_T (*u_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[4];
static real_T v_emlrt_marshallIn(const emlrtStack *sp, const mxArray *dim, const
  char_T *identifier);
static real_T w_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static void x_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[8]);
static void y_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[64]);

/* Function Definitions */
static void ab_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[64])
{
  static const int32_T dims[3] = { 4, 4, 4 };

  int32_T i3;
  int32_T i4;
  int32_T i5;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 3U, dims);
  for (i3 = 0; i3 < 4; i3++) {
    for (i4 = 0; i4 < 4; i4++) {
      for (i5 = 0; i5 < 4; i5++) {
        ret[(i5 + (i4 << 2)) + (i3 << 4)] = (*(real_T (*)[64])mxGetData(src))
          [(i5 + (i4 << 2)) + (i3 << 4)];
      }
    }
  }

  emlrtDestroyArray(&src);
}

static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct0_T *y)
{
  emlrtMsgIdentifier thisId;
  static const int32_T dims = 0;
  static const char * fieldNames[2] = { "Tx", "Kxx" };

  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b(sp, parentId, u, 2, fieldNames, 0U, &dims);
  thisId.fIdentifier = "Tx";
  c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "Tx")),
                     &thisId, y->Tx);
  thisId.fIdentifier = "Kxx";
  d_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "Kxx")),
                     &thisId, y->Kxx);
  emlrtDestroyArray(&u);
}

static void bb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[16])
{
  static const int32_T dims[3] = { 4, 1, 4 };

  int32_T i6;
  int32_T i7;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 3U, dims);
  for (i6 = 0; i6 < 4; i6++) {
    for (i7 = 0; i7 < 4; i7++) {
      ret[i7 + (i6 << 2)] = (*(real_T (*)[16])mxGetData(src))[i7 + (i6 << 2)];
    }
  }

  emlrtDestroyArray(&src);
}

static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[8])
{
  x_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static const mxArray *c_emlrt_marshallOut(const struct0_T *u)
{
  const mxArray *y;
  const mxArray *b_y;
  static const int32_T iv0[1] = { 8 };

  const mxArray *m2;
  real_T *pData;
  int32_T i;
  const mxArray *c_y;
  static const int32_T iv1[2] = { 8, 8 };

  y = NULL;
  emlrtAssign(&y, emlrtCreateStructMatrix(1, 1, 0, NULL));
  b_y = NULL;
  m2 = emlrtCreateNumericArray(1, iv0, mxDOUBLE_CLASS, mxREAL);
  pData = (real_T *)mxGetPr(m2);
  for (i = 0; i < 8; i++) {
    pData[i] = u->Tx[i];
  }

  emlrtAssign(&b_y, m2);
  emlrtAddField(y, b_y, "Tx", 0);
  c_y = NULL;
  m2 = emlrtCreateNumericArray(2, iv1, mxDOUBLE_CLASS, mxREAL);
  pData = (real_T *)mxGetPr(m2);
  for (i = 0; i < 64; i++) {
    pData[i] = u->Kxx[i];
  }

  emlrtAssign(&c_y, m2);
  emlrtAddField(y, c_y, "Kxx", 0);
  return y;
}

static void cb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[4])
{
  static const int32_T dims[1] = { 4 };

  int32_T i8;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 1U, dims);
  for (i8 = 0; i8 < 4; i8++) {
    ret[i8] = (*(real_T (*)[4])mxGetData(src))[i8];
  }

  emlrtDestroyArray(&src);
}

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[64])
{
  y_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void db_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[16])
{
  static const int32_T dims[3] = { 2, 2, 4 };

  int32_T i9;
  int32_T i10;
  int32_T i11;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 3U, dims);
  for (i9 = 0; i9 < 4; i9++) {
    for (i10 = 0; i10 < 2; i10++) {
      for (i11 = 0; i11 < 2; i11++) {
        ret[(i11 + (i10 << 1)) + (i9 << 2)] = (*(real_T (*)[16])mxGetData(src))
          [(i11 + (i10 << 1)) + (i9 << 2)];
      }
    }
  }

  emlrtDestroyArray(&src);
}

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *derivatives,
  const char_T *identifier, struct1_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  f_emlrt_marshallIn(sp, emlrtAlias(derivatives), &thisId, y);
  emlrtDestroyArray(&derivatives);
}

static real_T (*eb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[16]
{
  real_T (*ret)[16];
  static const int32_T dims[2] = { 4, 4 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims);
  ret = (real_T (*)[16])mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *asmb, const
  char_T *identifier, struct0_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(asmb), &thisId, y);
  emlrtDestroyArray(&asmb);
}

static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct1_T *y)
{
  emlrtMsgIdentifier thisId;
  static const int32_T dims = 0;
  static const char * fieldNames[2] = { "D2U", "DU" };

  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b(sp, parentId, u, 2, fieldNames, 0U, &dims);
  thisId.fIdentifier = "D2U";
  g_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "D2U")),
                     &thisId, &y->D2U);
  thisId.fIdentifier = "DU";
  k_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "DU")),
                     &thisId, &y->DU);
  emlrtDestroyArray(&u);
}

static void fb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[128])
{
  static const int32_T dims[3] = { 4, 8, 4 };

  int32_T i12;
  int32_T i13;
  int32_T i14;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 3U, dims);
  for (i12 = 0; i12 < 4; i12++) {
    for (i13 = 0; i13 < 8; i13++) {
      for (i14 = 0; i14 < 4; i14++) {
        ret[(i14 + (i13 << 2)) + (i12 << 5)] = (*(real_T (*)[128])mxGetData(src))
          [(i14 + (i13 << 2)) + (i12 << 5)];
      }
    }
  }

  emlrtDestroyArray(&src);
}

static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct2_T *y)
{
  emlrtMsgIdentifier thisId;
  static const int32_T dims = 0;
  static const char * fieldNames[6] = { "D2UDFDF", "D2UDFDH", "D2UDFDJ",
    "D2UDHDH", "D2UDHDJ", "D2UDJDJ" };

  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b(sp, parentId, u, 6, fieldNames, 0U, &dims);
  thisId.fIdentifier = "D2UDFDF";
  h_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "D2UDFDF")),
                     &thisId, y->D2UDFDF);
  thisId.fIdentifier = "D2UDFDH";
  h_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "D2UDFDH")),
                     &thisId, y->D2UDFDH);
  thisId.fIdentifier = "D2UDFDJ";
  i_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "D2UDFDJ")),
                     &thisId, y->D2UDFDJ);
  thisId.fIdentifier = "D2UDHDH";
  h_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "D2UDHDH")),
                     &thisId, y->D2UDHDH);
  thisId.fIdentifier = "D2UDHDJ";
  i_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "D2UDHDJ")),
                     &thisId, y->D2UDHDJ);
  thisId.fIdentifier = "D2UDJDJ";
  j_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "D2UDJDJ")),
                     &thisId, y->D2UDJDJ);
  emlrtDestroyArray(&u);
}

static real_T (*gb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[4]
{
  real_T (*ret)[4];
  static const int32_T dims[1] = { 4 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 1U, dims);
  ret = (real_T (*)[4])mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[64])
{
  ab_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real_T hb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 0U, &dims);
  ret = *(real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[16])
{
  bb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[4])
{
  cb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct3_T *y)
{
  emlrtMsgIdentifier thisId;
  static const int32_T dims = 0;
  static const char * fieldNames[3] = { "DUDJ", "DUDF", "DUDH" };

  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b(sp, parentId, u, 3, fieldNames, 0U, &dims);
  thisId.fIdentifier = "DUDJ";
  j_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "DUDJ")),
                     &thisId, y->DUDJ);
  thisId.fIdentifier = "DUDF";
  l_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "DUDF")),
                     &thisId, y->DUDF);
  thisId.fIdentifier = "DUDH";
  l_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "DUDH")),
                     &thisId, y->DUDH);
  emlrtDestroyArray(&u);
}

static void l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[16])
{
  db_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real_T (*m_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *Piola_vect, const char_T *identifier))[16]
{
  real_T (*y)[16];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = n_emlrt_marshallIn(sp, emlrtAlias(Piola_vect), &thisId);
  emlrtDestroyArray(&Piola_vect);
  return y;
}
  static real_T (*n_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
  const emlrtMsgIdentifier *parentId))[16]
{
  real_T (*y)[16];
  y = eb_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static void o_emlrt_marshallIn(const emlrtStack *sp, const mxArray *vect_kin,
  const char_T *identifier, struct4_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  p_emlrt_marshallIn(sp, emlrtAlias(vect_kin), &thisId, y);
  emlrtDestroyArray(&vect_kin);
}

static void p_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct4_T *y)
{
  emlrtMsgIdentifier thisId;
  static const int32_T dims = 0;
  static const char * fieldNames[3] = { "BF", "QF", "QSigmaH" };

  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b(sp, parentId, u, 3, fieldNames, 0U, &dims);
  thisId.fIdentifier = "BF";
  q_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "BF")),
                     &thisId, y->BF);
  thisId.fIdentifier = "QF";
  h_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "QF")),
                     &thisId, y->QF);
  thisId.fIdentifier = "QSigmaH";
  h_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "QSigmaH")),
                     &thisId, y->QSigmaH);
  emlrtDestroyArray(&u);
}

static void q_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[128])
{
  fb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void r_emlrt_marshallIn(const emlrtStack *sp, const mxArray *kinematics,
  const char_T *identifier, struct5_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  s_emlrt_marshallIn(sp, emlrtAlias(kinematics), &thisId, y);
  emlrtDestroyArray(&kinematics);
}

static void s_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct5_T *y)
{
  emlrtMsgIdentifier thisId;
  static const int32_T dims = 0;
  static const char * fieldNames[1] = { "H" };

  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b(sp, parentId, u, 1, fieldNames, 0U, &dims);
  thisId.fIdentifier = "H";
  l_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "H")), &thisId,
                     y->H);
  emlrtDestroyArray(&u);
}

static real_T (*t_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *IntWeight, const char_T *identifier))[4]
{
  real_T (*y)[4];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = u_emlrt_marshallIn(sp, emlrtAlias(IntWeight), &thisId);
  emlrtDestroyArray(&IntWeight);
  return y;
}
  static real_T (*u_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
  const emlrtMsgIdentifier *parentId))[4]
{
  real_T (*y)[4];
  y = gb_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T v_emlrt_marshallIn(const emlrtStack *sp, const mxArray *dim, const
  char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = w_emlrt_marshallIn(sp, emlrtAlias(dim), &thisId);
  emlrtDestroyArray(&dim);
  return y;
}

static real_T w_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = hb_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static void x_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[8])
{
  static const int32_T dims[1] = { 8 };

  int32_T i0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 1U, dims);
  for (i0 = 0; i0 < 8; i0++) {
    ret[i0] = (*(real_T (*)[8])mxGetData(src))[i0];
  }

  emlrtDestroyArray(&src);
}

static void y_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[64])
{
  static const int32_T dims[2] = { 8, 8 };

  int32_T i1;
  int32_T i2;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims);
  for (i1 = 0; i1 < 8; i1++) {
    for (i2 = 0; i2 < 8; i2++) {
      ret[i2 + (i1 << 3)] = (*(real_T (*)[64])mxGetData(src))[i2 + (i1 << 3)];
    }
  }

  emlrtDestroyArray(&src);
}

void ResidualsMatricesUC_api(const mxArray * const prhs[9], const mxArray *plhs
  [1])
{
  struct0_T asmb;
  struct1_T derivatives;
  real_T (*Piola_vect)[16];
  struct4_T vect_kin;
  struct5_T kinematics;
  real_T (*IntWeight)[4];
  real_T dim;
  real_T n_node_elem;
  real_T ngauss;
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;

  /* Marshall function inputs */
  emlrt_marshallIn(&st, emlrtAliasP((const mxArray *)prhs[0]), "asmb", &asmb);
  e_emlrt_marshallIn(&st, emlrtAliasP((const mxArray *)prhs[1]), "derivatives",
                     &derivatives);
  Piola_vect = m_emlrt_marshallIn(&st, emlrtAlias((const mxArray *)prhs[2]),
    "Piola_vect");
  o_emlrt_marshallIn(&st, emlrtAliasP((const mxArray *)prhs[3]), "vect_kin",
                     &vect_kin);
  r_emlrt_marshallIn(&st, emlrtAliasP((const mxArray *)prhs[4]), "kinematics",
                     &kinematics);
  IntWeight = t_emlrt_marshallIn(&st, emlrtAlias((const mxArray *)prhs[5]),
    "IntWeight");
  dim = v_emlrt_marshallIn(&st, emlrtAliasP((const mxArray *)prhs[6]), "dim");
  n_node_elem = v_emlrt_marshallIn(&st, emlrtAliasP((const mxArray *)prhs[7]),
    "n_node_elem");
  ngauss = v_emlrt_marshallIn(&st, emlrtAliasP((const mxArray *)prhs[8]),
    "ngauss");

  /* Invoke the target function */
  ResidualsMatricesUC(&st, &asmb, &derivatives, *Piola_vect, &vect_kin,
                      &kinematics, *IntWeight, dim, n_node_elem, ngauss);

  /* Marshall function outputs */
  plhs[0] = c_emlrt_marshallOut(&asmb);
}

/* End of code generation (_coder_ResidualsMatricesUC_api.cpp) */
