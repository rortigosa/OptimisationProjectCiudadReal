/*
 * _coder_ResidualsMatricesULEC_api.c
 *
 * Code generation for function '_coder_ResidualsMatricesULEC_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "ResidualsMatricesULEC.h"
#include "_coder_ResidualsMatricesULEC_api.h"
#include "ResidualsMatricesULEC_data.h"

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
  emlrtMsgIdentifier *msgId, real_T ret[64]);
static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *DU, const
  char_T *identifier, struct1_T *y);
static void eb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[16]);
static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *asmb, const
  char_T *identifier, struct0_T *y);
static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct1_T *y);
static void fb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[16]);
static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[16]);
static void gb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[128]);
static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[4]);
static real_T (*hb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[4];
static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *D2U, const
  char_T *identifier, struct2_T *y);
static real_T ib_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId);
static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct2_T *y);
static real_T (*jb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[8];
static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[64]);
static void l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[16]);
static void m_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[16]);
static void n_emlrt_marshallIn(const emlrtStack *sp, const mxArray *vect_kin,
  const char_T *identifier, struct3_T *y);
static void o_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct3_T *y);
static void p_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[128]);
static void q_emlrt_marshallIn(const emlrtStack *sp, const mxArray *kinematics,
  const char_T *identifier, struct4_T *y);
static void r_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct4_T *y);
static real_T (*s_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *IntWeight, const char_T *identifier))[4];
static real_T (*t_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[4];
static real_T u_emlrt_marshallIn(const emlrtStack *sp, const mxArray *dim, const
  char_T *identifier);
static real_T v_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static real_T (*w_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  char_T *identifier))[8];
static real_T (*x_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[8];
static void y_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[8]);

/* Function Definitions */
static void ab_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
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
  static const int32_T dims[3] = { 2, 2, 4 };

  int32_T i3;
  int32_T i4;
  int32_T i5;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 3U, dims);
  for (i3 = 0; i3 < 4; i3++) {
    for (i4 = 0; i4 < 2; i4++) {
      for (i5 = 0; i5 < 2; i5++) {
        ret[(i5 + (i4 << 1)) + (i3 << 2)] = (*(real_T (*)[16])mxGetData(src))
          [(i5 + (i4 << 1)) + (i3 << 2)];
      }
    }
  }

  emlrtDestroyArray(&src);
}

static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[8])
{
  y_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
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

  int32_T i6;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 1U, dims);
  for (i6 = 0; i6 < 4; i6++) {
    ret[i6] = (*(real_T (*)[4])mxGetData(src))[i6];
  }

  emlrtDestroyArray(&src);
}

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[64])
{
  ab_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void db_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[64])
{
  static const int32_T dims[3] = { 4, 4, 4 };

  int32_T i7;
  int32_T i8;
  int32_T i9;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 3U, dims);
  for (i7 = 0; i7 < 4; i7++) {
    for (i8 = 0; i8 < 4; i8++) {
      for (i9 = 0; i9 < 4; i9++) {
        ret[(i9 + (i8 << 2)) + (i7 << 4)] = (*(real_T (*)[64])mxGetData(src))
          [(i9 + (i8 << 2)) + (i7 << 4)];
      }
    }
  }

  emlrtDestroyArray(&src);
}

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *DU, const
  char_T *identifier, struct1_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  f_emlrt_marshallIn(sp, emlrtAlias(DU), &thisId, y);
  emlrtDestroyArray(&DU);
}

static void eb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[16])
{
  static const int32_T dims[3] = { 4, 1, 4 };

  int32_T i10;
  int32_T i11;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 3U, dims);
  for (i10 = 0; i10 < 4; i10++) {
    for (i11 = 0; i11 < 4; i11++) {
      ret[i11 + (i10 << 2)] = (*(real_T (*)[16])mxGetData(src))[i11 + (i10 << 2)];
    }
  }

  emlrtDestroyArray(&src);
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
  static const char * fieldNames[3] = { "DUDF", "DUDH", "DUDJ" };

  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b(sp, parentId, u, 3, fieldNames, 0U, &dims);
  thisId.fIdentifier = "DUDF";
  g_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "DUDF")),
                     &thisId, y->DUDF);
  thisId.fIdentifier = "DUDH";
  g_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "DUDH")),
                     &thisId, y->DUDH);
  thisId.fIdentifier = "DUDJ";
  h_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "DUDJ")),
                     &thisId, y->DUDJ);
  emlrtDestroyArray(&u);
}

