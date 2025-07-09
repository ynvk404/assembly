.model small
.stack 100h
.data
    tb1 db "Nhap chuoi : $"
    tb2 db 13, 10, "Nhap ky tu can tim :$"
    true db 13, 10, "Tim thay!$"
    false db 13, 10, "Khong tim thay!$"
    string db 100, 0, 100 dup(0)
    c db ?
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
    
    mov ah, 1
    int 21h
    mov c, al
    
    mov cl, [string + 1]
    xor ch, ch
    lea si, string + 2

duyet:
    mov al, [si]
    cmp al, c
    je tim_duoc
    inc si
    loop duyet
    mov ah, 9
    lea dx, false
    int 21h
    jmp ketthuc
tim_duoc:
    mov ah, 9
    lea dx, true
    int 21h
ketthuc:
    mov ah, 4ch
    int 21h
main endp
end main