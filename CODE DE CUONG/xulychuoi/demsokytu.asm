.model small
.stack 100h
.data
    tb1 db "Nhap vao 1 chuoi : $"
    tb2 db 10, 13, "So luong la : $"
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
    
    mov ah, 9
    lea dx, tb2
    int 21h
    
    mov cl, [string + 1]
    xor ch, ch  
    call inso 
    
    mov ah, 4ch
    int 21h
main endp 
inso proc
    mov ax, cx
    mov bx, 10
    xor cx, cx
chia10:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
hienthi:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop hienthi
ret
inso endp
end main
