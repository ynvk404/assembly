.model small
.stack 100h
.data
    tb1 db "Nhap chuoi : $"   
    string db 100, 0, 100 dup(0)
    tb2 db 10, 13, "Tong la : $"
    sum dw ?
.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov ah, 9
    lea dx, tb1
    int 21h
    
    mov ah, 0ah
    lea dx, string
    int 21h
    
    mov ah, 9
    lea dx, tb2
    int 21h
    
    xor cx, cx
    mov cl, [string + 1]
    lea si, string + 2
    xor ax, ax  
    mov bx, 10
    mov sum, ax
duyet: 
    mov dx, [si]  
    cmp dl, ' '
    je tinhtong   
    
    mul bx
    mov dl, [si]
    xor dh, dh
    sub dl, '0' 
    add ax, dx   
    jmp tiep
    
tinhtong:
    add sum, ax  
    xor ax, ax     
tiep:
    inc si
    loop duyet 

    add sum, ax
    
    mov ax, sum
    call sothanhchu 
    
    mov ah, 4ch
    int 21h
main endp  

sothanhchu proc
    mov bx, 10
    xor cx, cx
chiakq:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne chiakq

hienthi:
    pop dx   
    add dl, '0'
    mov ah, 2
    int 21h
    loop hienthi

    ret
sothanhchu endp
end main