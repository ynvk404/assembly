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
    tbao2 db 10, 13, 'Chuyen thuong thanh hoa: $'   

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
        
        ;xet ki tu trong khoang a<=x<=z
         
        thuong_thanh_hoa:
            mov dl, [si]
            cmp dl, 'a' 
            jb hienThi        ;nhay neu nho hon
            cmp dl, 'z'
            ja hienThi         ;nhay neu lon hon
            sub dl, 32  
    
        hienThi:
            mov ah, 2
            int 21h
            
            inc si
            cmp [si], '$'
            jne thuong_thanh_hoa         ;nhay neu khong bang     
        
        mov ah, 4ch
        int 21h
end

;ma ascii cua 'a' la 97, ma ASCII cua 'A' la 65.
;97 - 65 = 32.                 
;duyet tung ki tu neu no lon hon a thi laf ki tu dac biet->hien thi
;neu nho hon a thi la ki tu in hoa->hien thi          
;con lai tru 32 de in hoa