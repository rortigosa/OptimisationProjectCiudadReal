/*
 * ResidualsMatricesUC.h
 *
 * Code generation for function 'ResidualsMatricesUC'
 *
 */

#ifndef __RESIDUALSMATRICESUC_H__
#define __RESIDUALSMATRICESUC_H__

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
extern void ResidualsMatricesUC(const emlrtStack *sp, struct0_T *asmb, const
  struct1_T *derivatives, const real_T Piola_vect[16], const struct4_T *vect_kin,
  const struct5_T *kinematics, const real_T IntWeight[4], real_T dim, real_T
  n_node_elem, real_T ngauss);

#endif

/* End of code generation (ResidualsMatricesUC.h) */
