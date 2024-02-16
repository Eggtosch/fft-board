BIN_DIR := bin

CROSS_COMPILER := cc
CROSS_COMPILER_BUILDER := tools/build-cross-compiler.sh

BOSSA_DIR    := bossa
BOSSAC_BUILD := $(BOSSA_DIR)/bin/bossac
BOSSAC       := $(CROSS_COMPILER)/bin/bossac

BOSSA_GIT_URL := https://github.com/arduino/BOSSA.git
BOSSA_PATCH_FILE := tools/0001-Update-WXVERSION-to-correct-local-version.patch

FW_BIN := $(BIN_DIR)/fw.bin
FW_ELF := $(BIN_DIR)/fw.elf

CC       := arm-none-eabi-gcc
HW_FLAGS := -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16 -mthumb
C_FLAGS  := -Os -Isrc/
LD_FLAGS := -nostdlib -lgcc -Tra.ld

C_SOURCES   := $(wildcard src/*.c)
ASM_SOURCES := $(wildcard src/*.s)
OBJECTS     := $(C_SOURCES:%.c=%.o) $(ASM_SOURCES:%.s=%.o)

all: build

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

$(BOSSAC): | $(BIN_DIR)
	git clone $(BOSSA_GIT_URL) $(BOSSA_DIR)
	git -C $(BOSSA_DIR) am < $(BOSSA_PATCH_FILE)
	make -C $(BOSSA_DIR) bossac -j16
	cp $(BOSSAC_BUILD) $(BOSSAC)
	rm -rf $(BOSSA_DIR)

$(CROSS_COMPILER): | $(BIN_DIR)
	BINUTILS_VERSION=2.41 GCC_VERSION=13.2.0 INSTALL_PATH=$(CROSS_COMPILER) TARGET_ARCH=arm-none-eabi $(CROSS_COMPILER_BUILDER)

%.o: %.s
	$(CC) -c $(HW_FLAGS) $< -o $@

%.o: %.c
	$(CC) -c $(HW_FLAGS) $(C_FLAGS) $< -o $@

$(FW_ELF): $(OBJECTS) | $(BIN_DIR) $(CROSS_COMPILER)
	$(CC) $(OBJECTS) $(HW_FLAGS) $(LD_FLAGS) -o $(FW_ELF)

$(FW_BIN): $(FW_ELF)
	arm-none-eabi-objcopy -O binary -j .text -j .data $(FW_ELF) $(FW_BIN)

build: $(FW_BIN)

flash: build | $(BOSSAC)
	-$(BOSSAC) --arduino-erase
	$(BOSSAC) --port=ttyACM0 --usb-port=1 --erase --write $(FW_BIN) --reset

clean:
	rm -rf $(BOSSA_DIR)
	rm -rf $(BIN_DIR)
	rm -rf $(OBJECTS)

really-clean-all: clean
	rm -rf $(CROSS_COMPILER)
