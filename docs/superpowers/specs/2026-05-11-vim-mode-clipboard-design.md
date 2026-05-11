# Clipboard Integration for Fish Vi-Mode Design

> **For agentic workers:** REQUIRED: Use superpowers:writing-plans to create an implementation plan for this spec.

**Goal:** Add Vim-like clipboard integration to the `vim_mode` function in fish shell, allowing 'y' and 'p' to interact with the system clipboard.

**Architecture:**
The implementation will utilize fish's built-in `fish_clipboard_copy` and `fish_clipboard_paste` functions. These functions are robust as they handle multiple clipboard backends (xsel, xclip, wl-copy, etc.) and terminal sequences (OSC 52).

**Key Bindings:**
- **Visual Mode**: `y` will copy the current selection to the system clipboard and return to default mode.
- **Normal Mode (Default)**: `yy` will copy the entire command line to the system clipboard.
- **Normal Mode (Default)**: `p` and `P` will paste from the system clipboard.

**Constraints:**
- Must not break `y` as an operator prefix (e.g., `yw` should still work, yanking to the internal killring).
- Must adhere to the existing style in `functions/vim_mode.fish`.
- Must verify that `xsel` (detected earlier) is used correctly by fish's built-in functions.
