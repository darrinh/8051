org 0

jmp init

NUMBERS:db 0C0h
        db 0F9H
        db 0A4H
        db 0B0H
        db 099H
        db 012H
        db 082H
        db 058H
        db 080H

DIGITS data 20h

INIT: 
 	
	mov DPTR,#numbers
	
	mov DIGITS+00H,#1H
	mov DIGITS+01H,#2H
	mov DIGITS+02H,#3H
	mov DIGITS+03H,#4H
	mov P2,#0ffH ;turn off all segments
	mov P0,#0H
RESET:
	mov B,#3H
	mov R1,#08H
	jmp main
	
main:
       

        mov R0,#DIGITS
        mov A,R0
        add a,b
        dec b
        mov R0,A
        mov A,@R0
        movc A,@A+DPTR
        
        mov P0,A
        mov a,R1
        cpl a
        mov p2,A
        mov p2,#0ffh
        mov a,r1
        rr a
        mov r1,a
        cjne R1,#80h,main
        jmp reset
        


        
        
       
       
        


	
	jmp main

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