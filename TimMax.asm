.MODEL small
.STACK 100h
.DATA
    msgNhap   db 10,13,'Nhap du lieu: $'
    msgHien   db 10,13,'Du lieu vua nhap:$'
    msgMax    db 10,13,'Gia tri lon nhat: $'
    max       db 0
    datainput db 100 dup('$')
    nextWord  db ?
.CODE
    CONTAINER:
              mov ax, @data
              mov ds, ax
    ; hiên thông báo nhập mảng
              lea dx, msgNhap
              mov ah,09h
              int 21h
    ; Nhập chuỗi dữ liệu
              mov ah,0ah
              lea dx, datainput
              int 21h
    ; hiển thi dữ liệu vừa nhập
              lea dx, msgHien
              mov ah,09h
              int 21h

              mov ah,09h
              lea dx, datainput+2
              int 21h
  
               
    resetSi:  
              mov si,"0"
              sub si,"0"
              lea si, datainput+2
   
    FindMAx:  
              mov al, [si]
              cmp al, "$"
              je  ShowMAx
    

              mov dl, al
              inc si
              cmp max, dl
              jb  addMAX
           
              jmp FindMAx
    addMAX:   
              mov max, dl
              jmp FindMAx
    ShowMAx:  
              lea dx, msgMax
              mov ah,09h
              int 21h

              mov dl, max
              mov ah, 02h
              int 21h
    Exit:     
              mov ah, 4ch
              int 21h
end CONTAINER