static void fb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[16])
{
  static const int32_T dims[3] = { 1, 4, 4 };

  int32_T i12;
  int32_T i13;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 3U, dims);
  for (i12 = 0; i12 < 4; i12++) {
    for (i13 = 0; i13 < 4; i13++) {
      ret[i13 + (i12 << 2)] = (*(real_T (*)[16])mxGetData(src))[i13 + (i12 << 2)];
    }
  }

  emlrtDestroyArray(&src);
}

static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[16])
{
  bb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void gb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, real_T ret[128])
{
  static const int32_T dims[3] = { 4, 8, 4 };

  int32_T i14;
  int32_T i15;
  int32_T i16;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 3U, dims);
  for (i14 = 0; i14 < 4; i14++) {
    for (i15 = 0; i15 < 8; i15++) {
      for (i16 = 0; i16 < 4; i16++) {
        ret[(i16 + (i15 << 2)) + (i14 << 5)] = (*(real_T (*)[128])mxGetData(src))
          [(i16 + (i15 << 2)) + (i14 << 5)];
      }
    }
  }

  emlrtDestroyArray(&src);
}

static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[4])
{
  cb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real_T (*hb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[4]
{
  real_T (*ret)[4];
  static const int32_T dims[1] = { 4 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 1U, dims);
  ret = (real_T (*)[4])mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *D2U, const
  char_T *identifier, struct2_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  j_emlrt_marshallIn(sp, emlrtAlias(D2U), &thisId, y);
  emlrtDestroyArray(&D2U);
}

static real_T ib_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 0U, &dims);
  ret = *(real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct2_T *y)
{
  emlrtMsgIdentifier thisId;
  static const int32_T dims = 0;
  static const char * fieldNames[9] = { "D2UDFDF", "D2UDFDH", "D2UDFDJ",
    "D2UDHDH", "D2UDHDJ", "D2UDJDJ", "D2UDHDF", "D2UDJDF", "D2UDJDH" };

  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b(sp, parentId, u, 9, fieldNames, 0U, &dims);
  thisId.fIdentifier = "D2UDFDF";
  k_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "D2UDFDF")),
                     &thisId, y->D2UDFDF);
  thisId.fIdentifier = "D2UDFDH";
  k_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "D2UDFDH")),
                     &thisId, y->D2UDFDH);
  thisId.fIdentifier = "D2UDFDJ";
  l_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "D2UDFDJ")),
                     &thisId, y->D2UDFDJ);
  thisId.fIdentifier = "D2UDHDH";
  k_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "D2UDHDH")),
                     &thisId, y->D2UDHDH);
  thisId.fIdentifier = "D2UDHDJ";
  l_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "D2UDHDJ")),
                     &thisId, y->D2UDHDJ);
  thisId.fIdentifier = "D2UDJDJ";
  h_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "D2UDJDJ")),
                     &thisId, y->D2UDJDJ);
  thisId.fIdentifier = "D2UDHDF";
  k_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "D2UDHDF")),
                     &thisId, y->D2UDHDF);
  thisId.fIdentifier = "D2UDJDF";
  m_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "D2UDJDF")),
                     &thisId, y->D2UDJDF);
  thisId.fIdentifier = "D2UDJDH";
  m_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "D2UDJDH")),
                     &thisId, y->D2UDJDH);
  emlrtDestroyArray(&u);
}

static real_T (*jb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[8]
{
  real_T (*ret)[8];
  static const int32_T dims[2] = { 2, 4 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims);
  ret = (real_T (*)[8])mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[64])
{
  db_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[16])
{
  eb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void m_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[16])
{
  fb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void n_emlrt_marshallIn(const emlrtStack *sp, const mxArray *vect_kin,
  const char_T *identifier, struct3_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  o_emlrt_marshallIn(sp, emlrtAlias(vect_kin), &thisId, y);
  emlrtDestroyArray(&vect_kin);
}

static void o_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct3_T *y)
{
  emlrtMsgIdentifier thisId;
  static const int32_T dims = 0;
  static const char * fieldNames[3] = { "BF", "QF", "QSigmaH" };

  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b(sp, parentId, u, 3, fieldNames, 0U, &dims);
  thisId.fIdentifier = "BF";
  p_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "BF")),
                     &thisId, y->BF);
  thisId.fIdentifier = "QF";
  k_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "QF")),
                     &thisId, y->QF);
  thisId.fIdentifier = "QSigmaH";
  k_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "QSigmaH")),
                     &thisId, y->QSigmaH);
  emlrtDestroyArray(&u);
}

