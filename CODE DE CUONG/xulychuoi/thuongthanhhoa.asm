.model small
.stack 100h
.data
    tb1 db "Nhap chuoi : $"
    tb2 db 10, 13, "Chuoi sau khi in hoa la : $"   
    string db 100, 0, 100 dup(0)
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
    
    mov cl, [string + 1]    
    xor ch, ch
    lea si, string + 2
    add si, cx
    mov dl, '$'
    mov [si], dl
    
    lea si, string + 2
lap:
    mov al, [si]
    cmp al, 'a'
    jb next
    cmp al, 'z'
    ja next
    sub al, 32
    mov [si], al
 
 next:
    inc si
    loop lap
    
    mov ah, 9
    lea dx, tb2
    int 21h
    
    lea dx, string + 2
    int 21h
    
    mov ah, 4ch
    int 21h
main endp
end main
    
