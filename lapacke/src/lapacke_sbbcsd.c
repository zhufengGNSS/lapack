/*****************************************************************************
  Copyright (c) 2011, Intel Corp.
  All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice,
      this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Intel Corporation nor the names of its contributors
      may be used to endorse or promote products derived from this software
      without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
  THE POSSIBILITY OF SUCH DAMAGE.
*****************************************************************************
* Contents: Native high-level C interface to LAPACK function sbbcsd
* Author: Intel Corporation
* Generated November, 2011
*****************************************************************************/

#include "lapacke.h"
#include "lapacke_utils.h"

lapack_int LAPACKE_sbbcsd( int matrix_order, char jobu1, char jobu2,
                           char jobv1t, char jobv2t, char trans, lapack_int m,
                           lapack_int p, lapack_int q, float* theta, float* phi,
                           float* u1, lapack_int ldu1, float* u2,
                           lapack_int ldu2, float* v1t, lapack_int ldv1t,
                           float* v2t, lapack_int ldv2t, float* b11d,
                           float* b11e, float* b12d, float* b12e, float* b21d,
                           float* b21e, float* b22d, float* b22e )
{
    lapack_int info = 0;
    lapack_int lwork = -1;
    float* work = NULL;
    float work_query;
    lapack_int nrows_u1, nrows_u2, nrows_v1t, nrows_v2t;
    if( matrix_order != LAPACK_COL_MAJOR && matrix_order != LAPACK_ROW_MAJOR ) {
        LAPACKE_xerbla( "LAPACKE_sbbcsd", -1 );
        return -1;
    }
#ifndef LAPACK_DISABLE_NAN_CHECK
    /* Optionally check input matrices for NaNs */
    nrows_u1 = ( LAPACKE_lsame( jobu1, 'y' ) ? p : 1);
    nrows_u2 = ( LAPACKE_lsame( jobu2, 'y' ) ? m-p : 1);
    nrows_v1t = ( LAPACKE_lsame( jobv1t, 'y' ) ? q : 1);
    nrows_v2t = ( LAPACKE_lsame( jobv2t, 'y' ) ? m-q : 1);
    if( LAPACKE_s_nancheck( q-1, phi, 1 ) ) {
        return -11;
    }
    if( LAPACKE_s_nancheck( q, theta, 1 ) ) {
        return -10;
    }
    if( LAPACKE_lsame( jobu1, 'y' ) ) {
        if( LAPACKE_sge_nancheck( matrix_order, nrows_u1, p, u1, ldu1 ) ) {
            return -12;
        }
    }
    if( LAPACKE_lsame( jobu2, 'y' ) ) {
        if( LAPACKE_sge_nancheck( matrix_order, nrows_u2, m-p, u2, ldu2 ) ) {
            return -14;
        }
    }
    if( LAPACKE_lsame( jobv1t, 'y' ) ) {
        if( LAPACKE_sge_nancheck( matrix_order, nrows_v1t, q, v1t, ldv1t ) ) {
            return -16;
        }
    }
    if( LAPACKE_lsame( jobv2t, 'y' ) ) {
        if( LAPACKE_sge_nancheck( matrix_order, nrows_v2t, m-q, v2t, ldv2t ) ) {
            return -18;
        }
    }
#endif
    /* Query optimal working array(s) size */
    info = LAPACKE_sbbcsd_work( matrix_order, jobu1, jobu2, jobv1t, jobv2t,
                                trans, m, p, q, theta, phi, u1, ldu1, u2, ldu2,
                                v1t, ldv1t, v2t, ldv2t, b11d, b11e, b12d, b12e,
                                b21d, b21e, b22d, b22e, &work_query, lwork );
    if( info != 0 ) {
        goto exit_level_0;
    }
    lwork = (lapack_int)work_query;
    /* Allocate memory for work arrays */
    work = (float*)LAPACKE_malloc( sizeof(float) * lwork );
    if( work == NULL ) {
        info = LAPACK_WORK_MEMORY_ERROR;
        goto exit_level_0;
    }
    /* Call middle-level interface */
    info = LAPACKE_sbbcsd_work( matrix_order, jobu1, jobu2, jobv1t, jobv2t,
                                trans, m, p, q, theta, phi, u1, ldu1, u2, ldu2,
                                v1t, ldv1t, v2t, ldv2t, b11d, b11e, b12d, b12e,
                                b21d, b21e, b22d, b22e, work, lwork );
    /* Release memory and exit */
    LAPACKE_free( work );
exit_level_0:
    if( info == LAPACK_WORK_MEMORY_ERROR ) {
        LAPACKE_xerbla( "LAPACKE_sbbcsd", info );
    }
    return info;
}
