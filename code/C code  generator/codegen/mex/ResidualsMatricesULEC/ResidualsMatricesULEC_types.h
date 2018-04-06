/*
 * ResidualsMatricesULEC_types.h
 *
 * Code generation for function 'ResidualsMatricesULEC'
 *
 */

#ifndef __RESIDUALSMATRICESULEC_TYPES_H__
#define __RESIDUALSMATRICESULEC_TYPES_H__

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

#ifndef typedef_emxArray__common
#define typedef_emxArray__common

typedef struct emxArray__common emxArray__common;

#endif                                 /*typedef_emxArray__common*/

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

#ifndef typedef_emxArray_real_T
#define typedef_emxArray_real_T

typedef struct emxArray_real_T emxArray_real_T;

#endif                                 /*typedef_emxArray_real_T*/

#ifndef typedef_struct0_T
#define typedef_struct0_T

typedef struct {
  real_T Tx[8];
  real_T Kxx[64];
} struct0_T;

#endif                                 /*typedef_struct0_T*/

#ifndef typedef_struct1_T
#define typedef_struct1_T

typedef struct {
  real_T DUDF[16];
  real_T DUDH[16];
  real_T DUDJ[4];
} struct1_T;

#endif                                 /*typedef_struct1_T*/

#ifndef typedef_struct2_T
#define typedef_struct2_T

typedef struct {
  real_T D2UDFDF[64];
  real_T D2UDFDH[64];
  real_T D2UDFDJ[16];
  real_T D2UDHDH[64];
  real_T D2UDHDJ[16];
  real_T D2UDJDJ[4];
  real_T D2UDHDF[64];
  real_T D2UDJDF[16];
  real_T D2UDJDH[16];
} struct2_T;

#endif                                 /*typedef_struct2_T*/

#ifndef typedef_struct3_T
#define typedef_struct3_T

typedef struct {
  real_T BF[128];
  real_T QF[64];
  real_T QSigmaH[64];
} struct3_T;

#endif                                 /*typedef_struct3_T*/

#ifndef typedef_struct4_T
#define typedef_struct4_T

typedef struct {
  real_T H[16];
  real_T F[16];
  real_T J[4];
} struct4_T;

#endif                                 /*typedef_struct4_T*/
#endif

/* End of code generation (ResidualsMatricesULEC_types.h) */
