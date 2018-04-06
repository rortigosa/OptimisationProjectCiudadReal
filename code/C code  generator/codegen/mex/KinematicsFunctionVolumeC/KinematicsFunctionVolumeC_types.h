/*
 * KinematicsFunctionVolumeC_types.h
 *
 * Code generation for function 'KinematicsFunctionVolumeC'
 *
 */

#ifndef __KINEMATICSFUNCTIONVOLUMEC_TYPES_H__
#define __KINEMATICSFUNCTIONVOLUMEC_TYPES_H__

/* Include files */
#include "rtwtypes.h"

/* Type Definitions */
#ifndef struct_emxArray__common
#define struct_emxArray__common

struct emxArray__common
{
  void *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
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
  real_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_real_T*/

#ifndef typedef_emxArray_real_T
#define typedef_emxArray_real_T

typedef struct emxArray_real_T emxArray_real_T;

#endif                                 /*typedef_emxArray_real_T*/

#ifndef struct_emxArray_real_T_3x3x8
#define struct_emxArray_real_T_3x3x8

struct emxArray_real_T_3x3x8
{
  real_T data[72];
  int32_T size[3];
};

#endif                                 /*struct_emxArray_real_T_3x3x8*/

#ifndef typedef_emxArray_real_T_3x3x8
#define typedef_emxArray_real_T_3x3x8

typedef struct emxArray_real_T_3x3x8 emxArray_real_T_3x3x8;

#endif                                 /*typedef_emxArray_real_T_3x3x8*/

#ifndef struct_emxArray_real_T_8
#define struct_emxArray_real_T_8

struct emxArray_real_T_8
{
  real_T data[8];
  int32_T size[1];
};

#endif                                 /*struct_emxArray_real_T_8*/

#ifndef typedef_emxArray_real_T_8
#define typedef_emxArray_real_T_8

typedef struct emxArray_real_T_8 emxArray_real_T_8;

#endif                                 /*typedef_emxArray_real_T_8*/

#ifndef typedef_struct0_T
#define typedef_struct0_T

typedef struct {
  emxArray_real_T_3x3x8 F;
  emxArray_real_T_3x3x8 H;
  emxArray_real_T_8 J;
} struct0_T;

#endif                                 /*typedef_struct0_T*/
#endif

/* End of code generation (KinematicsFunctionVolumeC_types.h) */
