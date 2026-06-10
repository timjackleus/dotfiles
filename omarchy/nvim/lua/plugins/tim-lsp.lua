return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        intelephense = {
          settings = {
            intelephense = {
              stubs = {
                "bcmath",
                "bz2",
                "calendar",
                "Core",
                "curl",
                "zip",
                "zlib",
                "wordpress",
                "woocommerce",
                "acf-pro",
                "wordpress-globals",
                "wp-cli",
                "genesis",
                "polylang",
              },
              environment = {
                includePaths = "~/.composer/vendor/php-stubs/",
              },
              files = {
                maxSize = 5000000,
              },
            },
          },
        },
      },
    },
  },
}
