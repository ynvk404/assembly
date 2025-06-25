inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h 
endm 
.model small
.stack 100
.data
    string db 255, 0, 255 dup ('$')  
    tbao1 db 'Nhap 1 chuoi: $'
    tbao2 db 10, 13, 'Dao nguoc: $'
.code   
main proc
    mov ax, @data
    mov ds, ax   
    
    inchuoi tbao1
    mov ah, 0Ah
    lea dx, string
    int 21h 
    
    inchuoi tbao2
    xor cx, cx 
    mov cl, [string + 1]        ;CL=do dai thuc te cua chuoi
    lea si, string + 2
;abcd -> day vao ngan xep (push) a b c d -> lay (pop) d c b a    
    reverse:
        push [si]
        inc si
        loop reverse
    
    mov cl, [string + 1]
    print:
        pop dx
        mov ah, 02h
        int 21h
        loop print           
    
    mov ah, 4ch
    int 21h
end