assume cs:code,ds:data,ss:stack

data segment
 		db	128 dup (0)
data ends



stack segment
		db	128 dup (0)
stack ends

code segment


start:		mov ax,stack
		mov ss,ax
		mov sp,128


		call cpy_int0

		call set_int0

		
		int 0	


		mov ax,4C00H
		int 21H

;---------------------------------------------------------

set_int0:	mov bx,0
		mov es,bx


		cli
		mov word ptr es:[0*4],7E00H
		mov word ptr es:[0*4+2],0
		sti

		ret


;-----------------------------------------------------------
cpy_int0:
		mov bx,0
		mov es,bx
		mov di,7E00H

		mov bx,cs
		mov ds,bx
		mov si,OFFSET new_int0

		mov cx,OFFSET new_int0_end - OFFSET new_int0

		cld
		rep movsb		;mov es:[di],ds:[si]

		ret





;----------------------------------------------------------
new_int0:	mov si,0

		mov cx,25*80

		mov ax,0B800H
		mov es,ax



show_string:	
	
		mov byte ptr es:[si],'!'
		add si,2
		loop show_string

		ret

		
new_int0_end:	nop
		

code ends

end start

