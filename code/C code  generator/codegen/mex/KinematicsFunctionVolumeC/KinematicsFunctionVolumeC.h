/*
 * KinematicsFunctionVolumeC.h
 *
 * Code generation for function 'KinematicsFunctionVolumeC'
 *
 */

#ifndef __KINEMATICSFUNCTIONVOLUMEC_H__
#define __KINEMATICSFUNCTIONVOLUMEC_H__

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

/* Function Declarations */
extern void KinematicsFunctionVolumeC(const emlrtStack *sp, struct0_T
  *init_kinematics, real_T dim, const real_T x_elem_data[], const int32_T
  x_elem_size[2], const real_T DNX_data[], const int32_T DNX_size[3]);

#endif

/* End of code generation (KinematicsFunctionVolumeC.h) */
