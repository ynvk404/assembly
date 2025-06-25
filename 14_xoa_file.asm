.model small
.stack 100
.data
    tbao db "Nhap ten file: $"  
    max db 250
    len db ? 
    tenfile 250 dup (?)
    thefile dw ?
.code
    main proc
        mov ax, @data
        mov ds, ax   
        
        mov ah, 09h
        lea dx, tbao
        int 21h
    
        mov ah, 0ah
        lea dx, max
        int 21h
        
        xor cx, cx     ;dua 0 ve cuoi chuoi
        mov cl, len
        lea bx, tenfile         ;con tro o dau chuoi
        add bx, cx              ;+cx de con tro ve cuoi chuoi
        mov byte ptr [bx], 0    ;them 0 vao cuoi chuoi  
        
        mov ah, 41h ; xoa tap tin da co
        lea dx, tenfile
        int 21h
        
        mov ah, 4ch ; thoat ve Dos
        int 21h
end 

