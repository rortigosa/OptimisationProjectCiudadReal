PROGRAM TestSolver
IMPLICIT NONE

INTEGER (KIND=4)                    ::  start, finish, i, J
INTEGER (KIND=4), PARAMETER         ::  NNZ   =  11 !NUMBER OF NON-ZEROS
INTEGER (KIND=4), PARAMETER         ::  N     =  5  ! SIZE OF THE MATRIX
!----------------------------------------------------------------------------------------------------
!  Declare variables related to the MI24 solver
!----------------------------------------------------------------------------------------------------
INTEGER (KIND=4), PARAMETER           ::  LDW   =  N
INTEGER (KIND=4), PARAMETER           ::  M     =  100 !(MAX ITERATIONS)
INTEGER (KIND=4), PARAMETER           ::  LDH   =  101 !(MAX ITERATIONS+1)
INTEGER (KIND=4)                      ::  IACT, LOCY, LOCZ

INTEGER (KIND=4), DIMENSION(8)        ::  ICNTL
INTEGER (KIND=4), DIMENSION(4)        ::  INFORM
INTEGER (KIND=4), DIMENSION(17)       ::  ISAVE
INTEGER (KIND=4), DIMENSION(14)       ::  ISAVE2

REAL    (KIND=8)                      ::  RESID
REAL    (KIND=8), DIMENSION(4)        ::  CNTL
REAL    (KIND=8), DIMENSION(9)        ::  RSAVE
REAL    (KIND=8), DIMENSION(LDW,M+7)  ::  W
REAL    (KIND=8), DIMENSION(LDW,8)    ::  W2
REAL    (KIND=8), DIMENSION(LDH,M+2)  ::  H

LOGICAL         , DIMENSION(4)        ::  LSAVE

REAL    (KIND=8), DIMENSION(NNZ)        ::  A
REAL    (KIND=8), DIMENSION(N)          ::  F
INTEGER (KIND=4), DIMENSION(NNZ)        ::  JA
INTEGER (KIND=4), DIMENSION(N+1)        ::  IA

A = (/2.0D0,3.0D0,3.0D0,4.0D0,6.0D0,4.0D0,1.0D0,5.0D0,5.0D0,6.0D0,1.0D0/)
F = (/8.0D0,45.0D0,31.0D0,15.0D0,17.0D0/)
JA = (/1,2,1,3,5,2,3,4,3,2,5/)
IA =   (/1,3,6,9,10,12/)


CALL SYSTEM_CLOCK(start)
CALL MI24ID(ICNTL,CNTL,ISAVE,RSAVE,LSAVE)

!ICNTL(1) = 1   !Printing of error messages
!ICNTL(2) = 1   !Printing of warning messages
ICNTL(3) = 0    !Preconditioning
!ICNTL(4) = 3    !L2-norm for convergence
!ICNTL(5) = 3    !Supply initial estimator
ICNTL(6) = 100  !Maximum number of iterations

W(:,1)   = F
IACT     =  0

20 CONTINUE
!PRINT*, "E"
CALL MI24AD(IACT,N,M,W,LDW,LOCY,LOCZ,H,LDH,RESID,ICNTL,CNTL,INFORM,ISAVE,RSAVE,LSAVE)
!PRINT*, RESID
!PRINT*, "hola1"
! IF (IACT<0) THEN
!     WRITE(6,2020) INFO(1)
!     GO TO 60
! ENDIF

IF (IACT==2) THEN

     J  =  1

     DO I=2,N+1
         W(I-1,LOCY)  =  DOT_PRODUCT(A(IA(I-1):IA(I)-1),W(JA(IA(I-1):IA(I)-1),LOCZ))
     ENDDO

     GO TO 20
ENDIF


! IF ( IACT .EQ. 3 ) THEN
!     DO I = 1, N
!     W( I, LOCY ) = W( I, LOCZ ) /20000.0d0
!     ENDDO
!     GO TO 20
! END IF

! IF ( IACT .EQ. 4 ) THEN
!     DO I = 1, N
!     W( I, LOCY ) = W( I, LOCZ ) /20000.0d0
!     ENDDO
!     GO TO 20
! END IF
!60 CONTINUE

!solution  =  W(:,2)

CALL  SYSTEM_CLOCK(finish)
PRINT*, "Solution found in ", 1.0D0*(finish-start)/1000.0D0, " seconds."
PRINT*, ""

PRINT*, W(:,2)

END PROGRAM TestSolver