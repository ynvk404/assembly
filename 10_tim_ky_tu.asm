.model small
.stack 100
.data

    tbao1 db 13, 10, "Nhap 1 chuoi bat ki: $"
    tbao2 db 13, 10, "Nhap 1 ki tu muon tim: $"
    tbao3 db 13, 10, "Ket qua: $"
    tbao4 db "Ki tu tim thay o vi tri $"
    tbao5 db "Khong tim thay ki tu $"
   
    str db 100 dup("$")
 
.code
    main proc
        mov ax, @data
        mov ds, ax
       
        mov ah, 09h
        lea dx, tbao1
        int 21h
        
        mov ah, 0Ah
        lea dx, str
        int 21h
               
        mov ah, 09h
        lea dx, tbao2
        int 21h
        mov ah, 01h
        int 21h 
        
        mov bx, 0
        mov bl, al
        mov ah, 9
        lea dx, tbao3
        int 21h
        
        mov al, bl
        mov cx, 0
        mov cl, [str + 1]
        lea si, [str + 2]
        mov bx, 1
        loop1:
        mov dx, [si]
        cmp al, dl
        je tbao4
        inc si
        inc bx
        loop loop1
        jmp tbao5
        
        tbTimThay:
            mov ah, 9
            lea dx, tbao4
            int 21h
            mov ax, bx
            call chuyenSoThanhChu
            jmp exit
        
        tbKhongTimThay:
            mov ah, 9
            lea dx, tbao5
            int 21h
        
        exit: 
            mov ah, 4ch
            int 21h
    main endp
    
    chuyenSoThanhChu proc
        mov bx, 10
        mov cx, 0
        chia10:
        mov dx, 0
            div bx
            push dx
            inc cl
            cmp ax, 0
            je hienthi
            jmp chia10
        hienthi:
            pop dx
            add dl, 48
            mov ah, 2
            int 21h
        loop hienthi
        ret
    chuyenSoThanhChu endp
end