static void p_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, real_T y[128])
{
  gb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void q_emlrt_marshallIn(const emlrtStack *sp, const mxArray *kinematics,
  const char_T *identifier, struct4_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  r_emlrt_marshallIn(sp, emlrtAlias(kinematics), &thisId, y);
  emlrtDestroyArray(&kinematics);
}

static void r_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct4_T *y)
{
  emlrtMsgIdentifier thisId;
  static const int32_T dims = 0;
  static const char * fieldNames[3] = { "H", "F", "J" };

  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b(sp, parentId, u, 3, fieldNames, 0U, &dims);
  thisId.fIdentifier = "H";
  g_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "H")), &thisId,
                     y->H);
  thisId.fIdentifier = "F";
  g_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "F")), &thisId,
                     y->F);
  thisId.fIdentifier = "J";
  h_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2013a(sp, u, 0, "J")), &thisId,
                     y->J);
  emlrtDestroyArray(&u);
}

static real_T (*s_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *IntWeight, const char_T *identifier))[4]
{
  real_T (*y)[4];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = t_emlrt_marshallIn(sp, emlrtAlias(IntWeight), &thisId);
  emlrtDestroyArray(&IntWeight);
  return y;
}
  static real_T (*t_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
  const emlrtMsgIdentifier *parentId))[4]
{
  real_T (*y)[4];
  y = hb_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T u_emlrt_marshallIn(const emlrtStack *sp, const mxArray *dim, const
  char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = v_emlrt_marshallIn(sp, emlrtAlias(dim), &thisId);
  emlrtDestroyArray(&dim);
  return y;
}

static real_T v_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = ib_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T (*w_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  char_T *identifier))[8]
{
  real_T (*y)[8];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = x_emlrt_marshallIn(sp, emlrtAlias(u), &thisId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T (*x_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
  const emlrtMsgIdentifier *parentId))[8]
{
  real_T (*y)[8];
  y = jb_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static void y_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
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

void ResidualsMatricesULEC_api(const mxArray * const prhs[10], const mxArray
  *plhs[1])
{
  struct0_T asmb;
  struct1_T DU;
  struct2_T D2U;
  struct3_T vect_kin;
  struct4_T kinematics;
  real_T (*IntWeight)[4];
  real_T dim;
  real_T n_node_elem;
  real_T ngauss;
  real_T (*u)[8];
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;

  /* Marshall function inputs */
  emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "asmb", &asmb);
  e_emlrt_marshallIn(&st, emlrtAliasP(prhs[1]), "DU", &DU);
  i_emlrt_marshallIn(&st, emlrtAliasP(prhs[2]), "D2U", &D2U);
  n_emlrt_marshallIn(&st, emlrtAliasP(prhs[3]), "vect_kin", &vect_kin);
  q_emlrt_marshallIn(&st, emlrtAliasP(prhs[4]), "kinematics", &kinematics);
  IntWeight = s_emlrt_marshallIn(&st, emlrtAlias(prhs[5]), "IntWeight");
  dim = u_emlrt_marshallIn(&st, emlrtAliasP(prhs[6]), "dim");
  n_node_elem = u_emlrt_marshallIn(&st, emlrtAliasP(prhs[7]), "n_node_elem");
  ngauss = u_emlrt_marshallIn(&st, emlrtAliasP(prhs[8]), "ngauss");
  u = w_emlrt_marshallIn(&st, emlrtAlias(prhs[9]), "u");

  /* Invoke the target function */
  ResidualsMatricesULEC(&st, &asmb, &DU, &D2U, &vect_kin, &kinematics,
                        *IntWeight, dim, n_node_elem, ngauss, *u);

  /* Marshall function outputs */
  plhs[0] = c_emlrt_marshallOut(&asmb);
}

/* End of code generation (_coder_ResidualsMatricesULEC_api.c) */
