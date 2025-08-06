.section .text
.global _start
.type _start, %function

_start:
    b reset

reset:
    ldr sp, =0x03007F00    @ Set stack pointer
    bl main
hang:
    b hang
