# Assembly__KMA
- hàm 0Ah -> byte đầu tiên: số lượng kí tự tối đa, byte2:số lượng kí tự thực tế, byte t3 trở đi là chứa kí tự => lea si, string+2 di chuyển trỏ đến vị trí của kí tự đầu tiên của chuỗi

- hàm 01: đọc kí tự (có hiện)được nhập từ bàn phím lên màn hình -> AL=mã ascii của ký tự
- hàm 02: hiện 1 kí tự lên màn hình (DL = ascii của ký tự cần hiện)
- hàm 08: đọc kí tự (k hiện) từ bàn phím -> AL=mã ascii của kí tự
- hàm 09: hiển thị xâu ký tự lên màn hình kết thúc bởi $ -> DX=offset của xâu ký tự
- hàm 0Ah: đọc xâu kí tự từ bàn phím -> DX=offset của xâu kí tự

- hàm 39: tạo thư mục -> DX = offset của tên thư mục. Thành công => được tạo. Thất bại CF=1, AM=mã lỗi
-hàm 3Ah: xóa thư mục

- hàm 3Ch: tạo file -> DX=offset, CX= thuộc tính của file -> thành công CF=0,AX= file handle
      00h: file bth
      01h: file chỉ đọc
      02h: file ẩn
      04h: file hệ thống
      08h: thuộc tính cho nhãn đĩa
      10h: thuộc tính cho thư mục con

- hàm 3D: mở file, AL = mode, AL=2: read/write
      0: Read-Only (Chỉ đọc)
      1: Write-Only (Chỉ ghi)
      2: Read/Write (Đọc/Ghi)
      3: Chế độ mở tập tin khác (trong một số trường hợp có thể kết hợp với các chế độ chia sẻ)
      4: Chế độ mở tập tin khác (trong một số trường hợp có thể kết hợp với các chế độ chia sẻ)
- ham 3Fh: đọc file , BX: thefile 
- hàm 3Eh: đóng file , DS:DX= offset của vùng đệm, CX: số byte cần đọc, BX: thẻ file

- hàm 40h: ghi vào file, S:DX= offset của vùng đệm, CX: số byte cần đọc, BX: thẻ file
- hàm 41h: xóa file, DX = địa chỉ offset của tên file
- hàm 56h: đổi tên file
        mov ah, 56h       ; Đặt hàm 56h vào thanh ghi AH
        mov dx, offset old_filename ; Địa chỉ của tên tệp cũ
        mov di, offset new_filename ; Địa chỉ của tên tệp mới
        int 21h           ; Gọi ngắt phần mềm DOS
  
- giải thuật nhập tên file đối với hàm 0Ah
        xor cx, cx ; dua zero ve cuoi chuoi​
        mov cl, len ;khai bao bien de dung ham 0ah cua int 21h dang
        lea bx, tenfile; max db 250 ; so ky tu toi da duoc nhap
        mov dl,0 ; len db ? ; chieu dai chuoi da nhap​
       mov [bx], dl ; tenfile db 250 dup(?); chua noi dung​ duoc nhap

Tại sao phải cất thẻ file (mov thefile, ax) và nếu không cần đóng file thì có cần cất thẻ file hay không?
Chúng ta phải cất thẻ file (file handle) vì:

Thao tác với file: Khi bạn mở hoặc tạo một file, DOS trả về một file handle trong thanh ghi AX. Bạn cần lưu giá trị này để có thể sử dụng trong các thao tác tiếp theo với file như ghi dữ liệu vào file hoặc đóng file.

Đóng file: Để đóng một file, bạn cần sử dụng file handle đã được trả về khi mở hoặc tạo file. Nếu bạn không lưu file handle, bạn sẽ không thể đóng file chính xác, điều này có thể gây ra rò rỉ tài nguyên.
