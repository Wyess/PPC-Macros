.macro  GOTO	address
lis	r12,\address@h
ori	r12,r12,\address@l
mtctr	r12
bctr
.endm


.macro  CALL	function
lis	r12,\function@h
ori	r12,r12,\function@l
mtctr	r12
bctrl
.endm



/*Absolute branch if equal*/

.macro  abeq	address
lis	r12,\address@h
ori	r12,r12,\address@l
mtctr	r12
beqctr-
.endm



.macro  lwi	reg, value
lis	\reg, \value@h
ori	\reg, \reg, \value@l
.endm


.macro lfsi freg, value
.if	\value == 0
fsubs	\freg,\freg,\freg
.else
bl	0f
.float	\value
0:
mflr	r12
lfs	\freg,0(r12)
.endif
.endm


.macro fsqrt freg1,freg2
frsqrte \freg1,\freg2
fres	\freg1,\freg1
.endm


.macro  stmfd from, to, offset,reg
  stfd   \from,\offset(\reg) 
  .if     \to-\from
  stmfd    "(\from+1)",\to, \offset+8,\reg
  .endif
.endm

.macro  lmfd from, to, offset,reg
  lfd   \from,\offset(\reg) 
  .if     \to-\from
  lmfd    "(\from+1)",\to, \offset+8,\reg
  .endif
.endm


.macro  PATCH	reg1,reg2,address,value
lis	\reg1, \address@ha
lis	\reg2,\value@h
ori	\reg2,\reg2,\value@l
stw	\reg2,\address@l(\reg1)
.endm