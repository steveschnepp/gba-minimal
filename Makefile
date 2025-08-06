CC = arm-none-eabi-gcc
LD = arm-none-eabi-ld
OBJCOPY = arm-none-eabi-objcopy

CFLAGS = -marm -mcpu=arm7tdmi -O2 -nostdlib -ffreestanding -Wall
LDFLAGS = -T linker.ld

all: pixel.gba

crt0.o: crt0.s
	$(CC) -c $< -o $@

main.o: main.c
	$(CC) $(CFLAGS) -c $< -o $@

pixel.elf: crt0.o main.o
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@

pixel.gba: pixel.elf
	$(OBJCOPY) -O binary $< $@

clean:
	rm -f *.o *.elf *.gba
