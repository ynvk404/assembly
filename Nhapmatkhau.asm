.model small
.stack 100h
.data
    msg1 db "Nhap mat khau(toi da 10 ky tu, ESC de ket thuc): $"
    msg2 db 13, 10, "Ban da nhap: $"
    string db 10, 0, 11 dup(?) 
; 1 byte t?i string[0] d? quy d?nh d? d�i t?i da

; 1 byte t?i string[1] d? luu d? d�i th?c t? (s? c?p nh?t sau khi nh?p xong)

; 11 byte t? string[2] d? luu n?i dung ngu?i d�ng nh?p
    len db 0
 .code
 main proc
    mov ax, @data
    mov ds, ax
    
    lea dx, msg1
    mov ah, 9
    int 21h
    
    mov cx, 10
    lea si, string
    lap:
        mov ah, 8
        int 21h
        cmp al, 27
        je done 
        ;gan ky tu
        mov [si], al
        inc si
        inc len
        ;in ky tu
        mov dl, '*'
        mov ah, 2
        int 21h
        loop lap
    done:  
        
        ;them ky tu '$' vao cuoi chuoi 
        mov al, len  ;lay do dai chuoi
        mov [string + 1], al ;gan vao [string + 1]
        mov cl, [string + 1]    ;luu vao thanh ghi cl
        lea bx, string + 2  ;tro vao dia chi dau chuoi
        xor ch, ch      ;xoa phan cao
        add bx, cx      ;tro den vi tri cuoi cung
        mov dl, '$'     ;gan ky tu '$'
        mov [bx], dl    
        
        ;xuong dong
        mov ah, 02h
        mov dl, 13
        int 21h
        mov dl, 10
        int 21h   
        ;in chuoi da nhap
        lea dx, msg2
        mov ah, 9
        int 21h
        lea dx, string + 2  ;in tu ky tu dau
        int 21h
        
        mov ah, 4ch
        int 21h
main endp
end main
        
        