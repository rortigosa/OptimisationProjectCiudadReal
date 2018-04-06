/*
 * ResidualsMatricesULEC.h
 *
 * Code generation for function 'ResidualsMatricesULEC'
 *
 */

#ifndef __RESIDUALSMATRICESULEC_H__
#define __RESIDUALSMATRICESULEC_H__

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
#include "ResidualsMatricesULEC_types.h"

/* Function Declarations */
extern void ResidualsMatricesULEC(const emlrtStack *sp, struct0_T *asmb, const
  struct1_T *DU, const struct2_T *D2U, const struct3_T *vect_kin, const
  struct4_T *kinematics, const real_T IntWeight[4], real_T dim, real_T
  n_node_elem, real_T ngauss, const real_T u[8]);

#endif

/* End of code generation (ResidualsMatricesULEC.h) */
