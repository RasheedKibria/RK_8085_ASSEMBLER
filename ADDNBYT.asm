;FILE NAME C:\ALS\ADDNBYT.ASM
;8085 ALP TO ADD N ONE BYTE NUMBERS. N IS STORED AT LOCATION X.
;FROM X1, THE NUMBERS ARE STORED. RESULT STORED IN LOCATIONS Y AND Y1.
;ALSO DISPLAY THE RESULT IN THE ADDRESS FIELD.
	ORG C100H
X: 	DB 03H, 	ECH
	DB DDH,0EH

	ORG C000H
Y: 	EQU C200H

MVI B, 00H ;Initialise B with 00H.
LXI H, X
MOV C, M ;;Load C with number of bytes to be added
DCR C ;Decrement C. C now indicates the number of additions
;to be performed
INX H
MOV A,M ;;Load A with the first byte

;The instructions from here to JNZ AGAIN performs the following. It adds the
;next byte to A. B will be incremented by 1 if there is Carry. Decrements the
;counter C, and if nonzero repeats the operations.
AGAIN: 	INX H
		ADD M ;;Add to A the next byte
		JNC NOINRB
		INR B ;;B is incremented by 1 if there is Cy
		
NOINRB: DCR C ;Decrement C
		JNZ AGAIN ;If not zero jump to AGAIN
		
;When we come out of the loop, B will have MS byte of sum and A will have LS
;byte of sum
MOV H, B
MOV L, A ;;Load HL with the sum in B and A registers
SHLD Y ;Store the sum in word location Y
RST 5 ;Make sure to terminate with HLT instead of RST 1
