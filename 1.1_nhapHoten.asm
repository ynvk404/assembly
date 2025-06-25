.model small
.stack
.data                 
    nhap db 10 dup(?),24h
    masv db "DO THI YEN$"   
    ten db 0Dh,0Ah,"AT180251$"     
    tbao db 0Dh,0Ah,"Khong co ai co ten nhu vay!$"
                  
.code
    main proc      
        mov ax, @data
        mov ds, ax
        mov es, ax
        
        lea si, nhap
        mov ah, 01h
        mov cx, 10     
        
     lap:
        int 21h
        cmp al, 0Dh
        jz next
        mov [si], al
        inc si
        loop lap
          
     next:        
        cld
        lea si, nhap
        lea di, masv
        mov cx, 10          
        repe cmpsb
        jz inten
        
        mov ah, 09h
        lea dx, tbao 
        int 21h
        jmp thoat
        
        inten:
        mov ah, 09h
        lea dx, ten
        int 21h
        
    thoat:
        mov ah, 4Ch
        int 21h
            
    main endp
end