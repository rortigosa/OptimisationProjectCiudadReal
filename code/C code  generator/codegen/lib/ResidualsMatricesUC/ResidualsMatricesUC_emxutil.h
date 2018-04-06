/*
 * File: ResidualsMatricesUC_emxutil.h
 *
 * MATLAB Coder version            : 3.0
 * C/C++ source code generated on  : 16-Nov-2017 12:07:55
 */

#ifndef __RESIDUALSMATRICESUC_EMXUTIL_H__
#define __RESIDUALSMATRICESUC_EMXUTIL_H__

/* Include Files */
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include "rtwtypes.h"
#include "ResidualsMatricesUC_types.h"

/* Function Declarations */
extern void emxEnsureCapacity(emxArray__common *emxArray, int oldNumel, int
  elementSize);
extern void emxFree_real_T(emxArray_real_T **pEmxArray);
extern void emxInit_real_T(emxArray_real_T **pEmxArray, int numDimensions);

#endif

/*
 * File trailer for ResidualsMatricesUC_emxutil.h
 *
 * [EOF]
 */
