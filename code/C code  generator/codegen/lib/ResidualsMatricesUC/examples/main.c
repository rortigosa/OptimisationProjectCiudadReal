/*
 * File: main.c
 *
 * MATLAB Coder version            : 3.0
 * C/C++ source code generated on  : 16-Nov-2017 12:07:55
 */

/*************************************************************************/
/* This automatically generated example C main file shows how to call    */
/* entry-point functions that MATLAB Coder generated. You must customize */
/* this file for your application. Do not modify this file directly.     */
/* Instead, make a copy of this file, modify it, and integrate it into   */
/* your development environment.                                         */
/*                                                                       */
/* This file initializes entry-point function arguments to a default     */
/* size and value before calling the entry-point functions. It does      */
/* not store or use any values returned from the entry-point functions.  */
/* If necessary, it does pre-allocate memory for returned values.        */
/* You can use this file as a starting point for a main function that    */
/* you can deploy in your application.                                   */
/*                                                                       */
/* After you copy the file, and before you deploy it, you must make the  */
/* following changes:                                                    */
/* * For variable-size function arguments, change the example sizes to   */
/* the sizes that your application requires.                             */
/* * Change the example values of function arguments to the values that  */
/* your application requires.                                            */
/* * If the entry-point functions return values, store these values or   */
/* otherwise use them as required by your application.                   */
/*                                                                       */
/*************************************************************************/
/* Include Files */
#include "rt_nonfinite.h"
#include "ResidualsMatricesUC.h"
#include "main.h"
#include "ResidualsMatricesUC_terminate.h"
#include "ResidualsMatricesUC_initialize.h"

/* Function Declarations */
static void argInit_2x2x4_real_T(double result[16]);
static void argInit_4x1_real_T(double result[4]);
static void argInit_4x1x4_real_T(double result[16]);
static void argInit_4x4_real_T(double result[16]);
static void argInit_4x4x4_real_T(double result[64]);
static void argInit_4x8x4_real_T(double result[128]);
static void argInit_8x1_real_T(double result[8]);
static void argInit_8x8_real_T(double result[64]);
static double argInit_real_T(void);
static void argInit_struct0_T(struct0_T *result);
static void argInit_struct1_T(struct1_T *result);
static void argInit_struct2_T(struct2_T *result);
static struct3_T argInit_struct3_T(void);
static void argInit_struct4_T(struct4_T *result);
static void argInit_struct5_T(struct5_T *result);
static void main_ResidualsMatricesUC(void);

/* Function Definitions */

/*
 * Arguments    : double result[16]
 * Return Type  : void
 */
static void argInit_2x2x4_real_T(double result[16])
{
  int idx0;
  int idx1;
  int idx2;

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 2; idx0++) {
    for (idx1 = 0; idx1 < 2; idx1++) {
      for (idx2 = 0; idx2 < 4; idx2++) {
        /* Set the value of the array element.
           Change this value to the value that the application requires. */
        result[(idx0 + (idx1 << 1)) + (idx2 << 2)] = argInit_real_T();
      }
    }
  }
}

/*
 * Arguments    : double result[4]
 * Return Type  : void
 */
static void argInit_4x1_real_T(double result[4])
{
  int idx0;

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 4; idx0++) {
    /* Set the value of the array element.
       Change this value to the value that the application requires. */
    result[idx0] = argInit_real_T();
  }
}

/*
 * Arguments    : double result[16]
 * Return Type  : void
 */
static void argInit_4x1x4_real_T(double result[16])
{
  int idx0;
  int idx2;

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 4; idx0++) {
    for (idx2 = 0; idx2 < 4; idx2++) {
      /* Set the value of the array element.
         Change this value to the value that the application requires. */
      result[idx0 + (idx2 << 2)] = argInit_real_T();
    }
  }
}

/*
 * Arguments    : double result[16]
 * Return Type  : void
 */
static void argInit_4x4_real_T(double result[16])
{
  int idx0;
  int idx1;

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 4; idx0++) {
    for (idx1 = 0; idx1 < 4; idx1++) {
      /* Set the value of the array element.
         Change this value to the value that the application requires. */
      result[idx0 + (idx1 << 2)] = argInit_real_T();
    }
  }
}

/*
 * Arguments    : double result[64]
 * Return Type  : void
 */
static void argInit_4x4x4_real_T(double result[64])
{
  int idx0;
  int idx1;
  int idx2;

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 4; idx0++) {
    for (idx1 = 0; idx1 < 4; idx1++) {
      for (idx2 = 0; idx2 < 4; idx2++) {
        /* Set the value of the array element.
           Change this value to the value that the application requires. */
        result[(idx0 + (idx1 << 2)) + (idx2 << 4)] = argInit_real_T();
      }
    }
  }
}

/*
 * Arguments    : double result[128]
 * Return Type  : void
 */
