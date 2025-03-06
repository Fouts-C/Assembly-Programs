        .ORIG x3000  ; Set starting address

MAIN    GETC        ; Get a character from the keyboard
        OUT         ; Echo the character
        LD  R1, H_CHAR  ; Load ASCII value of 'H'
        NOT R1, R1  ; Take bitwise NOT of 'H'
        ADD R1, R1, #1  ; Two's complement to negate
        ADD R2, R0, R1  ; Compare input with 'H'
        BRnp DONE   ; If not 'H', branch to DONE

        LEA R0, HELLO  ; Load address of "hello" string
        PUTS        ; Print the string

DONE    HALT        ; Stop execution

H_CHAR  .FILL x48  ; ASCII 'H'
HELLO   .STRINGZ "hello"

        .END