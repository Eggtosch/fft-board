#pragma once

typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;
typedef unsigned long long u64;

_Static_assert(sizeof(u8) == 1, "sizeof(u8) != 1");
_Static_assert(sizeof(u16) == 2, "sizeof(u16) != 2");
_Static_assert(sizeof(u32) == 4, "sizeof(u32) != 4");
_Static_assert(sizeof(u64) == 8, "sizeof(u64) != 8");
