{\rtf1\ansi\ansicpg1252\cocoartf2638
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 #\
# Global data (gender, age, and fat)\
#\
    .data\
    .comm gender,1\
    .global gender\
    .comm age,1\
    .global age\
    .comm fat,1\
    .global fat\
\
.text\
.global Fatmonitor\
   \
Fatmonitor: \
    lds  r18, gender\
    lds  r19, age        ;read in values\
    lds  r20, fat\
    cpi   r18, 0x0F      ;female is set to 0x0F, if it matches, branch to female\
    breq female\
    cpi  r18, 0x0A\
    breq male            ;male is set to 0x0A, if it matches, branch to male\
    ret                  ;Else -> exit prog\
\
male:    ;male\
    cpi  r19, 20     ;for < 20, exit prog\
    brlo  exit\
    cpi   r19, 60\
    brsh rm3         ;branch to age >= 60\
    cpi   r19, 40\
    brsh rm2         ;branch to age >= 40\
\
    cpi   r20, 25    ;branch where age >= 20\
    brsh  lightup     ;branch to very high light pattern\
    cpi   r20, 20\
    brsh  high        ;branch to high light pattern\
    cpi   r20, 8\
    brsh  norm         ;branch to normal light pattern\
    jmp   low         ;jump to low light pattern\
    \
rm2:                  \
    cpi   r20, 28    ;branch where age >=40   \
    brsh  lightup      \
    cpi   r20, 22\
    brsh  high\
    cpi   r20, 11\
    brsh  norm\
    jmp   low\
rm3:    \
    cpi   r20, 30     ;branch where age >= 60\
    brsh lightup      \
    cpi   r20, 25\
    brsh high\
    cpi   r20, 13\
    brsh  norm\
    jmp  low\
norm:\
    jmp normal\
    \
female: \
    ;female\
    cpi  r19, 20      ;for < 20, exit prog\
    brlo exit\
    cpi   r19, 60\
    brsh rf3          ;branch to age >= 60\
    cpi   r19, 40\
    brsh rf2          ;branch to age >= 40\
    \
    cpi   r20, 39     ;branch where age >= 20\
    brsh lightup      ;branch to very high light pattern\
    cpi   r20, 33\
    brsh high         ;branch to high light pattern\
    cpi   r20, 21\
    brsh normal       ;branch to normal light pattern\
    jmp  low          ;jump to low light pattern\
rf2:                 \
    cpi   r20, 40     ;branch where age >=40   \
    brsh lightup      \
    cpi   r20, 34\
    brsh high\
    cpi   r20, 23\
    brsh normal\
    jmp  low          \
rf3:    \
    cpi   r20, 42     ;branch where age >= 60\
    brsh lightup      ;branch to very high light pattern\
    cpi   r20, 36\
    brsh high         ;branch to high light pattern\
    cp   r20, 24\
    brsh normal       ;branch to normal light pattern\
    jmp  low          ;jump to low light pattern\
    ret\
exit:\
    ret\
\
    \
lightup:\
       ldi  r18, 0b00110001\
       out  0x04, r18   ; 0x04 is I/O address of DDRB\
       out  0x05, r18   ; 0x05 is I/O address of PORTB\
       ret\
high:\
      ldi    r16, 50\
allA: ldi    r18, 0b00100000 ;selects red light and loops through lighting it up and turning off.\
      out    0x04, r18 \
      out    0x05, r18   \
      ldi    r17, 0xff\
dl1A: ldi    r19, 0xff\
dl2A: nop\
      nop\
      nop\
      nop\
      dec    r19\
      brne   dl2A\
      dec    r17\
      brne   dl1A\
      ldi    r18, 0b00000000\
      out    0x04, r18   \
      out    0x05, r18   \
      ldi    r17, 0xff\
dl3A: ldi    r19, 0xff\
dl4A: nop\
      nop\
      nop\
      nop\
      dec    r19\
      brne   dl4A\
      dec    r17\
      brne   dl3A\
      dec    r16\
      brne   allA\
      ret\
normal:\
      ldi    r16, 50\
allB: ldi    r18, 0b00010000 ;selects green light and loops through lighting it up and turning off.\
      out    0x04, r18 \
      out    0x05, r18  \
      ldi    r17, 0xff\
dl1B: ldi    r19, 0xff\
dl2B: nop\
      nop\
      nop\
      nop\
      dec    r19\
      brne   dl2B\
      dec    r17\
      brne   dl1B\
      ldi    r18, 0b00000000\
      out    0x04, r18 \
      out    0x05, r18  \
      ldi    r17, 0xff\
dl3B: ldi    r19, 0xff\
dl4B: nop\
      nop\
      nop\
      nop\
      dec    r19\
      brne   dl4B\
      dec    r17\
      brne   dl3B\
      dec    r16\
      brne   allB\
      ret\
low:\
      ldi    r16, 50\
allC: ldi    r18, 0b00000001  ;selects blue light and loops through lighting it up and turning off.\
      out    0x04, r18  \
      out    0x05, r18  \
      ldi    r17, 0xff\
dl1C: ldi    r19, 0xff\
dl2C: nop\
      nop\
      nop\
      nop\
      dec    r19\
      brne   dl2C\
      dec    r17\
      brne   dl1C\
      ldi    r18, 0b00000000 \
      out    0x04, r18   \
      out    0x05, r18  \
      ldi    r17, 0xff\
dl3C: ldi    r19, 0xff\
dl4C: nop\
      nop\
      nop\
      nop\
      dec    r19\
      brne   dl4C\
      dec    r17\
      brne   dl3C\
      dec    r16\
      brne   allC\
      ret}