-- Options ====================================================================
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.scrolloff = 999
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = false
vim.opt.smarttab = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false
vim.opt.list = true
vim.opt.listchars = {tab = '..', trail = '_', extends = '>', precedes = '<', nbsp = '~'}
vim.opt.timeoutlen = 500
vim.opt.undofile = true
vim.opt.laststatus = 3
vim.opt.shortmess:append('Ic')
vim.opt.lazyredraw = true
vim.opt.more = false
vim.opt.updatetime = 250
vim.opt.maxmempattern = 2000

-- Mappings ===================================================================
vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.keymap.set('n', '<Space>', '<Nop>')
vim.keymap.set('n', '<Down>', 'gj')
vim.keymap.set('n', '<Up>', 'gk')
vim.keymap.set('n', 'dd', '"_dd')
vim.keymap.set('n', 'd', '"_d')
vim.keymap.set('n', 'c', '"_c')
vim.keymap.set({'n', 'v'}, '<Del>', '"_x')
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'JK', '<Esc>')
vim.keymap.set('n', '<Localleader>v', ':e $MYVIMRC<CR>', {silent = true})
vim.keymap.set('n', '<Localleader>u', ':so $MYVIMRC<CR>', {silent = true})
vim.keymap.set('n', '<leader>cd', ':CdCurrent<CR>', {silent = true})
vim.keymap.set('n', '<Leader>n', ':bn<CR>', {silent = true})
vim.keymap.set('n', '<Leader>w', ':w!<CR>', {silent = true})
vim.keymap.set('n', '<Leader>q', ':q<CR>', {silent = true})
vim.keymap.set('n', '<Leader>x', ':bd!<CR>', {silent = true})
vim.keymap.set('n', '<Leader>v', ':aboveleft vs<CR><C-w><C-w>', {silent = true})
vim.keymap.set('n', '<Leader>h', ':botright split<CR><C-w><C-w>', {silent = true})
vim.keymap.set('n', '<Leader>t', ':bot term<CR><C-\\><C-n>:resize 10<CR>i', {silent = true})
vim.keymap.set('t', '<C-q>', '<C-\\><C-n>', {silent = true})
vim.keymap.set('n', '<Leader>m', ':w<CR>:!make<CR>', {silent = true})
vim.keymap.set('n', '<C-l>', ':nohlsearch<CR>', {silent = true})
vim.keymap.set('n', '<Leader>z', function() vim.wo.wrap = not vim.wo.wrap end)
vim.keymap.set('n', '<C-k>', ':m .-2<CR>==', {silent = true})
vim.keymap.set('n', '<C-j>', ':m .+1<CR>==', {silent = true})
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv", {silent = true})
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv", {silent = true})
vim.keymap.set('n', '<Leader>s', ':%s/')
vim.keymap.set('n', '<Leader>r', ':%s/<C-r><C-w>//g<Left><Left>')
vim.keymap.set('n', '<Leader>g', ':g/<C-r><C-w>/')
vim.keymap.set('c', '<Down>', function() return vim.fn.pumvisible() == 1 and '<C-n>' or '<Down>' end, {expr = true})
vim.keymap.set('c', '<Up>', function() return vim.fn.pumvisible() == 1 and '<C-p>' or '<Up>' end, {expr = true})
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>')
vim.keymap.set('n', '<Leader>i', 'mK')
vim.keymap.set('n', '<Leader>o', '`K')
vim.keymap.set('n', "<leader><leader>c", "<cmd>ToggleQuickfix<CR>", {})

-- Commandes perso ============================================================
vim.api.nvim_create_user_command('CdCurrent', function()
    local path = vim.api.nvim_buf_get_name(0)
    if path ~= '' and vim.bo.buftype == '' and not path:find('^term://') then
        local dir = vim.fn.fnamemodify(path, ':p:h')
        if vim.fn.isdirectory(dir) == 1 then
            vim.api.nvim_set_current_dir(dir)
            print(dir)
        end
    else
        print('Impossible de changer de répertoire pour ce buffer.')
    end
end, {})

vim.api.nvim_create_user_command('ToggleQuickfix', function()
    local qf_exists = false
    for _, win in ipairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
            qf_exists = true
            break
        end
    end
    if qf_exists then
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end, {})

