""""" Vimwiki """""""""""""""""
" registered extensions (global)
let g:vimwiki_ext2syntax = {'.vwmd': 'markdown'}

let personal_wiki = {}
let personal_wiki.path = '~/vimwiki/'
let personal_wiki.syntax = 'markdown'
let personal_wiki.ext = '.vwmd'

let sandstorm_wiki = {}
let sandstorm_wiki.path = '~/vw_sandstorm'
let sandstorm_wiki.syntax = 'markdown'
let sandstorm_wiki.ext = '.vwmd'

let g:vimwiki_list = [personal_wiki, sandstorm_wiki]

nmap <leader>tt <Plug>VimwikiToggleListItem

"""" vim notational """""""""
let g:nv_search_paths = ['~/vimwiki', '~/vw_sandstorm']
