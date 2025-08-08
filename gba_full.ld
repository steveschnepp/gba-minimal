MEMORY
{
    ROM   (rx)  : ORIGIN = 0x08000000, LENGTH = 32M
    EWRAM (w!x) : ORIGIN = 0x02000000, LENGTH = 256K
    IWRAM (w!x) : ORIGIN = 0x03000000, LENGTH = 32K
    VRAM  (wx)  : ORIGIN = 0x06000000, LENGTH = 96K  /* optional: GPU memory */
    OAM   (rw)  : ORIGIN = 0x07000000, LENGTH = 1K   /* optional: sprites */
}

SECTIONS
{
    /* header region skipped (0x08000000 - 0x080000BF) */

    .text : ALIGN(4)
    {
        _text_start = .;
        KEEP(*(.init))
        *(.text*)
        *(.rodata*)
        *(.glue_7)
        *(.glue_7t)
        _text_end = .;
    } > ROM

    .data : ALIGN(4)
    {
        _data_start = .;
        *(.data*)
        _data_end = .;
    } > IWRAM AT > ROM

    .bss (NOLOAD) : ALIGN(4)
    {
        _bss_start = .;
        *(.bss*)
        *(COMMON)
        _bss_end = .;
    } > IWRAM

    .ewram_data : ALIGN(4)
    {
        _ewram_data_start = .;
        *(.ewram*)
        _ewram_data_end = .;
    } > EWRAM

    /DISCARD/ :
    {
        *(.eh_frame*)
        *(.comment*)
        *(.note*)
    }
}

PROVIDE(_rom_start = ORIGIN(ROM));
PROVIDE(_heap_start = _bss_end);
PROVIDE(_stack_top = ORIGIN(IWRAM) + LENGTH(IWRAM));
