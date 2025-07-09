.model small
.stack 100h
.data
    tb1 db "nhap ten file : $"
    thefile dw ?
    tenfile db 100, 0, 100 dup(0)
    tb2 db 10, 13, "Da tao file thanh cong !$" 
    tb3 db 10, 13, "Nhap noi dung file : $"     
    tb4 db 10, 13, "Ghi thanh cong!$" 
    noidung db 100, 0, 100 dup(0)
.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov ah, 9
    lea dx, tb1
    int 21h
    
    mov ah, 0ah
    lea dx, tenfile
    int 21h
    
    mov cl, [tenfile + 1]
    lea si, tenfile + 2
    xor ch, ch
    add si, cx
    mov dl, 0
    mov [si], dl
    
    mov ah, 3ch
    lea dx, tenfile + 2
    mov cx, 0
    int 21h   
    mov thefile, ax       
     
    mov ah, 9
    lea dx, tb2
    int 21h 
    lea dx, tb3
    int 21h
    
    mov ah, 0Ah
    lea dx, noidung
    int 21h
    
    mov ah, 40h
    mov bx, thefile
    lea dx, noidung + 2
    mov cl, [noidung + 1] 
    xor ch, ch
    int 21h
    
    mov ah, 3eh
    mov bx, thefile
    int 21h 
    
    mov ah, 9
    lea dx, tb4
    int 21h 
    
    mov ah, 4ch
    int 21h 
   
main endp
end main

    
    
    
    
    