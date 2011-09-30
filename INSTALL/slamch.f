C> \brief \b SLAMCH
C>\details
C> \b Purpose:
C>\verbatim
C>
C> SLAMCH determines single precision machine parameters.
C>
C>\endverbatim
C> \author LAPACK is a software package provided by Univ. of Tennessee, Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..
C> \date November 2011
C> \ingroup auxOTHERauxiliary
C>
C> \param[in] CMACH
C> \verbatim
C>          Specifies the value to be returned by SLAMCH:
C>          = 'E' or 'e',   SLAMCH := eps
C>          = 'S' or 's ,   SLAMCH := sfmin
C>          = 'B' or 'b',   SLAMCH := base
C>          = 'P' or 'p',   SLAMCH := eps*base
C>          = 'N' or 'n',   SLAMCH := t
C>          = 'R' or 'r',   SLAMCH := rnd
C>          = 'M' or 'm',   SLAMCH := emin
C>          = 'U' or 'u',   SLAMCH := rmin
C>          = 'L' or 'l',   SLAMCH := emax
C>          = 'O' or 'o',   SLAMCH := rmax
C>          where
C>          eps   = relative machine precision
C>          sfmin = safe minimum, such that 1/sfmin does not overflow
C>          base  = base of the machine
C>          prec  = eps*base
C>          t     = number of (base) digits in the mantissa
C>          rnd   = 1.0 when rounding occurs in addition, 0.0 otherwise
C>          emin  = minimum exponent before (gradual) underflow
C>          rmin  = underflow threshold - base**(emin-1)
C>          emax  = largest exponent before overflow
C>          rmax  = overflow threshold  - (base**emax)*(1-eps)
C> \endverbatim
C>
      REAL             FUNCTION SLAMCH( CMACH )
C
C  -- LAPACK auxiliary routine (version 3.3.0) --
C  -- LAPACK is a software package provided by Univ. of Tennessee,    --
C  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
C     November 2011
C
C     .. Scalar Arguments ..
      CHARACTER          CMACH
C     ..
C
C     .. Scalar Arguments ..
      REAL               A, B
C     ..
C
C =====================================================================
C
C     .. Parameters ..
      REAL               ONE, ZERO
      PARAMETER          ( ONE = 1.0E+0, ZERO = 0.0E+0 )
C     ..
C     .. Local Scalars ..
      REAL               RND, EPS, SFMIN, SMALL, RMACH
C     ..
C     .. External Functions ..
      LOGICAL            LSAME
      EXTERNAL           LSAME
C     ..
C     .. Intrinsic Functions ..
      INTRINSIC          DIGITS, EPSILON, HUGE, MAXEXPONENT,
     $                   MINEXPONENT, RADIX, TINY
C     ..
C     .. Executable Statements ..
C
C
C     Assume rounding, not chopping. Always.
C
      RND = ONE
C
      IF( ONE.EQ.RND ) THEN
         EPS = EPSILON(ZERO) * 0.5
      ELSE
         EPS = EPSILON(ZERO)
      END IF
C
      IF( LSAME( CMACH, 'E' ) ) THEN
         RMACH = EPS
      ELSE IF( LSAME( CMACH, 'S' ) ) THEN
         SFMIN = TINY(ZERO)
         SMALL = ONE / HUGE(ZERO)
         IF( SMALL.GE.SFMIN ) THEN
C
C           Use SMALL plus a bit, to avoid the possibility of rounding
C           causing overflow when computing  1/sfmin.
C
            SFMIN = SMALL*( ONE+EPS )
         END IF
         RMACH = SFMIN
      ELSE IF( LSAME( CMACH, 'B' ) ) THEN
         RMACH = RADIX(ZERO)
      ELSE IF( LSAME( CMACH, 'P' ) ) THEN
         RMACH = EPS * RADIX(ZERO)
      ELSE IF( LSAME( CMACH, 'N' ) ) THEN
         RMACH = DIGITS(ZERO)
      ELSE IF( LSAME( CMACH, 'R' ) ) THEN
         RMACH = RND
      ELSE IF( LSAME( CMACH, 'M' ) ) THEN
         RMACH = MINEXPONENT(ZERO)
      ELSE IF( LSAME( CMACH, 'U' ) ) THEN
         RMACH = tiny(zero)
      ELSE IF( LSAME( CMACH, 'L' ) ) THEN
         RMACH = MAXEXPONENT(ZERO)
      ELSE IF( LSAME( CMACH, 'O' ) ) THEN
         RMACH = HUGE(ZERO)
      ELSE
         RMACH = ZERO
      END IF
C
      SLAMCH = RMACH
      RETURN
C
C     End of SLAMCH
C
      END
C***********************************************************************
C> \brief \b SLAMC3
C>\details
C> \b Purpose:
C>\verbatim
C>
C> SLAMC3  is intended to force  A  and  B  to be stored prior to doing
C> the addition of  A  and  B ,  for use in situations where optimizers
C> might hold one of these in a register.
C>
C>\endverbatim
C> \author LAPACK is a software package provided by Univ. of Tennessee, Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..
C> \date November 2011
C> \ingroup auxOTHERauxiliary
C>
C> \param[in] A
C> \verbatim
C> \endverbatim
C>
C> \param[in] B
C> \verbatim
C>          The values A and B.
C> \endverbatim
C>
C
      REAL             FUNCTION SLAMC3( A, B )
C
C  -- LAPACK auxiliary routine (version 3.3.0) --
C     Univ. of Tennessee, Univ. of California Berkeley and NAG Ltd..
C     November 2010
C
C     .. Scalar Arguments ..
      REAL               A, B
C     ..
C =====================================================================
C
C     .. Executable Statements ..
C
      SLAMC3 = A + B
C
      RETURN
C
C     End of SLAMC3
C
      END
C
C***********************************************************************
