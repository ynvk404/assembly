.model small
.stack 100h
.data
    tb1 db "Nhap vao 1 chuoi : $"
    tb2 db 10, 13, "Tong la : $"
    tong dw 0
.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov ah, 9
    lea dx, tb1
    int 21h

    call nhap

    mov ah, 9
    lea dx, tb2
    int 21h

    mov ax, tong
    call inso

    mov ah, 4ch
    int 21h
main endp

nhap proc
    xor dx, dx      
    xor cx, cx      
nhapktra:
    mov ah, 1
    int 21h        
    cmp al, ' '
    je tinhtong   
    cmp al, 13
    je exit         

    sub al, '0'
    mov cl, al
    mov ax, dx
    mov bx, 10
    mul bx
    add ax, cx
    mov dx, ax
    jmp nhapktra

tinhtong:
    add tong, dx    
    xor dx, dx      
    jmp nhapktra

exit:
    cmp dx, 0
    je boqua
    add tong, dx    
boqua:
    ret
nhap endp

inso proc
    xor cx, cx
    mov bx, 10
chia10:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne chia10
hienthi:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop hienthi
ret
inso endp

end main
