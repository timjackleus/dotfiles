local present, neotree = pcall(require, "neo-tree")

if not present then
  return
end

neotree.setup({
  window = {
    position = "float",
    mappings = {
      ["l"] = "open",
      ["h"] = "open",
      ["<c-s>"] = "open_split",
      ["<c-v>"] = "open_vsplit",
    },
  },
  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_hidden = false,
    },
  },
})
