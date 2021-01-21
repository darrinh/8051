;The cyclon eye
org 0
sjmp INIT
  org 30H

INIT:
  mov P2,#0H
  
Fstart:
  MOV B,#80H      ;set Accumulator B to 80h
  MOV A,#01H      ;set Accumulator A to 0
  jmp sloop       ;starts in 'forward direction'
  
Bstart:
  MOV A,#80H      ;set Accumulator A to 80h
  MOV B,#01H      ;set Accumulator B to 01h
                  ;reverse direction
  
  MOV P1, #0FFH   ;turn off all LED's (the output is inverted as the LEDs are connected to +5v, not gnd)
         ;direction of led 'eye'

SLOOP:
  PUSH A          ;save content of accumulator A
  CPL A           ;invert accumulator
  MOV p1,A        ;Write accumulator value to Port 1
  POP A           ;Restore accumulator
  MOV R0,#01H     ;set number of loops for delay (1 loop is 250ms)
  CALL Delay_ms   ;call delay
  JNB P2.0,Forward;if bit not set, keep going in same direction
  RR A            ;otherwise reverse direction (rotate accumulator right)
  jmp compare     ;skip to comparision
 FORWARD:
  RL A           ;rotate accumulator left
  
 COMPARE: 
  CJNE A,B,SLOOP  ;Jump to inner loop if A != B
  cpl p2.0        ;invert p2.0 bit
  JNB P2.0,Fstart ;moving forward
  jmp Bstart      ;moving reverse
  
  
  

Delay_ms:
  MOV R6,#5FH

Outer_loop:
  ACALL LOOP
  DJNZ R0, Outer_loop
  RET
  
LOOP: 
  ACALL DELAY
  DJNZ R6,LOOP
  RET

DELAY: 
  MOV TMOD,#00000001B 
  MOV TH0,#0FCH
  MOV TL0,#018H 
  SETB TR0 
  
LOOP_END:
  JNB TF0,LOOP_END 
  CLR TR0 
  CLR TF0 
  RET
  
end




