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
    
    call inso
    
    mov ah, 4ch
    int 21h
main endp

nhap proc
    xor cx, cx
    xor dx, dx
    xor si, si        ; si dùng làm flag nh?p s? (0 = chua nh?p s?)
nhapktra:
    mov ah, 1
    int 21h
    
    cmp al, '-'
    je reset_dx       ; g?p d?u '-', b? qua và reset bi?n s?
    
    cmp al, ' '
    je kiemtra
    
    cmp al, 13
    je exit
    
    sub al, '0'
    cmp al, 9          ; ki?m tra ký t? nh?p có ph?i s? 0..9 không
    ja nhapktra        ; n?u không ph?i s? thì b? qua
    
    xor cx, cx
    mov cl, al
    mov bx, 10
    mov ax, dx
    mul bx
    add ax, cx
    mov dx, ax
    mov si, 1          
    jmp nhapktra

reset_dx:
    xor dx, dx
    jmp nhapktra

kiemtra:
    cmp si, 1          
    jne skip
    call checkchia5
    xor dx, dx
    xor si, si         
skip:
    jmp nhapktra

exit:
    cmp si, 1
    jne thoat
    call checkchia5
thoat:
    ret 
    
nhap endp

checkchia5 proc
    mov ax, dx
    mov bx, 5
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
    mov ax, dem

    cmp ax, 0
    jne chia10

    mov dl, '0'
    mov ah, 2
    int 21h
    ret

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
