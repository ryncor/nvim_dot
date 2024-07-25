-- Enable line numbers
vim.opt.number = true

-- Enable relative line numbers
vim.opt.relativenumber = true

-- Enable mouse support
vim.o.mouse = "a"

-- Enable auto-indentation
vim.o.autoindent = true
vim.o.smartindent = true

-- Enable clipboard integration
vim.o.clipboard = "unnamedplus"

-- Enable persistent undo
vim.o.undofile = true

-- Set line wrapping
-- vim.o.wrap = false

-- tabs
vim.opt.shiftwidth = 4      -- Size of an indent
vim.opt.tabstop = 4         -- Number of spaces tabs count for

-- search
vim.opt.ignorecase = true   -- Ignore case in search patterns
vim.opt.smartcase = true    -- Override ignorecase if search contains capitals
vim.opt.incsearch = true    -- Incremental search
vim.opt.hlsearch = true     -- Highlight search matches

vim.g.mapleader = ' ' 

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

 { "folke/tokyonight.nvim",
  	transparent = true,
 },


  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "c", "lua", "python", "javascript" },
        highlight = {
          enable = true,              -- false will disable the whole extension
          additional_vim_regex_highlighting = false,
        },
      }
    end
  },

  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {"pyright"} -- Specify LSPs to install
      })
    end
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
	      local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local opts = { noremap=true, silent=true }
        
        buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
        buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        buf_set_keymap('n', '<leader>p', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', '<leader>n', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
		buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      end

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      })
    end
  }
})

-- Configure LSP diagnostics to disable warning signs
vim.diagnostic.config({
  signs = false,
  virtual_text = true, -- or false, depending on your preference
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})


vim.cmd[[colorscheme tokyonight]]
vim.cmd("highlight Normal guibg=none")
vim.cmd("highlight NonText guibg=none")
vim.cmd("highlight LineNr guibg=none")
vim.cmd("highlight Folded guibg=none")
vim.cmd("highlight EndOfBuffer guibg=none")

