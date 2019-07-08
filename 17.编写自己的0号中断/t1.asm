assume cs:code,ds:data,ss:stack

data segment
 		db	'divide error',0

data ends



stack segment
		db	128 dup (0)
stack ends

code segment


start:		mov ax,stack
		mov ss,ax
		mov sp,128

		call cpy_new_int8			;将中断程序的内容复制到 0:7E00H

		call set_new_int8			;将中断程序的地址写入中断向量表

		mov ax,0
		mov dx,1
		mov bx,1
		div bx				




		mov ax,4c00H
		int 21H
;-----------------------------------------------------------

set_new_int8:	
		mov bx,0
		mov es,bx

		mov word ptr es:[0*4],7E00H		;int0中断的物理地址：ip
		mov word ptr es:[0*4+2],0		;int0中断的物理地址：cs

		ret



;-----------------------------------------------------------
new_int8:	jmp newInt8

string:		db	'divide error',0

newInt8:	mov bx,0B800H
		mov es,bx

		mov bx,0
		mov ds,bx

		mov di,160*10+30*2
		mov si,7E03H

showString:	mov dl,ds:[si]
		cmp dl,0
		je showStringRet
		mov es:[di],dl
		add di,2
		inc si
		jmp showString 

showStringRet:	

		mov ax,4c00H
		int 21H	





new_int8_end:	nop

;-----------------------------------------------------------

cpy_new_int8:							;将new_int8中的代码复制到7E00H位置
		

		mov bx,cs						;程序起始地址段
		mov ds,bx				
		mov si,OFFSET new_int8			;new_int8 偏移地址

		mov bx,0
		mov es,bx
		mov di,7E00H

		mov cx,OFFSET new_int8_end - new_int8	;new_int8代码长度

		cld					
		rep movsb				;按字节复制 mov es:[di],ds:[si]


		ret

		

		
		

code ends

end start


