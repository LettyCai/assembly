assume cs:code,ds:data,ss:stack ;伪指令

data segment 
      db 'BaSic'		;将第一个字符串转换成大写
      db 'iNForMATion'	;将第二个字符串转换为小写
data ends


stack segment stack
      dw 0,0,0,0
      dw 0,0,0,0
      dw 0,0,0,0
      dw 0,0,0,0
	
stack ends



code segment
  
start:	  mov ax,stack
          mov ss,ax		;设置栈段
          mov sp,128	;设置栈顶寄存器

          mov ax,data
          mov ds,ax		;设置数据段

  
          mov cx,5
          mov bx,0

uperLetter:	mov al,ds:[bx]
          and al,11011111b
          mov ds:[bx],al
          inc bx
          loop uperLetter

          mov cx,11


lowerLetter:	mov al,ds:[bx]
          or al,00100000b
          mov ds:[bx],al
          inc bx
          loop lowerLetter

  mov ax,4C00H		;ax = 4C00H
  int 21H

code ends
end start