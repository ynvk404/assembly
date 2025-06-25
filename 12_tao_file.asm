inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h
    
    mov ah, 02h 
    mov dl, 0Ah
    int 21h 
    
    mov ah, 02h
    mov dl, 0Dh
    int 21h
endm
.model small
.stack 100
.data
    max db 250
    len db ? 
    tenfile 250 dup (?)
    thefile dw ?
    msg1 db "Nhap ten file: $"   
    msg2 db 10, 13, "Nhap noi dung file: $" 
    string dw 251, ?, 250 dup ('$')
.code
    main proc
        mov ax, @data
        mov ds, ax 
    
        inchuoi msg1
        mov ah, 0Ah
        lea dx, max
        int 21h
               
        xor cx, cx         ;dua zero ve cuoi chuoi
        mov cl, len        ;khai bao bien de dung ham 0ah cua int 21h dang?
        lea bx, tenfile    ;luu dia chi bat dau cua chuoi vao bx   
        add bx, cx         ;+ cx -> de dua con tro ve cuoi    
        mov dl, 0 
        mov [bx], dl   ;them 0 ki tu ket thuc chuoi vao cuoi
        
        mov ah, 3ch        ;tao file moi voi AX=thefile, CX thuoc tinh file 
        lea dx, tenfile    
        mov cx, 0
        int 21h            ;CX=thuoc tinh cua file  00-> file bth
        mov thefile, ax    ;l cat file
        
        inchuoi msg2
        mov ah, 0Ah
        lea dx, string
        int 21h   
        
        lea si, string + 1        ;lay do dai cua chuoi
        mov al, [si]
        mov len, al
        
        mov ah, 40h              ;ghi vao file
        mov bx, thefile
        mov cl, len
        lea dx, string + 2
        int 21h
        
        mov bx, thefile
        mov ah, 3eh              ;dong file
        int 21h
        
        mov ah, 4ch
        int 21h

end 

;filehandle -> 1 so nguyen 16bit -> can dinh nghia kieu dw   
;cuoi ten file can co zero -> dung ham 0Ah k nhap duoc zero vao cuoi chuoi
; neu nhap 0 thi la ma ascii cua ki tu 0 (kp zero).
;=> dung giai thuat dua 0 ve cuoi chuoi