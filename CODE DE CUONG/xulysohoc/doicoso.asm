.model small
.stack 100h
.data
    tb_nhap db "Nhap vao 1 so (thap phan): $"
    tb_hex  db 13, 10, "He 16: $"
    tb_nhi  db 13, 10, "He 2: $"
    so dw 0
.code

main proc
    mov ax, @data
    mov ds, ax

    mov ah, 9
    lea dx, tb_nhap
    int 21h

    call nhap_thap_phan
    mov so, dx

    mov ah, 9
    lea dx, tb_hex
    int 21h

    mov ax, so
    call xuat_he_16

    mov ah, 9
    lea dx, tb_nhi
    int 21h

    mov ax, so
    call xuat_he_2

    mov ah, 4ch
    int 21h
main endp

nhap_thap_phan proc
    xor dx, dx
    mov bx, 10
vong_nhap:
    mov ah, 1
    int 21h
    cmp al, 13
    je ket_thuc_nhap
    sub al, '0'
    xor cx, cx
    mov cl, al
    mov ax, dx
    mul bx
    add ax, cx
    mov dx, ax
    jmp vong_nhap
ket_thuc_nhap:
    ret
nhap_thap_phan endp

xuat_he_16 proc
    mov bx, 16
    xor cx, cx
chia_he_16:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne chia_he_16

hien_ky_tu_hex:
    pop dx
    cmp dl, 9
    jbe la_so_hex
    add dl, 55        ; A = 65 -> 10 + 55
    jmp in_ky_tu

la_so_hex:
    add dl, '0'

in_ky_tu:
    mov ah, 2
    int 21h
    loop hien_ky_tu_hex
    ret
xuat_he_16 endp

xuat_he_2 proc
    mov bx, 2
    xor cx, cx
chia_he_2:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne chia_he_2

hien_ky_tu_nhi_phan:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop hien_ky_tu_nhi_phan
    ret
xuat_he_2 endp

end main
