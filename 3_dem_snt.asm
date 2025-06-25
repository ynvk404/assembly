
.model small
.stack 100
.data
    tbNhapChuoiSo db 13, 10, "Nhap chuoi so(vd:2 5 17): $"
    tbKq db 13, 10, "So luong so nguyen to la: $"
    str db 100 dup("$")
    snt dw 0 
    so10 dw 10
    x dw 0
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        mov ah, 09h
        lea dx, tbNhapChuoiSo
        int 21h 
        call xuLy
        
        mov ah, 09h
        lea dx, tbKq
        int 21h  
        call xuatKQ
        
        mov ah, 4Ch
        int 21h
        
    xuLy proc
        xor dx, dx
        xor cx, cx
        nhap:
        mov ah, 01h
        int 21h
        
        cmp al, 32        ;(so sanh voi space)
        je  kiemtra
        
        cmp al, 32
        je  nhap
       
        cmp al, 0Dh       ;so sanh voi Enter
        je  exit
        
        sub al, 30h        ;chuyen sang dang so nguyen
        mov cl, al 
        mov ax, dx
        mov bx, so10      
        mul bx
        
        add al, cl
        mov dx, ax  
        
        jmp nhap  
        
        
        kiemtra: 
             mov x, dx
             cmp x, 2 
             je lasnt   
             
             cmp x, 1  
             je exitxuly  
             
             mov bx, 2    ;khoi tao bx=2 de bat dau chia
             xor dx, dx                            
         lapchia:      ;kiem tra SNT; chia x cho 2 -> x-1
            
                mov ax, x
                div bx     ;phep DIV -> AX/BX -> thuong AX, du DX
                
                cmp bx, x
                je lasnt 
                
                cmp dx, 0    ;chia het
                je exitxuly  
                xor dx, dx
                inc bx  
                jmp lapchia
        
     
     
          lasnt:
                inc snt 
            
          exitxuly:
                 xor dx, dx
                 jmp nhap
        
     
        exit:
            ret
    nhapchuoi ENDP     
    
    xuatKq proc  
        xor cx, cx
         mov bx, so10 
         mov ax, snt
         xuat: 
            xor dx, dx 
            div bx
            push dx
            inc cx
            cmp ax, 0
            jnz xuat
         inra:
            mov ah, 2
            pop dx
            add dl, 30h
            int 21h
            loop inra
    
    
    xuatKq endp      
    
    
end main

;phep XOR -> clear ve 0. vi 2 bit giong nhau = 0