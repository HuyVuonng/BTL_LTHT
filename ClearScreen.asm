Clear proc
               mov ah, 00
               mov al,02
               int 10h
               mov ah, 4bh
               int 21h
               ret