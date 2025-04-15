; A Program to find the maximum 16-bit number in a segment and store in another

SET 0                      ; Source segment
src:    DW 0x1025          ; Each value is 16-bit (word)
        DW 0x8B4A
        DW 0x5616
        DW 0x7233
        DW 0x1A8C
        DW 0xAABB
        DW 0x1234
        DW 0x00FF
        DW 0xBEEF
        DW 0x9999          ; 10 words = 20 bytes
length: DB 10              ; 10 words

SET 0x2                    ; Destination segment
dest:   DW 0xAAAA               ; To store the max value

; Entry point
start:
    MOV AX, 0              ; Set source segment
    MOV DS, AX
    MOV AX, 0x2            ; Set destination segment
    MOV ES, AX

    MOV SI, OFFSET src     ; SI points to start of src array
    MOV CL, OFFSET length  ; Number of 16-bit elements
    MOV DI, OFFSET dest
    MOV AX, word DS[SI]           ; Load first word into AX (current max)
    ADD SI, 2              ; Move to next word
    DEC CL                 ; One word already processed

_loop:
    MOV BX, word DS[SI]           ; Load next word into BX
    CMP AX, BX             ; Compare with current max
    JAE skip_update        ; If AX >= BX, skip
    MOV AX, BX             ; Else update max

skip_update:
    ADD SI, 2              ; Move to next word
    DEC CL                 ; Decrement loop counter
    JNZ _loop              ; Repeat until done

    mov DX, AX
    MOV word ES[DI], AX      ; Store max in destination
HLT