.equ DIDR0 , 0x007E
.equ ADMUX , 0x007C
.equ ADCSRA , 0x007A
.equ ADCH , 0x0079
.equ TCNT1H, 0x85
.equ TCNT1L, 0x84
.equ TIFR1, 0x16
.equ TCCR1A, 0x80
.equ TCCR1B, 0x81
.equ OCR1AH, 0x89
.equ OCR1AL, 0x88

.data
.text
  .global initSensor
  .global readSensor
  .global waitOneSecond
  



initSensor:
  ldi r20, 0b00111111
  sts DIDR0, r20

  ldi r20, 0b10000111
  sts ADCSRA, r20
  
  ret


readSensor:  
  ldi r20, 0b01100000
  add r20, r24
  sts ADMUX, r20

  lds r20, ADCSRA
  ldi r19, 0b01000000
  or r20, r19
  sts ADCSRA, r20
  
L1:
  lds r20, ADCSRA
  SBRC r20, 6
  jmp L1

  lds r24, ADCH
  CLR r25

  ret



waitOneSecond:
  ldi r20, 0x3D
  sts OCR1AH, r20
  ldi r20, 0x08
  sts OCR1AL, r20
  ldi r20, 0
  sts TCNT1H, r20
  sts TCNT1L, r20
  sts TCCR1A, r20
  ldi r20, 0x0D
  sts TCCR1B, r20
loop:
  sbis TIFR1, 1
  jmp loop
  ldi r20, 0
  sts TCCR1A, r20
  sts TCCR1B, r20
  ldi r20, 0x02
  out TIFR1, r20

  ret






