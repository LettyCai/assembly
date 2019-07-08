assume cs:code,ds:data,ss:stack


data segment
    db	7 dup ('1975','1976','1977') 
  
  dd	7 dup (16,22,282)

  dw	7 dup (3,7,9)

data ends


table segment

  db	21 dup ('year summ ne ?? ')
  
table ends

stack segment
    db	128 dup (0)
stack ends

code segment


start:	mov ax,stack
  mov ss,ax
  mov sp,128

  mov ax,data
  mov ds,ax

  mov ax,table
  mov es,ax


  mov si,0	;��ݡ�������ƫ�Ƶ�ַ
  mov di,0	;table��ƫ�Ƶ�ַ
  mov bp,0	;����ƫ�Ƶ�ַ

  mov cx,21

  ;�洢���
saveData:	mov ax,ds:[si]
  mov es:[di],ax
  mov ax,ds:[si+2]
  mov es:[di+2],ax

  
  ;�洢������
  mov ax,ds:[si+4*21]
  mov es:[di+4],ax
  mov ax,ds:[si+4*21+2]
  mov es:[di+4+2],ax
  
  ;�洢����
  mov ax,ds:[bp+4*21+4*21]	;cx=10 si=10*4=40	di=16*10=160
  mov es:[di+8],ax

  ;����ƽ������
  mov ax,es:[di+4]
  mov dx,es:[di+6]
  div word ptr es:[di+8]

  
  mov es:[di+10],ax

  add si,4
  add di,16
  add bp,2

  loop saveData


  mov ax,4C00H
  int 21H

code ends


end start