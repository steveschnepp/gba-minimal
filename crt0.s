.section .text
.global _start
.type _start, %function

_start:
    b reset

.section .bss
    .space 0x4000

reset:
    ldr sp, =0x03007F00    @ Set stack pointer
    bl main
hang:
    b hang
