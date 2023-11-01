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
             PUBLIC     @MOVEF$qv
    PS:      
@MOVEF$qv PROC
             push       AX
             push       BX
             push       CX
             push       DX
             mov        ax,@data
             mov        ds,ax
    LTM0:    
             CLRSCR
             HienString tm               ; Hiện thông báo tm
             lea        dx,buff          ; Vào tên thư mục cần tạo
             call       GET_FILE_NAME
             lea        dx,file_name
             mov        ah,3bh
             int        21h
             jnc        LTM1             ; Nếu bit cờ CF=0 thì nhảy đến LTM1,
             HienString Err_MD           ; còn CF=1 thì hiện thông báo lỗi
             jmp        ExitTM
    LTM1:    
             HienString Suc_MD           ; Hiện thông báo thành công
    ExitTM:  
             HienString tieptuc          ; Hiện thông báo tieptuc
             mov        ah,1             ; Chò 1 ký tự từ bàn phím
             int        21h
             cmp        al,'c'           ;Ký tự vào có phải 'c';
             jne        ThoatTTM         ; Không phải 'c' thì nhảy đế Thoat_TM,
             jmp        LTM0             ; còn đúng là 'c' thì nhảy về LTM0
    ThoatTTM:
             mov        ah,4ch           ; Về DOS
             pop        DX
             pop        CX
    ;  mov        ah, 00h
    ;  mov        al,02
    ;  int        10h
    ;  mov        ah, 4bh
    ;  int        21h
             pop        BX
             pop        AX
             ret
             INCLUDE    lib3.asm         ; lib3.asm chứa CT con GET_DIR_NAME
@MOVEF$qv ENDP
END PS