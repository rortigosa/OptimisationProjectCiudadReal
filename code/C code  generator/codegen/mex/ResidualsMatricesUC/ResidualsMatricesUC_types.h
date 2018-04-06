/*
 * ResidualsMatricesUC_types.h
 *
 * Code generation for function 'ResidualsMatricesUC'
 *
 */

#ifndef __RESIDUALSMATRICESUC_TYPES_H__
#define __RESIDUALSMATRICESUC_TYPES_H__

/* Include files */
#include "rtwtypes.h"

/* Type Definitions */
#ifndef struct_emxArray__common
#define struct_emxArray__common

struct emxArray__common
{
  void *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray__common*/

#ifndef struct_emxArray_real_T
#define struct_emxArray_real_T

struct emxArray_real_T
{
  real_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_real_T*/

typedef struct {
  real_T Tx[8];
  real_T Kxx[64];
} struct0_T;

typedef struct {
  real_T D2UDFDF[64];
  real_T D2UDFDH[64];
  real_T D2UDFDJ[16];
  real_T D2UDHDH[64];
  real_T D2UDHDJ[16];
  real_T D2UDJDJ[4];
} struct2_T;

typedef struct {
  real_T DUDJ[4];
  real_T DUDF[16];
  real_T DUDH[16];
} struct3_T;

typedef struct {
  struct2_T D2U;
  struct3_T DU;
} struct1_T;

typedef struct {
  real_T BF[128];
  real_T QF[64];
  real_T QSigmaH[64];
} struct4_T;

typedef struct {
  real_T H[16];
} struct5_T;

#endif

/* End of code generation (ResidualsMatricesUC_types.h) */
