assume cs:code,ds:data,ss:stack

data segment
              		db	'welcome to masm!'
             		db	00000010b	;绿色
              		db	00100100b	;绿底红色
              		db	01110001b	;白底蓝色
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

              		mov ax,0B800H			;显存段地址
              		mov es,ax


              		mov si,0				;字符偏移地址
              		mov di,160*10 + 30*2	;显存偏移地址
					mov bp,0				;颜色偏移地

              		mov cx,3

setColor:           mov ah,ds:[16+bp]		;ax高16位地址存放颜色

                    push cx
                    push si
                    push di
                    push bp


                    mov cx,16



setGreen:	  		mov al,ds:[si]			;ax低16位地址存放字符
              		mov es:[di],ax			;写入显存
              		

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
