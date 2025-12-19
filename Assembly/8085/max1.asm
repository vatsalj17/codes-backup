.max:
    mov a, b
    cmp c
    jnc L1
    mov a, c
L1: ret

start:
    lxi h, 2000h
    mov b, m
    inx h
    mov c, m
    call .max
    inx h
    mov m, a
