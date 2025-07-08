.model small
.stack 100h
.data
    tb1 db "Nhap n : $"
    tb2 db 10, 13, "Ket qua n! = $"
.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov ah, 9
    lea dx, tb1
    int 21h
    
    mov ah, 1
    int 21h
    cmp al, '0'
    je dacbiet
    sub al, '0'
    mov cl, al
    mov bl, 1
    mov al, 1

giaithua:
    mul bl
    cmp cl, bl
    je chiakq
    inc bl
    jmp giaithua

chiakq:
    mov bx, 10
    xor cx, cx
chia:
    xor dx, dx  
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne chia

hienthi:
    mov ah, 9
    lea dx, tb2
    int 21h
lap:
    xor dx, dx
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop lap
    jmp thoat
dacbiet:
    mov ah, 9
    lea dx, tb2
    int 21h
    
    mov dl, '1'
    int 21h
thoat:
    mov ah, 4ch
    int 21h
main endp
end main
    
    
    