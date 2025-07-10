.model small
.stack 100h
.data
    tb1 db "Nhap vao 1 chuoi so : $"
    tb2 db 10, 13, "So luong so nguyen to la : $"
    snt dw 0
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
    mov ax, snt
    call inso
    mov ah, 4ch
    int 21h
main endp
nhap proc   
    xor cx, cx
    xor dx, dx
nhapktra:
    mov ah, 1
    int 21h
    cmp al, ' '
    je kiemtra
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
kiemtra:
    call checknto
    xor dx, dx
    jmp nhapktra
exit:
    cmp dx, 0
    je boqua
    call checknto
boqua:
    ret
nhap endp
checknto proc
    cmp dx, 2
    je lasnt
    cmp dx, 1
    jbe notsnt
    
    mov bx, 2
lap:
    mov ax, dx
    xor dx, dx
    div bx
    cmp dx, 0
    je notsnt
    inc bx
    cmp bx, ax
    jbe lap
lasnt:
    inc snt
notsnt:
    ret
checknto endp
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
inso endp
end main
    
    
    
