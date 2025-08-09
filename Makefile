CC = arm-none-eabi-gcc
LD = arm-none-eabi-ld
OBJCOPY = arm-none-eabi-objcopy

CFLAGS = -mthumb -mcpu=arm7tdmi -Oz -nostdlib -ffreestanding -Wall
LDFLAGS = -T gba_full.ld

all: pixel.gba

crt0.o: crt0.s
	$(CC) -c $< -o $@

main.o: main.c
	$(CC) $(CFLAGS) -c $< -o $@

pixel.elf: crt0.o main.o
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@

pixel.gba: pixel.elf elf2gba
	./elf2gba pixel.elf pixel.gba "PIXEL" "ABCD" "01"

elf2gba: elf2gba.c
	gcc -std=c99 -o elf2gba elf2gba.c

clean:
	rm -f *.o *.elf *.gba
