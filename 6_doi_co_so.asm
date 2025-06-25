inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
 	int 21h 
endm 
.model small
.stack 100
.data
    tbNhapSo db 13, 10, "Nhap 1 so bat ki: $"
    tbKq1 db 13, 10, "He 16: $"
    tbKq2 db 13, 10, "He 2: $"
    str db 100 dup("$")
    so dw ?
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        inchuoi tbNhapSo
        call dec_in 
        mov so, dx
        
        inchuoi tbKq1
        mov bx, so
        call hex_out
        
        xor bx, bx 
        
        inchuoi tbKq2
        mov bx, so
        call bin_out
         
    dec_in proc 
        xor dx, dx
        mov bx, 10
        xor ax, ax
        
        nhap:
            mov ah, 01h
            int 21h 
            
            cmp al, 0Dh
            je exit
            
            sub al, 30h       ;chuyen ascii sang so
            mov cl, al
            mov ax, dx
            mul bx
            add al, cl
            mov dx, ax          
            
            jmp nhap
        exit:  
            ret
    dec_in endp 
    
    hex_out proc
        mov cx, 4       ;vi can xuat 4 ky tu khi bieu dien 1 so 16 bit he hecxa
        xor dx, dx
        xuat: 
            mov dx, bx
            shr dx, 12 
            
            cmp dx, 09h    ;nhay neu lon hon (Vì neu hon hon 9 ->tuc la tu A-F)
            ja kytu       
            
            add dx, 30h     ;doi thanh ky tu 0-9
            jmp inra 
            
            kytu:
                add dl, 37h   ;doi thanh ky tu A-F
            
            inra:
                mov ah, 02h 
                int 21h
                shl bx, 4  
                loop xuat
        ret
    hex_out endp 
    
    bin_out proc
        mov cx, 16          ;xuat 16bit trong BX ra màn hình
        xuat2:
            mov dx, 0
            shl bx, 1         ;dich trai 1bit, bit cao nhat (MSB) dua vao CF
            rcl dx, 1       ;dua CF vao LSB cua DL  ;rotate with carry left
                            ;;bit trong CF se dua vao bit thap nhat (LSB) cua DL
            add dx, 30h     
            
            mov ah, 02h
            int 21h
            loop xuat2
    bin_out endp 


end

;37h=55(10)
;Trong he 16, A =11
;ma ascii cua A=65
;de chuyen sang: 10+55=65 -> add dl,37h
;dich phai 12 bit de lay 4 bit cao nhat luu vao dx