/*
 * File: ResidualsMatricesUC_types.h
 *
 * MATLAB Coder version            : 3.0
 * C/C++ source code generated on  : 16-Nov-2017 12:07:55
 */

#ifndef __RESIDUALSMATRICESUC_TYPES_H__
#define __RESIDUALSMATRICESUC_TYPES_H__

/* Include Files */
#include "rtwtypes.h"

/* Type Definitions */
#ifndef struct_emxArray__common
#define struct_emxArray__common

struct emxArray__common
{
  void *data;
  int *size;
  int allocatedSize;
  int numDimensions;
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
  double *data;
  int *size;
  int allocatedSize;
  int numDimensions;
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
  double Tx[8];
  double Kxx[64];
} struct0_T;

#endif                                 /*typedef_struct0_T*/

#ifndef typedef_struct2_T
#define typedef_struct2_T

typedef struct {
  double D2UDFDF[64];
  double D2UDFDH[64];
  double D2UDFDJ[16];
  double D2UDHDH[64];
  double D2UDHDJ[16];
  double D2UDJDJ[4];
} struct2_T;

#endif                                 /*typedef_struct2_T*/

#ifndef typedef_struct3_T
#define typedef_struct3_T

typedef struct {
  double DUDJ[4];
} struct3_T;

#endif                                 /*typedef_struct3_T*/

#ifndef typedef_struct1_T
#define typedef_struct1_T

typedef struct {
  struct2_T D2U;
  struct3_T DU;
} struct1_T;

#endif                                 /*typedef_struct1_T*/

#ifndef typedef_struct4_T
#define typedef_struct4_T

typedef struct {
  double BF[128];
  double QF[64];
  double QSigmaH[64];
} struct4_T;

#endif                                 /*typedef_struct4_T*/

#ifndef typedef_struct5_T
#define typedef_struct5_T

typedef struct {
  double H[16];
} struct5_T;

#endif                                 /*typedef_struct5_T*/
#endif

/*
 * File trailer for ResidualsMatricesUC_types.h
 *
 * [EOF]
 */
