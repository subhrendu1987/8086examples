; A Program to find fibonacci sequence
SET 0x0
count: DB 10         ; Total number of terms in decimal

SET 0x1             ; Destination segment (i.e. ES)
fib: DW 0
     DW 1         ; First two Fibonacci numbers (0, 1) in base 10
; Fill rest of the numbers after this


; Entry point
start:
    MOV AX, 0x0      ; Load segment 0x1
    MOV DS, AX       ; Set DS to point to fib segment
    MOV CL, byte count ; Load count = 10
    MOV AX, 0x1      ; Load segment 0x1
    MOV ES, AX       ; Set ES to point to fib segment
    MOV DI, OFFSET fib ; DI points to start of fib array

_next:
    ; Get previous two terms
    MOV AX, word ES[DI]       ; AX = fib[n-2]
    ADD DI, 2
    MOV BX, word ES[DI]     ; BX = fib[n-1]
    ADD AX, BX            ; AX = fib[n] = fib[n-1] + fib[n-2]
    DAA
    ADD DI, 2
    MOV word ES[DI], AX     ; Store next term at fib[n]
    SUB DI, 2             ; Move to next word (DI += 2)
    DEC CL
    JNZ _next
HLT