INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
    ct1       db 13,10, 'Hay nhap thu muc can chuyen den: $'
    ct2       db 13,10, 'Thu muc da duoc chuyen den : $'
    Err_O     db 13,10, 'Khong mo duoc tep !$'
    Err_R     db 13,10, 'Khong doc duoc tep !$'
    Err_W     db 13,10, 'Khong ghi duoc tep !$'
    Err_C     db 13,10, 'Khong dong duoc tep !$'
    buff      db 30
              db ?
    file_name db 30 dup(?)
    the_tep1  dw ?
    the_tep2  dw ?
    dem       db 512 dup(?)
    tieptuc   db 'Co tiep tuc CT (c/k) ? $'
.CODE
    PS:       
              mov        ax,@data
              mov        ds,ax
    L_CT0:    
              CLRSCR
              HienString ct1              ; Hi?n thông báo ct1
              lea        dx,buff
              call       GET_FILE_NAME    ; Vào tên t?p c?n copy di
              lea        dx,file_name     ; M? t?p dã có d? d?c
              mov        al,0
              mov        ah,3dh
              int        21h
              jnc        L_CT1
              HienString Err_O            ; Hi?n thông báo Err_O n?u m? t?p b? l?i (CF=1)
              jmp        Exit_CT
    L_CT1:    
              mov        the_tep1,ax      ; N?u m? t?p t?t thì dua th? t?p có trong AX -> bi?n thetep1
              HienString ct2
              lea        dx,buff
              call       GET_FILE_NAME    ; Vào tên t?p c?n copy d?n
              lea        dx,file_name     ; T?o t?p m?i và m?
              mov        cx,0             ; Không d?t thu?c tính nào cho t?p
              mov        ah,3ch
              int        21h
              jnc        L_CT2
              HienString Err_O            ; Hi?n thông báo Err_O n?u t?o và m? t?p b? l?i (CF=1)
              jmp        DONG_TEP1
    L_CT2:    
              mov        the_tep2,ax      ; N?u m? t?p t?t thì dua th? t?p có trong AX -> bi?n thetep2
    L_CT3:    
              mov        bx,the_tep1      ; Ð?c 512 byte t? t?p copy di -> vùng nh? dem
              mov        cx,512
              lea        dx,dem
              mov        ah,3fh
              int        21h
              jnc        L_CT4
              HienString Err_R            ; Hi?n thông báo Err_R n?u d?c t?p b? l?i (CF=1)
              jmp        DONG_TEP2
    L_CT4:    
              and        ax,ax            ; S? lu?ng byte th?c t? dã d?c du?c b?ng 0?
              jz         DONG_TEP1        ; Ðúng bang 0 (h?t t?p) thì nh?y d?n dóng các t?p và k?t thúc,
              mov        bx,the_tep2      ; còn không b?ng 0 thì ti?n hành ghi t?p
              mov        cx,ax            ; Ðua s? lu?ng byte d?c du?c vào CX
              lea        dx,dem           ; Tr? d?n vùng d?m ch?a s? li?u c?n ghi
              mov        ah,40h           ; Ch?c nang ghi t?p
              int        21h
              jnc        L_CT5
              HienString Err_W            ; Hi?n thông báo Err_W n?u không ghi du?c t?p (CF=1),
              jmp        DONG_TEP2
    L_CT5:    
              jmp        L_CT4            ; Ghi t?p t?t thì nh?y v? ti?p t?c d?c và ghi
    DONG_TEP2:
              mov        bx,the_tep2      ; Ch?c nang dóng t?p
              mov        ah,3eh
              int        21h
              jnc        DONG_TEP1
              HienString Err_C            ; Hi?n thông báo Err_C n?u không dóng du?c t?p (CF=1)
    DONG_TEP1:
              mov        bx,the_tep1      ; Ch?c nang dóng t?p
              mov        ah,3eh
              int        21h
              jnc        Exit_CT
              HienString Err_C
    Exit_CT:  
              Hienstring tieptuc          ; Hi?n thông báo tieptuc
              mov        ah,1             ; Ch? 1 ký t? t? bàn phím
              int        21h
              cmp        al,'c'           ; Ký t? vào có ph?i 'c'
              jne        Thoat_CT         ; Không ph?i 'c' thì nh?y d? Thoat_CT,
              jmp        L_CT0            ; còn dúng là 'c' thì nh?y v? L_CT0
    Thoat_CT: 
              mov        ah,4ch           ; V? DOS
              int        21h
              INCLUDE    lib3.asm         ; lib3.asm ch?a CT con GET_FILE_NAME
			END  PS
