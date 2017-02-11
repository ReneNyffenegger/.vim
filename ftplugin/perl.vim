call TQ84_log_indent('ftplugin/vim.vim')

nnoremap <buffer> ! :execute "echo(tq84#SystemInDir(expand('%:p:h'), 'perl ' . expand('%:t')))"<CR>

nnoremap <buffer> ,# :%s/# \+\([{}]\)/#_\1/<CR>

call TQ84_log_dedent()
