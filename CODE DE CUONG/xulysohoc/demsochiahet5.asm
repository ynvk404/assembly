.model small
.stack 100h
.data
    tb1 db "Nhap chuoi so : $"
    tb2 db 10, 13, "So luong so chia het cho 5 la : $"
    dem dw 0
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
    
    mov ax, dem
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
    mov bx, 10
    mov ax, dx
    mul bx
    add ax, cx
    mov dx, ax
    jmp nhapktra
kiemtra:
    call checkchia5
    xor dx, dx
    jmp nhapktra
exit:
    cmp dx, 0
    je boqua
    call checkchia5
boqua:
    ret
nhap endp
checkchia5 proc
    mov bx, 5
    mov ax, dx
    xor dx, dx
    div bx
    cmp dx, 0
    jne trolai
    inc dem
trolai:
    ret
checkchia5 endp

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

    
    
