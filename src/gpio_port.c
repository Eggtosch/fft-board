#include <gpio_port.h>

volatile struct gpio_port *gpio_port0 = (volatile struct gpio_port*) 0x40040000UL;
volatile struct gpio_port *gpio_port1 = (volatile struct gpio_port*) 0x40040020UL;
volatile struct gpio_port *gpio_port2 = (volatile struct gpio_port*) 0x40040040UL;
volatile struct gpio_port *gpio_port3 = (volatile struct gpio_port*) 0x40040060UL;
volatile struct gpio_port *gpio_port4 = (volatile struct gpio_port*) 0x40040080UL;
volatile struct gpio_port *gpio_port5 = (volatile struct gpio_port*) 0x400400a0UL;
volatile struct gpio_port *gpio_port6 = (volatile struct gpio_port*) 0x400400c0UL;
volatile struct gpio_port *gpio_port7 = (volatile struct gpio_port*) 0x400400e0UL;
volatile struct gpio_port *gpio_port8 = (volatile struct gpio_port*) 0x40040100UL;
volatile struct gpio_port *gpio_port9 = (volatile struct gpio_port*) 0x40040120UL;
