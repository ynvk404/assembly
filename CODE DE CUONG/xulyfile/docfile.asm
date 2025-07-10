.model small
.stack 100h
.data 
    tb1 db "Nhap ten file can doc : $"
    string db 100, 0, 100 dup(0) 
    tb2 db 10, 13, "Noi dung cua file la : $"
    thefile dw ? 
    noidung db 100, 0, 100 dup(0)
    ;tenfile db "d:/test.txt", 0
.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov ah, 9
    lea dx, tb1
    int 21h
    
    mov ah, 0Ah 
    lea dx, string
    int 21h 
    
    mov cl, [string + 1]
    lea si, string + 2
    xor ch, ch
    add si, cx
    mov dl, 0
    mov [si], dl
    
    ;mo file
    mov ah, 3dh
    lea dx, string + 2
    mov al, 2  
    int 21h
    mov thefile, ax
    
    ;doc noi dung file
    mov ah, 3fh
    mov bx, thefile
    lea dx, noidung + 2
    mov cx, 100
    int 21h
    
    ;dong file
    mov ah, 3eh   
    mov bx, thefile    
    int 21h  
     
    ;them ky tu '$'     
    lea si, noidung + 2     
    add si, cx
    mov dl, '$'
    mov [si], dl
    
    mov ah, 9
    lea dx, tb2
    int 21h
    mov ah, 9
    lea dx, noidung + 2
    int 21h
    
    mov ah, 4ch
    int 21h
main endp
end main
