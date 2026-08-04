# MASM (x86-64) → AArch64 macOS: reference tables

## Directives

| MASM (x86-64, Windows) | AArch64 (Apple `clang`/`as`) | Notes |
|---|---|---|
| `.CODE` | `.text` | |
| `.DATA` | `.data` | |
| `option casemap:none` | (nothing — GAS is already case-sensitive) | |
| `public foo` | `.global _foo` | leading underscore, see below |
| `foo PROC` ... `foo ENDP` | `_foo:` ... (falls through to `ret`) | PROC/ENDP is just framing; a label is enough |
| `END` (end of file) | (nothing — not needed) | |
| `;` comment | `//` comment or `/* */` | **`;` is a statement separator in GAS, not a comment** — this is the easiest mistake to make |
| `db "text", 0` | `.asciz "text"` | |
| `BYTE` / `WORD` / `DWORD` / `QWORD` | `.byte` / `.hword` / `.word` / `.quad` | |

## Symbol naming

Mach-O (macOS's object format) prepends an underscore to every external C
symbol. `extern "C" void asm_func(void);` in a `.cpp` host file resolves to
the linker symbol `_asm_func`. Your `.s` file must declare
`.global _asm_func` and define label `_asm_func:` — not `asm_func:`. Same
for `main` → `_main`.

## Registers: map by role, not by name

x86-64 and AArch64 register files don't correspond 1:1. Don't try to find
"the ARM64 RAX" — instead identify what role a register is playing at each
point in the MASM source (return value? which argument? frame pointer?
scratch?) and use whichever AArch64 register holds that role under the ABI
below.

AArch64 has 31 general-purpose 64-bit registers `X0`–`X30`, each with a
32-bit view `W0`–`W30`, plus `SP` (stack pointer, not a numbered GPR).

## Calling convention: Windows x64 vs Apple AArch64 (AAPCS64)

| | Windows x64 (MASM target) | Apple AArch64 |
|---|---|---|
| Integer args 1–4/8 | `RCX, RDX, R8, R9` | `X0..X7` |
| Return value | `RAX` | `X0` |
| Frame pointer | `RBP` (optional) | `X29` (conventionally maintained) |
| Return address | on stack (via `call`) | `X30` (link register, via `bl`) |
| Stack alignment at call | 16 bytes, **plus 32-byte "shadow space"** the caller reserves for the callee | 16 bytes, no shadow space |
| Push/pop | `push` / `pop` | no such instruction — use `stp`/`ldp` (store/load pair) with pre/post-indexing |
| Reserved register | — | **`X18` is reserved by the OS on Apple platforms — never use it as a general scratch register** |

### Prologue / epilogue pattern

MASM (non-leaf function, conceptually):
```asm
foo PROC
  push rbp
  mov  rbp, rsp
  ; ... body ...
  pop  rbp
  ret
foo ENDP
```

AArch64/Apple equivalent:
```asm
_foo:
  stp x29, x30, [sp, -16]!   // push frame pointer + link register, sp -= 16
  mov x29, sp
  // ... body ...
  ldp x29, x30, [sp], 16     // restore, sp += 16
  ret
```

A true leaf function (no calls out, no stack use) needs none of this —
just the body and `ret`, same as the MASM `asm_func` example in this repo:
```asm
_asm_func:
  ret
```

## Addressing global data (PC-relative, Apple syntax)

x86-64 can often load a 64-bit absolute address directly. AArch64 uses
PC-relative addressing in two steps, and Apple's assembler uses `@PAGE` /
`@PAGEOFF` (not the `:lo12:` syntax you'll see on Linux):

```asm
  .data
msg:
  .asciz "hello\n"

  .text
  .global _main
_main:
  stp x29, x30, [sp, -16]!
  mov x29, sp

  adrp x0, msg@PAGE
  add  x0, x0, msg@PAGEOFF
  bl   _printf

  mov  w0, 0
  ldp  x29, x30, [sp], 16
  ret
```

Calling a variadic C function like `printf` follows the normal AAPCS64
integer-argument rules for the fixed args; `X0` holds the format string
pointer above.

## Verification

Use `scripts/verify.sh <file.s> [host.cpp]` from this skill directory.
It runs, at minimum:
```sh
clang -c file.s -o /tmp/file.o
```
and, when a host file is supplied, a full link + run:
```sh
clang host.cpp file.s -o /tmp/a.out && /tmp/a.out
```
Treat a clean assemble as necessary but not sufficient — prefer the linked
run whenever a host file exists, since it also validates the ABI/calling
convention, not just the syntax.
