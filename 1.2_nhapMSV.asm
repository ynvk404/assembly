.model small
.stack 100h
.data                 
    nhap db 8 dup(?),24h
    masv db "AT180251"
    ten db 0Dh,0Ah,"Do Thi Yen$"      ;0Dh=13-> tra ve dau dong, 0Ah=10->xuong dong
    tbao db 0Dh,0Ah,"Khong co ai co masv nhu vay!$"   
    tbao1 db "Nhap ma sinh vien: $"
                 
.code
    main proc      
        mov ax, @data
        mov ds, ax    ;Vi ds va es khong the gan truc tiep vao nen muon gan data phai thong qua trung gian ax
        mov es, ax
            
        mov ah, 09h   ;ngat 09h -> hien thi xau ki tu ket thuc = $
        lea dx, tbao1   
        
        int 21h
        
        mov ah, 01h   ;01h  -> doc ki tu duoc nhap tu ban phim -> output=AL
        mov cx, 8      ;so lan lap ki tu  
        lea si, nhap  ;doc ki tu va luu vao nhap
        
        lap: 
            int 21h
            cmp al, 0Dh   ;so sanh voi ki tu enter        
            jz next       ;nhay xuong next neu bang (jz/je)
            mov [si], al 
            inc si        ;tang gia tri cua toan hang dich len 1 de duyet mang 
            loop lap
          
        next:        
        cld
            lea si, nhap            
            lea di, masv
            mov cx, 8
            repe cmpsb     ;lenh so sanh chuoi
            jz inten       ;neu dung het thi chuyen den ham inten
            
            mov ah, 09h             ;sai thi in ra tbao 
            lea dx, tbao 
            int 21h
            jmp thoat     ;jmp: nhay k dieu kien
            
        inten:              
            mov ah, 09h   ;in ra ten nhu mong muon
            lea dx, ten
            int 21h
        
        thoat:
        mov ah, 4Ch
        int 21h
            
    main endp
end