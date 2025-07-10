inchuoi macro message
    mov ah, 9
    lea dx, message
    int 21h
endm  

.model small
.stack 100h
.data
    msg_nhap db 'Nhap so n (< 8) = $'
    msg_kq   db 10, 13, 'Ket qua n! = $'
    b  dw 10
    num      dw ?
.code

main proc
    mov ax, @data
    mov ds, ax

    inchuoi msg_nhap

    call nhap_num

    call tinh_giai_thua

    inchuoi msg_kq   
    mov ax, num
    call in_ket_qua

    mov ah, 4ch
    int 21h
main endp

tinh_giai_thua proc
    mov cx, num    
    mov ax, 1        

tinh:
    mul cx        
    dec cx
    cmp cx, 1
    jne tinh
    mov num, ax       
    ret
tinh_giai_thua endp


nhap_num proc
    mov num, 0

nhap_lai:
    mov ah, 1
    int 21h
    cmp al, 13  
    je ket_thuc_nhap
    sub al, '0'
    mov bl, al

    mov ax, num
    mul b
    add ax, bx
    mov num, ax
    jmp nhap_lai

ket_thuc_nhap:
    ret
nhap_num endp

in_ket_qua proc
    xor cx, cx

chia10:
    xor dx, dx
    div b
    push dx
    inc cx
    cmp ax, 0
    jne chia10

hien_thi:  
    pop dx   
    add dx, '0'
    mov ah, 2
    int 21h
    loop hien_thi

    ret
in_ket_qua endp
end
