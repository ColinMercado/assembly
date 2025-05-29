section .data
    prompt:     db "What is your name? "
    prompt_len: equ $-prompt

    buffer:     times 255 db '!'

    resp1:      db "Hello, "
    resp1_len:  equ $-resp1
    resp2:      db ", nice to meet you!", 10
    resp2_len:  equ $-resp2

section .text
global _start

_start:
    mov eax, 1
    mov edi, eax
    lea rsi, prompt
    mov edx, prompt_len
    syscall

    xor eax, eax
    xor edi, edi
    lea rsi, buffer
    mov edx, 255
    syscall
    mov rbx, rax

    mov eax, 1
    mov edi, eax
    lea rsi, resp1
    mov edx, resp1_len
    syscall

    mov eax, 1
    mov edi, eax
    lea rsi, buffer
    mov rdx, rbx
    syscall

    mov eax, 1
    mov edi, eax
    lea rsi, resp2
    mov edx, resp2_len
    syscall

    mov eax, 60
    xor edi, edi
    syscall