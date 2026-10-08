" Voltage - high-contrast dark colorscheme for Vim and Neovim.
" Palette: docs/palette.md. Every color is a hex value; the 256-color (cterm)
" fallback is derived from it, so there is one source of truth.

hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'voltage'
set background=dark

" --- helpers ---------------------------------------------------------------

" Nearest xterm-256 slot for a #rrggbb string (6x6x6 cube or grey ramp).
function! s:to256(hex) abort
  let l:rgb = [str2nr(a:hex[1:2], 16), str2nr(a:hex[3:4], 16), str2nr(a:hex[5:6], 16)]
  let l:lv = [0, 95, 135, 175, 215, 255]
  let l:ci = []
  let l:cube = []
  for l:c in l:rgb
    let l:best = 0
    for l:i in range(1, 5)
      if abs(l:lv[l:i] - l:c) < abs(l:lv[l:best] - l:c)
        let l:best = l:i
      endif
    endfor
    call add(l:ci, l:best)
    call add(l:cube, l:lv[l:best])
  endfor
  let l:avg = (l:rgb[0] + l:rgb[1] + l:rgb[2]) / 3
  let l:gi = max([0, min([23, (l:avg - 3) / 10])])
  let l:gv = 8 + 10 * l:gi
  let l:dc = 0
  let l:dg = 0
  for l:k in range(3)
    let l:dc += (l:rgb[l:k] - l:cube[l:k]) * (l:rgb[l:k] - l:cube[l:k])
    let l:dg += (l:rgb[l:k] - l:gv) * (l:rgb[l:k] - l:gv)
  endfor
  if l:dg < l:dc
    return 232 + l:gi
  endif
  return 16 + 36 * l:ci[0] + 6 * l:ci[1] + l:ci[2]
endfunction

