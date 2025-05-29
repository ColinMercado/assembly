section .data
BUF_LEN  equ 20
buffer   times BUF_LEN db 0
newline  db 10

section .text
global _start

_start:

    mov rsi, 1
    mov rdi, 10
    call print_int

    mov rsi, 1
    mov rdi, 186562354
    call print_int

    mov rsi, 1
    mov rdi, 0xdeadbeef12345678  ; 16045690981402826360 in decimal
    call print_int

    mov rax, 60
    mov rdi, 0
    syscall

print_int:
    push rbx

    lea rsi, [buffer + BUF_LEN - 1]
    mov byte [rsi], 0

.convert_dec:
    xor rdx, rdx
    mov rbx, 10
    div rbx
    add dl, '0'
    dec rsi
    mov [rsi], dl
    test rax, rax
    jnz .convert_dec

.out:
    mov rdx, buffer + BUF_LEN - rsi
    mov rax, 1
    mov rdi, 1
    syscall

    pop rbx
    ret
