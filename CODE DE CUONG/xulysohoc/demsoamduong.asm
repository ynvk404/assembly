.model small
.stack 100h
.data
    tb1 db "Nhap chuoi so : $"
    tb2 db 10, 13, "So luong so am la : $"  
    tb3 db 10, 13, "So luong so duong la : $"
    string db 100, 0, 100 dup(0)
    soduong dw 0
    soam dw 0
    flag db 0
.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov ah, 9
    lea dx, tb1
    int 21h
    
    call nhap
    
    mov ah, 9
    lea dx, tb2
    int 21h
    
    mov ax, soam
    call inso
    
    mov ah, 9
    lea dx, tb3 
    int 21h
    
    mov ax, soduong
    call inso
    
    mov ah, 4ch
    int 21h
main endp

nhap proc
    xor cx, cx
    xor dx, dx
nhapktra:
    mov ah, 1
    int 21h
    cmp al, '-'
    je danhdauam
    cmp al, ' '
    je kiemtra
    cmp al, 13
    je exit
    sub al, '0'
    xor cx, cx
    mov cl, al
    mov ax, dx
    mov bx, 10
    mul bx
    add ax, cx
    mov dx, ax
    jmp nhapktra

danhdauam:
    mov flag, 1
    jmp nhapktra  
    
kiemtra:
    call checkamduong
    xor dx, dx   
    mov flag, 0
    jmp nhapktra
exit:
    cmp dx, 0
    je boqua
    call checkamduong     
boqua:    
    ret
        
nhap endp 

checkamduong proc
    cmp flag, 1
    je lasoam  
    
    cmp dx, 0
    je thoat
    
    inc soduong
    jmp thoat
lasoam:
    inc soam
thoat:
    ret
checkamduong endp

inso proc 
    cmp ax, 0
    jne tieptuc
    mov dl, '0'
    mov ah, 2
    int 21h
    ret

tieptuc:
    xor cx, cx
    mov bx, 10   

chia10:
    xor dx, dx
    div bx
    push dx
    inc cx        
    cmp ax, 0
    jne chia10  

hienthi:
    pop dx
    add dl, '0'     
    mov ah, 2
    int 21h
    loop hienthi
    ret
inso endp

end main
