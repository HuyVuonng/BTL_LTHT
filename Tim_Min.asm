include LIB1.asm 
.Model small
.Stack 100h
.data
    M1    db 13,10,'Hay vao so luong thanh phan :$'
    M2    db 13,10, 'a[$'
    M3    db ']=$'
    M4    db 13,10,'Day so vua vao la : $'
    space db ' $'
    M5    db 13,10,'Gia tri be nhat cua day so la : $'
    M6    db 13,10,'Co tiep tuc CT(c/k) ? $'
 
    sltp  dw ?
    i     dw ?                                            ; khai bao bien
    a     dw 100h dup(?)                                  ; khai bao mang so nguyen
 
.code
         PUBLIC     @TimMin$qv
    PS:  
@TimMin$qv PROC
         mov        ax,@data      ;dua phan dia chi segment cua vung nho
         mov        ds,ax         ; cap phat cho bien vao DS
         push       CX
         push       bx            ;
         push       ax
    L0:  
         CLRSCR                   ;    xoa man hinh
         HienString M1            ; hien xau M1
         call       VAO_SO_N      ;  vao so luonh thanh phan
         mov        sltp,ax       ;dua so luong thanh phan vao bien sltp
         mov        cx,ax         ;cx=s;tp chi so vong lap
         lea        bx,a          ; bx tro offset den o nho chua a[0]
         mov        i,0           ;           ;chi so (luc dau la 0)
    ; VONG lap nhan cac so cua day dua vao mang a
    L1:  HienString M2            ;      hien xau M2 (a'[')
         mov        ax,i          ;            dia chi so vao AX
         call       HIEN_SO_N     ;      hien chi so cua mang
         HienString M3            ;        hien xau M3 (']=')
  
         call       VAO_SO_N      ;      vao gtri cac thanh phan cua day so
         mov        [BX],ax       ;             dua vao mang
         inc        i             ;                tang chi so
         add        bx,2          ;       BX tro den thanh phan tiep theo cua mang
         loop       L1
  
         HienString M4            ;       hien xau m4
         mov        cx,sltp       ;          cx+sltp (chi so vong lap)
         lea        bx,a          ;             bx tro den o nho chua a[0]
  
    ;vong lap hien cac so mang len man hinh
    L2:  mov        ax,[bx]       ;dua a[i] vao ax
         call       HIEN_SO_N     ;       ;hien a[i]
         HienString space         ;    hien cac dau cach
         add        bx,2          ;              bx tro den thanh phan tiep theo cua mang
         loop       L2
  
         HienString M5            ; hien xau M5
         mov        CX,sltp       ; cx=sltp;
         lea        BX,a          ; bx tro den o nho chua a[0]
         mov        ax,[bx]       ; dua a[0] vao ax
         dec        cx            ; giam chi so vong lap di 1
  
    ; vong lap tim so nho nhat cua day
    L3:  
         add        bx,2          ; tro den thanh phan tiep theo cua mang
         cmp        ax,[bx]       ; so sanh so be nhat(ax) voi so tiep theo
         jl         L4            ; so hien la be nhat ax < so tiep theo , nhay
         mov        ax,[bx]       ; con nguoc lai dua so tiep theo vao ax
  
    L4:  
         loop       L3            ; vong lap nhan cac so va so sanh
         call       HIEN_SO_N     ; Hien so lon nhat cua day
  
    L5:  
         HienString M6
         mov        ah,1          ; Chò 1 ký tự từ bàn phím
         int        21h
         cmp        al,'c'        ;Ký tự vào có phải 'c';
         jne        exit          ; Không phải 'c' thì nhảy đế Thoat_TM,
         jmp        L0
  
    exit:
         pop        CX
         pop        bx            ;
         pop        ax
         ret
         include    LIB2.asm
@TimMin$qv ENDP
end PS
           
           
