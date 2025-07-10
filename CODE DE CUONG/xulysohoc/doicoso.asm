.model small
.stack 100h
.data
tb1 db "Nhap vao 1 so : $"
tb2 db 13, 10, "He 16: $"
tb3 db 13, 10, "He 2: $"
so dw 0
.code
main proc
    mov ax, @data
    mov ds, ax 
    
    mov ah, 9
    lea dx, tb1
    int 21h
    
    call nhap
    mov so, dx
    
    mov ah, 9
    lea dx, tb2
    int 21h
    
    mov ax, so
    call inso16
    
    mov ah, 9
    lea dx, tb3
    int 21h
    
    mov ax, so
    call inso2
    
    mov ah, 4ch
    int 21h
main endp

nhap proc 
    xor cx, cx
    xor dx, dx
nhapktra:
    mov ah, 1
    int 21h
    cmp al, 13
    je ketthuc
    sub al, '0' 
    mov cl, al  
    mov ax, dx  
    mov bx, 10
    mul bx
    add ax, cx
    mov dx, ax
    jmp nhapktra
ketthuc:
    ret
nhap endp

inso16 proc
    mov bx, 16
    xor cx, cx
chia16:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne chia16
hienthi1:
    pop dx
    cmp dl, 9
    jbe laso
    add dl, 55
    jmp inkytu
laso:
    add dl, '0'
inkytu:
    mov ah, 2
    int 21h
    loop inkytu
ret
inso16 endp

inso2 proc
    mov bx, 2
    xor cx, cx
chia2:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne chia2
hienthi2:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop hienthi2
ret
inso2 endp
end main
    
  
