local present, treesitter = pcall(require, "treesitter")

if not present then
   return
end
treesitter.setup {
  ensure_installed = "maintained",
  context_commentstring = {
    enable = true
  },
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  }
}
