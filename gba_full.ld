ENTRY(_start)

MEMORY {
  BIOS    (rx)  : ORIGIN = 0x00000000, LENGTH = 32K
  EWRAM   (rw)  : ORIGIN = 0x02000000, LENGTH = 256K
  IWRAM   (rw)  : ORIGIN = 0x03000000, LENGTH = 32K
  IO      (rw)  : ORIGIN = 0x04000000, LENGTH = 1K
  PALRAM  (rw)  : ORIGIN = 0x05000000, LENGTH = 1K
  VRAM    (rw)  : ORIGIN = 0x06000000, LENGTH = 96K
  OAM     (rw)  : ORIGIN = 0x07000000, LENGTH = 1K
  ROM     (rx)  : ORIGIN = 0x08000000, LENGTH = 32M
}

SECTIONS {
  .text : {
    KEEP(*(.init))
    *(.text*)
    *(.rodata*)
  } > ROM

  .data : {
    *(.data*)
  } > EWRAM AT > ROM

  .bss : {
    __bss_start__ = . ;
    *(.bss*)
    *(COMMON)
    __bss_end__ = . ;
  } > EWRAM

  .iwram : {
    *(.iwram*)
  } > IWRAM

  .vram : {
    *(.vram*)
  } > VRAM

  .oam : {
    *(.oam*)
  } > OAM

  .palram : {
    *(.palram*)
  } > PALRAM

  .iomem : {
    *(.iomem*)
  } > IO

  /DISCARD/ : {
    *(.comment)
    *(.note*)
  }

  _end = . ;
}
