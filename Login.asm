inchuoi macro chuoi
    mov ah, 9
    lea dx, chuoi
    int 21h
endm

.model small
.stack 100h
.data
    intro_msg     db 13, 10, "=== CHUONG TRINH DANG NHAP ===", 13, 10, "$"
    reenter_msg   db 13, 10, "Nhap lai thong tin dang nhap...", 13, 10, "$"
    username_msg  db "Nhap tai khoan : $"
    password_msg  db 13, 10, "Nhap mat khau (toi da 10 ky tu) : $"
    msg_success   db 13, 10, "Dang nhap thanh cong!$"
    msg_fail      db 13, 10, "Sai thong tin dang nhap. Vui long thu lai!$"

    username_input db 20, 0, 20 dup(?)
    password_input db 10, 0, 11 dup(?)

    username db "admin"
    password db "khai2004"
    len db 0

.code 
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax

    inchuoi intro_msg

login:
    inchuoi username_msg
    lea dx, username_input
    mov ah, 0Ah
    int 21h

    inchuoi password_msg

    mov cx, 10
    lea si, password_input + 2
    mov len, 0
nhap_pass:
    mov ah, 8
    int 21h
    cmp al, 13          ; N?u ngu?i d�ng nh?n Enter
    je ketthuc_nhap
    mov [si], al
    inc si
    inc len
    mov dl, '*'
    mov ah, 2
    int 21h
    loop nhap_pass    
      
ketthuc_nhap:
    ; k?t th�c chu?i
    mov al, len
    mov [password_input + 1], al
    mov cl, [password_input + 1]
    lea bx, password_input + 2
    xor ch, ch
    add bx, cx
    mov dl, '$'
    mov [bx], dl

    ; ki?m tra username
    mov al, [username_input + 1]  ; l?y d? d�i th?c t?
    cmp al, 5
    jne sai
    lea si, username
    lea di, username_input + 2
    mov cx, 5
    cld
    repe cmpsb
    jne sai
    
    ; ki?m tra password
    lea si, password
    lea di, password_input + 2
    mov cx, 8
    cld
    repe cmpsb
    jne sai

    inchuoi msg_success
    jmp thoat

sai:
    inchuoi msg_fail
    inchuoi reenter_msg
    jmp login

thoat:
    mov ah, 4ch
    int 21h
main endp
end main
