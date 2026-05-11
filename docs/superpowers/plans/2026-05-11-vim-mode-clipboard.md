# Vim Mode Clipboard Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Update `vim_mode.fish` to include system clipboard bindings for yank and paste.

**Architecture:** Add specific `bind` calls for `visual` and `default` modes within the `vim_mode` function.

**Tech Stack:** Fish Shell, xsel (system clipboard utility).

---

### Task 1: Update `vim_mode.fish`

**Files:**
- Modify: `functions/vim_mode.fish`

- [ ] **Step 1: Add clipboard bindings to the function**

Add the following lines before the `end` of the function:
```fish
    # Clipboard integration
    bind -M visual y fish_clipboard_copy end-selection repaint-mode
    bind -M default p fish_clipboard_paste
    bind -M default P fish_clipboard_paste
    bind -M default yy fish_clipboard_copy
```

- [ ] **Step 2: Verify syntax**

Run: `fish -n functions/vim_mode.fish`
Expected: No output (success).

- [ ] **Step 3: Commit changes**

```bash
git add functions/vim_mode.fish docs/superpowers/specs/2026-05-11-vim-mode-clipboard-design.md
git commit -m "feat(fish): add clipboard integration to vim_mode"
```

---

### Task 2: Verification

- [ ] **Step 1: Test bindings in a subshell**

Since I cannot interactively test the clipboard in this environment easily, I will verify the bindings are registered correctly.
Run: `fish -c "source functions/vim_mode.fish; vim_mode; bind -M visual y; bind -M default p; bind -M default yy"`
Expected: Output showing the new bindings.
