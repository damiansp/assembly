---
name: masm-to-arm64-macos
description: Translate x86-64 MASM (.asm) source files — such as the examples from "The Art of 64-Bit Assembly Language" — into AArch64 assembly (.s) that assembles and runs on Apple Silicon macOS. Use this whenever the user asks to port, translate, or convert a .asm/MASM file to ARM64, Apple Silicon, or macOS, or asks why a MASM example "doesn't work on my Mac." This is a semantic re-implementation, not a syntax swap — MASM targets Windows x86-64 and has no instruction-for-instruction ARM64 equivalent.
---

# MASM (x86-64) → AArch64 macOS Assembly

MASM and AArch64 are different instruction sets with different calling
conventions. Do not attempt a line-by-line mnemonic substitution — instead,
understand what each MASM routine *does* (inputs, outputs, control flow,
side effects) and re-express that behavior in idiomatic AArch64 for Apple's
ABI. Read `references/cheatsheet.md` before translating — it has the
directive, register-role, and calling-convention mapping tables this skill
depends on.

## Project layout

Each chapter directory has two sibling subdirectories:

```
NN_chaptername/
├── asm/         MASM sources (.asm) + any host .c/.cpp files
└── arm64_osx/   mirror of the above: translated .s files + copies of the
                 same host .c/.cpp files
```

`arm64_osx/` mirrors `asm/` file-for-file: every `.asm` source has a
same-basename `.s` translation, and every companion host `.c`/`.cpp` file is
copied over unchanged so each directory builds independently. Preserve this
1:1 mapping for every chapter, not just the one currently being worked on.

## Workflow

1. **Read the full context, not just the .asm file.** If there's a paired
   `.c`/`.cpp` host file in `asm/` (e.g. `extern "C"` declarations calling
   into the assembly), read it too — it defines the exact symbol names and
   call contract you must preserve on the ARM64 side.

2. **Inventory the source file**: entry point / `PUBLIC` symbols, `.DATA`
   contents and their declared types, every instruction used, and any
   MASM-specific macros (`INVOKE`, `PROC`/`ENDP` framing, etc.).

3. **Translate directives and layout** per
   `references/cheatsheet.md#directives` — `.CODE`/`.DATA` → `.text`/`.data`,
   `PROC`/`ENDP` → a label, no `END` needed. Remember: on macOS, every
   externally-visible C symbol gets a leading underscore (`main` → `_main`,
   `asm_func` → `_asm_func`) — this is what the linker/C runtime expects.

4. **Translate instructions by role, not by name.** Map each MASM register's
   *purpose* (return value, nth integer argument, scratch, frame pointer) to
   the AArch64 register that plays that role under the Apple ARM64 ABI — see
   `references/cheatsheet.md#calling-convention`. Build proper prologue/
   epilogue framing with `stp`/`ldp` (ARM64 has no `push`/`pop`), and keep
   `sp` 16-byte aligned at every public boundary.

5. **Watch the comment gotcha**: `;` is a MASM comment, but in GNU/Apple
   assembler syntax `;` separates statements on one line, not a comment.
   Use `//` or `/* */` in the translated `.s` file.

6. **Write the `.s` file into the sibling `arm64_osx/` directory**, same
   basename as the source (`asm/foo.asm` → `arm64_osx/foo.s`), creating
   `arm64_osx/` if it doesn't exist yet.

7. **Mirror any companion host files.** If `asm/` has a `.c`/`.cpp` host
   file not yet present in `arm64_osx/`, copy it over unchanged. If one
   already exists there and differs from `asm/`'s copy, that's a real
   discrepancy — don't silently overwrite; flag it to the user and confirm
   which side is authoritative before syncing.

8. **Verify it actually works** — don't just hand back text that looks
   plausible:
   ```
   .claude/skills/masm-to-arm64-macos/scripts/verify.sh arm64_osx/foo.s [arm64_osx/host.cpp]
   ```
   This assembles the `.s` with `clang`, and if a host file is given, links
   and runs the combined program. Fix and re-run until it passes. If there's
   no host file, at minimum confirm clean assembly.

9. **Report deviations**: call out anywhere you had to change behavior
   because a Windows-x64-specific construct (shadow space, `INVOKE` of a
   Win32 API, etc.) has no Apple ARM64 equivalent, and what you did instead.

## Reference

Full directive table, register-role mapping, Apple ARM64 calling convention
(argument/return registers, `x29`/`x30` framing, stack alignment, the
reserved `x18`), PC-relative global-data addressing (`adrp`/`add ...@PAGE`/
`@PAGEOFF`), and a worked example: `references/cheatsheet.md`.
