/*
 * FirstPiolaKirchhoffStressTensorUC.cpp
 *
 * Code generation for function 'FirstPiolaKirchhoffStressTensorUC'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "FirstPiolaKirchhoffStressTensorUC.h"
#include "FirstPiolaKirchhoffStressTensorUC_emxutil.h"
#include "FirstPiolaKirchhoffStressTensorUC_data.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 24, "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m"
};

static emlrtRTEInfo emlrtRTEI = { 8, 27, "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m"
};

static emlrtRTEInfo b_emlrtRTEI = { 10, 1, "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m"
};

static emlrtDCInfo emlrtDCI = { 10, 33, "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  4 };

static emlrtDCInfo b_emlrtDCI = { 10, 33, "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  1 };

static emlrtDCInfo c_emlrtDCI = { 10, 37, "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  4 };

static emlrtDCInfo d_emlrtDCI = { 10, 37, "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  1 };

static emlrtRTEInfo c_emlrtRTEI = { 13, 1, "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m"
};

static emlrtBCInfo emlrtBCI = { -1, -1, 17, 36, "DUDH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo b_emlrtBCI = { -1, -1, 18, 33, "F",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo c_emlrtBCI = { -1, -1, 26, 36, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo d_emlrtBCI = { -1, -1, 26, 38, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo e_emlrtBCI = { -1, -1, 26, 44, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo f_emlrtBCI = { -1, -1, 26, 46, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo g_emlrtBCI = { -1, -1, 26, 58, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo h_emlrtBCI = { -1, -1, 26, 60, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo i_emlrtBCI = { -1, -1, 26, 66, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo j_emlrtBCI = { -1, -1, 26, 68, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo k_emlrtBCI = { -1, -1, 26, 80, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo l_emlrtBCI = { -1, -1, 26, 82, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo m_emlrtBCI = { -1, -1, 26, 88, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo n_emlrtBCI = { -1, -1, 26, 90, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo o_emlrtBCI = { -1, -1, 26, 102, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo p_emlrtBCI = { -1, -1, 26, 104, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo q_emlrtBCI = { -1, -1, 26, 110, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo r_emlrtBCI = { -1, -1, 26, 112, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo s_emlrtBCI = { -1, -1, 26, 129, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo t_emlrtBCI = { -1, -1, 26, 131, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo u_emlrtBCI = { -1, -1, 26, 137, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo v_emlrtBCI = { -1, -1, 26, 139, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo w_emlrtBCI = { -1, -1, 26, 151, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo x_emlrtBCI = { -1, -1, 26, 153, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo y_emlrtBCI = { -1, -1, 26, 159, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ab_emlrtBCI = { -1, -1, 26, 161, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo bb_emlrtBCI = { -1, -1, 26, 173, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo cb_emlrtBCI = { -1, -1, 26, 175, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo db_emlrtBCI = { -1, -1, 26, 181, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo eb_emlrtBCI = { -1, -1, 26, 183, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo fb_emlrtBCI = { -1, -1, 26, 195, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo gb_emlrtBCI = { -1, -1, 26, 197, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo hb_emlrtBCI = { -1, -1, 26, 203, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ib_emlrtBCI = { -1, -1, 26, 205, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo jb_emlrtBCI = { -1, -1, 26, 219, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo kb_emlrtBCI = { -1, -1, 26, 221, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo lb_emlrtBCI = { -1, -1, 26, 227, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo mb_emlrtBCI = { -1, -1, 26, 229, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo nb_emlrtBCI = { -1, -1, 26, 241, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ob_emlrtBCI = { -1, -1, 26, 243, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo pb_emlrtBCI = { -1, -1, 26, 249, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo qb_emlrtBCI = { -1, -1, 26, 251, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo rb_emlrtBCI = { -1, -1, 26, 263, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo sb_emlrtBCI = { -1, -1, 26, 265, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo tb_emlrtBCI = { -1, -1, 26, 271, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ub_emlrtBCI = { -1, -1, 26, 273, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo vb_emlrtBCI = { -1, -1, 26, 285, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo wb_emlrtBCI = { -1, -1, 26, 287, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo xb_emlrtBCI = { -1, -1, 26, 293, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo yb_emlrtBCI = { -1, -1, 26, 295, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ac_emlrtBCI = { -1, -1, 27, 36, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo bc_emlrtBCI = { -1, -1, 27, 38, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo cc_emlrtBCI = { -1, -1, 27, 44, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo dc_emlrtBCI = { -1, -1, 27, 46, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ec_emlrtBCI = { -1, -1, 27, 58, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo fc_emlrtBCI = { -1, -1, 27, 60, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo gc_emlrtBCI = { -1, -1, 27, 66, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo hc_emlrtBCI = { -1, -1, 27, 68, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ic_emlrtBCI = { -1, -1, 27, 80, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo jc_emlrtBCI = { -1, -1, 27, 82, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo kc_emlrtBCI = { -1, -1, 27, 88, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo lc_emlrtBCI = { -1, -1, 27, 90, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo mc_emlrtBCI = { -1, -1, 27, 102, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo nc_emlrtBCI = { -1, -1, 27, 104, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo oc_emlrtBCI = { -1, -1, 27, 110, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo pc_emlrtBCI = { -1, -1, 27, 112, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo qc_emlrtBCI = { -1, -1, 27, 129, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo rc_emlrtBCI = { -1, -1, 27, 131, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo sc_emlrtBCI = { -1, -1, 27, 137, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo tc_emlrtBCI = { -1, -1, 27, 139, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo uc_emlrtBCI = { -1, -1, 27, 151, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo vc_emlrtBCI = { -1, -1, 27, 153, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo wc_emlrtBCI = { -1, -1, 27, 159, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo xc_emlrtBCI = { -1, -1, 27, 161, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo yc_emlrtBCI = { -1, -1, 27, 173, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ad_emlrtBCI = { -1, -1, 27, 175, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo bd_emlrtBCI = { -1, -1, 27, 181, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo cd_emlrtBCI = { -1, -1, 27, 183, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo dd_emlrtBCI = { -1, -1, 27, 195, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ed_emlrtBCI = { -1, -1, 27, 197, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo fd_emlrtBCI = { -1, -1, 27, 203, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo gd_emlrtBCI = { -1, -1, 27, 205, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo hd_emlrtBCI = { -1, -1, 27, 219, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo id_emlrtBCI = { -1, -1, 27, 221, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo jd_emlrtBCI = { -1, -1, 27, 227, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo kd_emlrtBCI = { -1, -1, 27, 229, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ld_emlrtBCI = { -1, -1, 27, 241, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo md_emlrtBCI = { -1, -1, 27, 243, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo nd_emlrtBCI = { -1, -1, 27, 249, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo od_emlrtBCI = { -1, -1, 27, 251, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo pd_emlrtBCI = { -1, -1, 27, 263, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo qd_emlrtBCI = { -1, -1, 27, 265, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo rd_emlrtBCI = { -1, -1, 27, 271, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo sd_emlrtBCI = { -1, -1, 27, 273, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo td_emlrtBCI = { -1, -1, 27, 285, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ud_emlrtBCI = { -1, -1, 27, 287, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo vd_emlrtBCI = { -1, -1, 27, 293, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo wd_emlrtBCI = { -1, -1, 27, 295, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo xd_emlrtBCI = { -1, -1, 28, 36, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo yd_emlrtBCI = { -1, -1, 28, 38, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ae_emlrtBCI = { -1, -1, 28, 44, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo be_emlrtBCI = { -1, -1, 28, 46, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ce_emlrtBCI = { -1, -1, 28, 58, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo de_emlrtBCI = { -1, -1, 28, 60, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ee_emlrtBCI = { -1, -1, 28, 66, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo fe_emlrtBCI = { -1, -1, 28, 68, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ge_emlrtBCI = { -1, -1, 28, 80, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo he_emlrtBCI = { -1, -1, 28, 82, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ie_emlrtBCI = { -1, -1, 28, 88, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo je_emlrtBCI = { -1, -1, 28, 90, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ke_emlrtBCI = { -1, -1, 28, 102, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo le_emlrtBCI = { -1, -1, 28, 104, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo me_emlrtBCI = { -1, -1, 28, 110, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ne_emlrtBCI = { -1, -1, 28, 112, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo oe_emlrtBCI = { -1, -1, 28, 129, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo pe_emlrtBCI = { -1, -1, 28, 131, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo qe_emlrtBCI = { -1, -1, 28, 137, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo re_emlrtBCI = { -1, -1, 28, 139, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo se_emlrtBCI = { -1, -1, 28, 151, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo te_emlrtBCI = { -1, -1, 28, 153, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ue_emlrtBCI = { -1, -1, 28, 159, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ve_emlrtBCI = { -1, -1, 28, 161, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo we_emlrtBCI = { -1, -1, 28, 173, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo xe_emlrtBCI = { -1, -1, 28, 175, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ye_emlrtBCI = { -1, -1, 28, 181, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo af_emlrtBCI = { -1, -1, 28, 183, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo bf_emlrtBCI = { -1, -1, 28, 195, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo cf_emlrtBCI = { -1, -1, 28, 197, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo df_emlrtBCI = { -1, -1, 28, 203, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ef_emlrtBCI = { -1, -1, 28, 205, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ff_emlrtBCI = { -1, -1, 28, 219, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo gf_emlrtBCI = { -1, -1, 28, 221, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo hf_emlrtBCI = { -1, -1, 28, 227, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo if_emlrtBCI = { -1, -1, 28, 229, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo jf_emlrtBCI = { -1, -1, 28, 241, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo kf_emlrtBCI = { -1, -1, 28, 243, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo lf_emlrtBCI = { -1, -1, 28, 249, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo mf_emlrtBCI = { -1, -1, 28, 251, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo nf_emlrtBCI = { -1, -1, 28, 263, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo of_emlrtBCI = { -1, -1, 28, 265, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo pf_emlrtBCI = { -1, -1, 28, 271, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo qf_emlrtBCI = { -1, -1, 28, 273, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo rf_emlrtBCI = { -1, -1, 28, 285, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo sf_emlrtBCI = { -1, -1, 28, 287, "SigmaH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo tf_emlrtBCI = { -1, -1, 28, 293, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo uf_emlrtBCI = { -1, -1, 28, 295, "Fg",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo vf_emlrtBCI = { -1, -1, 24, 42, "DUDH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo wf_emlrtBCI = { -1, -1, 24, 69, "DUDH",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtECInfo emlrtECI = { 2, 24, 27, "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m"
};

static emlrtBCInfo xf_emlrtBCI = { -1, -1, 30, 36, "DUDF",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtECInfo b_emlrtECI = { 2, 30, 27, "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m"
};

static emlrtBCInfo yf_emlrtBCI = { -1, -1, 30, 55, "DUDJ",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo ag_emlrtBCI = { -1, -1, 30, 74, "H",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtBCInfo bg_emlrtBCI = { -1, -1, 30, 15, "Piola",
  "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m",
  0 };

static emlrtECInfo c_emlrtECI = { -1, 30, 5, "FirstPiolaKirchhoffStressTensorUC",
  "C:\\SoftwareDevelopment\\OPTIMISATION_CODE\\code\\C code  generator\\FirstPiolaKirchhoffStressTensorUC.m"
};

static emlrtRTEInfo d_emlrtRTEI = { 11, 15, "trace",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\matfun\\trace.m"
};

/* Function Definitions */
void FirstPiolaKirchhoffStressTensorUC(const emlrtStack *sp, real_T Piola_data[],
  int32_T Piola_size[3], real_T ngauss, real_T dim, const real_T F_data[], const
  int32_T F_size[3], const real_T H_data[], const int32_T H_size[3], const
  real_T DUDF_data[], const int32_T DUDF_size[3], const real_T DUDH_data[],
  const int32_T DUDH_size[3], const real_T DUDJ_data[], const int32_T DUDJ_size
  [1])
{
  emxArray_real_T *PiolaH;
  int32_T k;
  real_T t;
  int32_T loop_ub;
  int32_T igauss;
  int32_T b_loop_ub;
  int32_T tmp_size[2];
  int32_T i0;
  real_T tmp_data[9];
  int32_T iv2[2];
  int32_T iv3[2];
  static const int8_T b[4] = { 1, 0, 0, 1 };

  real_T DUDH[9];
  int32_T b_DUDF_size[2];
  int32_T DUDF[2];
  int32_T b_PiolaH[2];
  int32_T c_DUDF_size[2];
  int32_T iv4[2];
  int32_T b_DUDF[2];
  int32_T b_tmp_data[3];
  int32_T c_loop_ub;
  int32_T c_tmp_data[3];
  int32_T iv5[2];
  int32_T d_DUDF_size[2];
  int32_T c_DUDF[2];
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  emxInit_real_T(sp, &PiolaH, 2, &b_emlrtRTEI, true);

  /* -------------------------------------------------------------------------- */
  /* --------------------------------------------------------------------------% */
  /*    This function computes the first Piola-Kirchhoff stress tensor  */
  /*  */
  /* -------------------------------------------------------------------------- */
  /* -------------------------------------------------------------------------- */
  k = PiolaH->size[0] * PiolaH->size[1];
  if (!(dim > 0.0)) {
    emlrtNonNegativeCheckR2012b(dim, (emlrtDCInfo *)&emlrtDCI, sp);
  }

  if (dim != (int32_T)muDoubleScalarFloor(dim)) {
    emlrtIntegerCheckR2012b(dim, (emlrtDCInfo *)&b_emlrtDCI, sp);
  }

  PiolaH->size[0] = (int32_T)dim;
  if (!(dim > 0.0)) {
    emlrtNonNegativeCheckR2012b(dim, (emlrtDCInfo *)&c_emlrtDCI, sp);
  }

  if (dim != (int32_T)muDoubleScalarFloor(dim)) {
    emlrtIntegerCheckR2012b(dim, (emlrtDCInfo *)&d_emlrtDCI, sp);
  }

  PiolaH->size[1] = (int32_T)dim;
  emxEnsureCapacity(sp, (emxArray__common *)PiolaH, k, (int32_T)sizeof(real_T),
                    &emlrtRTEI);
  if (!(dim > 0.0)) {
    emlrtNonNegativeCheckR2012b(dim, (emlrtDCInfo *)&emlrtDCI, sp);
  }

  t = dim;
  if (t != (int32_T)muDoubleScalarFloor(t)) {
    emlrtIntegerCheckR2012b(t, (emlrtDCInfo *)&b_emlrtDCI, sp);
  }

  if (!(dim > 0.0)) {
    emlrtNonNegativeCheckR2012b(dim, (emlrtDCInfo *)&c_emlrtDCI, sp);
  }

  if (t != (int32_T)muDoubleScalarFloor(t)) {
    emlrtIntegerCheckR2012b(t, (emlrtDCInfo *)&d_emlrtDCI, sp);
  }

  loop_ub = (int32_T)t * (int32_T)t;
  for (k = 0; k < loop_ub; k++) {
    PiolaH->data[k] = 0.0;
  }

  emlrtForLoopVectorCheckR2012b(1.0, 1.0, ngauss, mxDOUBLE_CLASS, (int32_T)
    ngauss, (emlrtRTEInfo *)&c_emlrtRTEI, sp);
  igauss = 0;
  while (igauss <= (int32_T)ngauss - 1) {
    /* -----------------------------------------------------------------------     */
    /*  Variables per Gauss pointg */
    /* -----------------------------------------------------------------------     */
    k = igauss + 1;
    if (!((k >= 1) && (k <= DUDH_size[2]))) {
      emlrtDynamicBoundsCheckR2012b(k, 1, DUDH_size[2], (emlrtBCInfo *)&emlrtBCI,
        sp);
    }

    k = igauss + 1;
    if (!((k >= 1) && (k <= F_size[2]))) {
      emlrtDynamicBoundsCheckR2012b(k, 1, F_size[2], (emlrtBCInfo *)&b_emlrtBCI,
        sp);
    }

    /* -----------------------------------------------------------------------     */
    /*  Piola contribution associated with H */
    /* -----------------------------------------------------------------------     */
    switch ((int32_T)dim) {
     case 2:
      loop_ub = DUDH_size[0];
      b_loop_ub = DUDH_size[1];
      if (!((igauss + 1 >= 1) && (igauss + 1 <= DUDH_size[2]))) {
        emlrtDynamicBoundsCheckR2012b(igauss + 1, 1, DUDH_size[2], (emlrtBCInfo *)
          &wf_emlrtBCI, sp);
      }

      tmp_size[0] = DUDH_size[1];
      tmp_size[1] = DUDH_size[0];
      for (k = 0; k < loop_ub; k++) {
        for (i0 = 0; i0 < b_loop_ub; i0++) {
          tmp_data[i0 + b_loop_ub * k] = DUDH_data[(k + DUDH_size[0] * i0) +
            DUDH_size[0] * DUDH_size[1] * igauss];
        }
      }

      for (k = 0; k < 2; k++) {
        iv2[k] = 2;
        iv3[k] = tmp_size[k];
      }

      if ((iv2[0] != iv3[0]) || (iv2[1] != iv3[1])) {
        emlrtSizeEqCheckNDR2012b(&iv2[0], &iv3[0], (emlrtECInfo *)&emlrtECI, sp);
      }

      st.site = &emlrtRSI;
      k = igauss + 1;
      if (!((k >= 1) && (k <= DUDH_size[2]))) {
        emlrtDynamicBoundsCheckR2012b(k, 1, DUDH_size[2], (emlrtBCInfo *)
          &vf_emlrtBCI, &st);
      }

      if (DUDH_size[0] == DUDH_size[1]) {
      } else {
        emlrtErrorWithMessageIdR2012b(&st, &d_emlrtRTEI, "Coder:MATLAB:square",
          0);
      }

      t = 0.0;
      for (k = 0; k < DUDH_size[0]; k++) {
        t += DUDH_data[(k + DUDH_size[0] * k) + DUDH_size[0] * DUDH_size[1] *
          igauss];
      }

      k = PiolaH->size[0] * PiolaH->size[1];
      PiolaH->size[0] = 2;
      PiolaH->size[1] = 2;
      emxEnsureCapacity(sp, (emxArray__common *)PiolaH, k, (int32_T)sizeof
                        (real_T), &emlrtRTEI);
      for (k = 0; k < 4; k++) {
        PiolaH->data[k] = t * (real_T)b[k] - tmp_data[k];
      }
      break;

     case 3:
      if (!(2 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[0], (emlrtBCInfo *)
          &c_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[1], (emlrtBCInfo *)
          &d_emlrtBCI, sp);
      }

      if (!(3 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[0], (emlrtBCInfo *)
          &e_emlrtBCI, sp);
      }

      if (!(3 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[1], (emlrtBCInfo *)
          &f_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[0], (emlrtBCInfo *)
          &g_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[1], (emlrtBCInfo *)
          &h_emlrtBCI, sp);
      }

      if (!(3 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[0], (emlrtBCInfo *)
          &i_emlrtBCI, sp);
      }

      if (!(2 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[1], (emlrtBCInfo *)
          &j_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[0], (emlrtBCInfo *)
          &k_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[1], (emlrtBCInfo *)
          &l_emlrtBCI, sp);
      }

      if (!(2 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[0], (emlrtBCInfo *)
          &m_emlrtBCI, sp);
      }

      if (!(3 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[1], (emlrtBCInfo *)
          &n_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[0], (emlrtBCInfo *)
          &o_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[1], (emlrtBCInfo *)
          &p_emlrtBCI, sp);
      }

      if (!(2 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[0], (emlrtBCInfo *)
          &q_emlrtBCI, sp);
      }

      if (!(2 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[1], (emlrtBCInfo *)
          &r_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[0], (emlrtBCInfo *)
          &s_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[1], (emlrtBCInfo *)
          &t_emlrtBCI, sp);
      }

      if (!(3 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[0], (emlrtBCInfo *)
          &u_emlrtBCI, sp);
      }

      if (!(1 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[1], (emlrtBCInfo *)
          &v_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[0], (emlrtBCInfo *)
          &w_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[1], (emlrtBCInfo *)
          &x_emlrtBCI, sp);
      }

      if (!(3 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[0], (emlrtBCInfo *)
          &y_emlrtBCI, sp);
      }

      if (!(3 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[1], (emlrtBCInfo *)
          &ab_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[0], (emlrtBCInfo *)
          &bb_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[1], (emlrtBCInfo *)
          &cb_emlrtBCI, sp);
      }

      if (!(2 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[0], (emlrtBCInfo *)
          &db_emlrtBCI, sp);
      }

      if (!(1 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[1], (emlrtBCInfo *)
          &eb_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[0], (emlrtBCInfo *)
          &fb_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[1], (emlrtBCInfo *)
          &gb_emlrtBCI, sp);
      }

      if (!(2 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[0], (emlrtBCInfo *)
          &hb_emlrtBCI, sp);
      }

      if (!(3 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[1], (emlrtBCInfo *)
          &ib_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[0], (emlrtBCInfo *)
          &jb_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[1], (emlrtBCInfo *)
          &kb_emlrtBCI, sp);
      }

      if (!(3 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[0], (emlrtBCInfo *)
          &lb_emlrtBCI, sp);
      }

      if (!(2 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[1], (emlrtBCInfo *)
          &mb_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[0], (emlrtBCInfo *)
          &nb_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[1], (emlrtBCInfo *)
          &ob_emlrtBCI, sp);
      }

      if (!(3 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[0], (emlrtBCInfo *)
          &pb_emlrtBCI, sp);
      }

      if (!(1 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[1], (emlrtBCInfo *)
          &qb_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[0], (emlrtBCInfo *)
          &rb_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[1], (emlrtBCInfo *)
          &sb_emlrtBCI, sp);
      }

      if (!(2 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[0], (emlrtBCInfo *)
          &tb_emlrtBCI, sp);
      }

      if (!(2 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[1], (emlrtBCInfo *)
          &ub_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[0], (emlrtBCInfo *)
          &vb_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[1], (emlrtBCInfo *)
          &wb_emlrtBCI, sp);
      }

      if (!(2 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[0], (emlrtBCInfo *)
          &xb_emlrtBCI, sp);
      }

      if (!(1 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[1], (emlrtBCInfo *)
          &yb_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[0], (emlrtBCInfo *)
          &ac_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[1], (emlrtBCInfo *)
          &bc_emlrtBCI, sp);
      }

      if (!(1 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[0], (emlrtBCInfo *)
          &cc_emlrtBCI, sp);
      }

      if (!(3 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[1], (emlrtBCInfo *)
          &dc_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[0], (emlrtBCInfo *)
          &ec_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[1], (emlrtBCInfo *)
          &fc_emlrtBCI, sp);
      }

      if (!(1 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[0], (emlrtBCInfo *)
          &gc_emlrtBCI, sp);
      }

      if (!(2 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[1], (emlrtBCInfo *)
          &hc_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[0], (emlrtBCInfo *)
          &ic_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[1], (emlrtBCInfo *)
          &jc_emlrtBCI, sp);
      }

      if (!(3 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[0], (emlrtBCInfo *)
          &kc_emlrtBCI, sp);
      }

      if (!(3 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[1], (emlrtBCInfo *)
          &lc_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[0], (emlrtBCInfo *)
          &mc_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[1], (emlrtBCInfo *)
          &nc_emlrtBCI, sp);
      }

      if (!(3 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[0], (emlrtBCInfo *)
          &oc_emlrtBCI, sp);
      }

      if (!(2 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[1], (emlrtBCInfo *)
          &pc_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[0], (emlrtBCInfo *)
          &qc_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[1], (emlrtBCInfo *)
          &rc_emlrtBCI, sp);
      }

      if (!(1 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[0], (emlrtBCInfo *)
          &sc_emlrtBCI, sp);
      }

      if (!(1 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[1], (emlrtBCInfo *)
          &tc_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[0], (emlrtBCInfo *)
          &uc_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[1], (emlrtBCInfo *)
          &vc_emlrtBCI, sp);
      }

      if (!(1 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[0], (emlrtBCInfo *)
          &wc_emlrtBCI, sp);
      }

      if (!(3 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[1], (emlrtBCInfo *)
          &xc_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[0], (emlrtBCInfo *)
          &yc_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[1], (emlrtBCInfo *)
          &ad_emlrtBCI, sp);
      }

      if (!(3 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[0], (emlrtBCInfo *)
          &bd_emlrtBCI, sp);
      }

      if (!(1 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[1], (emlrtBCInfo *)
          &cd_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[0], (emlrtBCInfo *)
          &dd_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[1], (emlrtBCInfo *)
          &ed_emlrtBCI, sp);
      }

      if (!(3 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[0], (emlrtBCInfo *)
          &fd_emlrtBCI, sp);
      }

      if (!(3 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[1], (emlrtBCInfo *)
          &gd_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[0], (emlrtBCInfo *)
          &hd_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[1], (emlrtBCInfo *)
          &id_emlrtBCI, sp);
      }

      if (!(1 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[0], (emlrtBCInfo *)
          &jd_emlrtBCI, sp);
      }

      if (!(2 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[1], (emlrtBCInfo *)
          &kd_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[0], (emlrtBCInfo *)
          &ld_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[1], (emlrtBCInfo *)
          &md_emlrtBCI, sp);
      }

      if (!(1 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[0], (emlrtBCInfo *)
          &nd_emlrtBCI, sp);
      }

      if (!(1 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[1], (emlrtBCInfo *)
          &od_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[0], (emlrtBCInfo *)
          &pd_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[1], (emlrtBCInfo *)
          &qd_emlrtBCI, sp);
      }

      if (!(3 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[0], (emlrtBCInfo *)
          &rd_emlrtBCI, sp);
      }

      if (!(2 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[1], (emlrtBCInfo *)
          &sd_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[0], (emlrtBCInfo *)
          &td_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[1], (emlrtBCInfo *)
          &ud_emlrtBCI, sp);
      }

      if (!(3 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[0], (emlrtBCInfo *)
          &vd_emlrtBCI, sp);
      }

      if (!(1 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[1], (emlrtBCInfo *)
          &wd_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[0], (emlrtBCInfo *)
          &xd_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[1], (emlrtBCInfo *)
          &yd_emlrtBCI, sp);
      }

      if (!(2 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[0], (emlrtBCInfo *)
          &ae_emlrtBCI, sp);
      }

      if (!(3 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[1], (emlrtBCInfo *)
          &be_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[0], (emlrtBCInfo *)
          &ce_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[1], (emlrtBCInfo *)
          &de_emlrtBCI, sp);
      }

      if (!(2 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[0], (emlrtBCInfo *)
          &ee_emlrtBCI, sp);
      }

      if (!(2 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[1], (emlrtBCInfo *)
          &fe_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[0], (emlrtBCInfo *)
          &ge_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[1], (emlrtBCInfo *)
          &he_emlrtBCI, sp);
      }

      if (!(1 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[0], (emlrtBCInfo *)
          &ie_emlrtBCI, sp);
      }

      if (!(3 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[1], (emlrtBCInfo *)
          &je_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[0], (emlrtBCInfo *)
          &ke_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[1], (emlrtBCInfo *)
          &le_emlrtBCI, sp);
      }

      if (!(1 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[0], (emlrtBCInfo *)
          &me_emlrtBCI, sp);
      }

      if (!(2 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[1], (emlrtBCInfo *)
          &ne_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[0], (emlrtBCInfo *)
          &oe_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[1], (emlrtBCInfo *)
          &pe_emlrtBCI, sp);
      }

      if (!(2 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[0], (emlrtBCInfo *)
          &qe_emlrtBCI, sp);
      }

      if (!(1 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[1], (emlrtBCInfo *)
          &re_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[0], (emlrtBCInfo *)
          &se_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[1], (emlrtBCInfo *)
          &te_emlrtBCI, sp);
      }

      if (!(2 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[0], (emlrtBCInfo *)
          &ue_emlrtBCI, sp);
      }

      if (!(3 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[1], (emlrtBCInfo *)
          &ve_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[0], (emlrtBCInfo *)
          &we_emlrtBCI, sp);
      }

      if (!(3 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, DUDH_size[1], (emlrtBCInfo *)
          &xe_emlrtBCI, sp);
      }

      if (!(1 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[0], (emlrtBCInfo *)
          &ye_emlrtBCI, sp);
      }

      if (!(1 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[1], (emlrtBCInfo *)
          &af_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[0], (emlrtBCInfo *)
          &bf_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[1], (emlrtBCInfo *)
          &cf_emlrtBCI, sp);
      }

      if (!(1 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[0], (emlrtBCInfo *)
          &df_emlrtBCI, sp);
      }

      if (!(3 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(3, 1, F_size[1], (emlrtBCInfo *)
          &ef_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[0], (emlrtBCInfo *)
          &ff_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[1], (emlrtBCInfo *)
          &gf_emlrtBCI, sp);
      }

      if (!(2 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[0], (emlrtBCInfo *)
          &hf_emlrtBCI, sp);
      }

      if (!(2 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[1], (emlrtBCInfo *)
          &if_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[0], (emlrtBCInfo *)
          &jf_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[1], (emlrtBCInfo *)
          &kf_emlrtBCI, sp);
      }

      if (!(2 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[0], (emlrtBCInfo *)
          &lf_emlrtBCI, sp);
      }

      if (!(1 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[1], (emlrtBCInfo *)
          &mf_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[0], (emlrtBCInfo *)
          &nf_emlrtBCI, sp);
      }

      if (!(1 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, DUDH_size[1], (emlrtBCInfo *)
          &of_emlrtBCI, sp);
      }

      if (!(1 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[0], (emlrtBCInfo *)
          &pf_emlrtBCI, sp);
      }

      if (!(2 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, F_size[1], (emlrtBCInfo *)
          &qf_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[0])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[0], (emlrtBCInfo *)
          &rf_emlrtBCI, sp);
      }

      if (!(2 <= DUDH_size[1])) {
        emlrtDynamicBoundsCheckR2012b(2, 1, DUDH_size[1], (emlrtBCInfo *)
          &sf_emlrtBCI, sp);
      }

      if (!(1 <= F_size[0])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[0], (emlrtBCInfo *)
          &tf_emlrtBCI, sp);
      }

      if (!(1 <= F_size[1])) {
        emlrtDynamicBoundsCheckR2012b(1, 1, F_size[1], (emlrtBCInfo *)
          &uf_emlrtBCI, sp);
      }

      DUDH[0] = ((DUDH_data[(DUDH_size[0] + DUDH_size[0] * DUDH_size[1] * igauss)
                  + 1] * F_data[((F_size[0] << 1) + F_size[0] * F_size[1] *
        igauss) + 2] - DUDH_data[((DUDH_size[0] << 1) + DUDH_size[0] *
        DUDH_size[1] * igauss) + 1] * F_data[(F_size[0] + F_size[0] * F_size[1] *
        igauss) + 2]) - DUDH_data[(DUDH_size[0] + DUDH_size[0] * DUDH_size[1] *
                  igauss) + 2] * F_data[((F_size[0] << 1) + F_size[0] * F_size[1]
                  * igauss) + 1]) + DUDH_data[((DUDH_size[0] << 1) + DUDH_size[0]
        * DUDH_size[1] * igauss) + 2] * F_data[(F_size[0] + F_size[0] * F_size[1]
        * igauss) + 1];
      DUDH[3] = ((DUDH_data[((DUDH_size[0] << 1) + DUDH_size[0] * DUDH_size[1] *
        igauss) + 1] * F_data[2 + F_size[0] * F_size[1] * igauss] - DUDH_data[1
                  + DUDH_size[0] * DUDH_size[1] * igauss] * F_data[((F_size[0] <<
        1) + F_size[0] * F_size[1] * igauss) + 2]) - DUDH_data[((DUDH_size[0] <<
        1) + DUDH_size[0] * DUDH_size[1] * igauss) + 2] * F_data[1 + F_size[0] *
                 F_size[1] * igauss]) + DUDH_data[2 + DUDH_size[0] * DUDH_size[1]
        * igauss] * F_data[((F_size[0] << 1) + F_size[0] * F_size[1] * igauss) +
        1];
      DUDH[6] = ((DUDH_data[1 + DUDH_size[0] * DUDH_size[1] * igauss] * F_data
                  [(F_size[0] + F_size[0] * F_size[1] * igauss) + 2] -
                  DUDH_data[(DUDH_size[0] + DUDH_size[0] * DUDH_size[1] * igauss)
                  + 1] * F_data[2 + F_size[0] * F_size[1] * igauss]) -
                 DUDH_data[2 + DUDH_size[0] * DUDH_size[1] * igauss] * F_data
                 [(F_size[0] + F_size[0] * F_size[1] * igauss) + 1]) +
        DUDH_data[(DUDH_size[0] + DUDH_size[0] * DUDH_size[1] * igauss) + 2] *
        F_data[1 + F_size[0] * F_size[1] * igauss];
      DUDH[1] = ((DUDH_data[(DUDH_size[0] + DUDH_size[0] * DUDH_size[1] * igauss)
                  + 2] * F_data[(F_size[0] << 1) + F_size[0] * F_size[1] *
                  igauss] - DUDH_data[((DUDH_size[0] << 1) + DUDH_size[0] *
        DUDH_size[1] * igauss) + 2] * F_data[F_size[0] + F_size[0] * F_size[1] *
                  igauss]) - DUDH_data[DUDH_size[0] + DUDH_size[0] * DUDH_size[1]
                 * igauss] * F_data[((F_size[0] << 1) + F_size[0] * F_size[1] *
                  igauss) + 2]) + DUDH_data[(DUDH_size[0] << 1) + DUDH_size[0] *
        DUDH_size[1] * igauss] * F_data[(F_size[0] + F_size[0] * F_size[1] *
        igauss) + 2];
      DUDH[4] = ((DUDH_data[((DUDH_size[0] << 1) + DUDH_size[0] * DUDH_size[1] *
        igauss) + 2] * F_data[F_size[0] * F_size[1] * igauss] - DUDH_data[2 +
                  DUDH_size[0] * DUDH_size[1] * igauss] * F_data[(F_size[0] << 1)
                  + F_size[0] * F_size[1] * igauss]) - DUDH_data[(DUDH_size[0] <<
                  1) + DUDH_size[0] * DUDH_size[1] * igauss] * F_data[2 +
                 F_size[0] * F_size[1] * igauss]) + DUDH_data[DUDH_size[0] *
        DUDH_size[1] * igauss] * F_data[((F_size[0] << 1) + F_size[0] * F_size[1]
        * igauss) + 2];
      DUDH[7] = ((DUDH_data[2 + DUDH_size[0] * DUDH_size[1] * igauss] *
                  F_data[F_size[0] + F_size[0] * F_size[1] * igauss] -
                  DUDH_data[(DUDH_size[0] + DUDH_size[0] * DUDH_size[1] * igauss)
                  + 2] * F_data[F_size[0] * F_size[1] * igauss]) -
                 DUDH_data[DUDH_size[0] * DUDH_size[1] * igauss] * F_data
                 [(F_size[0] + F_size[0] * F_size[1] * igauss) + 2]) +
        DUDH_data[DUDH_size[0] + DUDH_size[0] * DUDH_size[1] * igauss] * F_data
        [2 + F_size[0] * F_size[1] * igauss];
      DUDH[2] = ((DUDH_data[DUDH_size[0] + DUDH_size[0] * DUDH_size[1] * igauss]
                  * F_data[((F_size[0] << 1) + F_size[0] * F_size[1] * igauss) +
                  1] - DUDH_data[(DUDH_size[0] << 1) + DUDH_size[0] * DUDH_size
                  [1] * igauss] * F_data[(F_size[0] + F_size[0] * F_size[1] *
        igauss) + 1]) - DUDH_data[(DUDH_size[0] + DUDH_size[0] * DUDH_size[1] *
                  igauss) + 1] * F_data[(F_size[0] << 1) + F_size[0] * F_size[1]
                 * igauss]) + DUDH_data[((DUDH_size[0] << 1) + DUDH_size[0] *
        DUDH_size[1] * igauss) + 1] * F_data[F_size[0] + F_size[0] * F_size[1] *
        igauss];
      DUDH[5] = ((DUDH_data[(DUDH_size[0] << 1) + DUDH_size[0] * DUDH_size[1] *
                  igauss] * F_data[1 + F_size[0] * F_size[1] * igauss] -
                  DUDH_data[DUDH_size[0] * DUDH_size[1] * igauss] * F_data
                  [((F_size[0] << 1) + F_size[0] * F_size[1] * igauss) + 1]) -
                 DUDH_data[((DUDH_size[0] << 1) + DUDH_size[0] * DUDH_size[1] *
                            igauss) + 1] * F_data[F_size[0] * F_size[1] * igauss])
        + DUDH_data[1 + DUDH_size[0] * DUDH_size[1] * igauss] * F_data[(F_size[0]
        << 1) + F_size[0] * F_size[1] * igauss];
      DUDH[8] = ((DUDH_data[DUDH_size[0] * DUDH_size[1] * igauss] * F_data
                  [(F_size[0] + F_size[0] * F_size[1] * igauss) + 1] -
                  DUDH_data[DUDH_size[0] + DUDH_size[0] * DUDH_size[1] * igauss]
                  * F_data[1 + F_size[0] * F_size[1] * igauss]) - DUDH_data[1 +
                 DUDH_size[0] * DUDH_size[1] * igauss] * F_data[F_size[0] +
                 F_size[0] * F_size[1] * igauss]) + DUDH_data[(DUDH_size[0] +
        DUDH_size[0] * DUDH_size[1] * igauss) + 1] * F_data[F_size[0] * F_size[1]
        * igauss];
      k = PiolaH->size[0] * PiolaH->size[1];
      PiolaH->size[0] = 3;
      PiolaH->size[1] = 3;
      emxEnsureCapacity(sp, (emxArray__common *)PiolaH, k, (int32_T)sizeof
                        (real_T), &emlrtRTEI);
      for (k = 0; k < 3; k++) {
        for (i0 = 0; i0 < 3; i0++) {
          PiolaH->data[i0 + PiolaH->size[0] * k] = DUDH[i0 + 3 * k];
        }
      }
      break;
    }

    k = igauss + 1;
    if (!((k >= 1) && (k <= DUDF_size[2]))) {
      emlrtDynamicBoundsCheckR2012b(k, 1, DUDF_size[2], (emlrtBCInfo *)
        &xf_emlrtBCI, sp);
    }

    b_DUDF_size[0] = DUDF_size[0];
    b_DUDF_size[1] = DUDF_size[1];
    for (k = 0; k < 2; k++) {
      DUDF[k] = b_DUDF_size[k];
    }

    for (k = 0; k < 2; k++) {
      b_PiolaH[k] = PiolaH->size[k];
    }

    if ((DUDF[0] != b_PiolaH[0]) || (DUDF[1] != b_PiolaH[1])) {
      emlrtSizeEqCheckNDR2012b(&DUDF[0], &b_PiolaH[0], (emlrtECInfo *)
        &b_emlrtECI, sp);
    }

    k = igauss + 1;
    if (!((k >= 1) && (k <= DUDJ_size[0]))) {
      emlrtDynamicBoundsCheckR2012b(k, 1, DUDJ_size[0], (emlrtBCInfo *)
        &yf_emlrtBCI, sp);
    }

    k = igauss + 1;
    if (!((k >= 1) && (k <= H_size[2]))) {
      emlrtDynamicBoundsCheckR2012b(k, 1, H_size[2], (emlrtBCInfo *)&ag_emlrtBCI,
        sp);
    }

    loop_ub = H_size[0];
    b_loop_ub = H_size[1];
    tmp_size[0] = H_size[0];
    tmp_size[1] = H_size[1];
    for (k = 0; k < b_loop_ub; k++) {
      for (i0 = 0; i0 < loop_ub; i0++) {
        tmp_data[i0 + loop_ub * k] = DUDJ_data[igauss] * H_data[(i0 + H_size[0] *
          k) + H_size[0] * H_size[1] * igauss];
      }
    }

    c_DUDF_size[0] = DUDF_size[0];
    c_DUDF_size[1] = DUDF_size[1];
    for (k = 0; k < 2; k++) {
      b_DUDF[k] = c_DUDF_size[k];
      iv4[k] = tmp_size[k];
    }

    if ((b_DUDF[0] != iv4[0]) || (b_DUDF[1] != iv4[1])) {
      emlrtSizeEqCheckNDR2012b(&b_DUDF[0], &iv4[0], (emlrtECInfo *)&b_emlrtECI,
        sp);
    }

    b_loop_ub = Piola_size[0];
    for (k = 0; k < b_loop_ub; k++) {
      b_tmp_data[k] = k;
    }

    c_loop_ub = Piola_size[1];
    for (k = 0; k < c_loop_ub; k++) {
      c_tmp_data[k] = k;
    }

    k = Piola_size[2];
    i0 = igauss + 1;
    if (!((i0 >= 1) && (i0 <= k))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, k, (emlrtBCInfo *)&bg_emlrtBCI, sp);
    }

    iv5[0] = b_loop_ub;
    iv5[1] = c_loop_ub;
    d_DUDF_size[0] = DUDF_size[0];
    d_DUDF_size[1] = DUDF_size[1];
    for (k = 0; k < 2; k++) {
      c_DUDF[k] = d_DUDF_size[k];
    }

    emlrtSubAssignSizeCheckR2012b(iv5, 2, c_DUDF, 2, (emlrtECInfo *)&c_emlrtECI,
      sp);
    b_loop_ub = DUDF_size[0] - 1;
    c_loop_ub = DUDF_size[1] - 1;
    for (k = 0; k <= c_loop_ub; k++) {
      for (i0 = 0; i0 <= b_loop_ub; i0++) {
        Piola_data[(b_tmp_data[i0] + Piola_size[0] * c_tmp_data[k]) +
          Piola_size[0] * Piola_size[1] * igauss] = (DUDF_data[(i0 + DUDF_size[0]
          * k) + DUDF_size[0] * DUDF_size[1] * igauss] + PiolaH->data[i0 +
          PiolaH->size[0] * k]) + tmp_data[i0 + loop_ub * k];
      }
    }

    igauss++;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_real_T(&PiolaH);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (FirstPiolaKirchhoffStressTensorUC.cpp) */
