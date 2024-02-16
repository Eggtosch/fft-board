FLASH_IMAGE_START = 0x4000;
FLASH_START = 0x00000000;
FLASH_LENGTH = 0x40000;

RAM_START = 0x20000000;
RAM_LENGTH = 0x8000;

MEMORY {
	FLASH(rx)      : ORIGIN = FLASH_IMAGE_START, LENGTH = FLASH_LENGTH - FLASH_IMAGE_START
	RAM(rwx)       : ORIGIN = RAM_START,         LENGTH = RAM_LENGTH
}

_estack = ORIGIN(RAM) + LENGTH(RAM);
ENTRY(reset_handler);

SECTIONS {
	.vector_table : {
		. = ALIGN(4);
		KEEP(*(.vector_table));
		. = ALIGN(4);
	} >FLASH

	.text : {
		. = ALIGN(4);
		_stext = .;
		*(.text);
		*(.text*);
		. = ALIGN(4);
		_etext = .;
	} >FLASH

	_sidata = .;
	.data : AT(_sidata) {
		. = ALIGN(4);
		_sdata = .;
		*(.data);
		*(.data*);
		. = ALIGN(4);
		_edata = .;
	} >RAM

	.bss : {
		. = ALIGN(4);
		_sbss = .;
		*(.bss);
		*(.bss*);
		. = ALIGN(4);
		_ebss = .;
	} >RAM
}
