INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
    tm        db 13,10,' Hay vao ten thu muc can chuyen den: $'
    Err_MD    db 13,10,' Khong chuyen duoc den thu muc !$'
    Suc_MD    db 13,10,' Thu muc da duoc chuyen !$'
    tieptuc   db 13,10,' Co tiep tuc CT (c/k) ? $'
    buff      db 50


              db ?
    file_name db 50 dup(?)
.CODE
    PS:       
              mov        ax,@data
              mov        ds,ax
    L_TM0:    
              CLRSCR
              HienString tm               ; Hiện thông báo tm
              lea        dx,buff          ; Vào tên thư mục cần tạo
              call       GET_FILE_NAME
              lea        dx,file_name
              mov        ah,3bh
              int        21h
              jnc        L_TM1            ; Nếu bit cờ CF=0 thì nhảy đến L_TM1,
              Hienstring Err_MD           ; còn CF=1 thì hiện thông báo lỗi
              jmp        EXIT_TM
    L_TM1:    
              Hienstring Suc_MD           ; Hiện thông báo thành công
    Exit_TM:  
              Hienstring tieptuc          ; Hiện thông báo tieptuc
              mov        ah,1             ; Chò 1 ký tự từ bàn phím
              int        21h
              cmp        al,'c'           ;Ký tự vào có phải 'c';
              jne        Thoat_TTM        ; Không phải 'c' thì nhảy đế Thoat_TM,
              jmp        L_TM0            ; còn đúng là 'c' thì nhảy về L_TM0
    Thoat_TTM:
              mov        ah,4ch           ; Về DOS
              int        21h
              INCLUDE    lib3.asm         ; lib3.asm chứa CT con GET_DIR_NAME
END PS