/*
 * xgetrf.h
 *
 * Code generation for function 'xgetrf'
 *
 */

#ifndef __XGETRF_H__
#define __XGETRF_H__

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
#include "KinematicsFunctionVolumeC_types.h"

/* Type Definitions */
#include <stdlib.h>

/* Function Declarations */
extern void xgetrf(const emlrtStack *sp, int32_T m, int32_T n, real_T A_data[],
                   int32_T A_size[2], int32_T lda, int32_T ipiv_data[], int32_T
                   ipiv_size[2]);

#endif

/* End of code generation (xgetrf.h) */
