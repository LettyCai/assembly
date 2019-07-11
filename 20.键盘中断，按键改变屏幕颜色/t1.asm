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

		
		call save_old_int9

		call cpy_new_int9
	
		call set_new_int9

testA:		mov ax,1000H
		jmp testA

		call set_old_int9

		mov ax,4c00H
		int 21H

;-----------------------------------------------------
set_old_int9:

		mov ax,0	
		mov es,ax

		cli
		push es:[200H]
		pop es:[9*4]
		push es:[202H]
		pop es:[9*4+2]
		sti

		ret



;-------------------------------------------------------
new_int9:	push ax

		in al,60H			;从60H（键盘）端口读取数据
		pushf

;调用中断时CS会变成0，所以中断中要call的代码需要同时复制到内存地址中

	
		call dword ptr cs:[200H]	;cs=0

		cmp al,48H
		jne new_int9_ret
		call change_screen_color


new_int9_ret:	pop ax
		iret



;-------------------------------------------------------
change_screen_color :

		push bx
		push cx
		push es

		mov bx,0B800H
		mov es,bx

		mov bx,1

		mov cx,2000

change_color:	inc byte ptr es:[bx]
		add bx,2
		loop change_color

		pop es
		pop cx
		pop bx

		ret

new_int9_end:	nop




;--------------------------------------------------------

set_new_int9:	mov bx,0
		mov es,bx

		
		cli
		mov word ptr es:[9*4],7E00H	;24H
		mov word ptr es:[9*4+2],0	;26H
		sti


		ret


;--------------------------------------------------------
cpy_new_int9:
		mov bx,cs		;源地址
		mov ds,bx

		mov si,OFFSET new_int9

		mov bx,0		;目的地址
		mov es,bx
		
		mov di,7E00H

		mov cx,OFFSET new_int9_end - OFFSET new_int9

		cld
		rep movsb

		ret


;---------------------------------------------------------

save_old_int9:

		mov bx,0
		mov es,bx

		cli			;屏蔽中断
		push es:[9*4]		;系统int9中断ip   E987H
		pop es:[200H]
		push es:[9*4+2]		;系统int9中断cs	  F000H	
		pop es:[202H]
		sti			;开启中断
		
		ret



code ends

end start


