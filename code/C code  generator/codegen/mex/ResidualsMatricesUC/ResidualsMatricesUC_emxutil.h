/*
 * ResidualsMatricesUC_emxutil.h
 *
 * Code generation for function 'ResidualsMatricesUC_emxutil'
 *
 */

#ifndef __RESIDUALSMATRICESUC_EMXUTIL_H__
#define __RESIDUALSMATRICESUC_EMXUTIL_H__

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mwmathutil.h"
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "blas.h"
#include "rtwtypes.h"
#include "ResidualsMatricesUC_types.h"

/* Function Declarations */
extern void emxEnsureCapacity(const emlrtStack *sp, emxArray__common *emxArray,
  int32_T oldNumel, int32_T elementSize, const emlrtRTEInfo *srcLocation);
extern void emxFree_real_T(emxArray_real_T **pEmxArray);
extern void emxInit_real_T(const emlrtStack *sp, emxArray_real_T **pEmxArray,
  int32_T numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);

#endif

/* End of code generation (ResidualsMatricesUC_emxutil.h) */
