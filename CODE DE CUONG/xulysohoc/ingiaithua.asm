inchuoi macro message
    mov ah, 9
    lea dx, message
    int 21h
endm  

.model small
.stack 100h
.data
    msg_nhap db 'Nhap so n (< 8) = $'
    msg_kq   db 10, 13, 'Ket qua n! = $'
    b        dw 10
    n        dw ?     
.code

main proc
    mov ax, @data
    mov ds, ax

    inchuoi msg_nhap

    call nhap
    call giaithua

    inchuoi msg_kq
    mov ax, n
    call in_so

    mov ah, 4ch
    int 21h
main endp

giaithua proc
    mov ax, n
    cmp ax, 0
    jne tinh
    mov n, 1       ; 0! = 1
    ret

tinh:
    mov cx, n
    mov ax, 1
lap:
    mul cx
    loop lap
    mov n, ax
    ret
giaithua endp

nhap proc
    mov n, 0
doc:
    mov ah, 1
    int 21h
    cmp al, 13
    je xong
    sub al, '0'
    mov bl, al

    mov ax, n
    mul b
    add ax, bx
    mov n, ax
    jmp doc
xong:
    ret
nhap endp

in_so proc
    cmp ax, 0
    jne in

    mov dl, '1'
    mov ah, 2
    int 21h
    ret

tieptuc:
    xor cx, cx
chia:
    xor dx, dx
    div b
    push dx
    inc cx
    cmp ax, 0
    jne chia

hien:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop hien
    ret
in_so endp

end main
