; A Program to move data from one segment to another
SET 0                   ; set address for segment 1
src:DB 0x25
      DB 0x4A
      DB 0x16
      DB 0x8B
      DB 0x03
      DB 0x72
      DB 0x5E
      DB 0x1A
      DB 0x6C
      DB 0x59 ; 10 bytes
length:DB 0x0A
SET 0x1                 ; set addresss for segment 2
dest:DB 0               ; store data

; actual entry point of the program
start:
    MOV AX, 0           ; move address of seg1
    MOV DS, AX          ; to DS
    MOV AX, 0x1         ; move address of seg2
    MOV ES, AX          ; to ES

    MOV SI, OFFSET src  ; point SI to src array
    MOV CL, byte length ; number of elements
    MOV DI, OFFSET dest     ; move offset of destination data
    MOV AL, byte DS[SI] ; load first byte into AL (max candidate)

    INC SI              ; move to next byte
    DEC CL              ; already used one byte

_loop:
    MOV AH, byte DS[SI] ; read next byte into AH
    CMP AL, AH          ; compare with current max
    JNC skip_update     ; if AL >= AH, skip update
    MOV AL, AH          ; else update max

skip_update:
    INC SI              ; move to next byte
    DEC CL              ; decrement counter
    JNZ _loop           ; loop if not zero

    MOV DL, AL  ; store max at dest[0]
    mov byte ES[DI],AL

    HLT                 ; end of program