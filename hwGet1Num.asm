.ORIG x3000
MAIN
    JSR GETNUM   ; Call GETNUM for the first digit
    JSR GETNUM   ; Call GETNUM for the second digit
    HALT         ; End program execution

GETNUM
    ; Save R1, R2, and R7
    ST R1, GN_SR1
    ST R2, GN_SR2
    ST R7, GN_SR7
    
START_LOOP  ; Start of loop for invalid input
    GETC              ; Get a character from user
    
    LD R1, NEG_ASCII  ; Load -48 into R1
    ADD R0, R0, R1    ; Convert ASCII to integer (R0 = ASCII - 48)

    BRn START_LOOP    ; If R0 < 0, get another character
    
    ADD R2, R0, #-10  ; Check if R0 >= 10
    BRzp START_LOOP   ; If R0 >= 10, get another character

    ; Restore R1, R2, R7
    LD R1, GN_SR1
    LD R2, GN_SR2
    LD R7, GN_SR7
    RET               ; Return with valid number in R0

; Storage locations for saved registers
GN_SR1 .FILL 0
GN_SR2 .FILL 0
GN_SR7 .FILL 0
NEG_ASCII .FILL #-48  ; Store -48 as a constant
.END
