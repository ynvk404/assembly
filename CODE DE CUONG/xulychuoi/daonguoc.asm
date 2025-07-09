.model small
.stack 100h
.data
    string db 100, 0, 100 dup(0)
    tb1 db "Nhap 1 chuoi : $"
    tb2 db 10, 13, "Chuoi sau khi dao nguoc : $"
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
    
daonguoc:
    push [si]
    inc si
    loop daonguoc
    
    mov cl, [string + 1]
hienthi:
    pop dx
    mov ah, 2
    int 21h
    loop hienthi
    
    mov ah, 4ch
    int 21h
main endp
end main