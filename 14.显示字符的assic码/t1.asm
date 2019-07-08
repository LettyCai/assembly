assume cs:code,ds:data,ss:stack

data segment

		dw	1230,12666,1,8,3,38

data ends

string segment

		db	10 dup ('0'),0
;		db	'00000 00000',0
 
string ends


stack segment
		    db	128 dup (0)
stack ends

code segment


start:		mov ax,stack
            	mov ss,ax
            	mov sp,128

            	call clear_screen			;清屏

		call init_reg				;初始化寄存器

		call show_number			;显示字符的子程序


		

            	mov ax,4c00H
            	int 21H


;-------------------------------------------------------------
show_number:	mov bx,0
		mov si,9			;es:[si]  从最右边一位开始填写

		mov di,160*10 + 30 *2

		mov cx,6			;显示一行

showNumber:	

		call show_word			;按照字符显示


		add di,160
		add bx,2
		loop showNumber

		ret

;-------------------------------------------------------------
show_word:	push ax
		push bx
		push cx
		push dx
		push ds
		push es
		push si 
		push di


		mov ax,ds:[bx]			;被除数的低16位
		mov dx,0				;被除数的高16位

		call short_div			;转换字符

		
		call show_string		;将字符显示在屏幕上

		pop di
		pop si
		pop es
		pop ds
		pop dx
		pop cx
		pop bx
		pop ax



		ret

;----------------------------------------------------------
show_string:	push cx
		push ds
		push es
		push si
		push di


		mov bx,string				
		mov ds,bx			
		
		mov bx,0B800H
		mov es,bx

		mov cx,0
		
showString:	mov cl,ds:[si]			;循环除法运算中，商为0时的偏移地址	
		jcxz showStringRet
		mov es:[di],cl
		add di,2
		inc si
		jmp showString
		

showStringRet:	pop di
		pop si
		pop es
		pop ds
		pop cx


		ret



;------------------------------------------------------------
short_div:	mov cx,10			;除数为10
		div cx
		add dl,30H			;余数+48=acssi码
		mov es:[si],dl			;将编码放在string段中
		mov cx,ax			;将商放在cx中，判断是否结束
		jcxz shortDivRet		;商为0则结束计算

		dec si
		mov dx,0

		jmp short_div




shortDivRet:	ret
		





;-------------------------------------------------------------
clear_screen:	mov bx,0		
            	mov dx,0700H
            	mov cx,2000
		mov ax,0B800H
		mov es,ax


clear_s:	mov es:[bx],dx
                add bx,2
                loop clear_s
                ret


;-------------------------------------------------------------

init_reg:	mov bx,data
                mov ds,bx

                mov bx,string
                mov es,bx
                ret
		
		

code ends

end start