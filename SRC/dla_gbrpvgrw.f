      DOUBLE PRECISION FUNCTION DLA_GBRPVGRW( N, KL, KU, NCOLS, AB, 
     $                            LDAB, AFB, LDAFB )
*
*     -- LAPACK routine (version 3.2)                                 --
*     -- Contributed by James Demmel, Deaglan Halligan, Yozo Hida and --
*     -- Jason Riedy of Univ. of California Berkeley.                 --
*     -- November 2008                                                --
*
*     -- LAPACK is a software package provided by Univ. of Tennessee, --
*     -- Univ. of California Berkeley and NAG Ltd.                    --
*
      IMPLICIT NONE
*     ..
*     .. Scalar Arguments ..
      INTEGER            N, KL, KU, NCOLS, LDAB, LDAFB
*     ..
*     .. Array Arguments ..
      DOUBLE PRECISION   AB( LDAB, * ), AFB( LDAFB, * )
*     ..
*
*  =====================================================================
*
*     .. Local Scalars ..
      INTEGER            I, J, KD
      DOUBLE PRECISION   AMAX, UMAX, RPVGRW
*     ..
*     .. Intrinsic Functions ..
      INTRINSIC          ABS, MAX, MIN
*     ..
*     .. Executable Statements ..
*
      RPVGRW = 1.0D+0
*
      KD = KU + 1
      DO J = 1, NCOLS
         AMAX = 0.0D+0
         UMAX = 0.0D+0
         DO I = MAX( J-KU, 1 ), MIN( J+KL, N )
            AMAX = MAX( ABS( AB( KD+I-J, J)), AMAX )
         END DO
         DO I = MAX( J-KU, 1 ), J
            UMAX = MAX( ABS( AFB( KD+I-J, J ) ), UMAX )
         END DO
         IF ( UMAX /= 0.0D+0 ) THEN
            RPVGRW = MIN( AMAX / UMAX, RPVGRW )
         END IF
      END DO
      DLA_GBRPVGRW = RPVGRW
      END FUNCTION
