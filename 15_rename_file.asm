inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h
endm
.model small
.stack 100
.data
   old_max db 250
    old_len db ? 
    oldfile 250 dup (?) 
     
    new_max db 250
    new_len db ?   
    newfile 250 dup (?)      
    
    tbao1 db "Nhap ten file cu: $" 
    tbao2 db 10, 13, "Nhap ten file moi: $"
.code
    main proc
        mov ax, @data
        mov ds, ax 
        mov es, ax 
        
        inchuoi tbao1
        mov ah, 0Ah
        lea dx, old_max
        int 21h
               
        xor cx, cx
        mov cl, old_len
        lea bx, oldfile         ;con tro o dau chuoi
        add bx, cx              ;+cx de dua con tro ve cuoi
        mov byte ptr [bx], 0    ;them 0 vao cuoi
        
        inchuoi tbao2
        mov ah, 0Ah
        lea dx, new_max
        int 21h
        
        xor cx, cx
        mov cl, new_len
        lea bx, newfile         ;con tro o dau chuoi
        add bx, cx              ;+cx de dua con tro ve cuoi
        mov byte ptr [bx], 0    ;them 0 vao cuoi
        
        mov ah, 56h             ;doi ten file
        lea dx, oldfile
        lea di, newfile
        int 21h 
        
        mov ah, 4ch
        int 21h
end 

;filehandle -> 1 so nguyen 16bit -> can dinh nghia kieu dw   
;cuoi ten file can co zero -> dung ham 0Ah k nhap duoc zero vao cuoi chuoi
; neu nhap 0 thi la ma ascii cua ki tu 0 (kp zero).
;=> dung giai thuat dua 0 ve cuoi chuoi