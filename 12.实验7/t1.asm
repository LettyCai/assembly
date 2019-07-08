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


  mov si,0	;年份、总收入偏移地址
  mov di,0	;table段偏移地址
  mov bp,0	;人数偏移地址

  mov cx,21

  ;存储年份
saveData:	mov ax,ds:[si]
  mov es:[di],ax
  mov ax,ds:[si+2]
  mov es:[di+2],ax

  
  ;存储总收入
  mov ax,ds:[si+4*21]
  mov es:[di+4],ax
  mov ax,ds:[si+4*21+2]
  mov es:[di+4+2],ax
  
  ;存储人数
  mov ax,ds:[bp+4*21+4*21]	;cx=10 si=10*4=40	di=16*10=160
  mov es:[di+8],ax

  ;计算平均收入
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