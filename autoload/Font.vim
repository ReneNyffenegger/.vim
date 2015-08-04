call TQ84_log_indent(expand("<sfile>"))

fu! Font#Characteristics() " {
  call TQ84_log_indent(expand("<sfile>"))
  
  let l:font = &guifont

  call TQ84_log('font: ' . l:font)

  let l:font_parts = matchlist(l:font, '\v([^:]+):(\w+):?(\w+)?')

  let l:font_size_parts = matchlist(l:font_parts[2], '\v(\w)(\d+)')

  let l:ret = {}

  let l:ret['name'  ] = l:font_parts[1]
  let l:ret['h_or_w'] = l:font_size_parts[1]
  let l:ret['size'  ] = l:font_size_parts[2]
  let l:ret['3rd?'  ] = l:font_parts[3]

  call TQ84_log_dedent()

  return l:ret

endfu " }

fu! Font#Set(fontCharacteristics) " {
  call TQ84_log_indent(expand("<sfile>"))
  
  let l:font_new = a:fontCharacteristics['name'] . ':' . a:fontCharacteristics['h_or_w'] . a:fontCharacteristics['size'] 
  call TQ84_log('l:font_new: ' . l:font_new)
  
  if a:fontCharacteristics['3rd?'] =~ '\S'
     call TQ84_log('3rd: ' . a:fontCharacteristics['3rd?'])
     let l:font_new .= ':' . a:fontCharacteristics['3rd?']
  endif

  call TQ84_log('new Font: ' . l:font_new)

  let &guifont = l:font_new

  call TQ84_log_dedent()

endfu " }

fu! Font#Resize(new_size) " {
  call TQ84_log_indent(expand("<sfile>") . " (new_size = " . a:new_size . ')')

  let l:fontCharacteristics = Font#Characteristics()
  
  let l:fontCharacteristics['size'] = a:new_size

  call Font#Set(l:fontCharacteristics)

  call TQ84_log_dedent()

endfu " }

fu! Font#ResizeWithInput() " {
  call TQ84_log_indent(expand("<sfile>"))

  let l:new_size = input('New Size: ')

  let l:fontCharacteristics = Font#Characteristics()
  
  let l:fontCharacteristics['size'] = l:new_size

  call Font#Set(l:fontCharacteristics)

  call TQ84_log_dedent()

endfu " }

fu! Font#ResizeRelative(by) " {
  call TQ84_log_indent(expand("<sfile>") . " (by = " . a:by . ')')
  
  let l:fontCharacteristics = Font#Characteristics()
  
  let l:fontCharacteristics['size'] += a:by

  call Font#Set(l:fontCharacteristics)

  call TQ84_log_dedent()

endfu " }

fu! Font#FontsFromRegistry() " {
  call TQ84_log_indent(expand("<sfile>"))

" Ideas found at
"   https://github.com/drmikehenry/vim-fontdetect/blob/master/autoload/fontdetect.vim
"
  if !executable("reg")
      TQ84_log('reg is not executable')
      throw "reg is not executable"
  endif

  let l:reg = system('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"')

  call TQ84_log('l:reg (1): ' . l:reg)
  
  let l:font_lines = split (l:reg, '\n')

  " l:reg starts with 
  "   \nHKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts\n
  " Remove these two (first) lines:
  let l:font_lines = l:font_lines[1:]

  " l:reg also has an emtpy last line to remove:
  let l:font_lines = l:font_lines[:-2]


  let l:ret = []
  for f in l:font_lines

    " A font-line looks like:
    "   Arial (TrueType)    REG_SZ    arial.ttf
    "   Batang & BatangChe & Gungsuh & GungsuhChe (TrueType)    REG_SZ    batang.ttc
    "   Courier 10,12,15    REG_SZ    COURE.FON
    "   MS Serif 8,10,12,14,18,24    REG_SZ    SERIFE.FON
    "   Small Fonts    REG_SZ    SMALLE.FON
    "   Small Fonts (120)    REG_SZ    SMALLF.FON

    call TQ84_log_indent('f = ' . f)

    let l:ff = f

    let l:ff = substitute (l:ff, ' *REG_SZ.*', '', '')
    call TQ84_log('l:ff = ' . l:ff)

    let l:ff = substitute(l:ff, '\v \d+(,\d+)+$', '', '')
    call TQ84_log('l:ff = ' . l:ff)

    let l:ff = substitute(l:ff, '\v *\([^)]*\)$', '', '')
    call TQ84_log('l:ff = ' . l:ff)

    call add(l:ret, l:ff)

    call TQ84_log_dedent()

  endfor

  call TQ84_log_dedent()
  return l:ret

endfu " }

fu! Font#Reset() " {

  call TQ84_log_indent(expand("<sfile>"))

  set guifont=Lucida\ Console:h8:cDEFAULT

  call TQ84_log_dedent()

endfu " }

fu! Font#Hebrew() " {

  call TQ84_log_indent(expand("<sfile>"))

  set guifont=Courier\ New:h11\:cEASTEUROPE

  call TQ84_log_dedent()

endfu " }

call TQ84_log_dedent()
