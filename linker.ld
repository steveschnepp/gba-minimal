ENTRY(_start)

MEMORY
{
    ROM (rx) : ORIGIN = 0x08000000, LENGTH = 32M
    RAM (rwx) : ORIGIN = 0x03000000, LENGTH = 256K
}

SECTIONS
{
    .text :
    {
        KEEP(*(.text*))
        *(.rodata*)
    } > ROM

    .data : 
    {
        *(.data*)
    } > RAM AT > ROM

    .bss :
    {
        __bss_start = .;
        *(.bss*)
        *(COMMON)
        __bss_end = .;
    } > RAM
}
