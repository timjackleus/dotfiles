local present, neogit = pcall(require, "neogit")

if not present then
   return
end

neogit.setup {
  commit_popup = {
      kind = "split",
  },
  kind = 'vsplit',
}
