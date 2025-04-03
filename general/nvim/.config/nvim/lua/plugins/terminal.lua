return {
  {
    "folke/snacks.nvim",
    keys = {
      { [[<C-\>]], "<Cmd>lua Snacks.terminal.toggle()<CR>", desc = "Toggle Terminal", mode = { "n", "t" } },
    },
    opts = {
      terminal = {
        win = {
          wo = {
            winbar = "",
          },
        },
      },
    },
  },
}
