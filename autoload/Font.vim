call TQ84_log_indent(expand("<sfile>"))

fu! Font#Characteristics() " {
  call TQ84_log_indent(expand("<sfile>") . "-Characteristics")
  
  let l:font = &guifont

  call TQ84_log('font: ' . l:font)

  let l:font_parts = matchlist(l:font, '\v(\w+):(\w+):?(\w+)?')

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
  call TQ84_log_indent(expand("<sfile>") . "-Set")
  
  let l:font_new = a:fontCharacteristics['name'] . ':' . a:fontCharacteristics['h_or_w'] . a:fontCharacteristics['size'] . ':' . a:fontCharacteristics['3rd?']

  call TQ84_log('new Font: ' . l:font_new)

  let &guifont = l:font_new

  call TQ84_log_dedent()

endfu " }

fu! Font#Resize(new_size) " {
  call TQ84_log_indent(expand("<sfile>") . "-Resize (new_size = " . a:new_size . ')')

  let l:fontCharacteristics = Font#Characteristics()
  
  let l:fontCharacteristics['size'] = a:new_size

  call Font#Set(l:fontCharacteristics)

  call TQ84_log_dedent()

endfu " }

fu! Font#ResizeWithInput() " {
  call TQ84_log_indent(expand("<sfile>") . "-ResizeWithInput")

  let l:new_size = input('New Size: ')

  let l:fontCharacteristics = Font#Characteristics()
  
  let l:fontCharacteristics['size'] = l:new_size

  call Font#Set(l:fontCharacteristics)

  call TQ84_log_dedent()

endfu " }

fu! Font#ResizeRelative(by) " {
  call TQ84_log_indent(expand("<sfile>") . "-ResizeRelative (by = " . a:by . ')')
  
  let l:fontCharacteristics = Font#Characteristics()
  
  let l:fontCharacteristics['size'] += a:by

  call Font#Set(l:fontCharacteristics)

  call TQ84_log_dedent()

endfu " }

call TQ84_log_dedent()
