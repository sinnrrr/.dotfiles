return {
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<C-q>", "<Cmd>bd %<CR>", desc = "Delete Current Buffer" },
      { "<C-S-q>", "<Cmd>e #<CR>", desc = "Undo Last Buffer Delete" },
      { "<C-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<C-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "<C-S-h>", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "<C-S-l>", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    },
  },
}
