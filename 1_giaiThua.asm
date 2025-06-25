.model small
.stack 100h
.data
    tbao1 db "Nhap so duong nho hon hoac bang 8: $"  
    tbao2 db 10, 13,"n! = $"
.code

main proc
    mov ax, @data
    mov ds, ax
    
    mov ah, 9           ;doc xau ki tu ket thuc boi $
    lea dx, tbao1
    int 21h
    
    mov ah, 1           ;doc 1 i tu tu ban phim -> AL(ma ascii)
    int 21h
    
    sub al, 30h         ;chuyen tu ascii sang so (so 5 -> ascii: 35h)
    mov cl, al
    
    mov bl, 1           
    mov al, 1 
    
giaithua:
    mul bl              ;al = al*bl
    cmp cl, bl           
    je chiakq           
    inc bl
    jmp giaithua        

;5!=120 -> 0 2 1 (chia 10 lay du) -> stack: 1 2 0    
chiakq:
    mov bx, 10          
    mov dx, 0           ;xoa bo nho
    mov cx, 0           ;bien dem = 0
    chia:
        div bx          ;ax = ax/bx
        push dx         ; day thuong vao ngan xep
        inc cx          ;count++
        cmp ax, 0
        je inkq
        xor dx, dx      ;
        jmp chia
        
inkq:
    
    mov ah, 9
    lea dx, tbao2             ;print linefeed
    int 21h
    mov dx, 0              ;clear dx
    
    ingiaithua:
        pop dx             ;
        add dx, 30h        ;chuyen ve ma ascii de hien thi
        mov ah, 2          ;
        int 21h
        dec cx             ;count--
        cmp cx, 0
        je quit
        jmp ingiaithua
        
quit:
    mov ah, 4ch
    int 21h
    
end main
        
     
;phep MUL 8bit: nhan AL voi toan hang nguon, kq 16b cat o AX   
;phep DIV 16bit: so du luu tai DX, thuong luu tren AX