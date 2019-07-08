assume cs:code,ds:data,ss:stack

data segment
  db	128 dup (0)
data ends

stack segment
    db	128 dup (0)
stack ends

code segment

start:	mov ax,stack
   mov ss,ax
    mov sp,128


  mov ax,2000H
  mov ds,ax
  mov bx,0

s:	mov ch,0
  mov cl,ds:[bx]
  jcxz ok
  inc bx
  jmp s

ok:	mov dx,bx

  mov ax,4C00H
  int 21H

code ends
end start