call plug#begin()
Plug 'https://github.com/joshdick/onedark.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'windwp/nvim-autopairs'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'AndrewRadev/tagalong.vim'
Plug 'pantharshit00/vim-prisma'
Plug 'vim-scripts/ShowPairs'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'luochen1990/rainbow'
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
Plug 'norcalli/nvim-colorizer.lua'
call plug#end()

lua << END
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.opt.laststatus = 3

require("bufferline").setup{
  highlights = {
    fill = {
      bg = '#23272e'
    }
  } 
}

require'colorizer'.setup()

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
    mappings = {
      list = {
        { key = "u", action = "dir_up",  },
    { key = "<C-e>", action = "close" }
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

require("nvim-autopairs").setup {}

require('nvim-treesitter.configs').setup {
  ensure_installed = { "c", "lua", "vim", "help", "typescript", "javascript", "tsx", "python", "toml", "json", "css", "html" },
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  },
  autotag = {
    enable = true
  }
}
require('lualine').setup({
  sections = {
    lualine_c = {
      {
          'windows',
          show_filename_only = false,
          path = 1,
          hide_filename_extension = false
      }
    }
  },
  extensions = {'nvim-tree'}
})
END

let g:rainbow_active = 0

" Два пробела вместо табуляции
set autoindent expandtab tabstop=2 shiftwidth=2

" Сворачивание
set foldmethod=syntax
set nofoldenable
set foldlevel=20

" Относительная нумеровка строк
set relativenumber
set number


"""REMAPS"""

" Сохранение на Ctrl + s
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

" Перемещение строки на Ctrl + Up / Ctrl + Down
imap <M-Up> <Esc>:move -2<CR>a
nmap <M-Up> :move -2<CR>
imap <M-Down> <Esc>:move +1<CR>a
nmap <M-Down> :move +1<CR>
vmap <M-Down> :m '>+1<CR>gv
vmap <M-UP> :m '<-2<CR>gv

" Копирование строк
vmap <C-Down> y<Up>pgv
vmap <C-Up> y<Up>pgv
nmap <C-Down> dd<Up>pp
imap <C-Down> <Esc>dd<Up>ppa
nmap <C-Up> dd<Up>p<Up>p
imap <C-Up> <Esc>dd<Up>p<Up>a

" Открыть конфиг
nmap <C-A-k> :tabnew<CR>:e ~/.config/nvim/init.vim<CR> 

nmap <c-e> :NvimTreeToggle<CR>

nnoremap tn :tabnew<CR>
nnoremap t<Right> :tabnext<CR>
nnoremap t<Left> :tabprev<CR>
nnoremap td :tabclose<CR>

nnoremap tt :split<CR>:term<CR>i

set splitbelow


"""THEME"""

let g:onedark_color_overrides = {
      \'background': { 'gui': '#23272e', 'cterm': '235', 'cterm16': '0' },
      \'red': { 'gui': '#ef596f', 'cterm': '204', 'cterm16': '1' },
      \'dark_red': { 'gui': '#BE5046', 'cterm': '196', 'cterm16': '9' },
      \'green': { 'gui': '#6fca78', 'cterm': '114', 'cterm16': '2' },
      \'yellow': { 'gui': '#e5bb70', 'cterm': '180', 'cterm16': '3' },
      \'dark_yellow': { 'gui': '#d19a66', 'cterm': '173', 'cterm16': '11' },
      \'blue': { 'gui': '#61afef', 'cterm': '39', 'cterm16': '4' },
      \'purple': { 'gui': '#d55fde', 'cterm': '170', 'cterm16': '5' },
      \'cyan': { 'gui': '#42b6c2', 'cterm': '38', 'cterm16': '6' },
      \'white': { 'gui': '#ABB2BF', 'cterm': '145', 'cterm16': '15' },
      \'black': { 'gui': '#23272e', 'cterm': '235', 'cterm16': '0' }
  \}

colorscheme onedark
syntax on
set t_Co=256
set cursorline 

let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }


"""CODE COMPLETION"""

set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes

" Показать подсказки на Ctrl + space
inoremap <silent><expr> <c-space> coc#refresh()

" Принять подсказку
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
"set statusline^=%{coc#status()}%{get(g:,'coc_git_status','')}%{get(b:,'coc_git_status','')}%{get(b:,'coc_git_blame','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

