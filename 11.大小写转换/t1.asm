assume cs:code,ds:data,ss:stack ;αָ��

data segment 
      db 'BaSic'		;����һ���ַ���ת���ɴ�д
      db 'iNForMATion'	;���ڶ����ַ���ת��ΪСд
data ends


stack segment stack
      dw 0,0,0,0
      dw 0,0,0,0
      dw 0,0,0,0
      dw 0,0,0,0
	
stack ends



code segment
  
start:	  mov ax,stack
          mov ss,ax		;����ջ��
          mov sp,128	;����ջ���Ĵ���

          mov ax,data
          mov ds,ax		;�������ݶ�

  
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