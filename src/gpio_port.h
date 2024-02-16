#pragma once

#include <stdint.h>

struct gpio_port {
	union {
		u32 pcntr1;
		struct {
			u16 podr;
			u16 pdr;
		};
	};
	union {
		u32 pcntr2;
		struct {
			u16 eidr;
			u16 pidr;
		};
	};
	union {
		u32 pcntr3;
		struct {
			u16 porr;
			u16 posr;
		};
	};
	union {
		u32 pcntr4;
		struct {
			u16 eorr;
			u16 eosr;
		};
	};
};

extern volatile struct gpio_port *gpio_port0;
extern volatile struct gpio_port *gpio_port1;
extern volatile struct gpio_port *gpio_port2;
extern volatile struct gpio_port *gpio_port3;
extern volatile struct gpio_port *gpio_port4;
extern volatile struct gpio_port *gpio_port5;
extern volatile struct gpio_port *gpio_port6;
extern volatile struct gpio_port *gpio_port7;
extern volatile struct gpio_port *gpio_port8;
extern volatile struct gpio_port *gpio_port9;

_Static_assert(__builtin_offsetof(struct gpio_port, pcntr1) == 0, "");
_Static_assert(__builtin_offsetof(struct gpio_port, podr)   == 0, "");
_Static_assert(__builtin_offsetof(struct gpio_port, pdr)    == 2, "");
_Static_assert(__builtin_offsetof(struct gpio_port, pcntr2) == 4, "");
_Static_assert(__builtin_offsetof(struct gpio_port, eidr)   == 4, "");
_Static_assert(__builtin_offsetof(struct gpio_port, pidr)   == 6, "");
_Static_assert(__builtin_offsetof(struct gpio_port, pcntr3) == 8, "");
_Static_assert(__builtin_offsetof(struct gpio_port, porr)   == 8, "");
_Static_assert(__builtin_offsetof(struct gpio_port, posr)   == 10, "");
_Static_assert(__builtin_offsetof(struct gpio_port, pcntr4) == 12, "");
_Static_assert(__builtin_offsetof(struct gpio_port, eorr)   == 12, "");
_Static_assert(__builtin_offsetof(struct gpio_port, eosr)   == 14, "");
_Static_assert(sizeof(struct gpio_port) == 16, "");
