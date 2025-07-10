.model small
.stack 100h
.data
    maSV db "at190128"
    tenSV db "Nguyen Van Khai$"      
    tb0 DB "Moi nhap ma sinh vien : $"
    tb1 DB 13, 10, "Khong co ai co ma sinh vien nhu vay!$"
    tb2 DB 13, 10, "Ten sinh vien la : $"
    string db 10, 0, 10 dup(0)
.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    
    lea dx, tb0
    mov ah, 9
    int 21h
    
    mov ah, 0ah
    lea dx, string
    int 21h
    
    mov cl, [string + 1]
    lea si, string + 2
    xor ch, ch
    add si, cx
    mov dl, '$'
    mov [si], dl
    
    mov cl, [string + 1]
    lea si, string + 2
    xor ch, ch
    lea di, maSV
    cld
    repe cmpsb
    je hienthi
sai:
    mov ah, 9
    lea dx, tb1
    int 21h
    jmp thoat
hienthi:
    mov ah, 9
    lea dx, tb2
    int 21h
    lea dx, tenSV
    int 21h
thoat:
    mov ah, 4ch
    int 21h
main endp
end main
