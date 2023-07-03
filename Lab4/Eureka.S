.extern delay

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
.endm  ;of popall

.file "Eureka"
.text
.global Eureka
Eureka:
  ldi r20, 0x20
  out 0x04, r20

  call E
  call long_delay
  call U
  call long_delay
  call R
  call long_delay
  call E
  call long_delay
  call K
  call long_delay
  call A
  ret

E:
  call short_flash
  ret

U:
  call short_flash
  call short_delay
  call short_flash
  call short_delay
  call long_flash
  ret

R:
  call short_flash
  call short_delay
  call long_flash
  call short_delay
  call short_flash
  ret

K:
  call long_flash
  call short_delay
  call short_flash
  call short_delay
  call long_flash
  ret

A:
  call short_flash
  call short_delay
  call long_flash
  ret



short_flash:
  ldi r20, 0x20
  out 0x05, r20
  call short_delay
  ldi r20, 0x00
  out 0x05, r20
  ret

long_flash:
  ldi r20, 0x20
  out 0x05, r20
  call long_delay
  ldi r20, 0x00
  out 0x05, r20
  ret

short_delay:
  pushall
    ldi  R22, 0xb0
    ldi  R23, 0x00
    ldi  R24, 0x00
    ldi  R25, 0x00
    call delay
  popall
    ret

long_delay:
  pushall
    ldi  R22, 0x00
    ldi  R23, 0x03
    ldi  R24, 0x00
    ldi  R25, 0x00
    call delay
  popall
    ret
