.model small
.stack 100h
.data
    tb1 db "Nhap chuoi so : $"
    tb2 db 10, 13, "So luong so am la : $"
    tb3 db 10, 13, "So luong so duong la : $"
    soam dw 0
    soduong dw 0
    flag db 0         
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
    mov ax, soam
    call inso

    mov ah, 9
    lea dx, tb3
    int 21h
    mov ax, soduong
    call inso

    mov ah, 4ch
    int 21h
main endp

nhap proc
    xor dx, dx
    xor si, si        
nhapktra:
    mov ah, 1
    int 21h

    cmp al, '-'
    je danhdauam

    cmp al, ' '
    je kiemtra

    cmp al, 13
    je ketthuc

    sub al, '0'
    cmp al, 9
    ja nhapktra    

    mov bx, 10
    xor cx, cx
    mov cl, al
    mov ax, dx
    mul bx
    add ax, cx
    mov dx, ax
    mov si, 1           
    jmp nhapktra

danhdauam:
    mov flag, 1    
    jmp nhapktra

kiemtra:
    cmp si, 1
    jne boqua
    call checkamduong
    xor dx, dx
    xor si, si
    mov flag, 0
boqua:
    jmp nhapktra

ketthuc:
    cmp si, 1
    jne thoat
    call checkamduong
thoat:
    ret
nhap endp

checkamduong proc
    cmp flag, 1
    je lasoam
    cmp dx, 0
    je thoat1
    inc soduong
    jmp thoat1
lasoam:
    inc soam
thoat1:
    ret
checkamduong endp
inso proc
    cmp ax, 0
    jne tieptuc
    mov dl, '0'
    mov ah, 2
    int 21h
    ret

tieptuc:
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
