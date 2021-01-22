org 0
sjmp Start
  org 30H
 
;digit 0 - C0H  
;digit 1 - F9H
;digit 2 - A4H 
;digit 3 - B0H
;digit 4 - 99H
;digit 5 - 12H
;digit 6 - 82H
;digit 7 - 58h 
;digit 8 - 80H
Start:

  mov p0,#080H
  clr p2.0    ;turns on left most 7 segment display (3)
 ; clr p2.1    ;(2)
  ;clr p2.2    ;(3)
  ;clr p2.3    ;(1)

  clr p0.0
  
  jmp start
  
  

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



