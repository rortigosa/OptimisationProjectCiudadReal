/*
 * FirstPiolaKirchhoffStressTensorUC.h
 *
 * Code generation for function 'FirstPiolaKirchhoffStressTensorUC'
 *
 */

#ifndef __FIRSTPIOLAKIRCHHOFFSTRESSTENSORUC_H__
#define __FIRSTPIOLAKIRCHHOFFSTRESSTENSORUC_H__

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
#include "FirstPiolaKirchhoffStressTensorUC_types.h"

/* Function Declarations */
extern void FirstPiolaKirchhoffStressTensorUC(const emlrtStack *sp, real_T
  Piola_data[], int32_T Piola_size[3], real_T ngauss, real_T dim, const real_T
  F_data[], const int32_T F_size[3], const real_T H_data[], const int32_T
  H_size[3], const real_T DUDF_data[], const int32_T DUDF_size[3], const real_T
  DUDH_data[], const int32_T DUDH_size[3], const real_T DUDJ_data[], const
  int32_T DUDJ_size[1]);

#endif

/* End of code generation (FirstPiolaKirchhoffStressTensorUC.h) */
