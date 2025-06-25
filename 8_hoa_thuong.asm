inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h 
endm 

.model small
.stack 100
.data
    string db 255 dup ('$')  
    tbao1 db 'Nhap 1 chuoi: $'
    tbao2 db 10, 13, 'Chuyen hoa thanh thuong: $'
.code  
    main proc
        mov ax, @data
        mov ds, ax   
        
        inchuoi tbao1
        mov ah, 0Ah
        lea dx, string
        int 21h 
        
        inchuoi tbao2
        lea si, string + 2
         
        hoa_thanh_thuong:
            mov dl, [si]
            cmp dl, 'A' 
            jb hienThi
            cmp dl, 'Z'
            ja hienThi
            add dl, 32  
    
        hienThi:
            mov ah, 2
            int 21h
            
            inc si
            cmp [si], '$'
            jne hoa_thanh_thuong         
        
        mov ah, 4ch
        int 21h
end        

;so sanh trong khoang A<=x<=Z
;neu nho hon A -> so+ki tu dac biet
;neu lon hon Z -> ki tu + chu thuong
;con lai no laf in hoa -> can cong 32 de thanh in thuong