# MorseCode.S

.macro pushall
push r16
push r17
push r18
push r19
push r20
push r21
push r22
push r23
push r24
push r25
push r26
push r27
push r28
push r29
push r30
push r31
.endm ; of pushall

.macro popall
pop r31
pop r30
pop r29
pop r28
pop r27
pop r26
pop r25
pop r24
pop r23
pop r22
pop r21
pop r20
pop r19
pop r18
pop r17
pop r16
.endm ; of popall

#--------------------------------------------------------------------
    .data

# binary representation of Morse code: 0: dot; 1: dash
morse_table: 
    .byte 0b01, 0b1000, 0b1010, 0b100, 0b0, 0b0010, 0b110, 0b0000, 0b00, 0b0111, 0b101, 0b0100, 0b11, 0b10, 0b111, 0b0110, 0b1101, 0b010, 0b000, 0b1, 0b001, 0b0001, 0b011, 0b1001, 0b1011, 0b1100, 0b01111, 0b00111, 0b00011, 0b00001, 0b00000, 0b10000, 0b11000, 0b11100, 0b11110, 0b11111
# the number of binary digits in each character 
morse_width: 
    .byte 2, 4, 4, 3, 1, 4, 3, 4, 2, 4, 3, 4, 2, 2, 3, 4, 4, 3, 3, 1, 3, 4, 3, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
# the English symbols encoded by the above Morse code 
ascii_table: 
    .byte 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0'
table_length:
    .byte 36

    .comm val, 1
    .comm width, 1
    .comm ascii, 1
    .global val, ascii, width

#---------------------------------------------------------------------

.text
    .global decode_morse

decode_morse:
    pushall
    
    LDI R31, hi8(morse_table) ; initialize high byte of Z  ;val
    LDI R30, lo8(morse_table) ; initialize low byte of Z
    LDI R29, hi8(ascii_table) ; initialize high byte of Y  ;ascii
    LDI R28, lo8(ascii_table) ; initialize low byte of Y
    LDI R27, hi8(morse_width) ; initialize high byte of X  ;width
    LDI R26, lo8(morse_width) ; initialize low byte of X

    # ENTER YOUR CODE BELOW
    LDS R21, val
    LDS R22, width

    LDI R25, 36
    
L1:
    LD R18, X+  ;width
    LD R19, Y+  ;ascii
    LD R20, Z+  ;val

    



#compare val w/r20
    CP R21, R20
    BRNE L1

#compare width w/ r18
    CP R22, R18
    BRNE TST
    RJMP END

#constraint, if none, store val of 0
TST:
    DEC R26
    CP R26, 0
    BRNE L1
    RJMP NUN
    



END:     ;sets ascii to value in r19
    STS ascii, R19

    popall
    RET

NUN:    ;if reached end of array and no match return 0
    LDI R19, 0
    STS ascii, R19
    popall 
    RET
