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
    msg2 db 10, 13, "Noi dung file: $" 
    string dw 251, ?, 250 dup ('$')
.code
    main proc
        mov ax, @data
        mov ds, ax 
    
        inchuoi msg1
        mov ah, 0Ah
        lea dx, max
        int 21h
               
        xor cx, cx         
        mov cl, len        
        lea bx, tenfile    ;luu dia chi bat dau cua chuoi vao bx   
        add bx, cx         ;+ cx -> de dua con tro ve cuoi    
        mov dl, 0 
        mov [bx], dl       ;them 0 ki tu ket thuc chuoi vao cuoi
        
        mov ah, 3dh         ;mo file da co AL=mode (AL=2->read/write)
        lea dx, tenfile    
        mov al,2
        int 21h            ;CX=thuoc tinh cua file  00-> file bth
        mov thefile, ax    ; cat thefile
        
        
        mov ah, 3fh             ;doc noi dung file vao vung nho dem
        mov bx, thefile
        lea dx, string
        mov cx, 250 
        int 21h
        
        mov ah, 3eh         ;dong file
        mov bx, thefile
        int 21h
        
        inchuoi msg2
        mov ah, 09h           ;in noi dung file ra man hinh
        lea dx, string
        int 21h   
        
        mov ah, 4ch
        int 21h

end 

;filehandle -> 1 so nguyen 16bit -> can dinh nghia kieu dw   
;cuoi ten file can co zero -> dung ham 0Ah k nhap duoc zero vao cuoi chuoi
; neu nhap 0 thi la ma ascii cua ki tu 0 (kp zero).
;=> dung giai thuat dua 0 ve cuoi chuoi       
;CX-> thuoc tinh cua file       
;AL -> mode file AL=2 ->read/write
