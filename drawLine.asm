.MODEL small
.STACK 100h
.DATA
    msg  db 'Nhan phim bat ki de thoat:$'

.CODE
                PUBLIC @DRAW$qv


    CONTAINER:  
@DRAW$qv PROC
                mov    ax, @data
                mov    ds, ax
              
    ; Draw
    ; setup
                mov    ah,0          ; set video mode
                mov    al,13h        ; graphical mode. 40*25.256 colors.320*200 pixels. 1page
                int    10h

                mov    ah,0ch
                mov    al, 10        ; set color of pixel
                mov    cx,30         ;row(x)
                mov    dx, 30        ; column(y)
                int    10h

    ;   Drawing
    ; ngang
    horizontal: 
                int    10h
                inc    cx
                cmp    cx, 100
                jbe    horizontal
    ; doc
                mov    cx, 130
    vertical:   
                int    10h
                inc    dx
                cmp    dx, 100
                jbe    vertical
    ; chéo
                mov    cx, 160
                mov    dx, 30
    cross:      
                int    10h
                inc    cx
                inc    dx
                cmp    dx, 100
                jbe    cross
               
    messAndExit:
                lea    dx, msg
                mov    ah,09h
                int    21h

                mov    ah,01h
                int    21h
                
                mov    ah, 00
                mov    al,02
                int    10h
                mov    ah, 4bh
                int    21h
    ; call Clear
                
    ;   Return to DOs
              
    ; mov    ah, 4ch
    ; int    21h
                ret
@DRAW$qv ENDP
end CONTAINER