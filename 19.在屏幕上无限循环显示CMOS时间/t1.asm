assume cs:code,ds:data,ss:stack

data segment
		db	128 dup (0)
data ends


stack segment
		db	128 dup (0)
stack ends



code segment


TIME_STYLE	db	'YY/MM/DD HH:MM:SS',0

CMOS_TIME	db	9,8,7,4,2,0



start:		mov ax,stack
		mov ss,ax
		mov sp,128

		call clear_screen


		call show_timestyle

		call show_clock

	

		mov ax,4c00H
		int 21H
;---------------------------------------------------------

show_clock:	mov ax,0B800H
		mov es,ax

		mov ax,cs
		mov ds,ax

		mov si,160*12+30*2	

		mov di,OFFSET CMOS_TIME

		mov cx,6

show_time:	mov al,ds:[di]
		out 70H,al
		in al,71H

		mov ah,al
		shr ah,1
		shr ah,1
		shr ah,1
		shr ah,1

		and al,00001111b
		
		add al,30H
		add ah,30H

		mov es:[si],ah
		mov es:[si+2],al
		add si,6

		add di,1

		


		loop show_time

		ret


;-----------------------------------------------------------
show_timestyle:
		mov ax,0B800H
		mov es,ax			;ÏÔ´æ¶ÎµØÖ·


		mov ax,cs			;´úÂë¶ÎµØÖ·
		mov ds,ax


		mov si,160*12+30*2		;ÏÔ´æÆ«ÒÆµØÖ·   es
		mov di,OFFSET TIME_STYLE	;×Ö·û´®Æ«ÒÆµØÖ·	ds



showString:	mov bl,ds:[di]
		cmp bl,0
		je show_timestyle_ret
		mov es:[si],bl
		add si,2
		inc di
		jmp showString


show_timestyle_ret:

		ret

		
;----------------------------------------------------------
clear_screen:	mov ax,0B800H
		mov es,ax

		mov si,0

		mov dx,0700H

		mov cx,2000
		
clear_s:	mov es:[si],dx
		add si,2
		loop clear_s
	
		ret

code ends

end start


