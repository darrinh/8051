org 0
sjmp Start
  org 30H
  
Start:
  MOV A,#01H       ;set Accumulator A to 0
  MOV B,#90H     ;set Accumulator B to FFh
  MOV P1, #0FFH   ;turn off all LED's (the output is inverted as the LEDs are connected to +5v, not gnd)
SLOOP:
  
  PUSH A          ;save content of accumulator A
  CPL A           ;invert accumulator
  MOV p1,A        ;Write accumulator value to Port 1
  POP A           ;Restore accumulator
  MOV R0,#01H     ;set number of loops for delay (1 loop is 250ms)
  CALL Delay_ms   ;call delay
  RL A           ;increment A
  CJNE A,B,SLOOP  ;Jump to inner loop if A != B
  JMP Start       ;go back to start
  
  

Delay_ms:
  MOV R6,#0F6H

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



