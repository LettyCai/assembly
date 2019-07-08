assume cs:code,ds:data,ss:stack

data segment
		dd	1000000
data ends


stack segment
		db	128 dup (0)
stack ends

code segment


start:		mov ax,stack
		mov ss,ax
		mov sp,128

		mov ax,data
		mov ds,ax

		mov bx,0

		mov ax,ds:[bx+0]		;��������16λ
		mov dx,ds:[bx+2]		;��������16λ

		mov cx,10			;����

		push ax				
		push dx
		mov bp,sp			;ss:[bp+0] H   ss:[bp+2] L

		call long_div


		mov ax,4c00H
		int 21H

;----------------------------------------------------------------

long_div:	mov ax,dx	; (H/N)
		mov dx,0
		div cx		;�̣�ax=int(H/N)  ���� dx = rem(H/N)*65536
		mov bx,ax	;bx= int(H/N)
	
	
		mov ax,ss:[bp+0]		;L
		div cx		;dx= rem(H/N)*65536    ax =L 

		mov cx,dx	;cx = (rem(H/N)*65536+L)/N
		
		mov dx,bx	;dx = int(H/N)*65536
	

		ret
		

code ends

end start
