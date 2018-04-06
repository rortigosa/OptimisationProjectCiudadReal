/*
 * KinematicsFunctionVolumeC.c
 *
 * Code generation for function 'KinematicsFunctionVolumeC'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "KinematicsFunctionVolumeC.h"
#include "KinematicsFunctionVolumeC_emxutil.h"
#include "xgetrf.h"
#include "trace.h"
#include "KinematicsFunctionVolumeC_data.h"
#include "lapacke.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 20, "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m"
};

static emlrtRSInfo b_emlrtRSI = { 27, "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m"
};

static emlrtRSInfo c_emlrtRSI = { 33, "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m"
};

static emlrtRSInfo d_emlrtRSI = { 68, "eml_mtimes_helper",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\ops\\eml_mtimes_helper.m"
};

static emlrtRSInfo e_emlrtRSI = { 21, "eml_mtimes_helper",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\ops\\eml_mtimes_helper.m"
};

static emlrtRSInfo g_emlrtRSI = { 20, "det",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\matfun\\det.m"
};

static emlrtRTEInfo emlrtRTEI = { 9, 44, "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m"
};

static emlrtRTEInfo b_emlrtRTEI = { 13, 1, "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m"
};

static emlrtDCInfo emlrtDCI = { 12, 50, "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  4 };

static emlrtDCInfo b_emlrtDCI = { 12, 50, "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  1 };

static emlrtBCInfo emlrtBCI = { -1, -1, 20, 59, "DNX",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo b_emlrtBCI = { -1, -1, 29, 23, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo c_emlrtBCI = { -1, -1, 29, 25, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo d_emlrtBCI = { -1, -1, 29, 30, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo e_emlrtBCI = { -1, -1, 29, 32, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo f_emlrtBCI = { -1, -1, 29, 39, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo g_emlrtBCI = { -1, -1, 29, 41, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo h_emlrtBCI = { -1, -1, 29, 46, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo i_emlrtBCI = { -1, -1, 29, 48, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo j_emlrtBCI = { -1, -1, 29, 55, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo k_emlrtBCI = { -1, -1, 29, 57, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo l_emlrtBCI = { -1, -1, 29, 62, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo m_emlrtBCI = { -1, -1, 29, 64, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo n_emlrtBCI = { -1, -1, 29, 71, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo o_emlrtBCI = { -1, -1, 29, 73, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo p_emlrtBCI = { -1, -1, 29, 78, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo q_emlrtBCI = { -1, -1, 29, 80, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo r_emlrtBCI = { -1, -1, 29, 92, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo s_emlrtBCI = { -1, -1, 29, 94, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo t_emlrtBCI = { -1, -1, 29, 99, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo u_emlrtBCI = { -1, -1, 29, 101, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo v_emlrtBCI = { -1, -1, 29, 108, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo w_emlrtBCI = { -1, -1, 29, 110, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo x_emlrtBCI = { -1, -1, 29, 115, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo y_emlrtBCI = { -1, -1, 29, 117, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ab_emlrtBCI = { -1, -1, 29, 124, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo bb_emlrtBCI = { -1, -1, 29, 126, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo cb_emlrtBCI = { -1, -1, 29, 131, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo db_emlrtBCI = { -1, -1, 29, 133, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo eb_emlrtBCI = { -1, -1, 29, 140, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo fb_emlrtBCI = { -1, -1, 29, 142, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo gb_emlrtBCI = { -1, -1, 29, 147, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo hb_emlrtBCI = { -1, -1, 29, 149, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ib_emlrtBCI = { -1, -1, 29, 158, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo jb_emlrtBCI = { -1, -1, 29, 160, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo kb_emlrtBCI = { -1, -1, 29, 165, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo lb_emlrtBCI = { -1, -1, 29, 167, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo mb_emlrtBCI = { -1, -1, 29, 174, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo nb_emlrtBCI = { -1, -1, 29, 176, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ob_emlrtBCI = { -1, -1, 29, 181, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo pb_emlrtBCI = { -1, -1, 29, 183, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo qb_emlrtBCI = { -1, -1, 29, 190, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo rb_emlrtBCI = { -1, -1, 29, 192, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo sb_emlrtBCI = { -1, -1, 29, 197, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo tb_emlrtBCI = { -1, -1, 29, 199, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ub_emlrtBCI = { -1, -1, 29, 206, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo vb_emlrtBCI = { -1, -1, 29, 208, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo wb_emlrtBCI = { -1, -1, 29, 213, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo xb_emlrtBCI = { -1, -1, 29, 215, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo yb_emlrtBCI = { -1, -1, 30, 20, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ac_emlrtBCI = { -1, -1, 30, 22, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo bc_emlrtBCI = { -1, -1, 30, 27, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo cc_emlrtBCI = { -1, -1, 30, 29, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo dc_emlrtBCI = { -1, -1, 30, 36, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ec_emlrtBCI = { -1, -1, 30, 38, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo fc_emlrtBCI = { -1, -1, 30, 43, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo gc_emlrtBCI = { -1, -1, 30, 45, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo hc_emlrtBCI = { -1, -1, 30, 52, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ic_emlrtBCI = { -1, -1, 30, 54, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo jc_emlrtBCI = { -1, -1, 30, 59, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo kc_emlrtBCI = { -1, -1, 30, 61, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo lc_emlrtBCI = { -1, -1, 30, 68, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo mc_emlrtBCI = { -1, -1, 30, 70, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo nc_emlrtBCI = { -1, -1, 30, 75, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo oc_emlrtBCI = { -1, -1, 30, 77, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo pc_emlrtBCI = { -1, -1, 30, 89, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo qc_emlrtBCI = { -1, -1, 30, 91, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo rc_emlrtBCI = { -1, -1, 30, 96, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo sc_emlrtBCI = { -1, -1, 30, 98, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo tc_emlrtBCI = { -1, -1, 30, 105, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo uc_emlrtBCI = { -1, -1, 30, 107, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo vc_emlrtBCI = { -1, -1, 30, 112, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo wc_emlrtBCI = { -1, -1, 30, 114, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo xc_emlrtBCI = { -1, -1, 30, 121, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo yc_emlrtBCI = { -1, -1, 30, 123, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ad_emlrtBCI = { -1, -1, 30, 128, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo bd_emlrtBCI = { -1, -1, 30, 130, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo cd_emlrtBCI = { -1, -1, 30, 137, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo dd_emlrtBCI = { -1, -1, 30, 139, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ed_emlrtBCI = { -1, -1, 30, 144, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo fd_emlrtBCI = { -1, -1, 30, 146, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo gd_emlrtBCI = { -1, -1, 30, 155, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo hd_emlrtBCI = { -1, -1, 30, 157, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo id_emlrtBCI = { -1, -1, 30, 162, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo jd_emlrtBCI = { -1, -1, 30, 164, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo kd_emlrtBCI = { -1, -1, 30, 171, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ld_emlrtBCI = { -1, -1, 30, 173, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo md_emlrtBCI = { -1, -1, 30, 178, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo nd_emlrtBCI = { -1, -1, 30, 180, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo od_emlrtBCI = { -1, -1, 30, 187, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo pd_emlrtBCI = { -1, -1, 30, 189, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo qd_emlrtBCI = { -1, -1, 30, 194, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo rd_emlrtBCI = { -1, -1, 30, 196, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo sd_emlrtBCI = { -1, -1, 30, 203, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo td_emlrtBCI = { -1, -1, 30, 205, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ud_emlrtBCI = { -1, -1, 30, 210, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo vd_emlrtBCI = { -1, -1, 30, 212, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo wd_emlrtBCI = { -1, -1, 31, 20, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo xd_emlrtBCI = { -1, -1, 31, 22, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo yd_emlrtBCI = { -1, -1, 31, 27, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ae_emlrtBCI = { -1, -1, 31, 29, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo be_emlrtBCI = { -1, -1, 31, 36, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ce_emlrtBCI = { -1, -1, 31, 38, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo de_emlrtBCI = { -1, -1, 31, 43, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ee_emlrtBCI = { -1, -1, 31, 45, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo fe_emlrtBCI = { -1, -1, 31, 52, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ge_emlrtBCI = { -1, -1, 31, 54, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo he_emlrtBCI = { -1, -1, 31, 59, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ie_emlrtBCI = { -1, -1, 31, 61, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo je_emlrtBCI = { -1, -1, 31, 68, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ke_emlrtBCI = { -1, -1, 31, 70, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo le_emlrtBCI = { -1, -1, 31, 75, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo me_emlrtBCI = { -1, -1, 31, 77, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ne_emlrtBCI = { -1, -1, 31, 89, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo oe_emlrtBCI = { -1, -1, 31, 91, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo pe_emlrtBCI = { -1, -1, 31, 96, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo qe_emlrtBCI = { -1, -1, 31, 98, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo re_emlrtBCI = { -1, -1, 31, 105, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo se_emlrtBCI = { -1, -1, 31, 107, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo te_emlrtBCI = { -1, -1, 31, 112, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ue_emlrtBCI = { -1, -1, 31, 114, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ve_emlrtBCI = { -1, -1, 31, 121, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo we_emlrtBCI = { -1, -1, 31, 123, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo xe_emlrtBCI = { -1, -1, 31, 128, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ye_emlrtBCI = { -1, -1, 31, 130, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo af_emlrtBCI = { -1, -1, 31, 137, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo bf_emlrtBCI = { -1, -1, 31, 139, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo cf_emlrtBCI = { -1, -1, 31, 144, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo df_emlrtBCI = { -1, -1, 31, 146, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ef_emlrtBCI = { -1, -1, 31, 155, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo ff_emlrtBCI = { -1, -1, 31, 157, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo gf_emlrtBCI = { -1, -1, 31, 162, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo hf_emlrtBCI = { -1, -1, 31, 164, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo if_emlrtBCI = { -1, -1, 31, 171, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo jf_emlrtBCI = { -1, -1, 31, 173, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo kf_emlrtBCI = { -1, -1, 31, 178, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo lf_emlrtBCI = { -1, -1, 31, 180, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo mf_emlrtBCI = { -1, -1, 31, 187, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo nf_emlrtBCI = { -1, -1, 31, 189, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo of_emlrtBCI = { -1, -1, 31, 194, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo pf_emlrtBCI = { -1, -1, 31, 196, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo qf_emlrtBCI = { -1, -1, 31, 203, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo rf_emlrtBCI = { -1, -1, 31, 205, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo sf_emlrtBCI = { -1, -1, 31, 210, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtBCInfo tf_emlrtBCI = { -1, -1, 31, 212, "F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtECInfo emlrtECI = { 2, 27, 19, "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m"
};

static emlrtBCInfo uf_emlrtBCI = { -1, -1, 37, 27, "init_kinematics.F",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtECInfo b_emlrtECI = { -1, 37, 5, "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m"
};

static emlrtBCInfo vf_emlrtBCI = { -1, -1, 38, 27, "init_kinematics.H",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

static emlrtECInfo c_emlrtECI = { -1, 38, 5, "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m"
};

static emlrtRTEInfo e_emlrtRTEI = { 103, 23, "eml_mtimes_helper",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\ops\\eml_mtimes_helper.m"
};

static emlrtRTEInfo f_emlrtRTEI = { 98, 23, "eml_mtimes_helper",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\ops\\eml_mtimes_helper.m"
};

static emlrtRTEInfo g_emlrtRTEI = { 11, 15, "det",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\matfun\\det.m"
};

static emlrtBCInfo wf_emlrtBCI = { -1, -1, 39, 5, "init_kinematics.J",
  "KinematicsFunctionVolumeC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\KinematicsFunctionVolumeC.m",
  0 };

/* Function Definitions */
void KinematicsFunctionVolumeC(const emlrtStack *sp, struct0_T *init_kinematics,
  real_T dim, const real_T x_elem_data[], const int32_T x_elem_size[2], const
  real_T DNX_data[], const int32_T DNX_size[3])
{
  emxArray_real_T *H;
  int32_T k;
  int32_T loop_ub;
  int32_T igauss;
  emxArray_real_T *y;
  int32_T b_loop_ub;
  int32_T i2;
  real_T b_data[24];
  int32_T y_size[2];
  int32_T c_loop_ub;
  real_T y_data[9];
  int32_T d_loop_ub;
  int32_T i3;
  real_T alpha1;
  real_T beta1;
  char_T TRANSB;
  char_T TRANSA;
  ptrdiff_t m_t;
  ptrdiff_t n_t;
  ptrdiff_t k_t;
  ptrdiff_t lda_t;
  ptrdiff_t ldb_t;
  ptrdiff_t ldc_t;
  int32_T iv4[2];
  int32_T b_y[2];
  static const int8_T b[4] = { 1, 0, 0, 1 };

  real_T c_y[9];
  real_T J;
  int32_T x_size[2];
  real_T x_data[9];
  int32_T ipiv_size[2];
  int32_T ipiv_data[3];
  boolean_T isodd;
  int32_T tmp_data[3];
  int32_T b_tmp_data[3];
  int32_T iv5[2];
  int32_T iv6[2];
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  emxInit_real_T(sp, &H, 2, &b_emlrtRTEI, true);

  /* -------------------------------------------------------------------------- */
  /* -------------------------------------------------------------------------- */
  /*  */
  /*  Kinematics of the continuum */
  /*  */
  /* -------------------------------------------------------------------------- */
  /* -------------------------------------------------------------------------- */
  if (!(dim > 0.0)) {
    emlrtNonNegativeCheckR2012b(dim, &emlrtDCI, sp);
  }

  if (dim != (int32_T)muDoubleScalarFloor(dim)) {
    emlrtIntegerCheckR2012b(dim, &b_emlrtDCI, sp);
  }

  k = H->size[0] * H->size[1];
  H->size[0] = (int32_T)dim;
  H->size[1] = (int32_T)dim;
  emxEnsureCapacity(sp, (emxArray__common *)H, k, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  loop_ub = (int32_T)dim * (int32_T)dim;
  for (k = 0; k < loop_ub; k++) {
    H->data[k] = 0.0;
  }

  igauss = 0;
  emxInit_real_T(sp, &y, 2, &emlrtRTEI, true);
  while (igauss <= DNX_size[2] - 1) {
    /* ---------------------------------------------------------------------- */
    /*  Compute derivative of displacements (Dx0DX) */
    /* ---------------------------------------------------------------------- */
    st.site = &emlrtRSI;
    loop_ub = DNX_size[0];
    b_loop_ub = DNX_size[1];
    k = 1 + igauss;
    if (!((k >= 1) && (k <= DNX_size[2]))) {
      emlrtDynamicBoundsCheckR2012b(k, 1, DNX_size[2], &emlrtBCI, &st);
    }

    for (k = 0; k < loop_ub; k++) {
      for (i2 = 0; i2 < b_loop_ub; i2++) {
        b_data[i2 + b_loop_ub * k] = DNX_data[(k + DNX_size[0] * i2) + DNX_size
          [0] * DNX_size[1] * igauss];
      }
    }

    b_st.site = &e_emlrtRSI;
    if (!(x_elem_size[1] == DNX_size[1])) {
      if (((x_elem_size[0] == 1) && (x_elem_size[1] == 1)) || ((DNX_size[1] == 1)
           && (DNX_size[0] == 1))) {
        emlrtErrorWithMessageIdR2012b(&b_st, &f_emlrtRTEI,
          "Coder:toolbox:mtimes_noDynamicScalarExpansion", 0);
      } else {
        emlrtErrorWithMessageIdR2012b(&b_st, &e_emlrtRTEI,
          "Coder:MATLAB:innerdim", 0);
      }
    }

    if ((x_elem_size[1] == 1) || (DNX_size[1] == 1)) {
      y_size[0] = x_elem_size[0];
      y_size[1] = DNX_size[0];
      c_loop_ub = x_elem_size[0];
      for (k = 0; k < c_loop_ub; k++) {
        for (i2 = 0; i2 < loop_ub; i2++) {
          y_data[k + y_size[0] * i2] = 0.0;
          d_loop_ub = x_elem_size[1];
          for (i3 = 0; i3 < d_loop_ub; i3++) {
            y_data[k + y_size[0] * i2] += x_elem_data[k + x_elem_size[0] * i3] *
              b_data[i3 + b_loop_ub * i2];
          }
        }
      }
    } else {
      y_size[0] = (int8_T)x_elem_size[0];
      y_size[1] = (int8_T)DNX_size[0];
      loop_ub = (int8_T)DNX_size[0];
      for (k = 0; k < loop_ub; k++) {
        b_loop_ub = y_size[0];
        for (i2 = 0; i2 < b_loop_ub; i2++) {
          y_data[i2 + y_size[0] * k] = 0.0;
        }
      }

      b_st.site = &d_emlrtRSI;
      if ((x_elem_size[0] < 1) || (DNX_size[0] < 1) || (x_elem_size[1] < 1)) {
      } else {
        alpha1 = 1.0;
        beta1 = 0.0;
        TRANSB = 'N';
        TRANSA = 'N';
        m_t = (ptrdiff_t)x_elem_size[0];
        n_t = (ptrdiff_t)DNX_size[0];
        k_t = (ptrdiff_t)x_elem_size[1];
        lda_t = (ptrdiff_t)x_elem_size[0];
        ldb_t = (ptrdiff_t)x_elem_size[1];
        ldc_t = (ptrdiff_t)x_elem_size[0];
        dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &alpha1, &x_elem_data[0],
              &lda_t, &b_data[0], &ldb_t, &beta1, &y_data[0], &ldc_t);
      }
    }

    /* ---------------------------------------------------------------------- */
    /*  Compute deformation gradient tensor */
    /* ---------------------------------------------------------------------- */
    switch ((int32_T)dim) {
     case 2:
      for (k = 0; k < 2; k++) {
        iv4[k] = 2;
      }

      b_y[0] = y_size[1];
      b_y[1] = y_size[0];
      if ((iv4[0] != b_y[0]) || (iv4[1] != b_y[1])) {
        emlrtSizeEqCheckNDR2012b(&iv4[0], &b_y[0], &emlrtECI, sp);
      }

      st.site = &b_emlrtRSI;
      alpha1 = trace(&st, y_data, y_size);
      k = y->size[0] * y->size[1];
      y->size[0] = y_size[1];
      y->size[1] = y_size[0];
      emxEnsureCapacity(sp, (emxArray__common *)y, k, (int32_T)sizeof(real_T),
                        &emlrtRTEI);
      loop_ub = y_size[0];
      for (k = 0; k < loop_ub; k++) {
        b_loop_ub = y_size[1];
        for (i2 = 0; i2 < b_loop_ub; i2++) {
          y->data[i2 + y->size[0] * k] = y_data[k + y_size[0] * i2];
        }
      }

      k = H->size[0] * H->size[1];
      H->size[0] = 2;
      H->size[1] = 2;
      emxEnsureCapacity(sp, (emxArray__common *)H, k, (int32_T)sizeof(real_T),
                        &emlrtRTEI);
      for (k = 0; k < 2; k++) {
        for (i2 = 0; i2 < 2; i2++) {
          H->data[i2 + H->size[0] * k] = alpha1 * (real_T)b[i2 + (k << 1)] -
            y->data[i2 + (k << 1)];
        }
      }
      break;

     case 3:
      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &b_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &c_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &d_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &e_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &f_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &g_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &h_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &i_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &j_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &k_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &l_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &m_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &n_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &o_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &p_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &q_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &r_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &s_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &t_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &u_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &v_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &w_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &x_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &y_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &ab_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &bb_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &cb_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &db_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &eb_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &fb_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &gb_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &hb_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &ib_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &jb_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &kb_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &lb_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &mb_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &nb_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &ob_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &pb_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &qb_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &rb_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &sb_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &tb_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &ub_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &vb_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &wb_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &xb_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &yb_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &ac_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &bc_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &cc_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &dc_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &ec_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &fc_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &gc_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &hc_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &ic_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &jc_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &kc_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &lc_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &mc_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &nc_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &oc_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &pc_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &qc_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &rc_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &sc_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &tc_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &uc_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &vc_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &wc_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &xc_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &yc_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &ad_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &bd_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &cd_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &dd_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &ed_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &fd_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &gd_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &hd_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &id_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &jd_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &kd_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &ld_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &md_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &nd_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &od_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &pd_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &qd_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &rd_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &sd_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &td_emlrtBCI, sp);
      }

      if (!(3 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[0], &ud_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &vd_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &wd_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &xd_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &yd_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &ae_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &be_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &ce_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &de_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &ee_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &fe_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &ge_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &he_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &ie_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &je_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &ke_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &le_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &me_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &ne_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &oe_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &pe_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &qe_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &re_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &se_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &te_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &ue_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &ve_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &we_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &xe_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &ye_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &af_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &bf_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &cf_emlrtBCI, sp);
      }

      if (!(3 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, y_size[1], &df_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &ef_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &ff_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &gf_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &hf_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &if_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &jf_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &kf_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &lf_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &mf_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &nf_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &of_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &pf_emlrtBCI, sp);
      }

      if (!(2 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[0], &qf_emlrtBCI, sp);
      }

      if (!(2 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, y_size[1], &rf_emlrtBCI, sp);
      }

      if (!(1 <= y_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[0], &sf_emlrtBCI, sp);
      }

      if (!(1 <= y_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, y_size[1], &tf_emlrtBCI, sp);
      }

      c_y[0] = ((y_data[1 + y_size[0]] * y_data[2 + (y_size[0] << 1)] - y_data[1
                 + (y_size[0] << 1)] * y_data[2 + y_size[0]]) - y_data[2 +
                y_size[0]] * y_data[1 + (y_size[0] << 1)]) + y_data[2 + (y_size
        [0] << 1)] * y_data[1 + y_size[0]];
      c_y[3] = ((y_data[1 + (y_size[0] << 1)] * y_data[2] - y_data[1] * y_data[2
                 + (y_size[0] << 1)]) - y_data[2 + (y_size[0] << 1)] * y_data[1])
        + y_data[2] * y_data[1 + (y_size[0] << 1)];
      c_y[6] = ((y_data[1] * y_data[2 + y_size[0]] - y_data[1 + y_size[0]] *
                 y_data[2]) - y_data[2] * y_data[1 + y_size[0]]) + y_data[2 +
        y_size[0]] * y_data[1];
      c_y[1] = ((y_data[2 + y_size[0]] * y_data[y_size[0] << 1] - y_data[2 +
                 (y_size[0] << 1)] * y_data[y_size[0]]) - y_data[y_size[0]] *
                y_data[2 + (y_size[0] << 1)]) + y_data[y_size[0] << 1] * y_data
        [2 + y_size[0]];
      c_y[4] = ((y_data[2 + (y_size[0] << 1)] * y_data[0] - y_data[2] *
                 y_data[y_size[0] << 1]) - y_data[y_size[0] << 1] * y_data[2]) +
        y_data[0] * y_data[2 + (y_size[0] << 1)];
      c_y[7] = ((y_data[2] * y_data[y_size[0]] - y_data[2 + y_size[0]] * y_data
                 [0]) - y_data[0] * y_data[2 + y_size[0]]) + y_data[y_size[0]] *
        y_data[2];
      c_y[2] = ((y_data[y_size[0]] * y_data[1 + (y_size[0] << 1)] -
                 y_data[y_size[0] << 1] * y_data[1 + y_size[0]]) - y_data[1 +
                y_size[0]] * y_data[y_size[0] << 1]) + y_data[1 + (y_size[0] <<
        1)] * y_data[y_size[0]];
      c_y[5] = ((y_data[y_size[0] << 1] * y_data[1] - y_data[0] * y_data[1 +
                 (y_size[0] << 1)]) - y_data[1 + (y_size[0] << 1)] * y_data[0])
        + y_data[1] * y_data[y_size[0] << 1];
      c_y[8] = ((y_data[0] * y_data[1 + y_size[0]] - y_data[y_size[0]] * y_data
                 [1]) - y_data[1] * y_data[y_size[0]]) + y_data[1 + y_size[0]] *
        y_data[0];
      k = H->size[0] * H->size[1];
      H->size[0] = 3;
      H->size[1] = 3;
      emxEnsureCapacity(sp, (emxArray__common *)H, k, (int32_T)sizeof(real_T),
                        &emlrtRTEI);
      for (k = 0; k < 3; k++) {
        for (i2 = 0; i2 < 3; i2++) {
          H->data[i2 + H->size[0] * k] = c_y[i2 + 3 * k];
        }
      }
      break;
    }

    st.site = &c_emlrtRSI;
    if (y_size[0] == y_size[1]) {
    } else {
      emlrtErrorWithMessageIdR2012b(&st, &g_emlrtRTEI, "Coder:MATLAB:square", 0);
    }

    if ((y_size[0] == 0) || (y_size[1] == 0)) {
      J = 1.0;
    } else {
      x_size[0] = y_size[0];
      x_size[1] = y_size[1];
      loop_ub = y_size[0] * y_size[1];
      for (k = 0; k < loop_ub; k++) {
        x_data[k] = y_data[k];
      }

      b_st.site = &g_emlrtRSI;
      xgetrf(&b_st, y_size[0], y_size[1], x_data, x_size, y_size[0], ipiv_data,
             ipiv_size);
      J = x_data[0];
      for (k = 1; k - 1 <= x_size[0] - 2; k++) {
        J *= x_data[k + x_size[0] * k];
      }

      isodd = false;
      for (k = 0; k <= ipiv_size[1] - 2; k++) {
        if (ipiv_data[k] > 1 + k) {
          isodd = !isodd;
        }
      }

      if (isodd) {
        J = -J;
      }
    }

    /* ---------------------------------------------------------------------- */
    /*   Storing information. */
    /* ---------------------------------------------------------------------- */
    loop_ub = init_kinematics->F.size[0];
    for (k = 0; k < loop_ub; k++) {
      tmp_data[k] = k;
    }

    b_loop_ub = init_kinematics->F.size[1];
    for (k = 0; k < b_loop_ub; k++) {
      b_tmp_data[k] = k;
    }

    k = init_kinematics->F.size[2];
    i2 = igauss + 1;
    if (!((i2 >= 1) && (i2 <= k))) {
      emlrtDynamicBoundsCheckR2012b(i2, 1, k, &uf_emlrtBCI, sp);
    }

    iv5[0] = loop_ub;
    iv5[1] = b_loop_ub;
    emlrtSubAssignSizeCheckR2012b(iv5, 2, y_size, 2, &b_emlrtECI, sp);
    loop_ub = y_size[1];
    for (k = 0; k < loop_ub; k++) {
      b_loop_ub = y_size[0];
      for (i2 = 0; i2 < b_loop_ub; i2++) {
        init_kinematics->F.data[(tmp_data[i2] + init_kinematics->F.size[0] *
          b_tmp_data[k]) + init_kinematics->F.size[0] * init_kinematics->F.size
          [1] * igauss] = y_data[i2 + y_size[0] * k];
      }
    }

    loop_ub = init_kinematics->H.size[0];
    for (k = 0; k < loop_ub; k++) {
      tmp_data[k] = k;
    }

    b_loop_ub = init_kinematics->H.size[1];
    for (k = 0; k < b_loop_ub; k++) {
      b_tmp_data[k] = k;
    }

    k = init_kinematics->H.size[2];
    i2 = igauss + 1;
    if (!((i2 >= 1) && (i2 <= k))) {
      emlrtDynamicBoundsCheckR2012b(i2, 1, k, &vf_emlrtBCI, sp);
    }

    iv6[0] = loop_ub;
    iv6[1] = b_loop_ub;
    emlrtSubAssignSizeCheckR2012b(iv6, 2, *(int32_T (*)[2])H->size, 2,
      &c_emlrtECI, sp);
    loop_ub = H->size[1];
    for (k = 0; k < loop_ub; k++) {
      b_loop_ub = H->size[0];
      for (i2 = 0; i2 < b_loop_ub; i2++) {
        init_kinematics->H.data[(tmp_data[i2] + init_kinematics->H.size[0] *
          b_tmp_data[k]) + init_kinematics->H.size[0] * init_kinematics->H.size
          [1] * igauss] = H->data[i2 + H->size[0] * k];
      }
    }

    k = init_kinematics->J.size[0];
    i2 = 1 + igauss;
    if (!((i2 >= 1) && (i2 <= k))) {
      emlrtDynamicBoundsCheckR2012b(i2, 1, k, &wf_emlrtBCI, sp);
    }

    init_kinematics->J.data[i2 - 1] = J;
    igauss++;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_real_T(&y);
  emxFree_real_T(&H);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (KinematicsFunctionVolumeC.c) */
