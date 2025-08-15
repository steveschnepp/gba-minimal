    .syntax unified
    .cpu arm7tdmi
    .arm
    .global _start
    .section .crt0

/* ======== GBA header area ======== */
    b   _start_code         @ First instruction (ARM branch) to code
    .space 0xC0 - 4         @ Reserve rest of 0xC0 bytes

/* ======== Actual startup code ======== */
_start_code:
    /* Mode bits */
    .equ MODE_SYS, 0x1F
    .equ MODE_IRQ, 0x12
    .equ MODE_SVC, 0x13

    /* Stack tops */
    .equ STACK_TOP, 0x03008000
    .equ STACK_IRQ, (STACK_TOP - 0x0000)
    .equ STACK_SVC, (STACK_TOP - 0x0100)
    .equ STACK_SYS, (STACK_TOP - 0x0200)

    /* IRQ mode stack */
    mrs r0, cpsr
    bic r0, r0, #0x1F
    orr r0, r0, #MODE_IRQ
    msr cpsr_c, r0
    ldr sp, =STACK_IRQ

    /* SVC mode stack */
    bic r0, r0, #0x1F
    orr r0, r0, #MODE_SVC
    msr cpsr_c, r0
    ldr sp, =STACK_SVC

    /* SYS mode stack */
    bic r0, r0, #0x1F
    orr r0, r0, #MODE_SYS
    msr cpsr_c, r0
    ldr sp, =STACK_SYS

    /* Jump to main in Thumb mode */
    ldr r0, =main
    bx  r0

hang:
    b hang
