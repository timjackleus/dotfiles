return {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = "mason.nvim",
  cmd = { "DapInstall", "DapUninstall" },
  opts = {
    automatic_installation = true,

    -- You can provide additional configuration to the handlers,
    -- see mason-nvim-dap README for more information
    handlers = {},

    ensure_installed = {
      "bash-debug-adapter",
      "chrome-debug-adapter",
      "firefox-debug-adapter",
      "go-debug-adapter",
      "js-debug-adapter",
      "netcoredbg",
      "node-debug2-adapter",
    },
  },
}
