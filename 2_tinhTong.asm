.model small
.stack 100
.data
    tbKqTong db 13, 10, "Tong = $"
    tbNhapChuoiSo db 13, 10, "Nhap chuoi so(vd: '12,23,44'): $"
    str db 100 dup("$")
    sum dw ?
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        mov ah, 9
	    lea dx, tbNhapChuoiSo
        int 21h
         
        mov ah, 0Ah ;doc chuoi tu ban phim (dx->offset cua xau ky tu)
        lea dx, str
        int 21h
        
        mov ah, 9
        lea dx, tbKqTong
        int 21h
        
        mov cx, 0		;bien dem so luong so trong chuoi
        mov cl, [str + 1]
        lea si, [str + 2]
        mov bx, 10
        mov ax, 0
        mov sum, ax ;khoi tao sum=0 (do ax=0)

        loop1:
        	mov dx, [si]
        	cmp dl, ","
       		je tinhTong
        	mul bx		;ax = ax*10 (do gan bx=10) 
        	mov dx, [si]	;gan tiep dx = so asci co vi tri tai SI
        	mov dh, 0
        	sub dl, 30h     ;chuyen ascii ve so
        	add ax, dx
        	jmp tiep
        	tinhTong:
        		add sum, ax
       			mov ax, 0
        	tiep:
        		inc si
        loop loop1
        
        add sum, ax
        mov ax, sum
        call chuyenSoThanhChu
        
        mov ah, 4ch
        int 21h
    main endp
    
;120/10 ->  dx: 0 2 1-> day vao stack: 1 2 0 
    chuyenSoThanhChu proc
        mov bx, 10
        mov cx, 0
        chia10:
        	mov dx, 0
        	div bx           ;output:ax -> thuong, dx: so du
        	push dx
        	inc cl
        	cmp ax, 0
       	 	je hienthi
        	jmp chia10
        hienthi:
        	pop dx
        	add dl, 30h ;chuyen ve ma ascii de hien thi
        	mov ah, 2
       	 	int 21h
        	loop hienthi
        ret
    chuyenSoThanhChu endp
end