org 0

jmp init

;table container digit patterns
NUMBER_TABLE:db 0C0h
             db 0F9H
             db 0A4H
             db 0B0H
             db 099H
             db 012H
             db 082H
             db 058H
             db 080H
;the decimal digits, 4 places, 0-9
DIGIT_CTR data 20h
;point to each digit in DIGIT_CTR
DIGIT_PTR data 24h



INIT: 
 	mov DIGIT_PTR,#0h
	mov DPTR,#NUMBER_TABLE
	;set all digits to zero
	mov DIGIT_CTR+00H,#0H
	mov DIGIT_CTR+01H,#0H
	mov DIGIT_CTR+02H,#0H
	mov DIGIT_CTR+03H,#0H
	mov P2,#0ffH ;turn off all segments
	mov P0,#0H
RESET:
	mov B,#3H
	mov R1,#08H
	jmp main
	
	
main:
        mov R0,#DIGIT_CTR
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
        call counter_increment
        cjne R1,#80h,main
        jmp reset
        

counter_increment:
        mov R0,#DIGIT_PTR
        mov A,@R0
        mov R0,#DIGIT_CTR
        add A,R0
        
        
        
        
        ret
        
        
        




        inc a
        mov @r0,a
        
        
         
         


              
        
       
       
        


	


	end 