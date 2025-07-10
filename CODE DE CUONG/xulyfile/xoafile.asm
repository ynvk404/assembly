.model small
.stack 100h
.data
    tb1 db "Nhap ten file can xoa : $"
    tenfile db 100, 0, 100 dup(0)
    thefile dw ?
.code
main proc
    mov ax,@data
    mov ds, ax
    
    mov ah, 9
    lea dx, tb1
    int 21h
    
    mov ah, 0Ah
    lea dx, tenfile
    int 21h
    
    xor cx, cx
    mov cl, [tenfile + 1]
    lea si, tenfile + 2      
    xor ch, ch
    add si, cx
    mov dl, 0
    mov [si], dl       
    
    mov ah, 3dh
    lea dx, tenfile + 2
    mov al, 0
    int 21h    
    mov thefile, ax

    mov ah, 3eh
    mov bx, thefile
    int 21h
    
    mov ah, 41h
    lea dx, tenfile + 2
    int 21h
   
     mov ah, 4ch
     int 21h
main endp
