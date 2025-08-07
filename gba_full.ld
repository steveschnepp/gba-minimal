ENTRY(_start)

MEMORY {
  ROM  (rx)  : ORIGIN = 0x08000000, LENGTH = 32M
  IWRAM(rwx) : ORIGIN = 0x03000000, LENGTH = 256K
}

SECTIONS {
  /* Reserve 192 bytes for GBA header */
  .header 0x08000000 : {
    . = 0xC0;
  } >ROM

  .text ALIGN(4) : {
    *(.text*)
    *(.rodata*)
  } > ROM

  .data ALIGN(4) : {
    __data_start__ = .;
    *(.data*)
    __data_end__ = .;
  } > IWRAM AT > ROM

  .bss ALIGN(4) (NOLOAD) : {
    __bss_start__ = .;
    *(.bss*)
    *(COMMON)
    __bss_end__ = .;
  } > IWRAM

  . = ALIGN(4);
  end = .;

  /DISCARD/ : {
    *(.eh_frame)
    *(.comment)
  }
}
