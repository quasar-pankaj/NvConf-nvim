return {
   'akinsho/toggleterm.nvim',
   version = "*",
   lazy = true,
   keys = {
      { "<C-t>", "<cmd>Toggleterm<cr>", desc = "Open terminal" },
   },
   config = function ()
      require("toggleterm").setup {
         -- size can be a number or function which is passed the current terminal
         size = function(term)
            if term.direction == "horizontal" then
               return 15
            elseif term.direction == "vertical" then
               return vim.o.columns * 0.2
            end
         end,
         open_mapping = [[<c-t>]],
         -- on_create = fun(t: Terminal), -- function to run when the terminal is first created
         -- on_open = fun(t: Terminal), -- function to run when the terminal opens
         -- on_close = fun(t: Terminal), -- function to run when the terminal closes
         -- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
         -- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
         -- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
         hide_numbers = true, -- hide the number column in toggleterm buffers
         shade_filetypes = {},
         autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
         highlights = {
            NormalFloat = { link = 'NormalFloat', },
            FloatBorder = { link = 'FloatBorder' },
         },
         shade_terminals = false, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
         -- shading_factor = '<number>', -- the percentage by which to lighten terminal background, default: -30 (gets multiplied by -3 if background is light)
         start_in_insert = true,
         insert_mappings = true, -- whether or not the open mapping applies in insert mode
         terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
         persist_size = true,
         persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
         -- direction = 'vertical' | 'horizontal' | 'tab' | 'float',
         direction = 'float',
         close_on_exit = true, -- close the terminal window when the process exits
         shell = vim.o.shell,
         auto_scroll = true, -- automatically scroll to the bottom on terminal output
         float_opts = {
            -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
            border = 'curved',
            width = 120,
            height = 25,
            -- winblend = 3,
            -- zindex = <value>,
         },
         winbar = {
            enabled = true,
            name_formatter = function(term)
               return term.name
            end
         }
      }
   end
}