static void argInit_4x8x4_real_T(double result[128])
{
  int idx0;
  int idx1;
  int idx2;

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 4; idx0++) {
    for (idx1 = 0; idx1 < 8; idx1++) {
      for (idx2 = 0; idx2 < 4; idx2++) {
        /* Set the value of the array element.
           Change this value to the value that the application requires. */
        result[(idx0 + (idx1 << 2)) + (idx2 << 5)] = argInit_real_T();
      }
    }
  }
}

/*
 * Arguments    : double result[8]
 * Return Type  : void
 */
static void argInit_8x1_real_T(double result[8])
{
  int idx0;

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 8; idx0++) {
    /* Set the value of the array element.
       Change this value to the value that the application requires. */
    result[idx0] = argInit_real_T();
  }
}

/*
 * Arguments    : double result[64]
 * Return Type  : void
 */
static void argInit_8x8_real_T(double result[64])
{
  int idx0;
  int idx1;

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 8; idx0++) {
    for (idx1 = 0; idx1 < 8; idx1++) {
      /* Set the value of the array element.
         Change this value to the value that the application requires. */
      result[idx0 + (idx1 << 3)] = argInit_real_T();
    }
  }
}

/*
 * Arguments    : void
 * Return Type  : double
 */
static double argInit_real_T(void)
{
  return 0.0;
}

/*
 * Arguments    : struct0_T *result
 * Return Type  : void
 */
static void argInit_struct0_T(struct0_T *result)
{
  /* Set the value of each structure field.
     Change this value to the value that the application requires. */
  argInit_8x1_real_T(result->Tx);
  argInit_8x8_real_T(result->Kxx);
}

/*
 * Arguments    : struct1_T *result
 * Return Type  : void
 */
static void argInit_struct1_T(struct1_T *result)
{
  /* Set the value of each structure field.
     Change this value to the value that the application requires. */
  argInit_struct2_T(&result->D2U);
  result->DU = argInit_struct3_T();
}

/*
 * Arguments    : struct2_T *result
 * Return Type  : void
 */
static void argInit_struct2_T(struct2_T *result)
{
  /* Set the value of each structure field.
     Change this value to the value that the application requires. */
  argInit_4x4x4_real_T(result->D2UDFDF);
  argInit_4x4x4_real_T(result->D2UDFDH);
  argInit_4x1x4_real_T(result->D2UDFDJ);
  argInit_4x4x4_real_T(result->D2UDHDH);
  argInit_4x1x4_real_T(result->D2UDHDJ);
  argInit_4x1_real_T(result->D2UDJDJ);
}

/*
 * Arguments    : void
 * Return Type  : struct3_T
 */
static struct3_T argInit_struct3_T(void)
{
  struct3_T result;

  /* Set the value of each structure field.
     Change this value to the value that the application requires. */
  argInit_4x1_real_T(result.DUDJ);
  return result;
}

/*
 * Arguments    : struct4_T *result
 * Return Type  : void
 */
static void argInit_struct4_T(struct4_T *result)
{
  /* Set the value of each structure field.
     Change this value to the value that the application requires. */
  argInit_4x8x4_real_T(result->BF);
  argInit_4x4x4_real_T(result->QF);
  argInit_4x4x4_real_T(result->QSigmaH);
}

/*
 * Arguments    : struct5_T *result
 * Return Type  : void
 */
static void argInit_struct5_T(struct5_T *result)
{
  /* Set the value of each structure field.
     Change this value to the value that the application requires. */
  argInit_2x2x4_real_T(result->H);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
static void main_ResidualsMatricesUC(void)
{
  struct0_T asmb;
  struct1_T r0;
  double dv0[16];
  struct4_T r1;
  struct5_T r2;
  double dv1[4];

  /* Initialize function 'ResidualsMatricesUC' input arguments. */
  /* Initialize function input argument 'asmb'. */
  argInit_struct0_T(&asmb);

  /* Initialize function input argument 'derivatives'. */
  /* Initialize function input argument 'Piola_vect'. */
  /* Initialize function input argument 'vect_kin'. */
  /* Initialize function input argument 'kinematics'. */
  /* Initialize function input argument 'IntWeight'. */
  /* Call the entry-point 'ResidualsMatricesUC'. */
  argInit_struct1_T(&r0);
  argInit_4x4_real_T(dv0);
  argInit_struct4_T(&r1);
  argInit_struct5_T(&r2);
  argInit_4x1_real_T(dv1);
  ResidualsMatricesUC(&asmb, &r0, dv0, &r1, &r2, dv1, argInit_real_T(),
                      argInit_real_T(), argInit_real_T());
}

/*
 * Arguments    : int argc
 *                const char * const argv[]
 * Return Type  : int
 */
int main(int argc, const char * const argv[])
{
  (void)argc;
  (void)argv;

  /* Initialize the application.
     You do not need to do this more than one time. */
  ResidualsMatricesUC_initialize();

  /* Invoke the entry-point functions.
     You can call entry-point functions multiple times. */
  main_ResidualsMatricesUC();

  /* Terminate the application.
     You do not need to do this more than one time. */
  ResidualsMatricesUC_terminate();
  return 0;
}

/*
 * File trailer for main.c
 *
 * [EOF]
 */
