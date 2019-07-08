assume cs:code,ds:data,ss:stack

data segment
  dw	11,22,33,44,55,66,77,88
  dd	0,0,0,0,0,0,0,0  

data ends

stack segment
  db	128 dup (0)
stack ends

code segment


start:	mov ax,stack
  mov ss,ax
  mov sp,128

  call init_reg

  call mul_start


  mov ax,4C00H
  int 21H

;-------------------------------------------------------------------

mul_start:	mov cx,8
  mov di,0	;����ƫ�Ƶ�ַ
  mov si,0	;���ƫ�Ƶ�ַ

mul_number:	mov ax,ds:[di+0]
  
	
  call get_cube  

  mov data:[8+si+0],ax
  mov data:[8+si+2],dx

  inc di
  add si,2
  
  loop mul_number
   
  ret



;-------------------------------------------------------------------

get_cube:
  mov bx,ax
  mul bx
  mul bx

  ret

;-------------------------------------------------------------------

init_reg:
  mov ax,data
  mov ds,ax
	
  ret

  

code ends

end start