assume cs:code,ds:data,ss:stack

data segment
              		db	'welcome to masm!'
             		db	00000010b	;��ɫ
              		db	00100100b	;�̵׺�ɫ
              		db	01110001b	;�׵���ɫ
data ends

stack segment
  					db	128 dup (0)
stack ends

code segment


start:		  		mov ax,stack
              		mov ss,ax
              		mov sp,128

             		mov ax,data
              		mov ds,ax

              		mov ax,0B800H			;�Դ�ε�ַ
              		mov es,ax


              		mov si,0				;�ַ�ƫ�Ƶ�ַ
              		mov di,160*10 + 30*2	;�Դ�ƫ�Ƶ�ַ
					mov bp,0				;��ɫƫ�Ƶ�

              		mov cx,3

setColor:           mov ah,ds:[16+bp]		;ax��16λ��ַ�����ɫ

                    push cx
                    push si
                    push di
                    push bp


                    mov cx,16



setGreen:	  		mov al,ds:[si]			;ax��16λ��ַ����ַ�
              		mov es:[di],ax			;д���Դ�
              		

              		inc si
              		add di,2
              		loop setGreen

                    pop bp
                    pop di
                    pop si
                    pop cx


                    add bp,1
                    add di,160
                    loop setColor

	



              		mov ax,4C00H
              		int 21H


code ends

end start
