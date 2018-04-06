/*
 * File: ResidualsMatricesUC.h
 *
 * MATLAB Coder version            : 3.0
 * C/C++ source code generated on  : 16-Nov-2017 12:07:55
 */

#ifndef __RESIDUALSMATRICESUC_H__
#define __RESIDUALSMATRICESUC_H__

/* Include Files */
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include "rtwtypes.h"
#include "ResidualsMatricesUC_types.h"

/* Function Declarations */
extern void ResidualsMatricesUC(struct0_T *asmb, const struct1_T *derivatives,
  const double Piola_vect[16], const struct4_T *vect_kin, const struct5_T
  *kinematics, const double IntWeight[4], double dim, double n_node_elem, double
  ngauss);

#endif

/*
 * File trailer for ResidualsMatricesUC.h
 *
 * [EOF]
 */
