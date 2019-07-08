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

            	call clear_screen			;����

		call init_reg				;��ʼ���Ĵ���

		call show_number			;��ʾ�ַ����ӳ���


		

            	mov ax,4c00H
            	int 21H


;-------------------------------------------------------------
show_number:	mov bx,0
		mov si,9			;es:[si]  �����ұ�һλ��ʼ��д

		mov di,160*10 + 30 *2

		mov cx,6			;��ʾһ��

showNumber:	

		call show_word			;�����ַ���ʾ


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


		mov ax,ds:[bx]			;�������ĵ�16λ
		mov dx,0				;�������ĸ�16λ

		call short_div			;ת���ַ�

		
		call show_string		;���ַ���ʾ����Ļ��

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
		
showString:	mov cl,ds:[si]			;ѭ�����������У���Ϊ0ʱ��ƫ�Ƶ�ַ	
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
short_div:	mov cx,10			;����Ϊ10
		div cx
		add dl,30H			;����+48=acssi��
		mov es:[si],dl			;���������string����
		mov cx,ax			;���̷���cx�У��ж��Ƿ����
		jcxz shortDivRet		;��Ϊ0���������

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