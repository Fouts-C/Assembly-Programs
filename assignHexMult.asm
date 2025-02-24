.ORIG x3000
MAIN
    JSR GETH4
    JSR GETH4
    HALT         ; End program execution

GETHD
    ; Save R1,2,3,4,7
    ST R1, GN_SR1
    ST R2, GN_SR2
    ST R3, GN_SR3
    ST R4, GN_SR4
    ST R7, GN_SR7
    
START_LOOP  ; Start of loop for invalid input
    GETC              ; Get a character from user
    
    LD R1, NEG_ASCII  ; Load -48 into R1
    ADD R2, R0, R1    ; Convert ASCII to integer (R0 = ASCII - 48)

    BRn START_LOOP    ; If R0 < 0, get another character
    
    ADD R2, R2, #-10 ; Check if R0 >= 10
    BRzp OTHER_CHECK  ; If R0 >= 10, get another character

    OUT
    ADD R0, R0, R1
    BR FINISH

;This group will check if character is a-f
OTHER_CHECK
    AND R2, R2, #0 ;clear R2
    LD R3, NEG_ASCII2
    ADD R2, R0, R3
    BRn CHECK_CAP ;not valid yet, check capital

    ADD R2, R2, #-6
    BRn FINISH_OTHER ;Valid char
    
CHECK_CAP   
    AND R2, R2, #0
    LD R4, NEG_ASCII4
    ADD R2, R0, R4   
    BRn START_LOOP  

    ADD R2, R2, #-6    
    BRzp START_LOOP
    BRn FINISH_CAP

FINISH_OTHER
    OUT
    ADD R0, R0, R3
    ADD R0, R0, #10
    BR FINISH

FINISH_CAP
    OUT
    ADD R0, R0, R4
    ADD R0, R0, #10


FINISH

    ; Restore R1,2,3,4,7
    LD R1, GN_SR1
    LD R2, GN_SR2
    LD R3, GN_SR3
    LD R4, GN_SR4
    LD R7, GN_SR7

    RET               ; Return with valid number in R0

MULT
    ; Save R1,2,3,4,7
    ST R1, GM_SR1
    ST R2, GM_SR2
    ST R3, GM_SR3
    ST R4, GM_SR4
    ST R7, GM_SR7

    ; Check if R1 or R2 is zero
    ADD R0, R1, #0     ; Check if R1 is zero
    BRz ZERO_RESULT
    AND R0, R0, #0
    ADD R0, R2, #0     ; Check if R2 is zero
    BRz ZERO_RESULT
    AND R0, R0, #0

START_MULT
    NOT R3, R2         ; Make R3 negative (R3 = -R2)
    ADD R3, R3, #1     ; Two’s complement
    ADD R4, R1, R3     ; Check R1 - R3
    BRn OPP_MULT       ; If R1 < -R2, use alternative method

    ; Standard multiplication
    AND R0, R0, #0     ; Clear result register
TOP1
    ADD R0, R0, R1     ; R0 += R1
    ADD R2, R2, #-1    ; Decrement R2
    BRp TOP1           ; Loop if R2 > 0
    BR FINISH_MULT

OPP_MULT
    AND R0, R0, #0     ; Clear result register
TOP2
    ADD R0, R0, R2     ; R0 += R2
    ADD R1, R1, #-1    ; Decrement R1
    BRp TOP2           ; Loop if R1 > 0
    BR FINISH_MULT

ZERO_RESULT
    AND R0, R0, #0     ; Ensure result is zero
    BR FINISH_MULT     ; Skip multiplication

FINISH_MULT
    ; Restore R1,2,3,4,7
    LD R1, GM_SR1
    LD R2, GM_SR2
    LD R3, GM_SR3
    LD R4, GM_SR4
    LD R7, GM_SR7

    RET               ; Return with valid result in R0

GETH4
    ; Save R1,2,3,4,7
    ST R1, GH_SR1
    ST R2, GH_SR2
    ST R3, GH_SR3
    ST R4, GH_SR4
    ST R7, GH_SR7

START_GH4
    JSR GETHD
    ADD R1, R0, #0
    LD R2, COL4
    JSR MULT
    AND R3, R3, #0
    ADD R3, R0, R3
    
    JSR GETHD
    ADD R1, R0, #0
    LD R2, COL3
    JSR MULT
    ADD R3, R0, R3

    JSR GETHD
    ADD R1, R0, #0
    LD R2, COL2
    JSR MULT
    ADD R3, R0, R3

    JSR GETHD
    ADD R1, R0, #0
    LD R2, COL1
    JSR MULT
    ADD R3, R0, R3
    
    LD R0, NEWLINE  ; Load newline character
    OUT             ; Print it

    AND R0, R0, #0
    ADD R0, R0, R3


FINISH_GETH4

    ; Restore R1,2,3,4,7
    LD R1, GH_SR1
    LD R2, GH_SR2
    LD R3, GH_SR3
    LD R4, GH_SR4
    LD R7, GH_SR7

    RET               ; Return with valid number in R0

; Storage locations for saved registers
GN_SR1 .FILL 0
GN_SR2 .FILL 0
GN_SR3 .FILL 0
GN_SR4 .FILL 0
GN_SR7 .FILL 0
GM_SR1 .FILL 0
GM_SR2 .FILL 0
GM_SR3 .FILL 0
GM_SR4 .FILL 0
GM_SR7 .FILL 0
GH_SR1 .FILL 0
GH_SR2 .FILL 0
GH_SR3 .FILL 0
GH_SR4 .FILL 0
GH_SR7 .FILL 0
NEG_ASCII .FILL #-48  ; Store -48 as a constant
NEG_ASCII2 .FILL #-97
NEG_ASCII4 .FILL #-65
COL1 .FILL #1
COL2 .FILL #16
COL3 .FILL #256
COL4 .FILL #4096
NEWLINE .FILL x0A
.END
