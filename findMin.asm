include LIB1.ASM
.MODEL small
.STACK 100h
.DATA
   msgNhapSoLuong db "Nhap so luong phan tu: $"
   msgNhap        db 10,13,'Nhap du lieu: $'
   msgHien        db 10,13,'Du lieu vua nhap:$'
   msgMin         db 10,13,'Gia tri nho nhat: $'
   cach           db ' $'
   min            dw ?
   datainput      db 100 dup('$')
   nextWord       db ?
   slPt           dw 0
   dem            db 0
.CODE
   CONTAINER: 
              mov        ax, @data
              mov        ds, ax

              CLRSCR
   ; Hiện msg nhap so luong phan tu
              HienString msgNhapSoLuong
              Call       VAO_SO_N
              mov        cx, ax
              mov        slPt, ax
              mov        si,0
              lea        si, datainput
   NhapData:  
              
              
   ; hiên thông báo nhập mảng
              HienString msgNhap
              call       VAO_SO_N
              mov        datainput[si], al   ;covert to number
              inc        si
              loop       NhapData
   resetSi:   
              mov        si,0
              lea        si, datainput

              HienString msgHien
              mov        cx,slPt
              mov        al, datainput[si]
              and        ax, 0ffh            ; xoa ah
              mov        min , ax

   HienDuLieu:
   ; hiển thi dữ liệu vừa nhập
               
              mov        al,datainput[si]
              inc        si
              and        ax, 0ffh            ; xoa ah
              call       HIEN_SO_N

              HienString cach
              loop       HienDuLieu
                

              mov        si,0
              lea        si, datainput
              mov        cx,slPt



   FindMin:   
              mov        al, datainput[si]
              inc        si
              and        ax, 0ffh            ; xoa ah
              cmp        min,ax
              jg         addmin

              loop       FindMin
              jmp        Showmin

   addmin:    
              dec        cx
              mov        min, ax
              and        cx,cx

              jnz        FindMin
   Showmin:   
              HienString msgMin
              mov        ax, min
              call       HIEN_SO_N
   Exit:      
              mov        ah, 4ch
              int        21h
              include    LIB2.ASM

end CONTAINER