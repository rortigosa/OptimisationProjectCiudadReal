/*
 * trace.h
 *
 * Code generation for function 'trace'
 *
 */

#ifndef __TRACE_H__
#define __TRACE_H__

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
extern real_T trace(const emlrtStack *sp, const real_T a_data[], const int32_T
                    a_size[2]);

#ifdef __WATCOMC__

#pragma aux trace value [8087];

#endif
#endif

/* End of code generation (trace.h) */
