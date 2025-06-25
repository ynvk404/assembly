inchuoi macro chuoi
    mov ah, 9
    lea dx, chuoi
    int 21h
endm

.model small
.stack 100h

.data
string db 100
db ? 
db 100 dup(?)

tenfile db 100
db ?
db 100 dup(?)

thefile dw ?
CRLF db 13, 10, 0

tb0 db 13, 10, "Nhap ten file can tao : $"
tb1 db 13,10, "Nhap noi dung can ghi: $"
tb2 db 13,10, "Ghi file thanh cong!$"
tb3 db 13,10, "Co loi khi tao hoac ghi file!$"
tb4 db 13, 10, "Chuoi sau khi doi cac ki tu dau cua tung tu hoa la : $"
.code
main proc
    mov ax, @data
    mov ds, ax

    inchuoi tb0
    mov ah, 0Ah
    lea dx, tenfile
    int 21h

    
    mov cl, [tenfile + 1]
    lea bx, tenfile + 2
    xor ch, ch
    add bx, cx
    mov dl, 0
    mov [bx], dl
   
    mov ah, 3Ch
    lea dx, tenfile + 2
    mov cx, 0
    int 21h
    jc tao_loi
    mov thefile, ax


    inchuoi tb1
    mov ah, 0Ah
    lea dx, string
    int 21h       
    lea si, string + 2
    call kiemtra 
    inchuoi tb4  
    mov cl, [string + 1]
    lea bx, string + 2
    xor ch, ch
    add bx, cx
    mov dl, '$'
    mov [bx], dl
    mov ah, 9   
    lea dx, string + 2 
    int 21h
      
    mov ah, 40h
    mov bx, thefile
    mov cl, [string + 1]
    xor ch, ch
    lea dx, string + 2
    int 21h
   

    mov ah, 40h
    mov bx, thefile
    mov cx, 2
    lea dx, CRLF
    int 21h

    ; ��ng file
    mov ah, 3Eh
    mov bx, thefile
    int 21h

    inchuoi tb2
    jmp ketthuc

tao_loi:
    inchuoi tb3

ketthuc:
    mov ah, 4Ch
    int 21h
main endp 
kiemtra proc
    mov al, 1
    lap:
        mov bl, [si]
        cmp bl, 13
        je thoat
        cmp bl, 'a'
        jl not_char
        cmp bl, 'z'
        jg not_char
        cmp al, 1
        jne not_char
        sub bl, 32
        mov [si], bl
        mov al, 0
        jmp next
    not_char:
        cmp bl, ' '
        jne next
        mov al, 1
    next:
        inc si
        jmp lap
    thoat:
        ret      
kiemtra endp
        
end main
