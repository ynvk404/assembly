.model small
.stack 100h
.data
    old_name db 'd:\teptin.txt',0
    new_name db 'd:\heheKHAI.txt',0
.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    mov ah, 56h
    lea dx, old_name
    lea di, new_name
    int 21h  
    
    mov ah, 4Ch
    int 21h 
    
main endp
end main
