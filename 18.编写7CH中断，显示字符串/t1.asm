assume cs:code,ds:data,ss:stack

data segment
 		db	'conversation',0

data ends



stack segment
		db	128 dup (0)
stack ends

code segment


start:		mov ax,stack
		mov ss,ax
		mov sp,128


		call cpy_new_int0

		call set_new_int0

		call init_reg

		call show_conversation
		

		mov ax,4C00H
		int 21H
;------------------------------------------------
show_conversation:

		mov si,0
		mov di,160*12+40*2

		mov bx,OFFSET showString - OFFSET showStringRet


showString:	mov dl,ds:[si]
		cmp dl,0
		je showStringRet
		mov es:[di],dl
		inc si
		add di,2

		
		int 7CH


			
showStringRet:


		ret



;--------------------------------------------------
init_reg:
		mov bx,data
		mov ds,bx

		mov bx,0B800H
		mov es,bx

		ret


;-----------------------------------------------------
set_new_int0:
		mov bx,0
		mov es,bx

		cli
		mov word ptr es:[7CH*4],7E00H
		mov word ptr es:[7CH*4+2],0
		sti


		ret



;-------------------------------------------------------
new_int0:	push bp			;bp    ip  push cs pushf
		mov bp,sp
		add ss:[bp+2],bx
		pop bp
		iret


new_int0_end:	nop



;---------------------------------------------------------

cpy_new_int0:
		mov bx,cs
		mov ds,bx
		mov si,OFFSET new_int0

		mov bx,0
		mov es,bx
		mov di,7E00H

		mov cx,OFFSET new_int0_end - OFFSET new_int0

		cld
		rep movsb

		ret
	

code ends

end start

