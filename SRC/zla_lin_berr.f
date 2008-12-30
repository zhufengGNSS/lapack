      SUBROUTINE ZLA_LIN_BERR ( N, NZ, NRHS, RES, AYB, BERR )
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
      INTEGER            N, NZ, NRHS
*     ..
*     .. Array Arguments ..
      DOUBLE PRECISION   AYB( N, NRHS ), BERR( NRHS )
      COMPLEX*16         RES( N, NRHS )
*     ..
*
*  Purpose
*  =======
*
*     ZLA_LIN_BERR computes componentwise relative backward error from
*     the formula
*         max(i) ( abs(R(i)) / ( abs(op(A_s))*abs(Y) + abs(B_s) )(i) )
*     where abs(Z) is the componentwise absolute value of the matrix
*     or vector Z.
*
*  =====================================================================
*
*     .. Local Scalars ..
      DOUBLE PRECISION   TMP
      INTEGER            I, J
      COMPLEX*16         CDUM
*     ..
*     .. Intrinsic Functions ..
      INTRINSIC          ABS, REAL, DIMAG, MAX
*     ..
*     .. External Functions ..
      EXTERNAL           DLAMCH
      DOUBLE PRECISION   DLAMCH
      DOUBLE PRECISION   SAFE1
*     ..
*     .. Statement Functions ..
      COMPLEX*16         CABS1
*     ..
*     .. Statement Function Definitions ..
      CABS1( CDUM ) = ABS( DBLE( CDUM ) ) + ABS( DIMAG( CDUM ) )
*     ..
*     .. Executable Statements ..
*
*     Adding SAFE1 to the numerator guards against spuriously zero
*     residuals.  A similar safeguard is in the CLA_yyAMV routine used
*     to compute AYB.
*
      SAFE1 = DLAMCH( 'Safe minimum' )
      SAFE1 = (NZ+1)*SAFE1

      DO J = 1, NRHS
         BERR(J) = 0.0D+0
         DO I = 1, N
            IF (AYB(I,J) .NE. 0.0D+0) THEN
               TMP = (SAFE1 + CABS1(RES(I,J)))/AYB(I,J)
               BERR(J) = MAX( BERR(J), TMP )
            END IF
*
*     If AYB is exactly 0.0 (and if computed by CLA_yyAMV), then we know
*     the true residual also must be exactly 0.0.
*
         END DO
      END DO
      END SUBROUTINE
