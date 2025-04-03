return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      on_colors = function(colors)
        colors.border = "#565f89"
      end,
    },
  },
}
