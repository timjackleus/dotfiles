local present, neogit = pcall(require, "neogit")

if not present then
  return
end

local options = {
  commit_popup = {
		kind = "split",
  },
  kind = 'vsplit',
}

neogit.setup(options)
