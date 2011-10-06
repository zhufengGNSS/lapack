*> \brief \b SLA_WWADDW
*
*  =========== DOCUMENTATION ===========
*
* Online html documentation available at 
*            http://www.netlib.org/lapack/explore-html/ 
*
*  Definition
*  ==========
*
*       SUBROUTINE SLA_WWADDW( N, X, Y, W )
* 
*       .. Scalar Arguments ..
*       INTEGER            N
*       ..
*       .. Array Arguments ..
*       REAL               X( * ), Y( * ), W( * )
*       ..
*  
*  Purpose
*  =======
*
*>\details \b Purpose:
*>\verbatim
*> Purpose
*>    =======
*>
*>    SLA_WWADDW adds a vector W into a doubled-single vector (X, Y).
*>
*>    This works for all extant IBM's hex and binary floating point
*>    arithmetics, but not for decimal.
*>
*>\endverbatim
*
*  Arguments
*  =========
*
*> \param[in] N
*> \verbatim
*>          N is INTEGER
*>            The length of vectors X, Y, and W.
*> \endverbatim
*>
*> \param[in,out] X
*> \verbatim
*>          X is REAL array, dimension (N)
*>            The first part of the doubled-single accumulation vector.
*> \endverbatim
*>
*> \param[in,out] Y
*> \verbatim
*>          Y is REAL array, dimension (N)
*>            The second part of the doubled-single accumulation vector.
*> \endverbatim
*>
*> \param[in] W
*> \verbatim
*>          W is REAL array, dimension (N)
*>            The vector to be added.
*> \endverbatim
*>
*
*  Authors
*  =======
*
*> \author Univ. of Tennessee 
*> \author Univ. of California Berkeley 
*> \author Univ. of Colorado Denver 
*> \author NAG Ltd. 
*
*> \date November 2011
*
*> \ingroup realOTHERcomputational
*
*  =====================================================================
      SUBROUTINE SLA_WWADDW( N, X, Y, W )
*
*  -- LAPACK computational routine (version 3.2.2) --
*  -- LAPACK is a software package provided by Univ. of Tennessee,    --
*  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
*     November 2011
*
*     .. Scalar Arguments ..
      INTEGER            N
*     ..
*     .. Array Arguments ..
      REAL               X( * ), Y( * ), W( * )
*     ..
*
*  =====================================================================
*
*     .. Local Scalars ..
      REAL               S
      INTEGER            I
*     ..
*     .. Executable Statements ..
*
      DO 10 I = 1, N
        S = X(I) + W(I)
        S = (S + S) - S
        Y(I) = ((X(I) - S) + W(I)) + Y(I)
        X(I) = S
 10   CONTINUE
      RETURN
      END
