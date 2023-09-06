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
   datainput      dw 200 dup(0)
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
   NhapData:  
   ; hiên thông báo nhập mảng
              HienString msgNhap
              call       VAO_SO_N
              mov        datainput[si], ax   ;covert to number
              add        si,2                ;cac phan tu cach nhau 2byte de du dung luong
              loop       NhapData

              mov        ax, datainput[0]    ;dua pt dau tien cua mang vao ax
              HienString msgHien
   ; and ax, 0ffh ; xoa ah
              mov        min , ax            ; dua ax chua gt cua phan tu dau tien vao lam so nho nhat
              call       reset               ; reset si

   HienDuLieu:
   ; hiển thi dữ liệu vừa nhập
              mov        ax,datainput[si]
              add        si,2
              call       HIEN_SO_N
              HienString cach
              loop       HienDuLieu
              call       reset

   FindMin:   
              mov        ax, datainput[si]
              add        si,2
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

reset PROC
              mov        si,0
              mov        cx,slPt
              ret
reset ENDP
end CONTAINER