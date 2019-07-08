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


start:		mov ax,stack
		mov ss,ax
		mov sp,128

		call init_reg				;初始化寄存器
		call clear_screen			;清屏

                call prepare_data			;格式化数据

	
	
		call show_data				;显示年份数据

		call show_number





		mov ax,4c00H
		int 21H

;-----------------------------------------------------------

show_number:
		mov ax,table
		mov ds,ax

		mov ax,0B800H
		mov es,ax

		mov bx,0				;行号
		mov cx,21

		mov si,24				;显存偏移地址
		mov bp,160*10+30*2			;显存起始地址
		
show_n:
		push cx

		mov ax,ds:[bx+4]			;被除数低16位
		mov dx,0				;被除数高16位

		call short_div

		pop cx

		loop show_n

		ret

;----------------------------------------------------
short_div:	mov cx,10
		div cx
		add dl,30H
		mov es:[bp+si],dl

		mov cx,ax
		jcxz shortDivRet

		sub si,2
		mov dx,0
		
		jmp short_div

shortDivRet:	add bp,160
		mov si,24
		add bx,16
		

		ret

		



;-------------------------------------------------------------
show_data:	
		mov ax,table
		mov ds,ax

		mov ax,0B800H
		mov es,ax


		mov bx,0				;数据起始地址
		mov cx,21

		mov si,0				;数据偏移地址
		mov bp,160*10+30*2			;显存起始地址
		mov di,0				;显存偏移地址

show_row:
		push cx

		mov cx,4


show_char:	mov al,ds:[bx+si]			;获取字符
		mov byte ptr es:[bp+di],al		;将字符显示在单地址
		add si,1				;读取下一个字符
		add di,2				;显示在下一个位置
		loop show_char

		pop cx

		add bp,160				;换行
	
		add bx,16
		mov di,0
		mov si,0					
		
		loop show_row

	
		ret
		
	



;-------------------------------------------------------------
clear_screen:	mov bx,0		
		mov dx,0700H
		mov cx,2000


clear_s:	mov es:[bx],dx
		add bx,2
		loop clear_s
		ret


;-------------------------------------------------------------

init_reg:	mov bx,0B800H
		mov es,bx
	
		mov bx,data
		mov ds,bx
		ret

;----------------------------------------------------------------
prepare_data:
	
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

	ret

		
		

code ends

end start