-- Autocommands ===============================================================
-- terminal
vim.api.nvim_create_autocmd('WinEnter', {
    callback = function()
        if vim.bo.buftype == 'terminal' then
            local mode = vim.api.nvim_get_mode().mode
            if mode ~= 'i' and mode ~= 't' then vim.cmd('startinsert') end
        end
    end
})

-- sessions
vim.api.nvim_create_autocmd('BufWinLeave', {pattern = '?*', command = 'silent! mkview'})
vim.api.nvim_create_autocmd('BufWinEnter', {pattern = '?*', command = 'silent! loadview'})

-- number
vim.api.nvim_create_autocmd({'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter'}, {
    pattern = '*',
    callback = function()
        if vim.wo.number and vim.api.nvim_get_mode().mode ~= 'i' then vim.wo.relativenumber = true end
    end
})

vim.api.nvim_create_autocmd({'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave'}, {
    pattern = '*',
    callback = function() if vim.wo.number then vim.wo.relativenumber = false end end
})

-- Texlab
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex', 'plaintex', 'bib'},
    callback = function(args)
        vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        vim.lsp.start({
            name = 'texlab',
            cmd = {'texlab'},
            root_dir = vim.fs.root(args.buf, {'Makefile', 'main.tex', '.git'}) or vim.fn.getcwd(),
            settings = {
                texlab = {
                    chktex = {onOpenAndSave = false},
                    diagnosticsDelay = 200,
                    build = {
                        executable = 'latexmk',
                        args = {'-pdf', '-interaction=nonstopmode', '-synctex=1', '%f'},
                        onSave = false
                    },
                }
            }
        }, {bufnr = args.buf})
    end
})

-- help keymap
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'help',
    callback = function(args)
        vim.keymap.set('n', '<CR>', '<C-]>', {buffer = args.buf, silent = true})
        vim.keymap.set('n', '<BS>', '<C-t>', {buffer = args.buf, silent = true})
    end
})

-- Mini =======================================================================
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'

if not vim.loop.fs_stat(mini_path) then
    local clone_cmd = {'git', 'clone', '--filter=blob:none', 'https://github.com/nvim-mini/mini.nvim', mini_path}
    vim.fn.system(clone_cmd)
    vim.cmd('packadd mini.nvim | helptags ALL')
end

require('mini.deps').setup({path = {package = path_package}})
require('mini.completion').setup()
require('mini.basics').setup()
require('mini.pairs').setup()
require('mini.surround').setup()
require('mini.ai').setup()

require('mini.comment').setup()
vim.keymap.set({'n', 'v'}, '<Leader>/', 'gcc<ESC>', {remap = true})

local statusline = require('mini.statusline')
local mode_map = {
    n = 'N',
    i = 'I',
    v = 'V',
    V = 'V-L',
    ['\22'] = 'V-B',
    c = 'C',
    s = 'S',
    S = 'S-L',
    ['\19'] = 'S-B',
    R = 'R',
    t = 'T'
}

statusline.setup({
    set_vim_settings = true,
    use_icons = false,
    content = {
        active = function()
            local mode_code = vim.api.nvim_get_mode().mode
            local mode_str = mode_map[mode_code] or mode_code:upper()
            local _, mode_hl = statusline.section_mode({})
            local filename = statusline.section_filename({})
            local filetype = vim.bo.filetype ~= '' and vim.bo.filetype or '-'
            local line = vim.fn.line('.')
            local col = vim.fn.col('.')
            local total_lines = vim.fn.line('$')
            local pct = math.floor((line / math.max(total_lines, 1)) * 100)
            local location = pct .. '%%' .. ' ' .. line .. ':' .. col
            return statusline.combine_groups({
                {hl = mode_hl, strings = {mode_str}}, {hl = 'MiniStatuslineFilename', strings = {filename}}, '%<', '%=',
                {hl = 'MiniStatuslineFileinfo', strings = {filetype}}, {hl = mode_hl, strings = {location}}
            })
        end
    }
})

-- Plugins ============================================================================================
local minideps = require('mini.deps')

-- Conform
minideps.add({source = 'stevearc/conform.nvim'})
require('conform').setup({
    formatters_by_ft = {
        lua = {'lua-format'},
        tex = {'latexindent'},
        javascript = {'prettier'},
        typescript = {'prettier'},
        html = {'prettier'},
        css = {'prettier'},
        json = {'prettier'},
        yaml = {'prettier'},
        markdown = {'prettier'},
        make = {'mbake'}
    },
    formatters = {
        ['lua-format'] = {prepend_args = {'--column-limit=120'}},
        ['latexindent'] = {args = {'-m', '-c', '/tmp/', '-'}},
        ['mbake'] = {command = "mbake", args = {'format', '$FILENAME'}, stdin = false}
    }
})
vim.api.nvim_create_user_command('Format', function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {['start'] = {args.line1, 0}, ['end'] = {args.line2, string.len(end_line)}}
    end
    require('conform').format({async = true, lsp_fallback = true, range = range})
end, {range = true})

