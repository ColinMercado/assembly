section .data

zero:   dq 0.0
one:    dq 1.0
two:    dq 2.0
four:   dq 4.0
negone: dq -1.0
limit:  dq 0.000001

format: db "%f", 10, 0

section .text

extern printf

global main
main:
    push rbp
    mov rbp, rsp

    ;; Compute pi
    movsd xmm0, qword [limit]
    call compute_pi 

    ;; Print result
    mov rdi, format
    mov al, 1
    call printf

    mov rax, 0
    pop rbp
    ret

compute_pi:
    push rbp
    mov rbp, rsp

    
    movsd xmm1, qword [zero]
    movsd xmm2, qword [two]
    movsd xmm3, qword [negone]

.loop_pi:
    movsd xmm4, xmm0
    addsd xmm4, qword [one]

    movsd xmm5, xmm0
    addsd xmm5, qword [two]

    movsd xmm6, xmm0
    mulsd xmm6, xmm4
    mulsd xmm6, xmm5

    movsd xmm7, qword [four]
    divsd xmm7, xmm6
    mulsd xmm7, xmm2

    addsd xmm3, xmm7

    addsd xmm0, qword [two]
    mulsd xmm2, qword [negone]

    movsd xmm6, xmm7
    comisd xmm6, qword [limit]
    ja .loop_pi

    addsd xmm3, qword [one]
    addsd xmm3, qword [one]
    addsd xmm3, qword [one]

    movsd xmm0, xmm3

    pop rbp
    ret