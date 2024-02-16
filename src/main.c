#include <stdint.h>
#include <gpio_port.h>

#define PIN 3

int main() {
	gpio_port0->pcntr1 |= (1 << PIN);
	gpio_port0->pcntr1 |= (1 << 4);
	while (1) {
		gpio_port0->pcntr1 |= (1 << (16 + PIN));
		for (volatile int i = 0; i < 2000000UL; i++) {}
		gpio_port0->pcntr1 &= ~(1 << (16 + PIN));
		for (volatile int i = 0; i < 2000000UL; i++) {}
	}

	return 0;
}