" s:h(group, fg, bg [, attr [, special]]) - fg/bg are '#rrggbb' or 'NONE'.
function! s:h(group, fg, bg, ...) abort
  let l:attr = a:0 >= 1 ? a:1 : 'NONE'
  let l:cmd = 'hi ' . a:group . ' gui=' . l:attr
        \ . ' cterm=' . substitute(l:attr, 'undercurl', 'underline', 'g')
  let l:cmd .= ' guifg=' . a:fg . ' ctermfg=' . (a:fg ==# 'NONE' ? 'NONE' : s:to256(a:fg))
  let l:cmd .= ' guibg=' . a:bg . ' ctermbg=' . (a:bg ==# 'NONE' ? 'NONE' : s:to256(a:bg))
  if a:0 >= 2
    let l:cmd .= ' guisp=' . a:2
  endif
  execute l:cmd
endfunction

" --- palette (docs/palette.md) ----------------------------------------------

let s:bg      = '#0d1117'
let s:bg_alt  = '#010409'
let s:fg      = '#ffffff'
let s:dim     = '#c9c9c9'
let s:gray    = '#6e7681'
let s:guide   = '#484f58'
let s:border  = '#30363d'
let s:line    = '#171b22'
let s:select  = '#264f78'
let s:string  = '#00ff41'
let s:string2 = '#6fe09f'   " JSON / YAML / TOML strings
let s:pink    = '#ff6b9d'   " numbers, control flow, member access
let s:type    = '#4fc1ff'
let s:decl    = '#ffa657'
let s:fdecl   = '#00d4ff'
let s:fcall   = '#82e2ff'
let s:param   = '#ffdd88'
let s:gold    = '#ffcc00'   " enums, macros, operators in conditionals
let s:orchid  = '#da70d6'   " language constants
let s:code    = '#ffaa44'
let s:comment = '#7cb668'
let s:red     = '#ff0000'
let s:cursor  = '#ff3333'
let s:sv_type = '#7bafd4'

" --- editor chrome -----------------------------------------------------------

call s:h('Normal',       s:fg,    s:bg)
call s:h('NormalNC',     s:fg,    s:bg)
call s:h('NormalFloat',  s:dim,   s:bg_alt)
call s:h('FloatBorder',  s:border, s:bg_alt)
call s:h('Cursor',       s:bg,    s:cursor)
call s:h('lCursor',      s:bg,    s:cursor)
call s:h('CursorIM',     s:bg,    s:cursor)
call s:h('TermCursor',   s:bg,    s:cursor)
call s:h('CursorLine',   'NONE',  s:line)
call s:h('CursorColumn', 'NONE',  s:line)
call s:h('ColorColumn',  'NONE',  s:line)
call s:h('LineNr',       s:gray,  'NONE')
call s:h('CursorLineNr', s:fg,    s:line, 'bold')
call s:h('SignColumn',   s:gray,  s:bg)
call s:h('FoldColumn',   s:gray,  s:bg)
call s:h('Folded',       s:gray,  s:bg_alt)
call s:h('Visual',       'NONE',  s:select)
call s:h('VisualNOS',    'NONE',  s:select)
call s:h('Search',       s:bg,    s:gold)
call s:h('IncSearch',    s:bg,    s:pink)
call s:h('CurSearch',    s:bg,    s:pink)
call s:h('Substitute',   s:bg,    s:pink)
call s:h('MatchParen',   s:gold,  'NONE', 'bold,underline')
call s:h('NonText',      s:guide, 'NONE')
call s:h('Whitespace',   s:guide, 'NONE')
call s:h('SpecialKey',   s:guide, 'NONE')
call s:h('EndOfBuffer',  s:bg,    'NONE')
call s:h('VertSplit',    s:border, s:bg)
call s:h('WinSeparator', s:border, s:bg)
call s:h('StatusLine',   s:dim,   s:bg_alt)
call s:h('StatusLineNC', s:gray,  s:bg_alt)
call s:h('StatusLineTerm',   s:dim,  s:bg_alt)
call s:h('StatusLineTermNC', s:gray, s:bg_alt)
call s:h('WinBar',       s:dim,   s:bg)
call s:h('WinBarNC',     s:gray,  s:bg)
call s:h('TabLine',      '#7a7a7a', s:bg_alt)
call s:h('TabLineFill',  s:gray,  s:bg_alt)
call s:h('TabLineSel',   s:fg,    s:bg, 'bold')
call s:h('Pmenu',        s:dim,   s:bg_alt)
call s:h('PmenuSel',     s:fg,    s:select)
call s:h('PmenuSbar',    'NONE',  s:border)
call s:h('PmenuThumb',   'NONE',  s:gray)
call s:h('WildMenu',     s:bg,    s:fdecl)
call s:h('Directory',    s:fdecl, 'NONE')
call s:h('Title',        s:fdecl, 'NONE', 'bold')
call s:h('ErrorMsg',     s:cursor, 'NONE', 'bold')
call s:h('WarningMsg',   s:decl,  'NONE')
call s:h('ModeMsg',      s:fg,    'NONE', 'bold')
call s:h('MoreMsg',      s:string, 'NONE')
call s:h('Question',     s:string, 'NONE')
call s:h('QuickFixLine', 'NONE',  s:select)
call s:h('SpellBad',     'NONE',  'NONE', 'undercurl', s:cursor)
call s:h('SpellCap',     'NONE',  'NONE', 'undercurl', s:decl)
call s:h('SpellLocal',   'NONE',  'NONE', 'undercurl', s:type)
call s:h('SpellRare',    'NONE',  'NONE', 'undercurl', s:orchid)
call s:h('DiffAdd',      'NONE',  '#0b3115')
call s:h('DiffChange',   'NONE',  '#1a2a3f')
call s:h('DiffDelete',   s:cursor, '#3a1519')
call s:h('DiffText',     'NONE',  s:select)
call s:h('Added',        s:string, 'NONE')
call s:h('Changed',      s:gold,  'NONE')
call s:h('Removed',      s:cursor, 'NONE')

" --- generic syntax groups ---------------------------------------------------

call s:h('Comment',      s:comment, 'NONE')
call s:h('SpecialComment', s:comment, 'NONE')
call s:h('Todo',         s:red,   'NONE', 'bold')
call s:h('String',       s:string, 'NONE')
call s:h('Character',    s:string, 'NONE')
call s:h('Number',       s:pink,  'NONE')
call s:h('Float',        s:pink,  'NONE')
call s:h('Boolean',      s:orchid, 'NONE')
call s:h('Constant',     s:orchid, 'NONE')
call s:h('Identifier',   s:fg,    'NONE')
call s:h('Function',     s:fcall, 'NONE')
call s:h('Statement',    s:pink,  'NONE')
call s:h('Conditional',  s:pink,  'NONE')
call s:h('Repeat',       s:pink,  'NONE')
call s:h('Label',        s:pink,  'NONE')
call s:h('Exception',    s:pink,  'NONE')
call s:h('Keyword',      s:pink,  'NONE')
call s:h('Operator',     s:fg,    'NONE')
call s:h('PreProc',      s:gold,  'NONE')
call s:h('Include',      s:gold,  'NONE')
call s:h('Define',       s:gold,  'NONE')
call s:h('Macro',        s:gold,  'NONE')
call s:h('PreCondit',    s:gold,  'NONE')
call s:h('Type',         s:decl,  'NONE')
call s:h('StorageClass', s:decl,  'NONE')
call s:h('Structure',    s:decl,  'NONE')
call s:h('Typedef',      s:decl,  'NONE')
call s:h('Special',      s:gold,  'NONE')
call s:h('SpecialChar',  s:gold,  'NONE')
call s:h('Tag',          s:fdecl, 'NONE')
call s:h('Delimiter',    s:fg,    'NONE')
call s:h('Debug',        s:red,   'NONE')
call s:h('Underlined',   s:fcall, 'NONE', 'underline')
call s:h('Error',        s:cursor, 'NONE', 'bold')
call s:h('Ignore',       s:guide, 'NONE')

" --- per-language groups -----------------------------------------------------
" Mirrors the VS Code theme's language-specific rules.

" C / C++ / CUDA
call s:h('cOperator',    s:fg,    'NONE')
call s:h('cppOperator',  s:pink,  'NONE')   " new / delete
call s:h('cppStructure', s:decl,  'NONE')   " class / namespace
call s:h('cIncluded',    s:string, 'NONE')

" Python
call s:h('pythonOperator',  s:gold,  'NONE')  " and / or / not / in / is
call s:h('pythonFunction',  s:fdecl, 'NONE')  " name after def
call s:h('pythonBuiltin',   s:fcall, 'NONE')
call s:h('pythonDecorator', s:gold,  'NONE')
call s:h('pythonDecoratorName', s:gold, 'NONE')
call s:h('pythonNone',      s:orchid, 'NONE')
call s:h('pythonBoolean',   s:orchid, 'NONE')

" SystemVerilog / Verilog
call s:h('verilogOperator',  s:gold,  'NONE')
call s:h('verilogNumber',    s:code,  'NONE')
call s:h('verilogConstant',  s:orchid, 'NONE')
call s:h('verilogGlobal',    s:gold,  'NONE')
call s:h('verilogDirective', s:gold,  'NONE')
call s:h('verilogType',      s:sv_type, 'NONE')

" Tcl
call s:h('tclCommand',   s:fdecl, 'NONE')
call s:h('tclVariable',  s:fg,    'NONE')

" Shell
call s:h('shStatement',  s:fcall, 'NONE')
call s:h('shOption',     s:decl,  'NONE')
call s:h('shVariable',   s:fg,    'NONE')
call s:h('shDerefSimple', s:fg,   'NONE')

" JSON
call s:h('jsonKeyword',  s:fdecl, 'NONE')
call s:h('jsonString',   s:string2, 'NONE')
call s:h('jsonBoolean',  s:orchid, 'NONE')
call s:h('jsonNull',     s:orchid, 'NONE')
call s:h('jsonEscape',   s:gold,  'NONE')
call s:h('jsonQuote',    s:fdecl, 'NONE')

" YAML
call s:h('yamlBlockMappingKey', s:fdecl, 'NONE')
call s:h('yamlFlowMappingKey',  s:fdecl, 'NONE')
call s:h('yamlString',      s:string2, 'NONE')
call s:h('yamlFlowString',  s:string2, 'NONE')
call s:h('yamlAnchor',      s:param, 'NONE')
call s:h('yamlAlias',       s:param, 'NONE')
call s:h('yamlNull',        s:orchid, 'NONE')
call s:h('yamlBool',        s:orchid, 'NONE')
call s:h('yamlDocumentStart', s:gray, 'NONE')
call s:h('yamlDocumentEnd',   s:gray, 'NONE')

" TOML
call s:h('tomlKey',      s:fdecl, 'NONE')
call s:h('tomlTable',    s:decl,  'NONE')
call s:h('tomlTableArray', s:decl, 'NONE')
call s:h('tomlString',   s:string2, 'NONE')
call s:h('tomlBoolean',  s:orchid, 'NONE')
call s:h('tomlDate',     s:pink,  'NONE')

" Markdown
call s:h('markdownH1',   s:fdecl, 'NONE', 'bold')
call s:h('markdownH2',   s:gold,  'NONE', 'bold')
call s:h('markdownH3',   s:decl,  'NONE', 'bold')
call s:h('markdownH4',   s:pink,  'NONE', 'bold')
call s:h('markdownH5',   s:orchid, 'NONE', 'bold')
call s:h('markdownH6',   s:type,  'NONE', 'bold')
call s:h('markdownHeadingDelimiter', s:gray, 'NONE')
call s:h('markdownBold',          s:fg,    'NONE', 'bold')
call s:h('markdownItalic',        s:param, 'NONE', 'italic')
call s:h('markdownBoldItalic',    s:param, 'NONE', 'bold,italic')
call s:h('markdownCode',          s:code,  'NONE')
call s:h('markdownCodeBlock',     s:code,  'NONE')
call s:h('markdownCodeDelimiter', s:code,  'NONE')
call s:h('markdownLinkText',      s:fdecl, 'NONE')
call s:h('markdownUrl',           s:fcall, 'NONE', 'underline')
call s:h('markdownListMarker',    s:decl,  'NONE')
call s:h('markdownOrderedListMarker', s:decl, 'NONE')
call s:h('markdownBlockquote',    s:comment, 'NONE', 'italic')
call s:h('markdownRule',          s:gray,  'NONE')
call s:h('markdownEscape',        s:gold,  'NONE')

" --- Neovim: Treesitter and LSP semantic tokens --------------------------------
" Plain Vim has no use for these; Neovim ignores nothing here (unknown groups
" are just defined and unused).

if has('nvim')
  call s:h('@variable',            s:fg,    'NONE')
  call s:h('@variable.builtin',    s:fdecl, 'NONE')
  call s:h('@variable.parameter',  s:param, 'NONE')
  call s:h('@variable.member',     s:pink,  'NONE')
  call s:h('@property',            s:pink,  'NONE')
  call s:h('@field',               s:pink,  'NONE')
  call s:h('@parameter',           s:param, 'NONE')
  call s:h('@constant',            s:orchid, 'NONE')
  call s:h('@constant.builtin',    s:orchid, 'NONE')
  call s:h('@constant.macro',      s:gold,  'NONE')
  call s:h('@boolean',             s:orchid, 'NONE')
  call s:h('@number',              s:pink,  'NONE')
  call s:h('@number.float',        s:pink,  'NONE')
  call s:h('@float',               s:pink,  'NONE')
  call s:h('@string',              s:string, 'NONE')
  call s:h('@string.escape',       s:gold,  'NONE')
  call s:h('@string.special',      s:gold,  'NONE')
  call s:h('@character',           s:string, 'NONE')
  call s:h('@comment',             s:comment, 'NONE')
  call s:h('@comment.todo',        s:red,   'NONE', 'bold')
  call s:h('@comment.note',        s:red,   'NONE', 'bold')
  call s:h('@comment.warning',     s:red,   'NONE', 'bold')
  call s:h('@comment.error',       s:red,   'NONE', 'bold')
  call s:h('@function',            s:fdecl, 'NONE')
  call s:h('@function.call',       s:fcall, 'NONE')
  call s:h('@function.builtin',    s:fcall, 'NONE')
  call s:h('@function.macro',      s:gold,  'NONE')
  call s:h('@function.method',     s:fdecl, 'NONE')
  call s:h('@function.method.call', s:fcall, 'NONE')
  call s:h('@method',              s:fdecl, 'NONE')
  call s:h('@method.call',         s:fcall, 'NONE')
  call s:h('@constructor',         s:type,  'NONE')
  call s:h('@type',                s:type,  'NONE')
  call s:h('@type.builtin',        s:decl,  'NONE')
  call s:h('@type.definition',     s:type,  'NONE')
  call s:h('@type.qualifier',      s:decl,  'NONE')
  call s:h('@storageclass',        s:decl,  'NONE')
  call s:h('@module',              s:type,  'NONE')
  call s:h('@namespace',           s:type,  'NONE')
  call s:h('@attribute',           s:gold,  'NONE')
  call s:h('@keyword',             s:pink,  'NONE')
  call s:h('@keyword.function',    s:decl,  'NONE')
  call s:h('@keyword.type',        s:decl,  'NONE')
  call s:h('@keyword.modifier',    s:decl,  'NONE')
  call s:h('@keyword.storage',     s:decl,  'NONE')
  call s:h('@keyword.operator',    s:gold,  'NONE')
  call s:h('@keyword.return',      s:pink,  'NONE')
  call s:h('@keyword.conditional', s:pink,  'NONE')
  call s:h('@keyword.repeat',      s:pink,  'NONE')
  call s:h('@keyword.exception',   s:pink,  'NONE')
  call s:h('@keyword.import',      s:pink,  'NONE')
  call s:h('@conditional',         s:pink,  'NONE')
  call s:h('@repeat',              s:pink,  'NONE')
  call s:h('@exception',           s:pink,  'NONE')
  call s:h('@include',             s:pink,  'NONE')
  call s:h('@preproc',             s:gold,  'NONE')
  call s:h('@define',              s:gold,  'NONE')
  call s:h('@operator',            s:fg,    'NONE')
  call s:h('@punctuation',         s:fg,    'NONE')
  call s:h('@punctuation.delimiter', s:fg,  'NONE')
  call s:h('@punctuation.bracket', s:fg,    'NONE')
  call s:h('@tag',                 s:fdecl, 'NONE')
  call s:h('@tag.attribute',       s:param, 'NONE')
  call s:h('@tag.delimiter',       s:fg,    'NONE')
  call s:h('@markup.heading.1',    s:fdecl, 'NONE', 'bold')
  call s:h('@markup.heading.2',    s:gold,  'NONE', 'bold')
  call s:h('@markup.heading.3',    s:decl,  'NONE', 'bold')
  call s:h('@markup.heading.4',    s:pink,  'NONE', 'bold')
  call s:h('@markup.heading.5',    s:orchid, 'NONE', 'bold')
  call s:h('@markup.heading.6',    s:type,  'NONE', 'bold')
  call s:h('@markup.strong',       s:fg,    'NONE', 'bold')
  call s:h('@markup.italic',       s:param, 'NONE', 'italic')
  call s:h('@markup.strikethrough', '#7a7a7a', 'NONE', 'strikethrough')
  call s:h('@markup.raw',          s:code,  'NONE')
  call s:h('@markup.link',         s:fdecl, 'NONE')
  call s:h('@markup.link.url',     s:fcall, 'NONE', 'underline')
  call s:h('@markup.link.label',   s:fdecl, 'NONE')
  call s:h('@markup.list',         s:decl,  'NONE')
  call s:h('@markup.quote',        s:comment, 'NONE', 'italic')
  call s:h('@text.title',          s:fdecl, 'NONE', 'bold')
  call s:h('@text.literal',        s:code,  'NONE')
  call s:h('@text.uri',            s:fcall, 'NONE', 'underline')
  call s:h('@text.strong',         s:fg,    'NONE', 'bold')
  call s:h('@text.emphasis',       s:param, 'NONE', 'italic')

  " LSP semantic tokens: declarations vs. calls, like the VS Code theme.
  call s:h('@lsp.type.parameter',  s:param, 'NONE')
  call s:h('@lsp.type.property',   s:pink,  'NONE')
  call s:h('@lsp.type.variable',   s:fg,    'NONE')
  call s:h('@lsp.type.type',       s:type,  'NONE')
  call s:h('@lsp.type.class',      s:type,  'NONE')
  call s:h('@lsp.type.struct',     s:type,  'NONE')
  call s:h('@lsp.type.interface',  s:type,  'NONE')
  call s:h('@lsp.type.typeParameter', s:type, 'NONE')
  call s:h('@lsp.type.enum',       s:type,  'NONE')
  call s:h('@lsp.type.enumMember', s:gold,  'NONE')
  call s:h('@lsp.type.macro',      s:gold,  'NONE')
  call s:h('@lsp.type.namespace',  s:type,  'NONE')
  call s:h('@lsp.type.function',   s:fcall, 'NONE')
  call s:h('@lsp.type.method',     s:fcall, 'NONE')
  call s:h('@lsp.typemod.function.declaration', s:fdecl, 'NONE')
  call s:h('@lsp.typemod.method.declaration',   s:fdecl, 'NONE')

  call s:h('DiagnosticError', s:cursor, 'NONE')
  call s:h('DiagnosticWarn',  s:decl,  'NONE')
  call s:h('DiagnosticInfo',  s:type,  'NONE')
  call s:h('DiagnosticHint',  s:fcall, 'NONE')
  call s:h('DiagnosticUnderlineError', 'NONE', 'NONE', 'undercurl', s:cursor)
  call s:h('DiagnosticUnderlineWarn',  'NONE', 'NONE', 'undercurl', s:decl)
  call s:h('DiagnosticUnderlineInfo',  'NONE', 'NONE', 'undercurl', s:type)
  call s:h('DiagnosticUnderlineHint',  'NONE', 'NONE', 'undercurl', s:fcall)
endif

" --- regex-syntax extras ---------------------------------------------------------
" Plain Vim syntax has no notion of a "function call" or "member access".
" These add the VS Code theme's call (#82e2ff) and member (#ff6b9d) colors, only
" while Voltage is the active scheme. Neovim with Treesitter ignores them.

function! s:syntax_extras() abort
  if get(g:, 'colors_name', '') !=# 'voltage'
    return
  endif
  let l:ft = &filetype
  if l:ft =~# '^\%(c\|cpp\|cuda\)$'
    syntax match voltageMember /\%(\.\|->\)\h\w*/ contains=NONE
    syntax match voltageCall /\%(\%(if\|for\|while\|switch\|return\|sizeof\|alignof\|typeof\|defined\|else\|do\|case\)\>\)\@!\<\h\w*\ze\s*(/ contains=NONE
  elseif l:ft ==# 'python'
    syntax match voltageMember /\.\h\w*/ contains=NONE
    syntax match voltageCall /\%(\%(if\|elif\|while\|for\|in\|and\|or\|not\|is\|return\|yield\|assert\|del\|with\|except\|lambda\|print\)\>\)\@!\<\h\w*\ze\s*(/ contains=NONE
  elseif l:ft =~# '^\%(verilog\|systemverilog\|verilog_systemverilog\)$'
    syntax match voltageCall /\%(\%(if\|for\|while\|case\|always\|always_ff\|always_comb\|assign\|repeat\|forever\)\>\)\@!\<\h\w*\ze\s*(/ contains=NONE
    syntax match voltageCall /\$\h\w*/ contains=NONE
  else
    return
  endif
  hi def link voltageCall   Function
  hi def link voltageMember Number
endfunction

augroup voltage_colors
  autocmd!
  autocmd Syntax c,cpp,cuda,python,verilog,systemverilog,verilog_systemverilog call s:syntax_extras()
augroup END
" Re-run for buffers that already have syntax loaded when the scheme is applied.
if exists('syntax_on') && &filetype !=# ''
  call s:syntax_extras()
endif
