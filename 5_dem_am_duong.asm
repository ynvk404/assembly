.model small
.stack 100
.data
    tbKqSoDuong db 13, 10, "So luong so duong: $"
    tbKqSoAm db 13, 10, "So luong so am: $"
    tbNhapChuoiSo db 13, 10, "Nhap chuoi so(vd: '12,23,44'): $"
    str db 100 dup("$")
    soam    db  0 
    soduong db  0  
    tongso  db  1
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        mov ah, 09h
        lea dx, tbNhapChuoiSo
        int 21h
         
        mov ah, 0Ah
        lea dx, str
        int 21h
        
        call xuly   
        
        xor ax,ax
        mov al, tongso
        sub al,soam
        mov soduong, al 
                        
        mov ah, 09h
        lea dx, tbKqSoAm
        int 21h
      
        xor ax,ax 
        mov al, soam 
        call xuatketqua 
        
        mov ah, 09h
        lea dx, tbKqSoDuong
        int 21h
        xor ax,ax 
        mov al, soduong 
        call xuatketqua  
         
        
        mov ah, 4ch
        int 21h

    xuly proc
        lea si, str + 2
        kiemtra:
            mov dx, [si]
            cmp dl, "$"
            je exit   
            
            cmp  dl, '-'  
            je demsoam
            cmp dl, ',' 
            je demso
            inc si
            jmp kiemtra
             
            
        demsoam: 
            inc soam
            inc si
            jmp kiemtra 
            
        demso:    
            inc tongso
            inc si
            jmp kiemtra       
        
        exit:
            ret
    
    xuly endp 
    
    xuatketqua proc
        xor cx,cx
        mov bx, 10
        chia10:
            xor dx,dx
            div bx
            push dx
            inc cx
            cmp ax, 0
            jnz chia10
        inra:
            mov ah,2
            pop dx
            add dl,30h
            int 21h 
            loop inra     
        ret
           
xuatketqua endp   
end    


;ham 0Ah c?a ngat 21 de nhap 1 chuoi
; byte dau tien chua kich thuoc toi da cua chuoi
;byte t2 chua so luong ky tu da nhap
;cac byte tiep chua cac ky tu