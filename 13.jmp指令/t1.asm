assume cs:code

data segment
  db	0
  dw OFFSET start ;ds:[1]

data ends

stack segment
  db	128 dup (0)
stack ends

code segment


start:	mov ax,data
  mov ds,ax
  mov bx,0

  jmp word ptr ds:[bx+1]	;IP = ds:[bx+1] = ds:[1] =OFFSET start = 0

  


  mov ax,4C00H
  int 21H



code ends

end start