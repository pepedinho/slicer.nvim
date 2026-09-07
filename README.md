# 🔪 slicer.nvim

A gentle, non-punitive time-slicing timer plugin for Neovim designed to help you stay aware of time without breaking your flow.

> **Why Slicer?**  
> When coding, it is easy to get hyper-focused, forget to eat, and lose track of time for loved ones. **slicer.nvim** sits right in your statusline, giving you an at-a-glance progression gauge while letting you easily extend or pause sessions whenever you need to.

---

## ✨ Features

- **Automatic Lualine Integration:** Zero manual statusline configuration needed. Slicer automatically injects its component into Lualine upon setup.
- **Visual Progress Gauge:** At-a-glance progress bar (`[████░░░░]`) displaying remaining slice time.
- **Gentle & Non-punitive:** Extend or pause active slices on the fly—no forced lockouts.
- **Asynchronous & Lightweight:** Built on top of `vim.uv` (libuv timers) to guarantee zero performance impact.
- **Customizable Appearance:** Full control over colors, typography (bold/regular), gauge width, icons, and notification preferences.

---

## 📦 Installation

Install **slicer.nvim** using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "pepedinho/slicer.nvim",
  config = function()
    require("slicer").setup({
      work_duration = 25 * 60, -- 25 minutes
      break_duration = 5 * 60,  -- 5 minutes
      extend_amount = 10 * 60,  -- +10 minutes
      gauge_width = 8,
      bar_color = "#a682ff",
      bar_bold = true,
    })

    -- Keymaps
    vim.keymap.set("n", "<leader>ss", "<cmd>SlicerStart<cr>", { desc = "Slicer: Start" })
    vim.keymap.set("n", "<leader>se", "<cmd>SlicerExtend<cr>", { desc = "Slicer: Extend (+10m)" })
    vim.keymap.set("n", "<leader>sp", "<cmd>SlicerPause<cr>", { desc = "Slicer: Pause/Resume" })
    vim.keymap.set("n", "<leader>sx", "<cmd>SlicerStop<cr>", { desc = "Slicer: Stop" })
  end,
}
```

---

## ⚙️ Configuration Options

Default settings for `slicer.nvim`:

```lua
require("slicer").setup({
  work_duration = 25 * 60, -- Work slice duration in seconds (25 mins)
  break_duration = 5 * 60,  -- Break duration in seconds (5 mins)
  extend_amount = 10 * 60,  -- Extension time added in seconds (10 mins)
  gauge_width = 8,         -- Width of the progress gauge in characters
  icons = {
    work = "󰔟 ",
    break_time = "󰒲 ",
    paused = "󰏤 ",
    filled = "█",
    empty = "░",
  },
  notifications = {
    enabled = true,
    title = "Slicer",
  },
  bar_color = "#FFB86C",    -- Foreground color of the statusline gauge
  bar_bold = true,          -- Toggle bold formatting for the gauge text
})
```

---

## 🚀 User Commands

| Command | Description |
| :--- | :--- |
| `:SlicerStart [min]` | Start a new work slice (uses `work_duration` if no duration is specified). |
| `:SlicerExtend [min]` | Extend the current slice (adds `extend_amount` if no duration is specified). |
| `:SlicerPause` | Toggle pause/resume mode on the active slice. |
| `:SlicerStop` | Stop the active timer and clear the statusline gauge. |

---

## 📄 License

MIT © [pepedinho](https://github.com/pepedinho)
