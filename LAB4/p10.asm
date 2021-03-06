;10. d-(7-a*b+c)/a-6
;a,c-byte; b-word; d-doubleword
;UNSIGNED
assume DS: data, CS: code
data segment
    a DB 2
    b DW 10
    c DB 57
    d DD 100
data ends
code segment
start:
    mov AX, data
    mov DS, AX

    ; prima data fac a * b
    ; apoi fac 7 + c
    ; apoi din 7+c scad a*b a.i am 7-a*b+c
    ; fac impartirea cu a
    ; apoi scaderile

    ;COMPUTE a*b => DX:AX := 20
    mov AL, a ; AL := a = 2
    mov AH, 0 ; CONVERT BYTE TO WORD => AX := 2
    mov BX, b ; BX := b = 10
    mul BX; DX:AX := AX * BX = 2 * 10 = 20

    ;COMPUTE 7 + c => CX:BX := 64
    mov BL, 7; BL := 7
    add BL, c; BL := BL + c = 7 + 57 = 64
    mov BH, 0; CONVERT BYTE TO WORD => BX := 64
    mov CX, 0 ; CONVERT WORD TO DWORD => CX:BX := 64

    ;COMPUTE 7-a*b+c => DX:AX = 44
    sub BX, AX ; BX := AX - 20 = 64 - 20 = 44
    sbb CX, DX ;
    mov AX, BX ; MOVING CX:BX TO DX:AX
    mov DX, CX ;

    ;COMPUTE (7-a*b+c)/a => DX:AX = 44 / 2 = 22
    mov BL, a; BL := A = 2
    mov BH, 0; CONVERT BYTE TO WORD => BX := 2
    div BX;  AX := DX:AX / BX =  44 / 2 = 22
    mov DX, 0; CONVERT WORD TO DWORD => DX:AX := 22

    ;COMPUTE d => CX:BX := D = 100
    mov CX, word ptr d+2
    mov BX, word ptr d

    ;COMPUTE d-(7-a*b+c) => CX:BX := CX:BX - DX:AX = 100 - 22 = 78
    sub BX, AX
    sbb CX, DX

    ;COMPUTE d-(7-a*b+c)/a-6 => CX:BX := CX:BX - DX:AX = 78 - 6 = 72
    mov AL, 6 ; AL := 6
    mov AH, 0 ; CONVERT BYTE TO WORD => AX := 6
    mov DX, 0 ; CONVERT WORD TO DWORD => DX:AX := 6
    sub BX, AX ;
    sbb CX, DX ;


    mov AX, 4c00h
    int 21h
code ends
end start
