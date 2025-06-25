.model small
.stack 100h
.data
    string1 db 100           ; c?u tr�c d�ng cho h�m 0Ah
             db ?
             db 100 dup(?)
    buffer db 255 dup('$')   ; d�ng l�m v�ng d?m d? d?c file
    thefile dw ?
    tbaoloi db "Khong mo duoc file!$" 
    tb1 db "Nhap ten file: $"
.code
main proc
    mov ax, @data
    mov ds, ax

    ; In th�ng b�o nh?p t�n file
    mov ah, 9
    lea dx, tb1
    int 21h

    ; Nh?p t�n file
    mov ah, 0Ah
    lea dx, string1
    int 21h

    ; Th�m k� t? k?t th�c chu?i (NULL) v�o t�n file
    mov cl, [string1 + 1]
    xor cx, cx
    mov cl, [string1 + 1]
    lea bx, string1 + 2 
    add bx, cx
    mov dl, 0
    mov [bx], dl       ; ? Ghi 0 v�o ngay sau k� t? d?u ti�n


    ; M? file (read-only)
    mov ah, 3Dh
    mov al, 0
    lea dx, string1 + 2
    int 21h
    jc loi
    mov thefile, ax

    ; �?c file v�o buffer
    mov ah, 3Fh
    mov bx, thefile
    lea dx, buffer
    mov cx, 254
    int 21h

    ; K?t th�c buffer b?ng '$' d? in du?c
    mov si, ax
    lea di, buffer
    add di, si
    mov byte ptr [di], '$'

    ; ��ng file
    mov ah, 3Eh
    mov bx, thefile
    int 21h

    ; In n?i dung
    mov ah, 9
    lea dx, buffer
    int 21h

    ; D?ng m�n h�nh
    mov ah, 08h
    int 21h

    mov ah, 4Ch
    int 21h

loi:
    mov ah, 9
    lea dx, tbaoloi
    int 21h

    mov ah, 4Ch
    int 21h
main endp
end main