vim.keymap.set({'n', 'v'}, '<Leader>f', ':Format<CR>', {silent = true})

-- Vimtex
minideps.add({source = 'lervag/vimtex', checkout = 'v2.15'})
vim.g.vimtex_view_general_viewer = 'zathura'
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_compiler_latexmk = {
    aux_dir = '',
    out_dir = '',
    callback = 1,
    continuous = 1,
    executable = 'latexmk',
    hooks = {},
    options = {'-verbose', '-file-line-error', '-synctex=1', '-interaction=nonstopmode'}
}
vim.g.vimtex_compiler_latexmk_engines = {
    ['_'] = '-pdf',
    pdflatex = '-pdf',
    lualatex = '-lualatex',
    xelatex = '-xelatex'
}

-- fzf-lua
minideps.add({source = 'ibhagwan/fzf-lua'})
local fzf = require('fzf-lua')
fzf.setup({
    winopts = {preview = {default = 'bat', layout = 'flex', horizontal = 'right:40%'}},
    keymap = {
        builtin = {['<C-/>'] = 'toggle-preview', ['<C-p>'] = 'toggle-preview'},
        fzf = {['shift-down'] = 'preview-page-down', ['shift-up'] = 'preview-page-up'}
    },
    files = {cmd = 'ag --hidden --ignore .git -g ""'},
    grep = {cmd = 'ag --vimgrep'}
})
vim.keymap.set('n', '<Leader><Leader>f', fzf.files)
vim.keymap.set('n', '<Leader><Leader>m', fzf.oldfiles)
vim.keymap.set('n', '<Leader><Leader>b', fzf.buffers)
vim.keymap.set('n', '<Leader><Leader>l', function() fzf.lines({winopts = {preview = {hidden = 'hidden'}}}) end)
vim.keymap.set('n', '<Leader><Leader>n', fzf.command_history)
vim.keymap.set('n', '<Leader><Leader>p', function() fzf.registers({winopts = {preview = {hidden = 'hidden'}}}) end)
vim.keymap.set('n', '<Leader><Leader>o', fzf.marks)

-- undotree
minideps.add({source = 'mbbill/undotree'})
vim.keymap.set('n', '<Leader>u', '<cmd>UndotreeToggle<CR>')

-- vim-visual-multi
minideps.add({source = 'mg979/vim-visual-multi'})

-- colorscheme
minideps.add('folke/tokyonight.nvim')
require('tokyonight').setup({style = 'night', transparent = false})
vim.cmd.colorscheme('tokyonight')
vim.api.nvim_set_hl(0, 'WinSeparator', {fg = '#7aa2f7', bold = true})
vim.api.nvim_set_hl(0, "Visual", {bg = "#d19a66", fg = "#282c34"})

-- oil.nvim
minideps.add('stevearc/oil.nvim')
require('oil').setup({
    keymaps = {
        ["gd"] = {
            desc = "Toggle file detail view",
            callback = function()
                detail = not detail
                if detail then
                    require("oil").set_columns({"icon", "size", "mtime"})
                else
                    require("oil").set_columns({"icon"})
                end
            end
        }
    },
    view_options = {show_hidden = true}
})
vim.keymap.set('n', '<Leader>e', ':Oil<CR>', {silent = true})

-- marks.nvim
minideps.add('chentoast/marks.nvim')
require('marks').setup({
    default_mappings = true,
    builtin_marks = {".", "<", ">", "^"},
    cyclic = true,
    force_write_shada = false,
    refresh_interval = 250,
    sign_priority = {lower = 10, upper = 15, builtin = 8, bookmark = 20},
    excluded_filetypes = {"qf", "dashboard", "fugitive"}
})

-- sudo.nvim
minideps.add({source = 'denialofsandwich/sudo.nvim', depends = {'MunifTanjim/nui.nvim'}})
require('sudo').setup({commands = true})

-- vim-cool
minideps.add({source = 'romainl/vim-cool'})
