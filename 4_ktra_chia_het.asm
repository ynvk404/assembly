.model small
.stack 100
.data
    tbNhapChuoiSo db 13, 10, "Nhap chuoi so(vd: '12,23,44'): $"    
    tbKqTong db 13, 10, "So luong so chia het cho 5: $"
    str db 100 dup("$")
    dem dw ?
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        lea dx, tbNhapChuoiSo  
        mov ah, 09h
        int 21h
         
        lea dx, str
        mov ah, 0Ah
        int 21h
        
        lea dx, tbKqTong
        mov ah, 09h
        int 21h
        
    lea si, [str + 2]
    mov bx, 10
    xor ax, ax 
    
    xu_ly:
        mov dx, [si]
        cmp dl, '$'
        je print 
        cmp dl, 0Dh
        je ktra_chia_het 
        cmp dl, ','
        je ktra_chia_het
        mul bx
        mov dx, [si] 
        mov dh, 0
        sub dx, 30h  
        add ax, dx 
        inc si
        jmp xu_ly  
        
    ktra_chia_het:
        
        xor dx, dx
        mov bx, 5       
        div bx
        cmp dx, 0       
        je tang_dem
        
        next:
            inc si
            mov ax, 0
            jmp xu_ly
        
        tang_dem:
            inc dem
            jmp next
            
    print:   
        xor cx, cx 
        mov ax, dem
        mov bx, 10
        pushdx: 
            mov dx, 0
            div bx
            add dx, 30h
            push dx
            inc cx
            cmp ax, 0
            jne pushdx
        popdx:
            pop dx
            mov ah, 02h
            int 21h
            loop popdx 
main endp
end
