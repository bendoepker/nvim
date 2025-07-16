require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here 
  -- with the ones you want to install
  ensure_installed = {
        'clangd', --dependency: unzip       -- C, C++, Fortran, etc.
        'cmake',                            -- Cmake
        'zls',                              -- Zig LSP
        'rust_analyzer',                    -- Rust LSP
        'mesonlsp',                         -- Meson LSP
        'pylsp',                            -- Python LSP
        'ts_ls',                            -- Typescript LSP (Requires NPM)
        'lua_ls',                           -- Lua LSP
    },

  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
  automatic_installation = true,
})

require('mason-lspconfig').setup({
  handlers = {
    -- this first function is the "default handler"
    -- it applies to every language server without a "custom handler"
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,

    -- this is the "custom handler" for `example_server`
    --example_server = function()
      --require('lspconfig').example_server.setup({
        ---
        -- in here you can add your own
        -- custom configuration
        ---
      --})
    --end,
  },
})
